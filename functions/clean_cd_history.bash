###
# CleanCdHistory
CleanCdHistory()
{
  # Read history file
  local -r uniq_ary=($(cat ${CD_HISTORY} \
                  | reverse_order \
                  | unique \
                  | reverse_order))
  \cp $CD_HISTORY $CD_HISTORY.bak &> /dev/null
  :> ${CD_HISTORY} # truncate file
  for line in "${uniq_ary[@]}"; do
    if [[ -e $line ]]; then
      echo $line >> ${CD_HISTORY}
    fi
  done
}

