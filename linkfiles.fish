#!/usr/bin/env fish
set files fish nvim kitty ghostty tmux
set dir $PWD
set olddir $PWD/old

# .config setup
rm -rf $olddir
mkdir -p $olddir

for file in $files
    mv ~/.config/$file $olddir/
end

for file in $files
    echo "Creating symlink: ~/config/.$file -> $dir/$file"
    ln -sf $dir/$file ~/.config/$file
end
