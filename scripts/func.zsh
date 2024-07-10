timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

restore-vbox(){
  vm=$1
  vbm controlvm $vm poweroff
  vbm snapshot $vm restorecurrent
  vbm startvm $vm --type headless
}

restore-vbox-snap(){
  vm=$1
  snap=$2
  vbm controlvm $vm poweroff
  vbm snapshot $vm restore $snap
  vbm startvm $vm --type headless
}

rm-dry(){
    arg=$1
    if [[ -z arg ]]; then
        echo "no argument passed"
        return 1
    elif [[ -f $arg ]]; then
        echo rm $arg
    elif [[ -d $arg ]]; then
        find $arg -type f -maxdepth 1 -exec echo rm {} \;
        find $arg -type d -maxdepth 2 -exec echo rm {} \;
    else
        echo "passed argument $arg was not found on the fs"
        return 1
    fi
}

# Some extra prompt commands
function p10k-on-pre-prompt() {
  # Script to show the python version on the prompt of the virtual env when activated and not the global pyenv
  if [[ -z $VIRTUAL_ENV ]]; then
    p10k display '1/right/pyenv'=show
  else
    p10k display '1/right/pyenv'=hide
  fi

  if [[ $(hostname) == de01mmaa033.* ]]; then
    p10k display '1/left/context'=hide
  fi
}
