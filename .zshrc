########################### PLUGINS ##################################

source ~/.zplug/init.zsh

zplug "aloxaf/fzf-tab"
zplug "laggardkernel/zsh-thefuck", defer:2
zplug "supercrabtree/k", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "subnixr/minimal"
zplug load #--verbose

########################## SYNTAX HIGHLIGHTING #######################
cd ~/wsz

[[ $- != *i* ]] && return
# Otherwise start tmux
[[ -z "$TMUX" ]] && exec tmux
export PATH=~/.local/bin:~/wsz/bin:/mnt/nfs/homes/wszurkow/.local/lib/python3.8/site-packages:$PATH
ZSH_HIGHLIGHT_STYLES[path]='fg=gray, italic'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=magenta'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty)

########################## SUBNIXR THEME SETTINGS ######################

MNML_PROMPT=(mnml_status mnml_cwd)
MNML_MAGICENTER=()
MNML_INFOLN=()
MNML_OK_COLOR=5
MNML_ERR_COLOR=3

########################### BINDKEYS #################################
#
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char
bindkey    "^F" 			fzf-file-widget
# Autocompletes even if no whitespace
# BREAKS FZF TAB
#bindkey '^i' expand-or-complete-prefix # https://stackoverflow.com/questions/37772712/zsh-how-to-make-tab-completion-need-no-space-to-next-word-after-cursor

####################### ZSH COMPLETION SUBSTRING #####################

#zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

######################## TMUX ###################################

#if [ "$TMUX" = "" ]; then tmux; fi

######################### HISTORY ###################################

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY
setopt appendhistory
setopt AUTO_CD
#setopt ALWAYS_TO_END

########################### SOURCE ###################################

source ~/.fzf/shell/key-bindings.zsh
source ~/.fzf/shell/completion.zsh
#source /etc/profile.d/autojump.zsh
#source /home/wsz/.config/broot/launcher/bash/br

########################### DOTFILES ##################################

alias zrc="vim ~/.zshrc"
alias zpf="vim ~/.zprofile"
alias xrc="vim ~/.xinitrc"
alias vrc="vim ~/.vimrc"
alias vimc="vim ~/.vim/ftplugin/c_mappings.vim"
alias csnippets="vim /home/wsz/.config/coc/ultisnips/c.snippets"
alias vdir="vim ~/.dot/vim/"
alias krc="vim ~/.config/kitty/kitty.conf"
alias irc="vim ~/.config/i3/config"
alias ibrc="vim ~/.config/i3/i3blocks.conf"
alias isrc="vim ~/.config/i3/i3status.conf"
alias ib2rc="vim ~/.config/i3/i3blocks2.conf"
alias trc="vim ~/.tmux.conf"
alias config="cd ~/.config"

########################## VIM ######################################

FILE="/etc/passwd"
alias vim="nvim -u ~/.vimrc"

########################### FASD ###############################

eval "$(~/wsz/bin/fasd --init auto)"
alias j="fasd_cd -d"
alias vv="f -e nvim"
alias v="xdotool key v i m space asterisk asterisk Tab"
alias c="xdotool key c d space asterisk asterisk Tab"

########################### TRASH-CLI ###############################

alias del="trash-put"
alias dells="trash-list"
alias restore="trash-restore"
alias delete="mv -t ~/.Trash/"
#set -o noclobber # prevent > override


########################### ALIASES ##################################

### DEFAULTS
alias ..="cd .."
alias cddl="cd ~/Downloads"
alias back="~/.dot/backup.sh"
alias autopush="git add .; git status; git commit -m "autopush"; git push"
alias n0="vim $DOT/notes.md"
alias norme="norminette"
#alias valgrind_color="~/.local/bin/colour-valgrind"
#if [ -f ~/.local/bin/colour-valgrind ]; then alias valgrind="valgrind_color --tool=memcheck --leak-check=full --leak-resolution=high --show-reachable=yes" ; fi
alias valgrind="valgrind --tool=memcheck --leak-check=full --leak-resolution=high --show-reachable=no -s --leak-check=full "


### MISC
alias cal="cal -m"
alias vsch="vim ~/.dot/sch.md"
alias 42="cd ~/42"
alias powertop="sudo powertop"
alias autotune="sudo powertop --auto-tune"
alias playlist="vim ~/.dot/playlist"
alias tmp="cd ~/.tmp"
alias dot="cd ~/.dot"
alias ddgr="ddgr --colors 'djcddf'"
alias rain="buku -a"
alias buku="buku --colors 'djedf'"

### GIT
alias gcl="git clone"
alias gch="git checkout"

### SSH
if [ $TERM = "xterm-kitty" ] ; then alias ssh="kitty +kitten ssh" ; fi

### GIT
alias gitls="curl -s \"https://api.github.com/users/wszki/repos?per_page=100\" | grep -o 'git@[^\"]*'"

### IP SCAN
alias nmap_scan="sudo arpi"
alias nmap_scan_0="sudo arpi -net=192.168.0.0/24 && sudo arpi"

########################### AUDIO ##################################

### SUPERCOLLIDER
alias collider="pasuspender -- jackd ; jackd -r -d alsa &> /dev/null & vim -c "SCNvimStart" ~/.dot/supercollider/main.sc && killall jackd"
#alias startjack="pasuspender -- jackd ; jackd -r -d alsa &> /dev/null &"
#alias collider="vim  ~/.dot/supercollider/main.sc"

### RENOISE
alias renoise="pasuspender -- jackd ; jackd -r -d alsa &> /dev/null & /usr/local/bin/renoise-3.3.1 && killall jackd"

########################## PACKAGE MANAGER ########################

### PACMAN
alias pac="sudo pacman -S"
alias pacss="pacman -Ss"
alias pacsyu="sudo pacman -Syu"
alias pac-orphans="pacman -Qtd"

### YAY
alias yay-cache-clear="rm ~/.cache/yay/completion.cache"

### MISC
alias mpv360="mpv --ytdl-format=18"
alias mpv720="mpv --ytdl-format=18"
alias ntf="notify.sh"
alias cppwd="pwd | copy"
alias ,,="i3-msg move to scratchpad"
alias info="info -v match-style=black,bgred,bold -v active-link-style=black,bgyellow,bold -v link-style=yellow"
alias copy="xclip -sel clip"
alias ytfzf="ytfzf -t"
alias ack="ack --color-match=yellow --color-lineno=magenta --color-filename=blue"
alias ipinfo="curl ipinfo.io"
alias internet_log="ss -p"
alias session_screen_share="cd ; mkfifo sharescreen; script -f sharescreen"
alias screenshot_terminal="ps aux | convert label:@- process.png"
alias veille="systemctl suspend && slock"
alias services="systemctl --type=service"
alias bday="birthday -f ~/.dot/schedule"
alias schedule="vim ~/.dot/schedule"
###     PERFORMANCE
alias governor-performance="sudo cpupower frequency-set -g performance"
alias governor-powersave="sudo cpupower frequency-set -g powersave"
alias governor-ondemand="sudo cpupower frequency-set -g ondemand"
alias governor-conservative="sudo cpupower frequency-set -g conservative"
alias powertop-report="sudo powertop --html=powerreport.html"
### K IS LS
alias sl="ls"
alias ka="k -Ah"
alias kk="k -Ah"
alias ls="k -h"
alias l="k -h"
alias lsa="k -hA --sort WORD"

########################################################################
############################### TRASH ##################################
########################################################################

## DOCKER
#alias docker_start="sudo systemctl start docker.service"
#alias docker_stop="sudo systemctl stop docker.service"

### C
#alias gcc="clang"
#alias gccc="gcc -Wall -Werror -Wextra"
#alias clangc="gcc -Wall -Werror -Wextra"
#alias gccf="gcc -g -fsanitize=address -Wall -Werror -Wextra"
#alias clangf="gcc -g -fsanitize=address -Wall -Werror -Wextra"
##alias norminette="~/.norminette/norminette.rb"
#alias norme="norminette -R CheckForbiddenSourceHeader"
#alias grademe="~/42/Libftest/grademe.sh -n"
#alias deepthought="vim ~/42/Libftest/deepthought"
#alias gnl="cd ~/42/gnl"
#alias bundle="~/.gem/ruby/2.7.0/bin/bundle"
#alias ftsrv="cd ~/42/ft_server"
#alias ddbuild="docker build -t server . && docker create -it server /bin/bash &&  "
#### TASK
#alias ,t="task"
#alias t="clear & task summary ; task list rc.dateformat=a_d/m_H:N ; task calendar "
#alias ,tdt="task due:tomorrowT12:00"
#alias ,tdl="task delete"
#alias ,tadd="task add"
#alias ddd="cd ~/42/cub3d"

### CUB3D
#alias man_mlx="man /usr/local/man/man3/mlx.1"
#alias man_mlx_loop="man /usr/local/man/man3/mlx_loop.1"
#alias man_mlx_new_image="man /usr/local/man/man3/mlx_new_image.1"
#alias man_mlx_pixel="man /usr/local/man/man3/mlx_pixel_put.1"
#alias man_mlx_window="man /usr/local/man/man3/mlx_new_window.1"
#alias c3d="cd ~/42/cub3d"
#alias gcc_mlx="gcc -I /usr/local/include/  main.c -L /usr/local/lib/ -lXext -lX11 -lmlx"
## task add Pay rent due:28th recur:monthly until:now+1yr


## SERVER
#alias server-start="sudo systemctl start mariadb.service; sudo systemctl start httpd.service"
#alias server-stop="sudo systemctl stop mariadb.service; sudo systemctl stop httpd.service"
#alias server-restart="sudo systemctl restart mariadb.service; sudo systemctl restart httpd.service"


### MPV
#alias mpyt="mpv --playlist=/home/wsz/.playlist --shuffle --no-video"
#alias mpsyt="~/.local/bin/mpsyt"


### YOUTUBLE DL
#
#alias youtube-dl-mp3="youtube-dl --extract-audio --audio-format mp3     "
#alias ytdlm="cdyt; youtube-dl -x --audio-format wav"
#alias dddl="cdyt; youtube-dl -xi --audio-format wav"
#alias dddlhere="youtube-dl -xi --audio-format wav"
#alias ddlddl="cdyt; youtube-dl -xi --audio-format wav --no-playlist"
#alias youtube-dl-wav="youtube-dl -xo '%(title)s.%(ext)s' --audio-format wav"
#alias youtube-dl-playlist="youtube-dl -a playlist -xo '%(title)s.%(ext)s' --audio-format wav"



### RM LOCK
#alias rm="rm -i"

## DATABASE
#alias maria="sudo mariadb"
#alias portinfo="sudo nmap -n -PN -sT -sU -p- localhost"

### CCAT
#alias cat="/bin/ccat --color=always"
#alias catc="/bin/ccat --color=always"

### GDB TUI
#alias db="gdb -tui -q"
#alias gdb="gdb -q"



### XCLIP
#alias pbc="xclip -selection clipboard"
#alias pbp="xclip -selection clipboard -o"

#alias f="fzf -e --preview='cat {}'  --preview-window=right:50%:wrap"
#alias a="ack --color-match=yellow --color-lineno=magenta --color-filename=blue"
#
#
#
#
#
#
#
#alias is="vim ~/Tree/Suckless/installScript/installScript.sh"
#alias edp_1="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --off --output DP-2-2 --off --output DP-2-3 --off"
#alias hdmion="xrandr --output HDMI-2 --auto --above eDP-1"
#alias hdmioff="xrandr --output HDMI-2 --off"
#alias docked-1=" xrandr --output eDP-1 --primary --mode 1920x1080 --pos 773x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1800x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --mode 1440x900 --pos 0x315 --rotate normal; xrandr --output DP-2-3"
##alias docked-1=" xrandr --output eDP-1 --primary --mode 1920x1080 --pos 773x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1800x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --mode 1440x900 --pos 0x315 --rotate normal; xrandr --output DP-2-3 --scale 1.25x1.25 "
##alias docked-1="xrandr --output DP-2-3 --scale 1.25x1.25 ; xrandr --output eDP-1 --primary --mode 1920x1080 --pos 773x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1800x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --mode 1440x900 --pos 0x315 --rotate normal; "
##alias docked-1="edp_1 ; xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1253x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --mode 1440x900 --pos 480x540 --rotate normal"
#alias docked-1="edp_1 && xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1280x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1280x0 --rotate normal --output DP-2-2 --mode 1280x1024 --pos 0x584 --rotate normal --output DP-2-3 --off"
#alias vga-1h="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off"
#alias vga-1v="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1920 --rotate normal --output DP-1 --mode 1920x1080 --pos 840x0 --rotate left --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off"
#alias vga-off="xrandr --output DP-1 --off"
#alias dualon="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 2025x1440 --rotate normal --output DP-1 --mode 1920x1080 --pos 1060x360 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 2560x1440 --pos 2980x0 --rotate normal"
#alias dualon2="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 366x1920 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 2560x1440 --pos 1080x480 --rotate normal"
#alias toweron1="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1080x1440 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 2560x1440 --pos 1080x0 --rotate normal"
#alias towerson="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1080x2560 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x1254 --rotate left --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 2560x1440 --pos 1080x0 --rotate left"
#alias ethernet="sudo systemctl start dhcpcd@enp0s31f6"
##alias vcv="cd ~/Tree/Rack/ && ./Rack"
#alias persist="nohup"
#alias showssh="cat ~/.ssh/id_rsa.pub"
#alias yank="xclip -sel clip"
## xinput --list | grep TouchPad
## TID=$(xinput list | grep -iPo 'touchpad.*id=\K\d+')
alias touchpad_restart="xinput disable 11 && xinput enable 11"



######  SERVICES
###     WIFI
#alias ip-info="ifconfig | grep \"inet \" | grep -v 127.0.0.1"
#alias wifi-auto-on="sudo systemctl enable netctl-auto@wlan0.service && sudo systemctl start netctl-auto@wlan0.service"
#alias wifi-auto-off="sudo systemctl disable netctl-auto@wlan0.service && sudo systemctl stop netctl-auto@wlan0.service"
#alias wifi="sudo wifi-menu"
#alias nmap-local="sudo nmap -sn 192.168.0.0/24"
#alias wifi-restart="sudo systemctl restart netctl-auto@wlan0.service"
#alias wifi_on="nmcli radio wifi on"
#alias wifi_off="nmcli radio wifi off"

#alias p="ping google.fr"

###     BLUETOOTH
#alias bluestart="sudo systemctl enable bluetooth.service && sudo systemctl start bluetooth.service"
#alias bluestop="sudo systemctl disable bluetooth.service && sudo systemctl stop bluetooth.service"


###     LOGIND.CONF
#alias nosleep="sudo vim /etc/systemd/logind.conf"

###     SLEEP
#alias sleep-off="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
#alias sleep-on="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"

###     BATTERY
#alias battery-monitor="udevadm monitor --property"

###		AUDIO
#alias glitchout="aplay /bin/*"



#####################################################################################

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
#DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
