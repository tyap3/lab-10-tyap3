#!/bin/bash
# Author: Twicee Yap 
# Date: March 27, 2026
# Purpose: Print users from array

users=("tstark" "bbanner" "thor" "srogers" "nromanoff")

for user in "${users[@]}"; do
  echo $user
done