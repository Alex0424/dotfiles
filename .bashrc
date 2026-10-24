export EDITOR=nvim #/etc/environment
export ELECTRON_OZONE_PLATFORM_HINT=wayland

alias cdw='cd /home/alex/repo/work'
alias cdp='cd /home/alex/repo/personal'
alias sky='astroterm --unicode --constellation --color -i Stockholm --metadata -q'

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH" # User specific environment
fi
export PATH

if [ -f /etc/bashrc ]; then
  . /etc/bashrc # Source global definitions
fi

if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc" # User specific aliases and functions
    fi
  done
fi
unset rc

eval "$(ssh-agent -s)" && ssh-add ~/.ssh/work_gh
#eval "$(ssh-agent -s)" && ssh-add ~/.ssh/personal_gh

eval "$(starship init bash)"
