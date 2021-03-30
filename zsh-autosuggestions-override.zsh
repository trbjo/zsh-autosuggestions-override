# Accept the entire suggestion and execute it
_zsh_autosuggest_execute() {
    if [ -z $BUFFER ]; then
        gitstatus_prompt_update
        if [ "${LASTWIDGET}" == "autosuggest-execute" ] && [ ${MYVAR} ]
        then
            zle clear-screen
            printf "\r"
            git status --porcelain --short 2> /dev/null
            unset MYVAR
        else
            zle clear-screen
            printf "\r"
            ls --color=auto --group-directories-first
            MYVAR=1
        fi
        printf "\x1B[5m\033[1mλ\033[0m "
        return 0
    fi

    # Add the suggestion to the buffer
    BUFFER="$BUFFER$POSTDISPLAY"

    # Remove the suggestion
    unset POSTDISPLAY

    # Call the original `accept-line` to handle syntax highlighting or
    # other potential custom behavior
    _zsh_autosuggest_invoke_original_widget "accept-line"
}

export KEYTIMEOUT=1
bindkey -e '\e' autosuggest-execute
