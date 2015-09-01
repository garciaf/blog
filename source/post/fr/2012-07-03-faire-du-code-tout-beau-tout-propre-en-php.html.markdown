---
title: Faire du code tout beau tout propre en PHP
date: 2012-07-03 00:00 UTC
tags: php
cover: php.jpg
---

Pour avoir du code qui rentre dans le moule des développements modernes,
il existe des conventions en php, comme la convention
[PEAR](http://pear.php.net/manual/fr/standards.php) ou même
[symfony](http://symfony.com/doc/current/contributing/code/standards.html)
possède ses propres conventions. Alors maintenant comment mettre en
place ses conventions sur son projet quand on est un peu flemmard ? Je
reviendrai sur deux soloutions opposées pour résoudre ce problème.

READMORE

## Solution 1 : Mieux vaut prévenir que guérir

 La première solution est assez séduisante sur le papier. Il s'agit de
configurer son IDE afin de signaler toutes les érreurs de mise en forme
en cours d'édition. J'ai testé sur eclipse et je dois dire en être
ressorti assez mitigé : 

-   Les performances de mon IDE sont tombées proche de zéro et chaque
    fois que je tape sur ue touche j'ai le temps de préparer le café. 
-   A l'utilisation cela permet de retenir les conventions et coder
    naturellement proprement et connaître les conventions proprement. 

Bref, je ne suis pas spécialement conquis par cette méthode mais dans
mon bureau cette méthode a conquis certains. Le pluggin retenue est
[PHPcheckstyle](http://code.google.com/p/phpcheckstyle/) , c'est une des
référence dans le domaine. Attention au premier lancement sur votre
machine avec l'IDE, ça risque de patiner un peu surtout sur un projet
existant. 

## Solution 2 : Mieux vaut guérir

Dans ce cas on applique un script beautifuler sur ces scripts après
avoir terminé. Pour cela [fabien potencier](https://github.com/fabpot) a
mis en ligne un outils pour faire ce travail d'indentation et de mise en
forme pour PHP il s'agit de
[PHP-CS-fixer](https://github.com/fabpot/PHP-CS-Fixer). Une fois
installé un appel à la ligne de commande permet de traiter l'ensemble
des fichiers dans un repertoire avec la commande suivante : 

> php-cs-fixer fix path/to/bundle

Et voilà votre code est indenté et mis en forme de manière automatique.
J'ai utilisé l'outils et le gain de temps et l'efficacité est au rendez
vous. Bon malheureusement le javascript n'est pas pris en compte. C'est
pas grave j'ai donc utilisé uglifyjs. L'installation est assez simple
sur linux :

on installe node.js dans un premier temps avec la commande 

> sudo aptitude install npm

 Il faut ensuite mettre à jour les dépendances : 

> sudo aptitude update

Ensuite il faut installer l'outils uglifyjs avec aptitude : 

> sudo aptitude install libnode-uglify

 Ensuite on rend les fichiers javascript "beautiful" avec la commande
suivante : 

> uglifyjs -b -v --overwrite path/to/jsfile.js

 L'option "--overwrite" permet d'enregistrer la modification directement
sur le fichier. 

Et voilà vos fichier PHP et javascripts sont désormais jolis et donc
plus facile à lire par vous même et vos collègues. 

## En conclusion

Je crois que je me ferai bien un script bash qui passe ces filtres avant
de faire un commit. Ceci dit les normes de codages sont assez
importantes à mettre en place de façon à avoir du code plus facile à
maintenir, plus facile à lire et pour optimiser le travail en équipe.
J'invite donc chacun à utiliser l'arme de son choix pour y parvenir pour
ma part j'opterai pour la solution 2 dans l'avenir, moins contraignante
et plus rapide à mettre en place que la solution 1. 

Si vous avez des suggestions d'outils ou que vous connaissez le script
qui automatise le formatage avant le commit faite tourner dans les
commentaires. 