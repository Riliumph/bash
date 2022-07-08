# only use stdin(FD 0)
if [[ -t 0 ]]; then
    stty stop undef  # disable ctrl-s
    stty start undef # disable ctrl-q
fi
