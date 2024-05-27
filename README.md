# Cairo
Cairo learning

## Steps for Cairo && Scrab

### Install WSL
wsl --install


### Install ASDF
sudo apt update
sudo apt upgrade


git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0


Add the following lines to your ~/.bashrc (or ~/.zshrc if you are using Zsh):
bash

"$HOME/.asdf/asdf.sh"
"$HOME/.asdf/completions/asdf.bash"
 


 Check if it is working
 source ~/.bashrc

### Install Scrab

asdf plugin add scarb

curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh

$ scarb --version
scarb 2.6.3 (e6f921dfd 2024-03-13)
cairo: 2.6.3 (https://crates.io/crates/cairo-lang-compiler/2.6.3)
sierra: 1.5.0


### LINUX BASICS

pwd - location 

cd .. - back


cd mnt - work with windows 


### Create projects

scarb new project_name

scarb build

scarb cairo-run