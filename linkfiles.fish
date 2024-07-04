#!/usr/bin/env fish
set files direnv fish nvim kitty
set dir $PWD
set olddir $PWD/old

rm -rf $olddir
mkdir -p $olddir

for file in $files
    mv ~/.config/$file $olddir/
end

for file in $files
    echo "Creating symlink: ~/config/.$file -> $dir/$file"
    ln -sf $dir/$file ~/.config/$file
end

mv ~/.tmux.conf $olddir/
echo "Creating symlink: ~/.tmux.conf -> $dir/tmux/.tmux.conf"
ln -sf $dir/tmux/.tmux.conf ~/.tmux.conf
