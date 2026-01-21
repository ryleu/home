# vim: set ft=zsh :

# load environment variables
## notes dir
if [[ -z $RY_NOTES_DIR ]]; then
	export RY_NOTES_DIR="$HOME/Documents/Notes"
fi
## todo path
if [[ -z $RY_TODO_PATH ]]; then
	export RY_TODO_PATH="$HOME/Documents/todo.md"
fi

function restart-hyprlock {
	if [[ ! -z $1 ]]; then
		inst=$1
	else
		inst=0
	fi

	hyprctl --instance $inst 'keyword misc:allow_session_lock_restore 1'
	hyprctl --instance $inst 'dispatch exec hyprlock'
}

alias todo="vim $RY_TODO_PATH"
function note {
	mkdir -p "$RY_NOTES_DIR"
	header="Note $(date -I)"
	file="$RY_NOTES_DIR/$header.md"

	if [[ ! -f "$file" ]]
	then
		vim "$file" +"0read !echo \"\# $header\""
	else
		vim "$file"
	fi
}

function notes {
	vim "$RY_NOTES_DIR"
}

function rmnote {
	rm -i "$RY_NOTES_DIR/Note $(date -I).md"
}

