# Système de favoris pour le shell

## Description

Ce script permet de gérer des favoris pour le shell. Il permet de créer des favoris, de se dépacer entre les favoris, de les supprimer et de les lister.

## Installation

Pour utiliser le script, vous pouvez le placer dans votre PATH : 
```bash
$ export PATH=$PATH:/chemin/vers/le/script
```

## Utilisation

Pour créer un favori, il suffit de lancer la commande `favorites.sh` avec le nom du favori en argument : 
```bash 
$ favorites.sh S nom_du_favori
```

Pour se déplacer dans un favori, il suffit de lancer la commande `favorites.sh` avec le nom du favori en argument : 
```bash
$ favorites.sh C nom_du_favori
```

Pour supprimer un favori, il suffit de lancer la commande `favorites.sh` avec le nom du favori en argument : 
```bash
$ favorites.sh R nom_du_favori
```

Pour lister les favoris, il suffit de lancer la commande `favorites.sh` sans argument : 
```bash
$ favorites.sh L
```

## Auteur

Ce script a été réalisé par [VASSEUR Pierre-Adrien](https://github.com/Pierrad)