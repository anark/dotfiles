function gemo {
  dir=$PWD;
  bundle_dir=`bundle show $1`;
  echo $bundle_dir;
  cd $bundle_dir;
  mvim .;
  cd $dir;
}

export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
export AWS_CLOUDFORMATION_HOME="/usr/local/Library/LinkedKegs/aws-cfn-tools/jars"
export AWS_CREDENTIAL_FILE="$HOME/.aws_credentials"

export PATH=$PATH:$EC2_HOME/bin
