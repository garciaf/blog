---
layout: post
title:  "Dis papa pourquoi on fait du php?" 
date:   2013-05-27 21:15:46
categories: article
language: fr
published: true
---

_"Papa, papa, à l'école ils font que de dire que PHP c'est trop nul, ... sniff...", "mais c'est pas grave mon petit" "Dis Papa pourquoi on fait du PHP? ", "Heu tu veux pas que je te dise comment on fait les bébé à la place ? Non ? Bon dans ce cas ..."_

## Il était une fois ...

En 1994, Rasmus Lerdorf inventait le PHP pour les besoins de son site web. Ce langage était alors un ensemble de fonctions écrites
en PERL. De simple bibliothèque basé sur PERL, PHP est ensuite devenu un language interprété à part entière basé sur du C.
En 1995, son créateur décida de passer PHP en open source. Une decision qui permit la véritable naissance de PHP.

L'idée n'est bien sûr pas de faire l'historique de PHP, car pour cela, je vous inviterai plutôt à vous rendre sur wikipédia
mais de tenter de répondre à la question "Dis papa, pourquoi on fait du PHP ?"

Pour répondre à cette question, il me semble important d'insister sur le coté Open Source de PHP qui selon moi a été un 
vecteur important de son succès dans les années 2000. Pour les non initiés à l'Open Source, je me permet une petite paranthèse. 
Le brevet libre part du principe que notre évolution au sens large doit être colletive et non individuelle. Chacun dépose une brique à l'édifice
afin de construire ensemble un ouvrage robuste, populaire, fiable et durable. Bien que des projets libres finissent aux oubliettes,
il est bien déplorable de voir des projets pertinents et viables finir de la même façon faute de financement et de brevet "All Right Reserved". 
Bref, je m'écarte du sujet et je pense qu'il pourra être interressant de créer un article à part entière sur le domaine du libre.

## Le PHP c'est libre

Revenons à notre ami PHP. Fin 90, fort d'une communauté libre fiable, ce langage intègre des librairies interressantes pour 
le développement du web : Communication vers des bases de données, maniement des images, traitement de tableau. 
Face à l'arrivé de la notion de programmation orienté objet dans le domaine de l'informatique, PHP reste à la page en intégrant
ce type de développement dans sa version 5 sortie en 2004. En 2007, 20 millions de sites à travers le Monde utilisaient PHP
( Wikipédia ).

Le brevet de PHP a permis sa démocratisation, certes; mais seule, sa licence ne pouvait pas faire son succès.
J'ai codé mes premières lignes de PHP en 2001. De nombreux hébergeurs proposaient alors de offres gratuites pour PHP, pendant
que de nombreux sites et forums d'aides se mettaient en place autour de ce langage. La tendance du moment était alors les
"pseudo frame" qui consistaient à reproduire la notion de frame HTML en PHP, ce qui permettait alors d'avoir moins de fichiers
sur le serveur et surtout du contenu sauvegardé en base de donnée. Beaucoup de bidouilleurs dont je faisais parti ont alors découvert
les joies du code avec un certain coté ludique.

## C'est bien mais ...

Lors de mes études, j'ai entendu les mauvaises langues "Php, c'est degueulasse comme langage, c'est même pas typé !".
Certes, on est loin de la rigueur imposée par du C ou du Java, mais c'est ce qui a permis aussi son développement "populaire". De plus de nombreuses inconsitence sont reprochés au language ([Phpsadness](http://phpsadness.com/)) toutes ses raisons font que ce language est un peu moins "cool".
Et je reconnais que l'absence de contraintes de codage peut amener le développeur à écrire avec son style, ce qui devient invivable lorsque l'on est plusieurs sur le projet. 

Alors forcémment j'ai douté, et j'ai pensé que l'avenir se trouvait sur des solutions plus propre comme du JSP ou de l'ASP

## J'aime PHP car ...

Heureusement, PHP a su avoir raison de mes doutes. Sur les développements de code "ouvert", on cherche à s'entendre sur des conventions de codage, ce qui rend le code plus propre et plus accessible pour les novices au projet en question ([Convention PEAR](http://pear.php.net/manual/en/standards.php)  [PSR-0](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md), [PSR-1](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-1-basic-coding-standard.md) et [PSR-2](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-2-coding-style-guide.md)). 
Et le développement en objet de PHP a permis à des Framework comme CakePHP ou Symfony de naître et ainsi rendre essentiel la notion de MVC
(Model View Controller), afin de bien séparer la logique, le controleur (celui qui reçoit et renvoit les données ), et les 
vues, consituées seulement de variables et de tableaux à afficher dans le code HTML. 
Des progrès au niveau de la gestion du cache coté serveur ont été réalisés dans les versions récentes, avec l'utilisation du cache APC. 
De plus les dernières versions de PHP intègrent des concepts très puissant empruntés à d'autres langages (traits, closure pour ne citer qu'eux). 
Depuis quelques temps PHP s'est doté d'un gestionnaire de dépendances enfin performant et souple j'ai nommé [Composer](http://getcomposer.org/) voilà de quoi pouvoir rendre l'écosysteme industriable. L'autre grande force c'est son utilisation massive (de __très__  nombreux projets existent) et son installation très simple sur de nombreux serveurs.

Bref, on code en PHP car c'est libre, performant, et tellement web =)

_Yoann & Fabien_
