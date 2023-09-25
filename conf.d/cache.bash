### Check cache directory
if [[ ! -v XDG_CACHE_HOME ]]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

# Exist shell variable
if [[ ! -v CACHE ]]; then
  # If env variable is undefined, set default path,
  CACHE="$XDG_CACHE_HOME/bash"
fi

# Check log directory existance
if [[ ! -d CACHE ]]; then
  mkdir -p "${CACHE}"
fi

### Check cache file
# Exist shell variable
if [[ ! -v CD_HISTORY ]]; then
  # If env variable is undefined, set default path,
  CD_HISTORY="$CACHE/cd_history.log"
fi

# Check log file existance
if [[ ! -f CD_HISTORY ]]; then
  touch "${CD_HISTORY}"
fi
