#!/bin/bash
# Author: Twicee Yap
# Date: March 27, 2026

users=($(cut -d"," -f1 userinfo.csv))

echo "Usernames:"

for user in "${users[@]}"; do
  echo "$user"
done