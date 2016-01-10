---
layout: post
title: Antisèches unix
tags: unix, fr
cover: unix.jpg
lang: fr
---
##Petit pense bête à l'usage des utilisateurs UNIX avec une mémoire de 256k
Ayant la mémoire courte je me permet de faire un pense bête de commandes simple et vitale dont je me sert pour mes dev, si au passage cela aide quelqu'un tant mieux :

###Créer un pont ssh 

```bash
ssh -f fg@remotehost -L 3307:remotesql:3306 -N -o TCPKeepAlive=yes;
ssh -f fg@remotehost -L 3308:remotesql:3306 -N -o TCPKeepAlive=yes
```
Voilà nous avons un pont qui permet d'avoir accès en local à une base de donnée comme si elle se trouve sur votre localhost sur le port 3307 et 3308

###Tuer un pont 
Une fois les commandes précédentes créé il est assez difficle de killer ces processus si un problème survient (top sous linux doit pouvoir faire l'affaire ceci dit) mais pour retrouver un processus et le tuer on peut utiliser ceci :

```bash
ps aux | grep ssh
```

et voilà vous avez les numéros des processus et un simple `kill -9` devra faire l'affaire
