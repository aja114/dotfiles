add-zsh-plugin (){
    git_url=$1
    plugin_name=$(basename -s .git "$git_url")
    plugin_dest=${ZSH_CUSTOM}/plugins/${plugin_name}
    if [ -d "$plugin_dest" ]; then
        cd "$plugin_dest"
        git pull
    else
        git clone $git_url ${ZSH_CUSTOM}/plugins/${plugin_name}
    fi
}