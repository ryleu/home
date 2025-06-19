import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text

Scope {
    id: root

    // define a property to hold the time (so we can reference this in the text block)
    property string time
    property string battery

    Variants {
        model: Quickshell.screens;

        delegate: Component {
            PanelWindow {
                // the screen gets put into here v
                property var modelData

                // now we can reference it
                screen: modelData

                // determines where the thing goes
                // basically it sticks to the top, left, and right
                anchors {
                    top: true
                    left: true
                    right: true
                }

                // this how tall it are
                implicitHeight: 30

                // ok now inside of that thing there is a text block
                Text {
                    // it is referred to as `clock`
                    id: clock
                    // and its position is centered within the parent
                    anchors.centerIn: parent
                    // now we use the time here
                    text: root.time
                }

                Text {
                    id: battery

                    anchors.right: parent.right

                    text: "%1\%".arg(root.battery)
                }
            }
        }
    }

    // and the text comes from a Process thing which i think comes from .Io
    Process {
        // we need to set an id so it can be referenced by the timer
        id: dateProc

        // the command is the date command
        command: ["date"]

        // and it run once
        running: true

        // when it done running, collect the output and make clock's text equal to the output
        stdout: StdioCollector {
            onStreamFinished: {
                // we set root's time property because we can't directly access clock
                root.time = text
            }
        }
    }

    // here are the process for battery
    Process {
        id: batteryProc

        command: ["cat", "/sys/class/power_supply/BAT1/capacity"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.battery = text
            }
        }
    }

    // but we want it to run a bunch, so make a timer
    Timer {
        interval: 100
        repeat: true
        running: true

        // when the timer triggers, set the process to running
        // without this it won't update
        onTriggered: {
            dateProc.running = true
            batteryProc.running = true
        }
    }
}
