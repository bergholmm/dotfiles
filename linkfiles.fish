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

# zsh lives at ~ not ~/.config
# Move existing non-symlink files aside into $olddir, then symlink from the repo.
mkdir -p ~/.config/zsh
for zf in .zshrc .zshenv
    if test -e ~/$zf; and not test -L ~/$zf
        mv ~/$zf $olddir/
    end
    echo "Creating symlink: ~/$zf -> $dir/zsh/$zf"
    ln -sf $dir/zsh/$zf ~/$zf
end

# Symlink functions/, aliases.zsh, themes/ into ~/.config/zsh so .zshrc can find them
echo "Creating symlink: ~/.config/zsh/functions -> $dir/zsh/functions"
ln -sfn $dir/zsh/functions ~/.config/zsh/functions
echo "Creating symlink: ~/.config/zsh/aliases.zsh -> $dir/zsh/aliases.zsh"
ln -sf $dir/zsh/aliases.zsh ~/.config/zsh/aliases.zsh
echo "Creating symlink: ~/.config/zsh/themes -> $dir/zsh/themes"
ln -sfn $dir/zsh/themes ~/.config/zsh/themes
