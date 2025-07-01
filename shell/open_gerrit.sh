#!/bin/bash
open_gerrit () {
        url=$(git remote get-url origin | sed -E 's#ssh://[^@]+@([^:]+):[0-9]+/#https://\1/admin/repos/#')
        echo "Opening $url..."
        if [[ -e "$HOME/.last_ssh_ip" ]]; then
                ip=$(cat "$HOME/.last_ssh_ip")
                ssh "$(whoami)@$ip" "open \"$url\""
        fi
}
