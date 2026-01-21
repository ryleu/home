
[[ "$TERM" = "xterm-kitty" ]] && cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

function restart-hyprlock {
	if [[ ! -z $1 ]]; then
		inst=$1
	else
		inst=0
	fi

	hyprctl --instance $inst 'keyword misc:allow_session_lock_restore 1'
	hyprctl --instance $inst 'dispatch exec hyprlock'
}

alias todo="vim $HOME/Documents/todo.md"
function note {
        mkdir -p ~/Documents/Notes/
        filename="Note $(date -I)"
        file="$HOME/Documents/Notes/$filename.md"
        if [[ ! -f "$file" ]]; then
                vim "$file" +"0read !echo \"\# $filename\""
	else
		vim "$file"
	fi
        
}
function notes {
        vim "$HOME/Documents/Notes/"
}
function rmnote {
        rm -i "$HOME/Documents/Notes/Note $(date -I).md"
}

