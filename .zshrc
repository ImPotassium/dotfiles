# Brag about my system when I open my terminal
# I'm gonna do something with this I promise
case $(ps -o comm= -p $PPID) in
   'electron')
      # Config for any Electron terminals, mainly for VSCode
      fastfetch -c ~/.config/fastfetch/electron.jsonc
   ;;
   'yakuake')
      # Config for Yakuake
      fastfetch -c ~/.config/fastfetch/yakuake.jsonc
   ;;
   'dolphin')
      # Config for Dolphin
      
   ;;
   'kitty')
      # Config for Kitty
      fastfetch -c ~/.config/fastfetch/kitty.jsonc
   ;;
   'nvim')
      # Config for Neovim terminal
      fastfetch -c ~/.config/fastfetch/nvim.jsonc
   ;;
   'login')
      # Config for YTT3 terminal
      fastfetch -c ~/.config/fastfetch/ytt.jsonc
   ;;
   *)
      # Default config for everything else
      fastfetch
   ;;
esac

# where plugins are stored
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it isnt
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load Zinit Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light atuinsh/atuin

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Powerlevel10k starting
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# The prompt config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory # share history through all active zsh sessions
setopt hist_ignore_space # command won't be added to the history if you begin with a space
setopt hist_save_no_dups # prevents duplicate commands from entering the history
setopt hist_find_no_dups # prevents duplicate commands from showing in the historical search
setopt hist_ignore_dups # prevents duplicate commands from entering the history

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=hl:#61AFEF,hl+:#4DC4FF,info:#E5C07B,marker:#98C379
  --color=prompt:#C678DD,spinner:#DE73FF,pointer:#DE73FF,header:#56B6C2
  --color=border:#5c6370,scrollbar:#A5E075,label:#aeaeae,query:#ABB2BF
  --border="rounded" --border-label="Double Quarter Pounder with Cheese" --border-label-pos="-8" --preview-window="border-bold"
  --prompt="> " --marker=">" --pointer="◆" --separator=".. ..- ... . .- .-. -.-. .... -... - .-- "
  --scrollbar="I" --layout="reverse"'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Integrations
eval "$(zoxide init --cmd cd zsh)" # change zoxide's command to 'cd' instead of 'z'
eval "$(thefuck --alias)" # so I can curse when I make a mistake
eval "$(atuin init zsh)" # enable atuin; a better history
eval "$(fzf --zsh)" # fuzzy finder keybinds or smth
export BAT_THEME="OneHalfDark" # sets the Bat theme to match Kitty

# Path
export PATH=$PATH:/home/Bam/.local/bin # for pipx

# Aliases
alias bye='shutdown now' # shuts down the system immediately
alias cat='bat' # muscle memory fix
alias freaking='sudo' # because funny but nicer
alias fucking='sudo' # because funny
alias in='yay -S' # Installs (a) package(s) system and aur
alias ls='ls --color' # adds color to the ls command
alias lsa='ls -a --color' # makes it easier to use the ls -a command with color
alias un='yay -Rns' # uninstalls (a) package(s) and useless dependencies
alias up='yay -Syu' # update all packages system and aur
alias vim='nvim' # muscle memory fix
alias wpc='warp-cli connect' # shortens the command to connect to Cloudflare Warp
alias wpd='warp-cli disconnect' # shortens the command to disconnect from Cloudflare Warp
alias xcm='chmod +x' # shortens the command for adding execute perms for files
alias yeet-orphans='sudo pacman -Rs $(pacman -Qtdq)' # deletes orphan packages
