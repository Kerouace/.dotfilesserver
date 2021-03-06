
# .dotfiles
My Server and root account dotfiles.

## Required and Recommended Software
### Required
- lsd
- git
- tmux
- neovim
### Recommended
- zsh (highly recommended) (change shell with: ```chsh -s /bin/zsh```)
- sc-im

## Migration of my dotfiles to other system
### set alias in .bashrc
```alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'```
### clone this repository
```git clone --bare https://github.com/Kerouace/.dotfilesserver $HOME/.dotfiles```
### checkout changes
```config checkout```
### backup old files
```mkdir -p .config-backup && \ 
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```
### checkout changes
```config checkout```
### set showUntrackedFiles to no
```config config --local status.showUntrackedFiles no```
### pull current setup
```config pull```
