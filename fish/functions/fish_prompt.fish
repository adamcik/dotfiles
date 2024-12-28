function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l last_status $status
    set -l normal (set_color normal)

    set -l user
    if test $USER != "adamcik"
    	set -l user (set_color $fish_color_user) "$USER" $normal @
    end

    set -l color_host $fish_color_host
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    set -l prompt_status (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    echo -n -s $user (set_color $color_host) (prompt_hostname) $normal ':' (set_color -o $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal $prompt_status "> "
end
