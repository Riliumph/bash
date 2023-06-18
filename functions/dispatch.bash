###
# Dispatch
# Do not write complex and long command in PROMPT_COMMAND directly
# Use the dispatch function that wraps the process
Dispatch()
{
  export LAST_STATUS=$?
  control_history ${LAST_STATUS}
}
