# Install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fssl https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fssl https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# Add the config 
echo "source $HOME/dotfiles/.zshrc" > $HOME/.zshrc


