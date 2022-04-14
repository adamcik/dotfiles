function fish_title
    # this one sets the X terminal window title
    # argv[1] has the full command line
    echo (hostname): (pwd): $argv[1]

    switch "$TERM"
    case 'screen*'

      # prepend hostname to screen(1) title only if on ssh
      if set -q SSH_CLIENT
        set maybehost (hostname):
      else
        set maybehost ""
      end

      # inside the function fish_title(), we need to
      # force stdout to reach the terminal
      #
      # (status current-command) gives only the command name
      echo -ne "\\ek"$maybehost(status current-command)"\\e\\" > /dev/tty
    end
end
