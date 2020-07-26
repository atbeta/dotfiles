# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

zinit ice depth=1; zinit light romkatv/powerlevel10k
# Two regular plugins loaded without investigating.
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma/history-search-multi-word

# Oh My Zsh and Prezto
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet PZT::modules/helper/init.zsh
zinit snippet PZT::modules/completion/init.zsh

# Other plugins
zinit light tj/git-extras
zinit load agkozak/zsh-z

### End of Zinit's installer chunk

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Vim mode default
bindkey -v

# Custom alias
proxy() {
    export https_proxy=http://127.0.0.1:6152
    export http_proxy=http://127.0.0.1:6152
    export all_proxy=socks5://127.0.0.1:6153
    echo "All proxy on"
}
unproxy() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo "All proxy off"
}

alias vim='nvim'
alias cat='bat'
alias ls='exa --icons --group-directories-first'
alias help='tldr'

# fzf alias
alias vimf='vim $(fzf)'
alias cdf='cd $(find * -type d | fzf)'

# fzf config
export FZF_DEFAULT_OPTS="--height 100% --layout=reverse --preview 'bat --color \"always\" {}'"
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --type f"


# Other custom config
# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh

# asdf
. $HOME/.asdf/asdf.sh

# rust
source $HOME/.cargo/env
export PATH="$PATH:$HOME/.local/share/flutter/bin"
export PATH="$PATH:$HOME/.local/share/flutter/bin/cache/dart-sdk/bin"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Android Studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init - zsh)"

# Clangd path
export PATH=$PATH:/usr/local//Cellar/llvm/10.0.0_3/bin
