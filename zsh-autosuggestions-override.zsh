# Accept the entire suggestion and execute it
_zsh_autosuggest_execute() {
    if [ -z $BUFFER ]; then
        xterm_title_preexec
        print -nP '\x1b[?25l' # hide cursor
        if [ "${LASTWIDGET}" == "autosuggest-execute" ] || [ "${LASTWIDGET}" == "goto_sublime_current_dir" ] && [ ${MYVAR} ]
        then
            print -Pn -- '\x1B[F\x1B[2K'
            ls --color=auto --group-directories-first
            unset MYVAR
        else
            clear
            MYVAR=1
        fi
        preprompt
        zle reset-prompt
    else
        # Add the suggestion to the buffer
        BUFFER+="${POSTDISPLAY%%[[:blank:]]#}"

        # Remove the suggestion
        unset POSTDISPLAY

        # Call the original `accept-line` to handle syntax highlighting or
        # other potential custom behavior
        _zsh_autosuggest_invoke_original_widget "accept-line"
    fi
}

export KEYTIMEOUT=1
bindkey -e '\e' autosuggest-execute
