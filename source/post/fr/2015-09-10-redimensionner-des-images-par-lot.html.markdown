---
title: Redimensionner des images par lot
date: 2015-09-10 14:41 UTC
tags: rmagick, unix
cover: unix.jpg
lang: fr
---

Voilà une petite ligne de commande pour redimensionner des images par lot avec Rmagick. 

READMORE

### Redimensionner un seul fichier

```bash
convert fichier.jpg -resize 1024x resized-fichier.jpg
```

### Redimensionner plusieurs fichiers

```bash
for file in *.jpg; do convert $file -resize 1024x resized-$file; done 
```

### Convertir un fichier
J'avais des fichiers photoshop que je voulais transformer en `jpeg` et rmagick m'a aussi aidé et c'est d'une simplicité biblique:

```bash
convert fichier.psd fichier.jpg
```