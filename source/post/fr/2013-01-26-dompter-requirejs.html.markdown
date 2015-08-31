---
title: Dompter requireJS
date: 2013-01-26 00:00 UTC
tags: javascript
cover: requirejs.jpg
---

RequireJs fait partie de ces outils que j'ai d'abord détesté avant d'adorer, retour d'expérience

READMORE

Un jour ce qui doit arriver arrive, vous vous lancer dans le développement d'une single page application. Bien entendu vous partez avec un framework javascript, un vrai (backbone, angularJs etc...) et vous commencer à coder pleins de fichier, pleins de classes, vos templates sont dans des fichiers à part. Tout est beau mais dans quel ordre va t'il falloir charger les fichiers sur votre page? Si vous ne souhaitez pas avoir à répondre à cette question je vous recommande l'usage de requirejs. Un bien bel outils pour gérer le chargement des fichiers asynchrone et l'optimisation des chargements coté client. Mais pour être honnête la première fois ça ressemblait plus à une épinde dans le pied qu'autre chose. Bref je vous livre ici ce que j'en ai compris histoire que vous ne fassiez pas les mêmes erreurs que moi. 

## Il y a une différence entre connaitre le chemin et arpenter le chemin:
Tout d'abbord dans votre fichier html vous allez déclarer un seul et unique script pointant vers la librairie requirejs, avec comme argument le chemin du premier fichier à démarrer. Ce fichier contiendra tous les chemins "non évident" ainsi que leurs alias. De plus c'est aussi là que vous déclarerez des dépendances entre les librairies. Ne ratez pas cette étapes ou vous risquez d'avoir des chargement curieux au lancement de vos application. Voyons un petit exemple. Nous allons charger un projet Backbone, avec underscore, jQuery et même bootstrap. On commence avec le HTML :

```html
 <script src="js/require.js" data-main="main"></script>
```

Voilà c'est terminé pour votre HTML, maintenant jetons un oeil à votre fichier main.js qui se trouve à la racine de votre dossier public, si vous le souhaitez vous pouvez bien entendu déclarer un autre chemin pour votre fichier dans l'attribut data-main. 

```javascript
require.config({
  paths: {
    "jquery": "vendors/jquery",
    "underscore": "vendors/underscore.min",
    "backbone": "vendors/backbone.min",
    "bootstrap": "vendors/bootstrap.min",
    "handlebars": "vendors/Handlebars",
    "i18nprecompile": "vendors/require-handlebars-plugin/hbs/i18nprecompile",
    "json2": "vendors/require-handlebars-plugin/hbs/json2",
    "hbs": "vendors/require-handlebars-plugin/hbs",
    "templates": "../views/templates"
  },
  shim: {
    "underscore": {
      exports: "_"
    },
    "backbone": {
      deps: ['underscore', 'jquery'],
      exports: 'Backbone'
    },
    "bootstrap": {
      exports: "$",
      deps: ['jquery']
    },
    "backboneGetSet": {
      deps: ['backbone']
    }
  },
  hbs: {
    templateExtension: 'hbs',
    "hbs/underscore": "underscore",
    disableI18n: true
  }
});

require(['app', 'backbone'], function(App, Backbone) {
  return App.initialize();
});
```

Vous avez un fichier pour démarrer, expliquons ce qui se cache dedans. Premièrement l'attribut "path", c'est ici que l'on va faire le lien entre les alias et les chemins de vos librairies. Vous n'avez pas besoin de spécifier le .js à la fin des chemins. Premier point assez important n'oubliez pas de prendre les version "amd" ou requirejs optimisé, celà vous évitera bien du soucis. Une fois dans les autres fichiers vous n'aurez plus qu'à utiliser les alias que vous avez écris.

Une fois dans vos fichier vous pourrez appelé les classes dont vous aurez besoin de manière très simple 

```javascript
define(function(require) {
  $ = require('jquery')
  $('.ma-class').html()
}
```
Vous voilà prêt à dévolpper sous forme de module. Vous ferez de cette manière du code plus maintenable, plus beau, plus propre. Dans le cadre d'une single page web app. Celà me semble plus que nécessaire. 

## Les petits trucs en plus

Require dispose de pas mal de pluggin, il y en a un que j'ai testé qui à la bonne idée de compiler les fichiers de template handlebar. Cela vous fera quelques lignes de code et vous permettra de vous concentrer d'avantage sur la logique de votre application. Le pluggin se trouve [ici](https://github.com/SlexAxton/require-handlebars-plugin)

Ensuite vous pourrez appeler vos template déjà compiler en utilisant la notation hbs!path/to/my/template

```javascript
rowTemplate = require('hbs!templates/info/rowInfo');
$("target").html(rowTemplate({"name":"toto"}));
```
Rien de plus simple, à noter que vous pouvez aussi gérer l'I18n avec ce pluggin. Si vous cherchez un exemple d'utilisation vous verrez un exemple massif d'utilisation sur mon application [trainJs](https://github.com/garciaf/train-js) 
## Conclusion 
Il faudra que je teste d'autre composant de requirejs qui propose l'opitimisation du code, l'utilisation coté serveur, et j'en passe. Bref un bien bel outils qui peut demander un peu de temps avant d'être maitrisé mais qui vous rendra le vie plus belle pour vos projets javascript.


