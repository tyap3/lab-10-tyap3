#!/bin/bash

if [[ $(whoami) != root ]]; then
  echo "You must run this script with root privileges."
  exit 1
fi

if [[ $# -ne 2 ]]; then
  echo "Usage: ./createusers.bash -i <filename>"
  exit 2
fi

while getopts "i:" opt; do
  case $opt in
    i) filename=$OPTARG ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 3
      ;;
  esac
done

if [[ ! -f $filename ]]; then
  echo "The file $filename does not exist."
  exit 4
fi

declare -A userInfo

while IFS=, read -r user name email; do
  userInfo["$user,name"]="$name"
  userInfo["$user,email"]="$email"
done < "$filename"

for key in "${!userInfo[@]}"; do
  if [[ $key == *",name" ]]; then
    user=${key%,*}
    password=$(openssl rand -base64 12)

    useradd -c "${userInfo[$user,name]}" -m $user -p $password

    cat << EOF
Account Information:
Username: $user
Full Name: ${userInfo[$user,name]}
Email: ${userInfo[$user,email]}
Password: $password

EOF
  fi
done

echo "Accounts have been created."