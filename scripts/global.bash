### global variable tools
asc_order='sort -f'
trim_duplication='awk '\''!dictionaty[$0]++'\'''
if which tac &> /dev/null; then
    reverse_order='tac'
else
    reverse_order='tail -r'
fi
