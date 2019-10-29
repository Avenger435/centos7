#!/bin/bash


# create file descriptor pointing into stdout in order to allow functions to echo directly to telminal
exec 99>&1

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

main () {
  USER_NAME=$(userInput "Enter Nexus username" "") && [ "$USER_NAME" = "" ] && echo "User name can not be empty" && exit 1
  PASSWORD=$(userInputHidden "Enter Nexus password" "") && [ "$PASSWORD" = "" ] && echo "Password can not be empty" && exit 1
  PASSWORD2=$(userInputHidden "Re-enter Nexus password" "") 
  [ "$PASSWORD" != "$PASSWORD2" ] && echo "Passwords did not match" && exit 1

  ENCRYPTED=$(mvn --encrypt-password "$PASSWORD")
  [ "$?" != "0" ] && echo "Encyprion of password failed: $ENCRYPTED" && exit 1

  sed -i "s:<username>.*</username>:<username>$USER_NAME</username>:g" "$BASE_DIR/settings.xml"
  [ "$?" != "0" ] && echo "Updating username to $BASE_DIR/settings.xml failed" && exit 1
  sed -i "s:<password>.*</password>:<password>$ENCRYPTED</password>:g" "$BASE_DIR/settings.xml"
  [ "$?" != "0" ] && echo "Updating password to $BASE_DIR/settings.xml failed" && exit 1
  
  echo "Username and password updated to $BASE_DIR/settings.xml"

}

function userInput() {
  local __question=$1
  local __default=$2
  local __answer=""

  read -p $__extra_args "$__question ($__default): " __answer
  if [ "$__answer" = "" ]; then
    echo $__default
  else
    echo $__answer
  fi
}

function userInputHidden() {
  local __question=$1
  local __default=$2
  local __answer=""

  read -s -p $__extra_args "$__question ($__default): " __answer
  echo "" 1>&99
  if [ "$__answer" = "" ]; then
    echo $__default
  else
    echo $__answer
  fi
}

main