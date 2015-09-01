---
title: Les PDF sur symfony 2
date: 2012-05-25 00:00 UTC
tags: php, symfony
lang: fr
cover: symphony-php.jpg
---

Je suis resté assez calme sur ce blog ces dernier temps car j'ai tenté
de voir comment on pouvait mettre en place des PDF simplement. Pour cela
j'ai fait confiance à Google et voilà ce que j'ai trouvé : 

### PsPdfBundle ou PHPPdf

Ce bundle est je dois dire assez performant, il permet de cacher pas mal
d'élément et se révèle assez simple d'utilisation. Attention à bien
définir le format dans le controleur. On génère le contenu à partir de
XML. Pas mal du tout, par contre, je dois avouer que c'est une sacré
machine à Gaz qui utilise quatre librairie différentes : Avalanche,
PHPPdf, Zend autre point noir ce bundle n'est pas très copain avec le
HTML. Dommage ...

Malheureusement l'utilisation de ce bundle est rentré en conflit avec un
de mes autre bundle donc ...

### Snapy 

Ce bundle aussi avait l'air sympa sur le fonctionnement, la doc est
simple malheureusement il faut à tout prix
installer [wkhtmltopdf and wkhtmltoimage](http://code.google.com/p/wkhtmltopdf/) pour le rendu, malheureusement mon hebergement (OVH perso) ne me permet pas d'installer
ce que je veux donc ...

### WhiteOctoberTCPDFBundle

Qui propose d'utiliser la librairie [tcpdf](tcpdf.org) et qui se trouve
être assez puissante et qui permet de générer du PDF à partir de HTML.
J'ai pu donc rajouter la fonctionnalité récupérer en PDF chacun des
articles

Maintenant c'est à vous de voir si vous souhaitez vous lancer dans le
pdf. Si jamais vous connaissez une solution pour faire du PDF et qui
rocks n'hésitez pas à me laisser un message.