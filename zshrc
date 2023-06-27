{{#if (is_executable "op")}}
{{#if (is_executable "gpg-connect-agent")}}
function gpg_cache () {
  gpg-connect-agent /bye &> /dev/null
  eval $(op signin)
  op item get {{op_item_id}} --fields password | /usr/lib/gnupg/gpg-preset-passphrase --preset {{gpg_key_fingerprint}}
}
{{/if}}
{{/if}}

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILESIZE=20000000

zstyle ':completion:*' menu select
bindkey '^[[Z' reverse-menu-complete

{{#if (command_success "test -d $HOME/zsh-syntax-highlighting")}}
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

{{#if (is_executable "navi")}}
eval "$(navi widget zsh)"
{{/if}}

{{#if (is_executable "atuin")}}
eval "$(atuin init zsh --disable-up-arrow)"
{{/if}}

{{#if (is_executable "fnm")}}
eval "$(fnm env --use-on-cd)"
{{/if}}

{{#if (is_executable "bat")}}
alias cat='bat'
{{/if}}

{{#if (is_executable "exa")}}
alias ls='exa --git --icons --color=always --group-directories-first'
{{/if}}

{{#if (is_executable "zellij")}}
alias ze='zellij'
alias za='zellij a -c'
{{/if}}

{{#if (is_executable "zoxide")}}
eval "$(zoxide init zsh)"
alias cd='z'
{{/if}}

{{#if (is_executable "starship")}}
eval "$(starship init zsh)"
{{/if}}
