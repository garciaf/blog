---
layout: post
title:  "Comment j'ai merdé un projet"
subtitle: "Ou comment exploser un projet en six étapes"
date:   2013-06-13 18:29:46
categories: article
language: fr
published: false
cover: /img/explosion.png
---


Il y a des choses dont on est pas toujours fier, et aujourd'hui je vais vous en raconter. 
Dans le dévelopement parfois on fait des trucs bien, parfois moins bien et parfois on merde carrément. 
Comment ça arrive ? C'est partie

## Le contexte 
Bon c'est un projet qu'on a vendu au client pour x jours au client. C'est simple tu devrais y arriver, on va tenter de le faire sur une techno que tu connais mais pas nous (Symfony2). C'est toujours intéressant de démarrer un nouveau projet, on peut tout faire. 
J'avais été formé sur le framework et l'éstimation me semblait réaliste. 

## Les premières difficultés
La hierarchie en gros plus l'on est haut, plus on a raison. J'étais alors dévelopeur c'est à dire tout en bas. 
Il faudra que toutes les décisions techniques soient validé par l'architect ou le chef de projet.
Ni le chef de projet, ni l'architecte n'avait d'expérience avec le framework.
La spec l'architect à bien travaillé il a pondu une spec de 50 pages, tous les écrans, des explications, tout le modèle, tout tout tout et pas un seul test. 
On est sur SVN pour le projet (Quand on utilise composer je vous raconte pas la rigolade). 
On dévelope sur Windows (no comment)
Et les (longues) réunions font partie du temps de dévelopement.

## Vouloir faire la révolution
De mon coté c'était mon deuxième projet from scratch et j'ai voulu faire les choses bien ce sera du TDD.
Je écrire des test, et je vais utiliser le maximum de bundle pour accélrer les choses. Malheureusement personne dans la boite n'a d'expérience avec le tdd. Mais j'insiste malgrès tout...
Je discute certains écrans dont l'implémentation me parait inutilement compliqué (des modales de modales par exemple), mais non la spec est gravé dans le marbre rien ne doit changer. 
Quelques (long) échanges pour finalement me réaffirmer la place de la hiérarchie dans les décisions techniques. 
Les meilleurs idée viennent toujours du haut.

## On rajoute un nouveau framework au milieu du dev
Dévelopement couche par couche on part du bas et on remonte. 
Du coups les interfaces sont à la fin. Mais pour pouvoir tester si ça marche il m'a fallu faire quelques interfaces à la main. 
Arrivé à la moitié on m'explique qu'il faut faire une interface full ext-js. Une grande partie de la logique est transféré sur le client.
Et on se prive de la generation des formulaire de symfony. De plus je suis une bille en ExtJs. 
Mon erreur avoir crut qu'apprendre cette couche supplémentaire ne changera rien. Perdu ...

