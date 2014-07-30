function gemo {
  dir=$PWD;
  bundle_dir=`bundle show $1`;
  echo $bundle_dir;
  cd $bundle_dir;
  mvim .;
  cd $dir;
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
