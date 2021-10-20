# Accept the entire suggestion and execute it
_zsh_autosuggest_execute() {
    if [[ $BUFFER ]]; then
        # Add the suggestion to the buffer
        BUFFER+="${POSTDISPLAY}"

        # Remove the suggestion
        [[ $POSTDISPLAY ]] && unset POSTDISPLAY || BUFFER="${BUFFER%%[[:blank:]]#}"

        # Call the original `accept-line` to handle syntax highlighting or
        # other potential custom behavior
        _zsh_autosuggest_invoke_original_widget "accept-line"
    else
        control_git_sideeffects_preexec
        print -n '\033[2J\033[3J\033[H' # hide cursor and clear screen
        if [ "${LASTWIDGET}" == "autosuggest-execute" ] && [ ${MYVAR} ]
        then
            ls --color=auto --group-directories-first
            print
            unset MYVAR
        else
            MYVAR=1
        fi
        preprompt
        zle reset-prompt
    fi
}

bindkey -e '\e' autosuggest-execute
