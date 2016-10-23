#!/bin/bash

function update_ent {
  tail -n1 /etc/passwd >> /var/lib/extrausers/passwd
  tail -n1 /etc/shadow >> /var/lib/extrausers/shadow
  tail -n1 /etc/group >> /var/lib/extrausers/group
  grep -v $1 /etc/passwd > /etc/passwd
  grep -v $1 /etc/shadow > /etc/shadow
  grep -v $1 /etc/group > /etc/group
}

case $2 in
  add)
    echo "Creating user '$3'..."
    useradd -M "$3"
    echo "$3:$4" | chpasswd
    echo -e "$4\n$4" | (smbpasswd -a -s "$3")
    update_ent $3
  ;;
  delete)
    echo "Removing user '$3'..."
    cp /etc/passwd /etc/shadow /etc/group /tmp/

    for file in passwd shadow group; do
      cat /var/lib/extrausers/$file >> /etc/$file
    done

    userdel $3

    for file in passwd shadow group; do
      diff /tmp/$file /etc/$file | sed -n '/^-[^-]/{ s/^-//; p; }' >> /var/lib/extrausers/$file
    done
  ;;
  password)
    echo "Changing password of user '$3'..."
    echo "$3:$4" | chpasswd
    echo -e "$4\n$4" | (smbpasswd -a -s "$3")
    update_ent $3
  ;;
  *)
    echo "Usage:"
    echo
    echo "manage add [USERNAME] [PASSWORD]"
    echo "  Adds a new user."
    echo
    echo "manage delete [USERNAME]"
    echo "  Remove a user."
    echo
    echo "manage password [USERNAME] [PASSWORD]"
    echo "  Reset a user password."
esac
