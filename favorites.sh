#!/bin/bash

#
## FONCTIONS
#

# Sauvegarde le répertoire courant dans ~/.favoris_bash
# $1 : nom du raccourci
function save {
    currDir=$(echo $(pwd) | sed 's/ /\\ /g') # Cela permet de gérer les espaces dans les noms de répertoires
    echo "$1 -> $currDir" >> ~/.favoris_bash
    echo "Le répertoire $(pwd) est sauvegardé dans vos favoris"
    echo "-> Raccourci : $1"
}

# Change le répertoire courant en fonction du raccourci passé en paramètre
# $1 : nom du raccourci
function go {
    if [ $(echo $1 | grep -c "/") -eq 0 ]; then
        dir=$(cat ~/.favoris_bash | grep "^$1" | cut -d'>' -f2 | sed 's/\\ / /g' | sed 's/^ *//g' | sed 's/ *$//g') # Cela permet de gérer les espaces dans les noms de répertoires
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
        $SHELL # Force le shell à se relancer pour prendre en compte le changement de répertoire
        exit 0
    fi
}

# Supprime un raccourci de ~/.favoris_bash
# $1 : nom du raccourci
function remove {
    sed -i '' "/^$1/d" ~/.favoris_bash
}

# Affiche la liste des raccourcis
function list {
    cat ~/.favoris_bash
}

#
## SCRIPT
#

# Création du fichier ~/.favoris_bash s'il n'existe pas
if [ ! -f ~/.favoris_bash ]; then
    touch ~/.favoris_bash
fi

# Vérification du nombre de paramètres
if [ $# -eq 0 ]; then
    echo "Usage: favorites.sh [S|C|R|L] [directory]"
    exit 1
fi


# Vérification du premier paramètre et appel de la fonction correspondante
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
