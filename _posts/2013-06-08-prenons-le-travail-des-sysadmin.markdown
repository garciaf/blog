---
layout: post
title:  "Prenons le travail des sysadmin"
date:   2013-06-08 18:25:00
categories: article
language: fr
published: false
---

Parfois on voit et on entend des choses incroyables :
- Oui alors ce serveur de production c'est une copie d'un serveur de production, tu comprends on a fait une copie d'une VM il y a 3 ans, on ne sait pas ce qui il y a dessus. 
- Mais pourquoi il tombe en panne une fois par semaine ?
- On sait pas mais il faut surtout pas y toucher !
- Mais comment on refait un serveur clean ?
- On peut pas, il faut faire une copie de la VM qui fait 20 Go et il faut surtout pas y toucher. 
- Mais si ...
- Non il ne faut pas y toucher cette VM est sacrée et si jamais elle disparait le projet mourra avec et une pluis de météorite s'abattra sur terre. 

J'aimerai vous dire que cette conversion est issue de mon imagination mais je l'ai vue de mes yeux et la VM sacrée aussi (la pluie de météorite c'est peut-être mon imagination)
La question que je me pose c'est comment peut-on être professionnel quand ce que l'on vend à un client c'est finalement un chateau de carte ni plus ni moins.

Mais comment faire ? Et si on fabriquait nos serveur avec du code ? Si no serveur n'était tout simplement qu'un build, que l'on puisse jeter et reconstruire comme bon nous semble ? Bref faire de l'administration de serveur avec tous les outils du développement moderne. 

## Le bac à sable
Pour pouvoir jouer un peu, il nous faut un bac à sable.  
     