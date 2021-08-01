### global variable tools
trim_duplication='awk '\''!dictionaty[$0]++'\'''
if which tac &> /dev/null; then
    reverse_order='tac'
else
    reverse_order='tail -r'
fi
