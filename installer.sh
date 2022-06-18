# Install oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then:
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi;

# Add the config 
cat "source ~/dotfiles/.zshrc" > ~/.zshrc


