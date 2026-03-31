# Set up special command path
PATH="$BASH_ROOT/.local/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
# remove path duplication until now
PATH="$(path_unique)"
