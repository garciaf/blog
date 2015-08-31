---
title: Présentation des nouvelles APIs HTML5 qui vont vous aider avec exemples concrets
date: 2012-10-16 00:00 UTC
tags: javascript, html5
cover: html-5.jpg
---

Présentation des nouvelles APIs HTML5 qui vont vous aider avec exemples concrets
READMORE

J'ai eu la chance de pouvoir développer des applications web pour de
véritables navigateurs (comprenez par là: "pas de Internet Explorer
comme cible") et j'ai donc pu profiter de quelques nouveautés HTML5 pour
mon projet. Le but de cet article n'est pas de les présenter toutes (
D'autres s'en sont déjà chargé mieux que moi) mais plutôt de revenir sur
les nouveauté qui m'ont changé la vie de mon développement et comment je
m'en suis servie. Mais pour commencer pourquoi faire du HTML5 ?

## Le HTML 5 pour quoi faire ?

Durant ma carrière j'ai vu de nombreux projets qui avaient comme cible
IE7 et IE8, je n'ai pas la (mal)chance de devoir supporter IE6 mais j'en
ai vu d'autre s'arracher les cheveux à le faire. D'avance pourquoi ne
faut-il pas cibler ces navigateurs pour ces projets, voici quelques
raisons pour les clients :

-   Un support de ce type rajoute toujours et j'insiste sur le TOUJOURS
    du temps de développement et le temps c'est de l'argent
-   Les dernières études montrent que Internet Explorer n'est plus le
    monstre qu'il était et c'est temps mieux.
-   Développer pour des navigateurs récents vous permettra de faire plus
    de choses à moindre coût. C'est un peu comme si vous devez
    développer un jeux sur une amstrad et une PS3, et que le jeu doit
    être le même pour les deux plateforme, ça risque d'être compliqué et
    pas terrible
-   Améliorer le web tout simplement ...

## Les custom data attributes

Vraiment pratique celle-là, cela permet de mettre de l'information dans
votre page qui sera accéssible très simplement et très logiquement sans
être affiché sur la page. Cela evitera de mettre des input hidden dans
tous les sens pour stocker de l'information dans une page. Par exemple
vous avez une ligne HTML comme ceci :
```html
<td id="rowId" data-user-id="2" data-user-name="Fabien">Du texte de ligne</td>
```
Et voilà vous pouvez maintenant accéder aux données de la ligne en
camelCase de cette façon :

```javascript
    var row = document.getElementById('rowId');
    var userId = row.dataset.userId; // leaves = 47;
    // 'Setting' data-attributes using dataset
    var userName = row.dataset.userName; 
    row.dataset.userRole = 'admin';  
```

Vos sont accéssible très simplement en écriture et lecture grâce à
quelques lignes de javascript à noter que jQuery propose d'accéder à ces
variable avec la méthode
[data](http://api.jquery.com/data/ "Data jquery") qui fait éxactement le
même travail. Très pratique à utiliser. 

## sessionStorage et localeStorage

Plus la peine de jouer avec les cookies pour stocker des information de
votre utilisateur. SessionStorage est un tableau accessible partout qui
conservera des informations tout le long de la navigation. Pour parvenir
à cela voilà comment on fait (En Javacript) :
```javascript
sessionStorage.MaVariable = "Fabbook"
```
On y accède ensuite de cette façon

``` javascript
console.log(sessionStorage.MaVariable)
// "Fabbook"
```

Voilà le travail est fait. Maintenant si vous souhaitez mettre du
contenu plus "Persistent" (les réglage de votre utilisateur par exemple)
on va utiliser  `localStorage` qui va faire le travail pour nous. Le
fonctionnement est similaire à sessionStorage sauf que les informations
seront conservé au delà de la session. En gros jusqu'à ce que
l'utilisateur vide le cache et l'historique de son naviagateur. Pour
info voilà comment on s'en saire :

```javascript
localStorage.MaVariable = "Fabbook"
```

On y accède ensuite de cette façon

```javascript
console.log(localStorage.MaVariable)
// "Fabbook"
```
Voilà vous avez un stockage sur du long terme sans vous prendre la tête.
Pas mal me direz vous ? Mais si on veut stocker plus on peut toujours
créer une base sur le navigateur. 

## SQlite pour une base de données dans le navigateur (webkit navigateur)

Oui vous pouvez toujours lancer une base SQLite dans un navigateur. La
taille de la base peut être assez variable de 5Mo à plus tout dépend du
navigateur. On peut donc créer une base et faire des requêtes SQL. C'est
très pratique si l'on veut stocker de grande quantité d'information sur
le client. Besoin très spécifique il faut bien le dire, mais ce genre de
fonction ouvre le spectre des possibilités d'une application web. Alors
comment on fait ?

```javascript
var db = openDatabase(shortName, version, displayName, maxSize);
```
Voilà vous avez ouvert une base de donnée reste à faire quelques
transaction pour écrire dedans.

```javascript
    function createTables(db)
    {
        db.transaction(
            function (transaction) { 
                /* The first query causes the transaction to (intentionally) fail if the table exists. */
                transaction.executeSql('CREATE TABLE people(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL DEFAULT "John Doe", shirt TEXT NOT NULL DEFAULT "Purple");', [], nullDataHandler, errorHandler);
                /* These insertions will be skipped if the table already exists. */
                transaction.executeSql('insert into people (name, shirt) VALUES ("Joe", "Green");', [], nullDataHandler, errorHandler);
                transaction.executeSql('insert into people (name, shirt) VALUES ("Mark", "Blue");', [], nullDataHandler, errorHandler);
                transaction.executeSql('insert into people (name, shirt) VALUES ("Phil", "Orange");', [], nullDataHandler, errorHandler);
                transaction.executeSql('insert into people (name, shirt) VALUES ("jdoe", "Purple");', [], nullDataHandler, errorHandler);
            }
        );
    }
```

Et voilà vous avez de quoi écrire dans la base de donnée, j'ai fais un
de mes premier développement avec cette fonction. Avec l'expérience je
pense qu'il vaut mieux utiliser un ORM java-script. Il se trouve qu'il
en existe des pas mal (pas de quoi égaler un Doctrine tout de même, mais
bon) je vous recommande
[persistencejs](http://persistencejs.org/ "peristence JS") qui est pas
mal du tout. Et qui vous permettra d'être portable vers d'autres
naviagateur.  

## Media Query pour faire du responsive layout

Le nom est un peu étrange mais finalement l'idée est assez simple. Il
s'agit de pouvoir proposer des feuilles de styles CSS en fonction de la
résolution de l'écran. Ainsi un même contenu peut avoir différentes
présentation sans devoir faire quoi que ce soit en java-script. Dans la
pratique je me sers surtout de bootstrap qui le propose de manière très
simplifié. Mais si vous tenez à faire votre propre feuille de style
voilà comment faire :

```html
<link rel="stylesheet" media="(min-width: 320px) and (max-width: 640px)" href="smallscreen.css" />
```
Et voilà vous avez une feuille de style uniquement pour les résolutions
comprisent entre 320 et 640 px, il y a bien entendu beaucoup plus de
possibilité Alsacréation en parle assez bien
[ici](http://www.alsacreations.com/article/lire/930-css3-media-queries.html "Media Queries")

## Conclusion 

Voilà un petit retour sur les api qui m'ont le plus impréssionné ou
m'ont été le plus utile. Toujours est-il que la direction générale tend
à pouvoir faire plus que du simple HTML et construire de véritable
application dans les navigateurs. Si vous aussi vous avez des fonction
HTML 5 qui vous plaisent faites tourner dans les commentaires.
