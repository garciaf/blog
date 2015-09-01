---
lang: fr
title: Les petits trucs de node.js et coffeeScript
date: 2012-11-18 00:00 UTC
tags: javascript
cover: nodejs.jpg
---

Les petits trucs de node.js et coffeeScriptRécapitulatif des petites commandes qui vont faciliter votre vie avec node.js et les astuces de coffe-script

READMORE

Ayant commencé depuis peu le dev sur node.js, j'ai eu le temps de
travailler avec quelqu'un de mes collègues. Et je me débrouillais tant
bien que mal avec cette bête étrange qu'est node.js mais j'avais
toujours quelques problèmes bêtes la pluspart du temps. Ils m'ont montré
des trucs qui m'ont fait penser "Mais c'est trop pratique comme truc en
fait". Petit tour d'orizons :

## Les variables d'environnement 

Le titre est un peu barbare mais le concept est très simple. Lorsqu'on
développe il est intéressant d'avoir une configuration pour le
développement, une pour les test et une pour la production. Dans votre
code vous pourrez charger une configuration plutôt qu'une autre assez
simplement. Par exemple dans votre code vous pourrez mettre ceci, (en
coffe-script):

```
config = require "config/#{process.env.NODE_ENV}.json"
```

 Ensuite lorsque vous lancerez votre serveur node.js vous pourrez
définir le paramètre directement, de la façon suivante :

```
NODE_ENV=dev coffee app.coffee 
```
 Votre fichier de conigurqtion sera de la forme `dev.json` par exemple.
Et voilà tiens mais quel est cette drôle de syntaxe pour lancer son
application ? La réponse au chapitre suivant :

## Compiler le coffee-script en direct live

 Au début j'écrivais le coffe-script, et je générais les fichiers et
après je lançais l'application. Un peu fastidieux au bout d'un moment,
non ? Pour y remedier l'idéal est d'utiliser le coffe-script
directement. Pour cela vous lancez l'application directement avec le
coffe-script (que vous avez installé gloablement avec la commande
suivante `npm install -g coffee-script`) vous lancerez votre application
avec coffee-script. 

Par contre si jamais vous écrivez du script client et que vous souhaitez
que le serveur ne serve uniquement que le script javascript vous n'avez
pas d'autre choix que de compiler à chaque changement le script coffee,
heureusement le package possède une option intéressante qui vous permet
de compiler le fichier à chaque changement avec l'option -w ou --watch.
Cette petite option vous fera gagner un temps précieux. Ainsi lorsque
vous développerai votre script client vous taperez la commande suivante
pour recompiler le fichier à chaque changement :

```
coffee -cw monScript.coffee
```
Voilà votre script est recompilé à chaque enregistrement du fichier
coffee

## Redémarrer votre serveur à chaque changement ou crash

Une chose parfois énervante est lorsque votre application crash ou
lorsque vous avez fait un changement dans votre code et que vous devez
redémarrer votre serveur pour prendre en compte ses changements.
Heureusement un petit module va vous faciliter la vie, son
nom **nodemon **vous l'installez globalement de la façon suivante : 

```
npm install -g nodemon
```
ensuite vous lancez votre application avec la commande suivante (dans
l'exemple vous déclarez des variables d'environnement) :

    NODE_ENV=dev nodemon app.coffee 

Et voilà votre serveur redemerra automatiquement à chaque crash ou
changement dans les sources. 

Le mapping dans coffee-script
-----------------------------

Le mapping est une chose très simple en coffee et une longue histoire en
javascript. Exemple supposez que vous avez un tableau d'objet et vous
souaitez en extraire un tableau avec seulement quelques attributs en
javascript vous aurez quelque chose comme ça : 

```javascript
    var result = []
    for (var i=0; i < array.length; i++)
      result.push(array[i].name)
    var result = array.map(function(item, i){
      return item.name;
    });
```

Alors qu'en coffee une ligne suffit :

```javascript
result = (item.name for item in array)
```

Vous avez économisé pas mal de code et de fait beaucoup de source
d'erreur

## Tester si une variable existe en coffee-script 

Un autre point agançant avec le javascript est lorsque l'on doit tester
si une variable existe ou pas. Il faut tester deux choses pour être sûr
le type et si la variable est null :

    typeof variable !== "undefined" && variable !== null;

ce qui se traduit en coffeescript par :

    variable?

Cette syntaxe est vraiment utile et cette astuce rendra votre code plus
claire. 

##Conclusion

Voilà un petit article des petits trucs que j'ai découvert ces derniers
temps, je compléterai cet article au fil de mes découvertes ou des
commentaires. Si vous souhaitez trouver d'autre astuces ou des
explications détaillées je vous conseil [le petit livre de
coffee-script](http://arcturo.github.com/library/coffeescript/index.html)
qui vaut le détour. En attendant bon dev ...