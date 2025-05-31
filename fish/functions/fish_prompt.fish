function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l last_status $status

    echo -s

    if test $USER != "adamcik"
      echo -n -s (set_color $fish_color_user) "$USER" $n @
    end

    if set -q SSH_CONNECTION
      echo -n -s (set_color $fish_color_host_remote)
    else
      echo -n -s (set_color $fish_color_host)
    end

    echo -n -s (prompt_hostname) (set_color normal) ':' (set_color -o $color_cwd) (prompt_pwd)

    echo -n -s (set_color normal) (fish_vcs_prompt)

    if set -q VIRTUAL_ENV
      echo -n -s (set_color normal) " [" (basename "$VIRTUAL_ENV") "] "
    end

    echo -n -s (set_color normal) (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    echo -s
    echo -n -s (set_color normal) '$ '
end
