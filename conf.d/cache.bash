### Check cache directory
if [[ ! -v XDG_CACHE_HOME ]]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

# Exist shell variable
if [[ ! -v CACHE ]]; then
  # If env variable is undefined, set default path,
  CACHE="$XDG_CACHE_HOME/bash"
fi

mkdir -p "${CACHE}"

### Check cache file
# Exist shell variable
if [[ ! -v CD_HISTORY ]]; then
  # If env variable is undefined, set default path,
  CD_HISTORY="$CACHE/cd_history.log"
fi

touch "${CD_HISTORY}"
