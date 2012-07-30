function gemo {
  dir=$PWD;
  bundle_dir=`bundle show $1`;
  echo $bundle_dir;
  cd $bundle_dir;
  mvim .;
  cd $dir;
}
