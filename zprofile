export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/balena-cli:$PATH"

{{#if (command_success "test -d $HOME/go")}}
export PATH="$PATH:$HOME/go/bin"
export GOROOT=$(go1.20.3 env GOROOT)
export PATH="$PATH:$GOROOT/bin"
export GOPRIVATE="github.com/beeb"
{{/if}}

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export PATH="$PATH:$HOME/.foundry/bin"

{{#if (command_success "test -f $HOME/.cargo/env")}}
. "$HOME/.cargo/env"
{{/if}}