# Ctrl+Up-Arrow : Move parent directory
if [[ ${PS1} ]]; then
	# \e[1;5A : Ctrl-Up
	# \er : redraw PS1 @ GNU readline
	bind '"\e[1;5A":"\ercd ../\n"'
	# Attention: No need bind's option "-x"
fi

