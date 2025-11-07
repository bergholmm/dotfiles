#!/usr/bin/env fish
set files fish nvim kitty
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

# tmux setup
mv ~/.tmux.conf $olddir/
echo "Creating symlink: ~/.tmux.conf -> $dir/tmux/.tmux.conf"
ln -sf $dir/tmux/.tmux.conf ~/.tmux.conf

# .zshrc setup
mv ~/.zshrc $olddir/
ln -sf $dir/zsh/.zshrc ~/.zshrc
