### global variable tools
LAST_STATUS=0 # Initialize status code by 0

# Exsit shell variable
if [[ ! -v CACHE ]]; then
  # If env variable is undefined, set default path,
  CACHE=${BASH_ROOT}/cache
fi

# Check log directory existance
if [[ ! -d CACHE ]];then
  mkdir -p ${CACHE}
fi
