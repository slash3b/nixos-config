# "inspired" by Derek Taylor (DistroTube)

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set EDITOR "nvim"                 		  # $EDITOR use Emacs in terminal

### SET MANPAGER
### Uncomment only one of these!

### "nvim" as manpager
#set -x MANPAGER "nvim +Man!"

### "less" as manpager
set -x MANPAGER "less"

### ALIASES ###
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias vim='nvim'
