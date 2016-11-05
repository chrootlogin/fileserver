#!/bin/bash

function move_user2passwd {
  for file in passwd shadow group; do
    grep "$1" /var/lib/extrausers/$file >> /etc/$file
    grep -v "$1" /var/lib/extrausers/$file >> /var/lib/extrausers/$file.tmp
    mv /var/lib/extrausers/$file.tmp /var/lib/extrausers/$file
  done
}

function move_user2extrapasswd {
  for file in passwd shadow group; do
    grep "$1" /etc/$file >> /var/lib/extrausers/$file
    grep -v "$1" /etc/$file > /etc/$file.tmp
    mv /etc/$file.tmp /etc/$file
  done
}

case $2 in
  add_user)
    echo "Creating user '$3'..."

    useradd -M "$3"
    echo "$3:$4" | chpasswd
    echo -e "$4\n$4" | (smbpasswd -a -s "$3")
    move_user2extrapasswd "$3"
  ;;
  add_group)
    echo "Creating group '$3'..."

    groupadd "$3"
    move_user2extrapasswd "$3"
  ;;
  add_user_to_group)
    echo "Adding user '$3' to group '$4'..."

    move_user2passwd "$4"
    usermod -a -G "$4" "$3"
    move_user2extrapasswd "$4"
  ;;
  delete_user)
    echo "Removing user '$3'..."

    move_user2passwd "$3"
    userdel "$3"
  ;;
  password)
    echo "Changing password of user '$3'..."

    move_user2passwd "$3"
    echo "$3:$4" | chpasswd
    echo -e "$4\n$4" | (smbpasswd -a -s "$3")
    move_user2extrapasswd "$3"
  ;;
  *)
    echo "rootLogin/fileserver management utility"
    echo "---------------------------------------"
    echo
    echo "Usage:"
    echo
    echo "manage add_user [USERNAME] [PASSWORD]"
    echo "  Adds a new user."
    echo
    echo "manage add_group [GROUPNAME]"
    echo "  Adds a new group."
    echo
    echo "manage add_user_to_group [USERNAME] [GROUPNAME]"
    echo "  Adds a user to a group."
    echo
    echo "manage delete_user [USERNAME]"
    echo "  Remove a user."
    echo
    echo "manage password [USERNAME] [PASSWORD]"
    echo "  Reset a user password."
esac
