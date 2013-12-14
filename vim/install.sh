vundle=~/.vim/bundle/vundle

if [ ! -d "$vundle" ]; then
  git clone https://github.com/gmarik/vundle.git $vundle 
  mkdir ~/.vim/undo ~/.vim/temp
fi

vim +BundleInstall +qall

