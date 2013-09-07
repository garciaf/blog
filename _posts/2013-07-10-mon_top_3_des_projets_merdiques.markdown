---
layout: post
category: article
title: La fusée qui ne décolle pas
subtitle: Retour sur un projet compliqué
date: 2013-07-10 23:02:57
language: fr
published: true
cover: /img/rocket-crash.jpeg
---

Dans ma carrière j'ai eu la chance de travailler sur des projets passionants et parfois j'ai eu moins de chance...
Retour sur un projet merdique...

## Le projet qui est dirigé par les fonctionnalités

Quand je suis arrivé sur le projet qui portait un nom de fusée, je suis tombé sur une équipe super sympa. 
Le type que je devais remplacer à commencé par me montrer les classes. 
Il me dit "c'est bon, tu n'as pas encore peur ?", il me montre les 250 tables du projet.
Il commence à me montrer les classes qui font plusieurs milliers de lignes. 
Le framework javascript c'est "[Prototype](http://prototypejs.org)" ! Et c'est du Symfony 1.0 coté serveur.
La une fois la première réaction passée, j'ai fait une grimace un peu étrange, tout en pensant "Qu'est ce que je fais là ?"

![wtf](/img/wtf.gif "Premiere rencontre avec une classe de 2000 lignes")
 <blockquote>
  Premiere rencontre avec une classe de 2000 lignes
</blockquote>


### C'est quoi les conséquences ? 
En gros il faut une semaine pour terminer, pour la moindre évolution. 
Et à chaque fois que vous poussez un changement, vous récoltez une collection de bug. 
Bref une ligne de code et vous passez une semaine à corriger. 
L'équipe aussi sympa soit-elle n'est pas encouragée à écrire du bon code.


### Pourquoi c'est devenu compliqué ?
Le problème c'est que chaque fois qu'une feature est finie, il y a dix features qui sont déjà en retard. 
Bref il n'y a jamais le temps de faire du refractoring, d'écrire des tests, de faire évoluer le framework.
Les dévelopeurs sont transformés en pompier éteignant les feux les uns après les autres. 

L'autre aspect qui a rendu le projet compliqué c'est le contexte schysophrene de ce projet. 
En effet il s'agit là d'une grosse entreprise qui est divisée en plusieurs sous entreprises. 
Et bien entendu elles sont en concurrence, ne se font pas confiance et du coup l'on doit développer un seul et même logiciel qui est aussi schysophrene que l'entreprise elle-même. 

Certains CEO vous diront que c'est bien d'avoir une strucure comme ça, ça maintient la productivité.
D'un autre coté lorsque vous devez faire un seul et même outil avec ce genre de structure, cela complique les choses. 
C'est un peu comme si vous faisiez une maison et que suivant la personne qui rentre vous deviez avoir un intérieur différent. 

Il y avait environ une dizaine d'environnements chacun ayant des fonctionnalités différentes, suivant le département et tout ça avec le même code.

Bref, même avant de coder quoi que ce soit c'est déjà compliqué. Quand vous partez sur des bases aussi complexes le projet ne vieillira pas bien. 

### Dans un monde parfait

Le problème c'est qu'on est dans un système qui donne le maximum de décisions à ceux qui en savent le moins (ou qui ont su il y a longtemps).
C'est un peu comme si vous construisiez une maison et que vous dessiniez les plans de la maison à la place de l'architecte.
Si votre maison s'écroule ne soyez pas surpris, car l'architecte lorsqu'il dessine ses plans, pense à des choses qu'ignorent les autres personnes (les murs porteurs, la resistance des matériaux, et j'en passe).
Lorsque vous développez un logiciel et que vous ignorez l'équipe qui l'implémente, vous terminez dans la même situation. 
Il faut impliquer les équipes techniques, les développeurs ne sont pas là pour "pisser" du code mais pour résoudre des problèmes, c'est certainemant ce qu'il font de mieux. 
Bref écoutez votre architecte pour construire votre maison.  
