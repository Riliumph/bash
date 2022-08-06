########## ATTENTION ##########
# It prohibits using "set -u" to detect that a variable is undefined.
# It is only allowed for bash scripts with execution privileges.
# Don't allow "set -u" here

### bash secret power
shopt -s expand_aliases    # for non-interactive shell
shopt -s cdspell           # estimate spell miss
shopt -s dirspell          # complement by ignorring upper & lower case
shopt -s extglob
shopt -s globstar

# if [[ ${PF} == "Cygwin" ]]; then
#   set -o igncr
#   export SHELLOPTS
# fi
