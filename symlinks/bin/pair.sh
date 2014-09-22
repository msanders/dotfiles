#!/usr/bin/env sh
# From http://collectiveidea.com/blog/archives/2014/02/18/a-simple-pair-programming-setup-with-ssh-and-tmux/
set -eu

HELP=false
for flag in "$@"; do
  case "$flag" in
    -h|--help) HELP=true;;
  esac
done

if [ $# -eq 0 -o $HELP = true ]; then
    echo "usage: $(basename "$0") gh-username"
    exit 1
fi

# Create an account alias
sudo dscl . -append "/Users/$USER" RecordName Pair pair

# Configure sshd to only allow public-key authentication
sudo sed -E -i.bak 's/^#?(PasswordAuthentication|ChallengeResponseAuthentication).*$/\1 no/' /etc/sshd_config

# Add pair user public keys
touch ~/.ssh/authorized_keys
gh-auth add --users "$1" --command="$( which tmux ) attach -t pair"
