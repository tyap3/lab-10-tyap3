#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: ./users3.bash <file>"
  exit 1
fi

if [[ ! -f $1 ]]; then
  echo "The file $1 does not exist."
  exit 2
fi

declare -A userInfo

while IFS=, read -r user name email; do
  userInfo["$user,name"]="$name"
  userInfo["$user,email"]="$email"
done < "$1"

printf "%-9s\t%-20s%-10s\n" "Username" "Full Name" "Email"

for key in "${!userInfo[@]}"; do
  if [[ $key == *",name" ]]; then
    user=${key%,*}
    printf "%-9s\t%-20s%-10s\n" "$user" "${userInfo[$user,name]}" "${userInfo[$user,email]}"
  fi
done