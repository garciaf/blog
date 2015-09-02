---
layout: post
title:  "Prenons le travail des sysadmin"
date:   2013-06-08 18:25:00
categories: article
lang: fr
cover: holly.jpg
published: true
---

Parfois on voit et on entend des choses incroyables :
- "Oui alors ce serveur de production c'est une copie d'un serveur de production, tu comprends on a fait une copie d'une VM il y a 3 ans, on ne sait pas ce qui il y a dessus."
- "Mais pourquoi il tombe en panne une fois par semaine ?"
- "On sait pas mais il faut surtout pas y toucher !"
- "Mais comment on refait un serveur clean ?"
- "On peut pas, il faut faire une copie de la VM qui fait 20 Go et il faut surtout pas y toucher."
- "Mais si ..."
- "Non il ne faut pas y toucher cette VM est sacrée et si jamais elle disparait le projet mourra avec et une pluis de météorite s'abattra sur terre." 

J'aimerai vous dire que cette conversion est issue de mon imagination mais je l'ai vue de mes yeux et la VM sacrée aussi (la pluie de météorite c'est peut-être mon imagination)
La question que je me pose c'est comment peut-on être professionnel quand ce que l'on vend à un client c'est finalement un chateau de carte ni plus ni moins.

Mais comment faire ? Et si on fabriquait nos serveur avec du code ? Si notre serveur n'était tout simplement qu'un build, que l'on puisse jeter et reconstruire comme bon nous semble ? Bref faire de l'administration de serveur avec tous les outils du développement moderne. 

## Le bac à sable
Pour pouvoir jouer un peu, il nous faut un bac à sable. Un truc que l'on peut casser sans risque de se faire taper sur les doigts. 
Pour cela on va utiliser [Vagrant](http://www.vagrantup.com/). L'idée est la suivante, il créé pour vous une machine vituel sur votre ordinateur. 
Par la suite on pourra se connecter à notre serveur virtuel par ssh. 

## La recette de cuisine
Maintenant que l'on a de quoi jouer, on va commencer la cuisine. Nous allons utiliser pour cela [chef](http://www.opscode.com/chef/).
Avec ce système on va fabriquer ou utiliser des recettes pour monter un serveur. Une recette s'installe de la manière suivante, si vous avez besoin de mysql vous entrez la commande suivante. 

```ruby
knife cookbook site install mysql
```

La recette se télécharge et vous voilà avec mysql utilisable dans vos recette. Un cookbook c'est juste un depot git avec du code ruby à l'intérieur. 
On peut avoir plusieurs recettes dans un cookbook. Ensuite il y les "node" qui sont simplement les instances particulière de serveur que l'on aura. Pour faire simple un node c'est ni plus ni moins qu'une machine physique(ou une VM)
On peut avoir des données spécifiques au node. En effet par exemple le mot de passe de votre base de donnée Mysql ne sera pas le même sur votre serveur de production que sur votre serveur de test. 
Ensuite il y a les rôles un role c'est un peu comme un menu, il contient plusieurs recettes. 

## Pourquoi faire si compliqué ?
Parce qu'on peut ! Non plus sérieusement une fois vos recette faite et votre environnement configuré vous serez capable de créer et mettre à jour des serveurs plus vite qu'il ne le faut pour le dire. 
De plus maintenant la configuration des serveurs est documenté sous forme de code. 
Plus besoin d'appeler admin réseau pour savoir ce qu'il y a sur le serveur. Bref c'est la fin de la VM sacré ou même du serveur sacré. 
En effet la machine et la configuration de vos serveurs sont gérés comme du code et tout le monde peut y avoir accès.
Vous n'êtes plus tributaire du sysadmin qui sait, voit tout et juge tout. 
