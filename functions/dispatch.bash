###
# Dispatch
# Do not write complex and long command in PROMPT_COMMAND directly
# Use the dispatch function that wraps the process
Dispatch()
{
  LAST_STATUS=$?
  share_history
}
