---
title: Ma relation avec les tests automatisés
date: 2015-09-04 09:32 UTC
tags: test, ruby, opinion
cover: love-hate.jpg
lang: fr
---

Pendant toutes ces années à écrire du code j'ai vécu une curieuse relation avec les tests automatisés. Je les ai aimé et detesté. 
Retour sur cette curieuse relation. 

READMORE
## Mes phases:
### Ignorance
A l'école, j'ai appris à écrire du code et tester n'a jamais été mentionné. 
Pendant un long moment je pensais que faire des logiciels c'était juste écrire du code et que ça marcherait toujours, j'ignorais encore à quel point j'étais dans le faux

### La magie
La réalité m'est vite revenue dans la figure, après avoir échouét à livrer des projets et passer des heures à faire du debugging. J'ai pensé qu'écrire des tests me permettrait d'écire du bon code et plus aucun bug n'oserait pointer le bout de son nez.
Mon premier essai a été un véritable désastre. J'ai commencé en me basant sur des conférences et des articles très enthousiaste sur le TDD.
J'étais obsédé par la couverture des tests, et je pensais qu'avec 100% de couverture mon logiciel serait parfait.
J'étais dans le faux, perdu et tellement naif. Donc, après avoir [littéralement explosé un projet](/post/2013/06/13/comment-j-ai-exploser-un-projet), la magie avait disparu puis vint la phase suivante.

### Sceptique
Je pensais que le TTD, était juste une mode, ça n'avait pas de place dans le monde réel.
Et je n'ai plus écris de tests. Mais heuereusement j'ai rencontré quelqu'un qui m'a fait changer mon point de vue sur la question.
Ce type était vraiment brillant, il trouvait toujours un moyen de réaliser ce qui était demandé. Son code était éléguant et facile à lire et bien entendu le code était testé.
Il m'a alors expliqué qu'écrire des tests faisait partie du développement.
Écrire des tests lui permettait d'avoir une plus grande concentration.
Mon avis sur la question avait changé, je n'écrivais toujours pas le moindre test mais je commençai à lire les tests et ma curiosité sur le sujet grandissait doucement.
J'étais plus détendu sur la question des tests, et si je donnais sa chance aux tests ?

### Test curieux

J'ai changé mon état d'esprit et aussi mon travail. 
Pour la première fois je serai seul à m'occuper d'un projet. 
Comme je ne savais rien sur le projet, j'ai commencé à écrire des tests pour voir comment l'application réagissait.
Mes tests étaient du genre "si je te donne ça à manger, tu me donnes quoi ? Si je me connecte en tant qu'administrateur vais-je voir cette onglet ?".
C'était une approche exploratrice.
De plus, personne ne lisait mon code, j'étais libre d'écrire tous les tests que je voulais. 
Lors de ma première fonctionnalité compliquée, je voulais être sûr que mon code fonctionnerait et je me suis surpris à écrire des tests en avance ou juste après avoir écrit le code. 
Je faisais du TDD sans m'en rendre compte et j'arrivais à la phase suivante...

### Enthousiaste

J'ai finalement commencé à croire qu'écrire des tests pouvait être utile.
Chaque fois que je développais une fonctionnalité, je me demandais comment je pourrai la tester. Le code que j'écrivais étais influencé par le besoin de le tester. Bien entendu le code simple ou trivial était laissé sans test.
Et j'arrivais à mon état d'esprit actuel...

### En paix

Maintenant je suis en paix avec les tests. Je sais que tester pour tester ne fait pas de miracle, et tester pour augmenter la couverture du code est inutile.
Je sais que tester n'est qu'un outil pour rendre la vie plus simple, mais uniquement si on l'utilise correctement.
Tester me permet aussi de me concentrer, et de limiter l'[overengineering](https://www.wikiwand.com/en/Overengineering) en spécifiant ce que l'on va coder.
Je sais aussi que certaines petites corrections et changements peuvent vivre sans être testés.

# Mon opinion

Maintenant tester est quelque chose de plus naturel, cependant ce n'est pas toujours automatique.
Mais j'ai quelques règles pour écrire un test: 

 - Vais je faire un changement sur ce module dans le futur ?
 - Est ce que je veux documenter ce code ? 
 - Est ce que ce code est critique ?

Si je réponds oui à une de ces questions j'écrirais certainement un test. 
Et vous ? C'est quoi l'état de votre relation avec les tests ? Laissez vos commentaires en dessous.