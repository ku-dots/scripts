#!/bin/bash
#  _ _     _                    _                         _               _         
# | (_)___| |_ _ __   __ _  ___| | ____ _  __ _  ___  ___| |__  _   _ ___(_)_______ 
# | | / __| __| '_ \ / _` |/ __| |/ / _` |/ _` |/ _ \/ __| '_ \| | | / __| |_  / _ \
# | | \__ \ |_| |_) | (_| | (__|   < (_| | (_| |  __/\__ \ |_) | |_| \__ \ |/ /  __/
# |_|_|___/\__| .__/ \__,_|\___|_|\_\__,_|\__, |\___||___/_.__/ \__, |___/_/___\___|
#            |_|                         |___/                 |___/               
#

paru -Qq | xargs -r pacman -Qi | awk -F ': ' '
/^Name/ {name=$2}
/^Installed Size/ {
  size_str=$2
  if (size_str ~ /KiB/) size=size_str + 0
  else if (size_str ~ /MiB/) size=(size_str + 0) * 1024
  else if (size_str ~ /GiB/) size=(size_str + 0) * 1024 * 1024
  packages[name] = size
}
END {
  for (pkg in packages)
    printf "%10.2f KiB\t%s\n", packages[pkg], pkg
}' | sort -nr
