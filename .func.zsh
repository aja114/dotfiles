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