# Variables
dir=~/.dotfiles
files=".bash_profile .git-completion.bash .git-prompt.sh"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# Create symlinks
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/$file
  echo "- - -"
done

# initialize new settings
source ~/.bash_profile