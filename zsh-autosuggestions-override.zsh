# Accept the entire suggestion and execute it
_zsh_autosuggest_execute() {
    if [ -z $BUFFER ]; then
        local preexec precmd
        for preexec in $preexec_functions
        do
            $preexec
        done
        print -n '\x1b[?25l\033[2J\033[3J\033[H' # hide cursor and clear screen
        if [ "${LASTWIDGET}" == "autosuggest-execute" ] && [ ${MYVAR} ]
        then
            ls --color=auto --group-directories-first
            unset MYVAR
        else
            MYVAR=1
        fi
        for precmd in $precmd_functions
        do
            $precmd
        done
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
