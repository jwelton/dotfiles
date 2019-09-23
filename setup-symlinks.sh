# Variables
dir=~/.dotfiles
files=".bash_profile .git-completion.bash .git-prompt.sh"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# Create symlinks
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s -f $dir/$file ~/$file
done

# initialize new settings
echo "Initializing new bash settings"
source ~/.bash_profile


# Setup custom Xcode theme. Credit goes to: https://github.com/bojan/xcode-one-dark
echo "Creating symlink for XCode theme."
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
ln ./One\ Dark.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes
