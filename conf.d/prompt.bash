########## TERMINAL CODE ##########
if command -v git &> /dev/null; then
  #export GIT_PS1_SHOWUPSTREAM=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWDIRTYSTATE=1
fi

# Register the function name intentionally so the prompt can change dynamically each time.
export PROMPT_COMMAND='Dispatch'
# Enclose in double quotes for static operation
SetPrompt
