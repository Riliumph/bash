# Set up special command path
path="$BASH_ROOT/.local/bin":"$PATH"
# remove path duplicatipn
path=$(echo "${path}" | tr ";" "\\n" | unique | tr "\\n" ";")
PATH=${path}