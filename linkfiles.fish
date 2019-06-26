#!/usr/bin/env fish
set files config/* tmux.conf skhdrc chunkwmrc yabairc
set dir ~/dotfiles
set olddir ~/dotfiles/old

rm -rf $olddir
mkdir -p $olddir

for file in $files;
    rm -rf $olddir/.$file;
    mv ~/.$file $olddir/;
end

for file in $files;
    echo "Creating symlink: ~/.$file -> $dir/$file"
    ln -sf $dir/$file ~/.$file;
end
