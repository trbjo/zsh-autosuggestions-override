
# Accept the entire suggestion and execute it
_zsh_autosuggest_execute() {

    if [[ $BUFFER =~ ^[0-9]+$ ]]; then
        light -S $BUFFER
        [ $PopUp ] && swaymsg 'focus tiling; [app_id="^(subl|sublime_text|firefox|mpv)$" app_id=__focused__ workspace="^(3|2λ)$"] fullscreen enable; [app_id="^PopUp$"] scratchpad show' > /dev/null 2>&1

        unset BUFFER
        return 0
    fi

    if [ -z $BUFFER ]; then
        clear

        if [ "${LASTWIDGET}" == "autosuggest-execute" ] && [ ${MYVAR} ]
        then
            exa --group-directories-first
            unset MYVAR
        else
            git -c color.status=always status -sb 2> /dev/null
            MYVAR=1
        fi

        zle redisplay
        return 0
    fi


    # Add the suggestion to the buffer
    BUFFER+="$POSTDISPLAY"

    # Remove the suggestion
    unset POSTDISPLAY

    # Call the original `accept-line` to handle syntax highlighting or
    # other potential custom behavior
    _zsh_autosuggest_invoke_original_widget "accept-line"
}

export KEYTIMEOUT=1
bindkey -e '\e' autosuggest-execute
