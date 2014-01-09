vundle=~/.vim/bundle/vundle

if [ ! -d "$vundle" ]; then
  mkdir -p ~/.vim/undo ~/.vim/temp $vundle
  git clone https://github.com/gmarik/vundle.git $vundle 
fi

vim +BundleInstall +qall

