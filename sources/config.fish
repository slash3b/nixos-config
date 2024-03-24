# "inspired" by Derek Taylor (DistroTube)

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set EDITOR "nvim"                 		  # $EDITOR use Emacs in terminal

### SET MANPAGER
### Uncomment only one of these!

### "nvim" as manpager
#set -x MANPAGER "nvim +Man!"

### "less" as manpager
set -x MANPAGER "less -S"

set -x PAGER "less -S"

### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

### git
alias gis='git status'
alias gid='git diff'
alias gids='git diff'

### copy-paste
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# vim and emacs
alias vim='nvim'

# GO (or any other lang)
# set -x GOBIN "$HOME/go/bin"
set -Ua fish_user_paths "$HOME/go/bin"

# direnv 
# trigger direnv at prompt, and on every arrow-based directory change (default)
set -g direnv_fish_mode eval_on_arrow 

# direnv fish config 
direnv hook fish | source

# asdf golang plugin
# https://github.com/asdf-community/asdf-golang
# . ~/.asdf/plugins/golang/set-env.fish

function godoc
    go doc -all $argv | cat -n | less -S
end

# https://github.com/ivakyb/fish_ssh_agent
fish_ssh_agent

# temporary
ssh-add -q

# from mitchelh
if isatty
    set -x GPG_TTY (tty)
end



