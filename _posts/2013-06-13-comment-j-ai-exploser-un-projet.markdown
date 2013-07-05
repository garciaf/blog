---
layout: post
title:  "Merder un projet en dix étapes"
subtitle: "Ou comment exploser un projet avec style ..."
date:   2013-06-13 18:29:46
categories: article
language: fr
published: true
cover: /img/explosion.png
---


Il y a des choses dont on est pas toujours fier, et aujourd'hui je vais vous en raconter une. 
Dans le dévelopement parfois on fait des trucs bien, parfois moins bien et parfois on merde carrément. 
Récit d'un projet mort né.

### Le contexte 
Bon c'est un projet qu'on a vendu au client pour x jours au client. C'est simple tu devrais y arriver, on va tenter de le faire sur une techno que tu connais mais pas nous (Symfony2). C'est toujours intéressant de démarrer un nouveau projet, on peut tout faire. 
J'avais été formé sur le framework et l'estimation me semblait réaliste. 

### Les premières difficultés
Pour commencer la "hierarchie", plus l'on est haut, plus on a raison. 
J'étais dévelopeur, tout en bas juste au dessus de la femme de ménage pour les choix techniques. 
Il faudra que toutes les décisions techniques soient validé par l'architecte ou le chef de projet.
Ni le chef de projet, ni l'architecte n'avait d'expérience avec ce framework.
L'architect à bien travaillé il a pondu une spec de 50 pages, tous les écrans, des explications, tout le modèle, tout tout tout et pas un seul test. 
On est sur SVN pour le projet (Quand on utilise composer je vous raconte pas la rigolade). 
On dévelope sur Windows (no comment)
Et les (longues) réunions font partie du temps de dévelopement.

### Déveloper en couche
En effet sur le papier cela semblait assez séduisant. Coder tout le modèle, puis tous les services, puis tous les controlleurs et pour finir toutes les interfaces. 
Malheureusement quand on arrive aux interfaces on se rend compte qu'il manque quelques services. Et on se rend compte que dans les services il manque quelques fonctions dans le modèle. Bref aujourd'hui je pense qu'il faut développer feature par feature car on revient moins sur son code. Et on fait des choses plus simples à chaque étape.

### Vouloir faire la révolution
De mon coté c'était mon deuxième projet from scratch et j'ai voulu faire les choses bien ce sera du TDD.
J' écris les test avant chaque developement. Malheureusement personne dans la boite n'a d'expérience avec le tdd. Mais j'insiste malgrès tout...
La boite n'est pas super chaude pour du TDD. Le N+2 est ancien dévelopeur C (quand ça compile le programme fonctionne point à la ligne) et comme plus on est haut plus on a raison les test automatiques ne sont pas dans les moeurs de l'entreprise.
Du coup c'est le chef de projet qui fait le [singe](/slide/2013/05/27/hiring-monjey-vs-bdd.html) pour tester le projet et guarantir la "qualité" du projet. 
Je discute certains écrans dont l'implémentation me parait inutilement compliqué (des modales de modales par exemple), mais non la spec est gravé dans le marbre rien ne doit changer. 
Quelques (long) échanges pour finalement me réaffirmer ma place dans la hiérarchie des décisions techniques. 
Les meilleurs idée viennent toujours du haut.

### Erreur en écrivant des test
Une erreur que j'ai commise lorsque j'ai écris mes tests, c'était d'écrire en me basant sur un jeux de fixture. 
C'est une mauvaise pratique qu'il convient de remplacer par des _Factory_ qui générent les données nécessaires aux tests.
Malheureusement quand vous êtes le seul à vouloir écrire des test personne ne voit ses erreurs.
Bref écrivez du test avec des gens qui ont de l'expérience ou la volonté d'apprendre, ça facilite les choses.

### Rajouter un nouveau framework au milieu du dev
Dévelopement couche par couche on part du bas et on remonte. 
Du coups les interfaces sont à la fin. Mais pour pouvoir tester si ça marche il m'a fallu faire quelques interfaces à la main. 
Arrivé à la moitié on m'explique qu'il faut faire une interface full ext-js. Une grande partie de la logique est transféré sur le client.
Et on se prive de la generation des formulaire de symfony. De plus je suis une bille en ExtJs. 
Mon erreur avoir crut qu'apprendre cette couche supplémentaire ne changera rien. Perdu ...

### L'architecte ne connait pas le framework et il doit tout valider
En effet la confiance n'est pas au rendez-vous, je suis alors un dev junior et l'architecte ne dévelope plus vraiment depuis un moment.
Il découvre le framework. De surcroit il doit vailder chacun de mes choix techniques (choix des bundles). 
Dans la mesure où il ne connait pas mieux le framework que moi, je trouve ça curieux. 

### Commentaire sur les commentaires
L'utilisation des commentaires et assez subjective au goût du dévelopeur. Certains les utilise beaucoup d'autre moins. 
Je fais partie de la seconde catégorie. Un code doit être compréhensible sans commentaires et les tests doivent expliquer ce que fait le code. 
J'écris du commentaire, lorsque je fais un hack, ou pour préciser un point relié au projet. 
Et mon architect n'avait pas le même point de vue sur la question, selon lui tout doit être commenté même les variables de classes. 
C'était pour le cas où nous utiliserions un générateur de documentation. 
Nous n'en avions jamais utilisé et je ne pense pas que cela ai changé. 
En bref j'ai été contraint d'écrire des commentaires inutiles dans l'éventualité où peut-être un générateur de doc serait utilisé.
Aujourd'hui je sais qu'il faut écrire le minimum de code pour remplir le besoin. 
Si l'on ne génére pas de documentation pas de commentaire inutile pour le cas où. Perdu encore une fois. 

### Le code en français
La spec était tellement carré que j'ai recopier le modele tel quel (quasiment) et ce fut une grosse erreur.
En effet tout était écris en français et lorsqu'il a fallu écrire des méthodes pour le model. 
J'ai eu des noms assez marrant comme _getVoiture()_ et bien d'autre. Le mélange est très mauvais et fait vite de la peine. 
Cela m'a valu de devoir traduire des noms de méthodes en français, cela m'a aussi valu de longue discussions avec mon architecte.
Bref codez toujours, toujours en anglais et même si tout est en français traduisez !

### Ne pas lancer d'alerte
En voyant le nombre de problème s'accumuler j'aurai du dire de manière explicite "Soit j'arrête de développer votre merde, soit on change le processus sinon on va dans le mur".
Le problème c'est que j'étais dans la situation où :
- on a pas assez de boulot pour pouvoir refuser des projets
- j'avais dis avant que l'estimation était bonne, je m'étais engagé et dire à voix haute ce que je pensais c'était me désavouer. 

Là où c'est très bête, c'est le context dans lequel j'ai validé ces estimations, j'avais fais beaucoup d'hypothèses sur le déroulement du dev (pas de client à déveloper, liberté technique, TDD facile à faire, développement en couche efficace). 

### Le coup de baton
Alors quand on s'est aperçu que l'on ne livrerai pas dans les temps. J'ai reçu une convocation de mon N+3 ("responsable de production") pour une réunion "musclé".
En gros c'était de ma faute, j'ai essayé de donner des justifications technique mais ça a été balayé de la main par un "Non l'architecte et le chef de projet se sont beaucoup remis en question". Vous réponsez quoi à ça ? J'ai fait un truc du style "oui mais heu ..."
A la fin de l'entretien, j'ai eu le droit à une évaluation et j'ai eu l'impression d'être un idiot ni plus ni moins.
Ensuite au deuxième "debrifing" j'ai dis ce qu'il avait envie d'entendre: 
- "Oui c'est de ma faute"
- "Oui je comprends que vous n'y êtes pour rien" 
- "je me suis remis en question" 

Dans ma tête j'étais déjà ailleurs.

## Conlusion
Voilà une expérience difficile qui m'a pris beaucoup de temps à coucher sur le papier. 
Suite à cette mésaventure, j'ai demissioné, j'ai eu droit à une mission à 130 km de chez moi.
Lors de cette mission j'ai eu la chance de rencontrer des gens formidable qui m'ont reconcilié avec le travail en équipe et j'ai eu l'occasion de voir l'un des projets les plus merdiques qu"il m'a été donné de voir (assurément dans mon top 3). 
Et je suis partis hors de l'hexagone pour voir comment ça se passe. 

Si c'était à refaire ?:
- Soit un client avec un framework javascript récent et maintenable (Angular, Backbone) qui parle à une API très simple (node, rails) mais ce projet ne justifie pas d'en faire une single page application (application de burautique)
- Soit un serveur qui fait tout et le javascript pour le strict minimum (affichage de modale) et coté serveur (symfony2, Rails ).
- Hébergement des sources sur Github
- Générer le code javascript avec coffeeScript
- Sass ou Less avec un Bootstrap ou Fondation au cul 
- Faire le design avec quelqu'un dont c'est le métier (designer)
- Deploiment avec un outils automatique
- Windows à la pouvelle et on travail avec un linux où un mac Os
- Le dévelopeur tranche les décisions techniques et laisse les aspects métier au client (idéalement au "product owner")
- Définition d'un produit minimum viable 
- Implémentation fonctionnalité par fonctionnalité
- Au revoire Eclipse, bonjours sublime Text ou Vim (avec un temps de formation pour Vim)

Malheureusement le Père Noël n'existe pas et ce projet restera un projet raté. 

Et si on arrété de se mentir ? C'est quoi le dernier projet que vous avez merdé ?