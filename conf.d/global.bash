### global variable tools
export LAST_STATUS=0 # Initialize status code by 0
# Attention to how to escape single-quotation
unique='awk '\''!dictionary[$0]++'\''' # Need not sort -f unlike uniq command

# Check environment value
if [[ ! -v CACHE ]]; then
  # If env variable is undefined, set default path,
  export CACHE=${BASH_ROOT}/cache
fi

# Check log directory existance
if [[ ! -d CACHE ]];then
  mkdir -p ${CACHE}
fi
