### global variable tools
export LAST_STATUS=0 # Initialize status code by 0
# Attention to how to escape single-quotation
unique='awk '\''!dictionaty[$0]++'\''' # Need not sort -f unlike uniq command
