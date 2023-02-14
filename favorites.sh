#!/bin/bash

#
## FUNCTIONS
#

function save {
    currDir=$(echo $(pwd) | sed 's/ /\\ /g')
    echo "$1 -> $currDir" >> ~/.favoris_bash
    echo "Le répertoire $(pwd) est sauvegardé dans vos favoris"
    echo "-> Raccourci : $1"
}

function go {
    if [ $(echo $1 | grep -c "/") -eq 0 ]; then
        dir=$(cat ~/.favoris_bash | grep "^$1" | cut -d'>' -f2 | sed 's/\\ / /g' | sed 's/^ *//g' | sed 's/ *$//g')
        if [ $(echo "$dir" | wc -l) -gt 1 ]; then
            echo "Plusieurs répertoires correspondent à votre recherche"
            echo "$dir"
            exit 1
        fi
        if [ -z "$dir" ]; then
            echo "Aucun répertoire ne correspond à votre recherche"
            exit 1
        fi
        cd "$dir"
        $SHELL # Force the shell to reload the new path (otherwise, it will not work)
        exit 0
    fi
}

function remove {
    sed -i '' "/^$1/d" ~/.favoris_bash
}

function list {
    cat ~/.favoris_bash
}

#
## SCRIPT
#

if [ ! -f ~/.favoris_bash ]; then
    touch ~/.favoris_bash
fi

if [ $# -eq 0 ]; then
    echo "Usage: favorites.sh [S|C|R|L] [directory]"
    exit 1
fi

case $1 in
    S)
        save $2
        ;;
    C)
        go $2
        ;;
    R)
        remove $2
        ;;
    L)
        list
        ;;
    *)
        echo "Usage: favorites.sh [S|C|R|L] [directory]"
        exit 1
        ;;
esac
