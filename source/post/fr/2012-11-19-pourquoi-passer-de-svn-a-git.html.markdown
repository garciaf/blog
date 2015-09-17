---
lang: fr
title: Pourquoi passer de SVN à GIT ?
date: 2012-11-19 00:00 UTC
tags: opinion
cover: git-logo.png
alias: pourquoi-passer-de-svn-a-git/blogarticle/
---

Ayant utilisé pendant plusieurs années SVN, j'avais du mal à comprendre
l'intérêt pour les gestionnaires décentrailisés, et puis un jour, j'ai
essayé Git, et je n'ai pas aimé. J'ai perséveré et j'ai compris pourquoi
c'était si bien...

READMORE

Malheureusement lorsqu'on me demande pourquoi il vaut mieux passer de SVN à GIT (ou tout autre gestionnaire de version décentralisé), je ne suis pas toujours des plus éloquent. 
Le but de cet article est de lister des raisons objectives pour faire un tel changement, qu'un patron de SS2I pourrait comprendre (en l'occurence le mien, mais le votre aussi peut-être). 

## Tous les autres migrent de SVN vers GIT 

Bon je dois reconnaître que cela peut paraître un peu léger comme
argument mais, il y a un fait tous les grands projets open source
migrent vers GIT ou un équivalent distribué quelques exemples pêle
mèle: 

-   PHP
-   Symfony2
-   Zend Framework 2
-   Linux
-   Eclipse
-   etc ...

Alors je doute que ces grands projets, ou entreprises font cette
migration par plaisir, car cela coûte et prend du temps, en effet il
faut former les gens, changer l'hebergement des dépôts. Alors pourquoi
font-ils ça ? Voyons un peu ...

## Facilite l'organisation du développement

Premier point intéressant avec Git c'est l'utilisation des branches, qui
est franchement facilité par rapport à SVN, ainsi que la gestion de
différents dépots distants. En effet il est possible de définir
différents dépôts distants pour ces sources. De plus on peut imaginer
l'utilisation des branches pour des usages précis : 

-   Master : Branche correspondant au code en production 
-   Dev : Branche utilisée par le(s) développeur(s) pour le
    développement
-   Issue\_xxx : branche pour résoudre un bug 
-   Fonctionnalité : branche contenant une nouvelle fonctionnalitée

Et ainsi de suite, on trouvera différents [exemples](http://www-igm.univ-mlv.fr/~dr/XPOSE2010/gestiondeversiondecentralisee/dvcs-dvcs.html)
sur la toile très bien fait. Voilà Git apportera une solution à
l'organisation du développement. Bon maintenant git apporte une réponse
à une autre question ...

## Commiter ou pas commiter ?

En tant qu'utilisateur de SVN, cette question se pose assez
régulièrement, seulement lorsque l'on fait un développement de grosse
envergure, on est en droit de se poser la question, faut-il envoyer ses
modifications sur lesquels on a beaucoup travaillé mais qui ne sont pas
terminées ? Si on commit dans le tronc alors que le dev n'est pas
terminé on laisse sur le dépôt une version instable du projet. D'un
autre coté si l'on ne commit pas, on se passe du versionnage de ses
fichiers ce qui n'est pas terrible non plus. 

Avec Git pas de problème les commit sont locaux et si l'on désire faire
partager ses developpements on peut pousser sa branche sans problème, la
merger, créer une nouvelle branche etc ... Une fois la modification
validée un simple merge permettra de propager la modification dans la
branch principale. Bref vous l'aurez compris les possibilités laissées
aux développeurs sont beaucoup plus grande. Et la gestion des forks et
autres versions se font beaucoup plus simplement et sans perte de
temps. 

C'est pas mal déjà, mais pourquoi changer ? Votre boss n'est pas encore
convaincu ? Creusons encore un peu ...

## Offrir une grande flexibilité sans perdre de temps

Prenons un exemple d'un cas qui n'arrive "presque jamais" en entreprise.
Vous dévelloppez une nouvelle fonctionnalité dites "de la mort". Vous
avez drôlement avancé votre code et là, PATATRA, le client à trouve un
bug dit lui aussi "de la mort" qui est complétement bloquant qui gène
les utilisateurs. Bref il faut résoudre cela au plus vite ! 

Là où les chose se compliquent avec SVN, Git quand à lui simplifie le
travail. On pourra donc "geler" son travail avec la commande stash :

     git stash "travail en cours de la fonctionnalité de la mort"

 Vous allez faire une nouvelle branche depuis la branch master. 

     git checkout -b master IssueDeLaMort

 Voilà vous êtes sur une nouvelle branche identique avec votre code en
production. Vous pouvez faire votre correction "super Importante"
ensuite vous commitez 

    git commit -a 

 Vous mergez votre modification sur la branch master

    git checkout master

    git merge IssueDeLaMort

    git push origine master

 Et voilà vous pouvez déployer votre branch master pour votre client,
votre boss, votre client, vous même et tout le monde est content.
Maintenant vous pouvez reprendre votre travail sans perdre la correction
que vous avez faite, comment ? 

    git checkout FonctionnaliteDeLaMort

    git stash apply

    git merge IssueDeLaMort

Vous allez de cette manière récupérer la modification du Bug et
reprendre votre développement. Si jamais il y a un conflit entre la
correction et votre nouvelle fonctionnalité, il faudra éditer le ou les
fichiers en conflits et voilà. 

Dans le monde SVN, faire ce genre de chose est un peu plus exotique et
surtout plus long. Certains m'ont expliqué qu'il fallait faire un
nouveau checkout du projet. Créer une branche distante et merger les
fichiers à la main en les comparants avec le trunk. Bref cela égale
perte de temps, et pour votre boss cela veut dire perte d'argent.

## SVN m'a tuer

Un cas qui se produit régulièrement en entreprise est que l'on ne
travaille pas tout le temps sur un seul projet, parfois quelqu'un
travaille sur un projet et reprend le votre etc ...

Bref dans mon cas, je reprend le travail d'un projet existant sur une
nouvelle branche avec SVN, j'ai terminé mes developpements. Ces dernier
dev doivent être qualifié avant livraison. 

Le problème c'est que j'ai de nouvelles évolution à faire, mais sur le
"trunk" cette fois. Et le problème c'est que le tronc est une version
complétement instable du projet. Donc forcement je perd du temps à
refaire fonctionner mon application.

Et le temps que je perd à cause du système de versionnage, c'est encore
de l'argent que perd mon patron. Avec Git les chose aurait été beaucoup
plus simple. Je poussais ma branche d'évolution sur une branche distante
pour pouvoir être qualifié, j'aurai recréer une branche depuis la master
et voilà ! Nous aurions mergé les branch des différents développeurs en
fonction de l'avancé des tests. Une solution donc bien plus confortable
et vraiment moins chère.

## Mais SVN ça marche très bien ! Pourquoi changer ?

Un autre argument lié cette fois aux inerties sociales. Une remarque que
l'on peut-entendre de la part de tout le monde même des confrères
développeurs, c'est : "pourquoi changer ? SVN ça marche très bien !"

En effet, si l'on va par là, pourquoi chercher à changer les choses qui
fonctionnent ?

La même chose se passe lorsque vous parlez à des gens qui n'ont jamais
utilisé de système de versionnage et qui s'échange les documents par
mail en numérottant soigneusement les version sur les noms de fichiers.
En prenant soin de ne pas écrire en même temps dans le même fichier.Si
jamais vous leur parlez de gestionnaire de version de commit etc ... il
vous répondrons la même chose "Pourquoi changer quelque chose qui
fonctionne ?".

Tout simplement parce que ces gens ne se rendent pas compte du temps
qu'ils perdent, et les afficionados de SVN ont le même problème, ils ne
réalisent pas le temps qu'ils perdent à cause des limites de l'outils
SVN (et par extension votre boss).

 Malheureusement ce qui va être vu c'est le coût d'un tel changement,
les formations, les serveurs etc ... Quel horeur ! Concernant la gestion
du serveur Git pourquoi ne pas déléguer ce travail à Github, son api est
vraiment sympa, il embarque par défaut beaucoup de fonctionnalité utiles
pour de revue de code, et de la gestion de bug. Il existe des version
payantes pour avoir des dépôts privés. Bref il y a là un bel outils à
utiliser qui à l'échelle d'une entreprise ne coutera vraiment pas chere.

Certe il y a cet aspect mais le gains, et le temps que fera économiser
cette migration sera largement compensé sur le long terme.

## Le mot de la fin 

Tous les cas décris dans cet articles sont issues de la réalité et non
pas de mon imagination. Est-ce que je vais arriver à convaincre mon boss
du bien fondé de ma demande ? L'avenir nous le dira (note, la réponse
est non mais j'ai changé d'entreprise depuis et ils utilsent Git ...),
si jamais vous avez de quoi mêttre de l'eau à mon moulin n'hesitez à
laisser quelques commentaires je suis en recherche de matière. De même
si vous connaissez de véritable freins à une migration je suis aussi
preneur. Je mettrais à jour cet article en fonction des retours. 

Bon dev d'ici là !