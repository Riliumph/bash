# Set up special command path
export PATH="${BASH_ROOT}/.local/bin":${PATH}

# remove path duplicatipn
export PATH=$(echo ${PATH} | tr ";" "\\n" | unique | tr "\\n" ";")
