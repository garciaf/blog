---
lang: fr
title: Developer un site web avec node.js et tous les outils
date: 2012-10-26 00:00 UTC
tags: javascript, nodejs
cover: nodejs.jpg
alias: developer-un-site-web-avec-node-js-et-tous-les-outils/blogarticle/
---
Retour d'expérience d'un newbie sur node.js ainsi que sequelize.js, express.js et tous leurs potes ...
READMORE
Dans la vie parfois on fait ce pour quoi on est bon, et c'est facile et parfois (ou souvent) on se remet en difficulté avec une nouveauté. Mon truc c'est le PHP et symfony2, mais mon avenir professionnel en a voulu autrement et me voilà partis pour node.js et tous l'environnement qui va avec. Comme je commence à partir de zéro, cet article présentera toutes les étapes de la configuration jusqu'à l'aboutissement de notre projet. 

## L'installation 
Il faut bien commencer par ça, étant sous ubuntu je donnerai la méthode pour ce système d'exploitation, ( pour les systèmes exotiques comme windows: google is your friend ). Tout d'abbord je vous conseille d'avoir l'une des versions les plus récente de node.js, car sinon de nombreux projet récent risquent de ne pas fonctionner. L'idée est d'ajouter le ppa le plus récent et l'installer par votre gestionnaire de paquet préféré. ( aptitude pour ma part mais apt-get fait très bien l'affaire). Ouvrez un shell et tapez les lignes suivantes (pour info j'ai trouvé l'info [ici](http://stackoverflow.com/questions/7214474/how-to-keep-up-with-the-latest-versions-of-nodejs-in-ubuntu-ppa-compiling) ) : 

```bashrc
sudo add-apt-repository ppa:chris-lea/node.js
sudo aptitude update
sudo aptitude install nodejs
```
Voilà vous avez node.js et sa dernière version. Bon et si maintenant on utilise le gestionnaire de paquet de node.js ? Il se nomme npm et s'installe toujours avec votre gestionnaire de version préféré :

```bashrc
sudo aptitude install npm
```
Maintenant nous utiliserons npm, pour la gestion des paquets (ou librairies si vous préférez ) de node.js.

## Express.js pour démarrer plus vite
Quoi de mieux qu'un petit framework qui structure votre projet et vous donne de bonne bases pour démarrer rapidement. Installer donc express.js au plus vite pour cela rien de plus simple.

```
sudo npm install express --global
```
l'option `--global` vous permettra, comme son nom l'indique d'installer le paqet globalement. Vous aurez ainsi accés à la commande express depuis n'importe quel dossier. Et cela risque de vous servir car nous allons créer notre projet avec cette commande justement

```
express fabbookJS
```

cette commande va donc créer un projet fabbookJs dans le repertoir courant, avec tout ce qu'il faut pour démarrer. Attention ce framework ne contient que la partie Vue et Controlleur, nous traiterons la partie modèle un peu plus tard. 

## Bower pour gérer ces librairie javascript client
Bon si on utilise un nouvel outils autant se faire plaisir sur les outils livré avec, non ? Le premier c'est [Bower](http://twitter.github.com/bower/), non ce n'est pas le méchant dans mario mais il s'agit d'un gestionnaire de librairie javascript. Fini la goute de sueur lorsqu'on veut mettre à jour ces librairies javascript, la liste des dite libriaires se trouve [ici](http://bower.io/search/). Nous allons donc intégrer bootstrap dans notre projet. Pour cela nous allons installer Bower,  éditer deux fichiers et lancer une commande bower.

### Installation bower
Pour cela nous allons installer globalement ce gestionnaire pour cela on passe par npm

```
npm install bower --g
```

Vous aurez accès à la commande bower. Je pense qu'il vaut mieux l'installer de manière global, en effet le gestionnaire de paquet n'a pas de sens dans un projet, et doit être accessible partout. De plus le projet n'a pas besoin de bower une fois que les librairie on été installé. 

### Adapter bower pour express.js

Ensuite nous allons personnaliser le fonctionnement de bowser pour qu'il installe les sources dans le dossier public. Nous créons un fichier .bowerrc et nous allons mettre le code suivant :

```json
{
  "directory" : "public/library",
  "json"      : "component.json",
  "endpoint"  : "https://bower.herokuapp.com"
}
```

cela mettra les librairie dans le dossier public de express et seront ansi accessible dans les templates. Nous allons ensuite éditer le fichier component.json qui contiendra les librairies à téléchargert. Le fichier pour obenir bootstrap css et js est le suivant : 

```json
{
  "name": "fabbook",
  "version": "0.0.1",
  "directory" : "public",
  "main": ["public/stylesheets/", "public/javascript/", "public/images/"],
  "dependencies": {
    "bootstrap-js": "*",
    "bootstrap.css": "*"
  },
  "source":
  {
    "bootstrap.css": "public/stylesheets/bootstrap/"
  }
}
```

Il ne vous reste plus qu'à lancer la commande d'installation :

```
bower install
```
## Un [coffee](http://coffeescript.org/) avant de commencer ...
Un truc pas mal que l'on peut faire avant de commencer quand on est flemmard comme moi c'est de lancer son projet en ecrivant en coffee-script. Pour ceux qui ne conaissent pas, il s'agit d'un meta-language pour générer du javascript. C'est pas mal et ça permet de faire du code simplement qui serait compliqué avec du javascript. Installer le de manière gloable de la façon suivante :

```
npm install -g coffee-script
```

Vous aurez accès à la commande coffee qui vous permettra de compiler vos fichier .coffee en javascript. Vous pourrez utiliser la commande suivante : 

```
coffee --compile .
```

Cette commande vous generera vos fichier javascript au même endroit que vos coffee-script, vous pouvez aussi choisir de ne génerer qu'un seul fichier en joignant tous les fichiers en un seul. Pas mal pour de la prodution (mais pas encore testé). Cependant le mieux sera de compiler les fichiers  a la demande avec coffe-script lui meme, avec la commande suivante :

```
coffee app.coffee
```

## Vos dépendances locales avec package.json
une autre grande force de node.js c'est de pouvoir gérer ces dépendances localement aussi grâce au fichier package.json qui contiendra toutes les librairies dont vous aurez besoin pour votre projet (un peu comme compser et le fichier composer.json). A titre d'exemple voici mon package.json utilisé dans le cadre de ce projet :

```json
{
  "name": "fabbook",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "start": "node app"
  },
  "dependencies": {
    "express": "3.0.0",
    "jade": "*",
    "sequelize": "*",
    "async": "*",
    "forms": "*"
  }
}
```
Une fois ce fichier mis en place la commande `npm install` vous permettra d'installer toutes les dépendances locales du projet. De manière général, je n'installe localement que les librairies utilisées par le projet. 

## Le controlleur et le routing
Alors maintenant il va falloir définir les routes de votre application et les applications qui vont avec. Les routes se trouveront dans le le fichier app.js et la logique se trouve dans le dossier `routes/` dans le fichier `app.js` vous associé les urls aux actions corespondantes. Nous allons pour le moment faire du VC (View Controller). Nous allons faire une action qui affiche hello plus le nom que vous mettez dans l'url. Nous allons définir la route pour commencer dans le fichier app.coffee:

```coffeescript
# Routing rules
app.get "/hello/:name", routes.hell
```
Maintenant dans le fichier `routes.coffee` on définit l'action avec la récupération du paramètre.

```coffeescript
exports.hello = (req, res) ->
  name = req.params.name
  res.render "hello",
    name: name
    title: name
```
N'oubliez pas de faire la vue qui va avec `hello.jade`

```jade
extends layout
block content
  div.container
    div.hero-unit
      h1 #{name}
      p Welcome to #{name}
```
Et voilà vous avez l'équivalent du demoBundle de symfony2 et vus avez une route du type http://localhost3000/hello/toto qui vous affichera un superbe welcome toto

## Le modele
Nous voilà maintenant avec un routing et un controller, il nous faut maintenant pouvoir accéder aux données et les afficher, pour cela, comme je suis flemmard (et par extension vous, si vous lisez ces lignes) nous allons utiliser un [ORM](http://www.wikiwand.com/fr/Mapping_objet-relationnel) pour se faciliter l'utilisation de la base de données. Express est un peu comme Symfony agnostique, il n'est pas livré avec un ORM obligatoire (de même pour le moteur de template) vous pourrez donc utiliser celui que vous voulez. Sur le net mongoDB est assez bien traité je vais donc me pencher sur sequelize.js qui a de bon arguments. 

Nous allons sortir la configuration de la base de données dans un fichier à part, que nous appellerons `db.coffee` et nous mettrons notre modele dans le dossier models qui contiendra un objet Article contenant un titre, un contenu, une date de création, et une de mise à jour. Le modele contient le fichier `article.coffee` suivant :

```coffeescript
module.exports = (sequelize, DataTypes) ->
  model = define_model(sequelize, DataTypes)
  
define_model = (sequelize, DataTypes) ->
  properties = 
    id:
      type: DataTypes.INTEGER
      allowNull: false
    title:
      type: DataTypes.STRING
      allowNull: false
    content:
      type: DataTypes.STRING
      allowNull: false
  model_options = 
    freezeTableName: true
    paranoid: false
    underscored: true
    timestamps: true
    
  sequelize.define 'article', properties, model_options
```

Voilà votre objet article et nous allons maintenant régler l'accés à la base de donnée dans le fichier `db.coffee` :

```coffeescript
Sequelize = require 'sequelize'
config = require "./config/#{process.env.NODE_ENV || 'dev'}.json"

connections = {}

connections[config.database] = new Sequelize config.database, config.user, config.password,
  logging: true
#Models
Article = exports.Article = connections[config.database].import "#{__dirname}/models/article"
```

A noter que nous en avons aussi profité pour sortir le fichier de configuration dans un fichier à part de façon à rendre l'application indépendante de la configuration de la machine. Maintenant nous allons construire nos deux routes, une qui affichera l'ensemble des articles et une qui affichera un article particulier. 

## Routes avec le model
Nous allons dans le fichier `route.coffee` et nous allons définir nos deux actions. 

```coffeescript
#
# * GET home page.
# 
db = require("../db")

exports.news = (req, res ) ->
  db.Article.findAll().success (articles) ->
    res.render "articles",
      articles: articles
      
exports.show = (req, res ) ->
  id = parseInt(req.params.id)
  db.Article.find(id).success (blog) ->
    res.render "article",
      article: blog
```

Et mainteant il on va définir les vues coresspondantes, il y a donc deux fichiers à créer `article.jade` et `articles.jade` (avec un s de différence) voilà le code 

```
#article.jade
extends layout
block content
  div.container
    div.hero-unit
      h1 #{article.title}
      p  #{article.content}
```
et l'autre template `articles.jade` : 

```
extends layout
block content
  div.container
    each article in articles
      div.hero-unit
        h1 #{article.title}
        p  #{article.content}
        a.btn(href="/news/"+article.id+"/article") read More
```

Il ne vous reste plus qu'à définir les routes dans `app.coffee` de la façon suivante : 

```coffeescript
app.get "/news/:id/article", routes.show
app.get "/news", routes.news
```

Et voilà vous aurez tout ce qu'il faut pour faire une application qui va bien. 

## Conclusion 
Etant développeur symfony, j'ai bien entendu orienté mon projet node.js afin de retrouver mes anciens repères. Ceci dit je suis agréablement surpris par la richesse de ce framework et des possibilités qu'il offre. Dans un prochain article je traiterai de la mise en production de votre projet et de la gestion des formulaires (Une des grande force de symfony2). Bien entendu si vous avez des suggestions ou des compléments n'hésitez pas à poster vos commentaire je me ferais un plaisir d'améliorer ce post au grès des propositions. Et que la force du node.js soit avec vous... 

PS: si vous souhaitez voir les sources de ce projet dans le détail vous pouvez vous rendre sur [github](https://github.com/garciaf/FabbookJs)





