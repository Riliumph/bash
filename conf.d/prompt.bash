########## TERMINAL CODE ##########
if which git &> /dev/null; then
  LoadGitFiles
  #export GIT_PS1_SHOWUPSTREAM=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWDIRTYSTATE=1
fi

# Enclose in single quotes for dynamic operation
export PROMPT_COMMAND='Dispatch'
# Enclose in double quotes for static operation
SetPrompt
