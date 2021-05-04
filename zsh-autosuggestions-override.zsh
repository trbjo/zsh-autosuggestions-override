# Accept the entire suggestion and execute it
_zsh_autosuggest_execute() {
    if [ -z $BUFFER ]; then
        xterm_title_preexec
        print -n '\x1b[?25l\033[J\033[1J\033[H' # hide cursor
        if [ "${LASTWIDGET}" == "autosuggest-execute" ] && [ ${MYVAR} ]
        then
            ls --color=auto --group-directories-first
            unset MYVAR
        else
            MYVAR=1
        fi
        preprompt
        zle reset-prompt
    else
        # Add the suggestion to the buffer
        BUFFER+="${POSTDISPLAY}"

        # Remove the suggestion
        [[ $POSTDISPLAY ]] && unset POSTDISPLAY || BUFFER="${BUFFER%%[[:blank:]]#}"

        # Call the original `accept-line` to handle syntax highlighting or
        # other potential custom behavior
        _zsh_autosuggest_invoke_original_widget "accept-line"
    fi
}

export KEYTIMEOUT=1
bindkey -e '\e' autosuggest-execute
