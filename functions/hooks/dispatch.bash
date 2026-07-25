###
# Dispatch
# Do not write complex and long command in PROMPT_COMMAND directly
# Use the dispatch function that wraps the process
Dispatch()
{
  # Preserve previous command status before running prompt hooks.
  export LAST_STATUS=$?
  SyncHistory
}
