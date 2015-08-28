---
title: Un crud avec node.js
date: 2012-10-31 00:00 UTC
tags: nodejs, javascript
cover: nodejs.jpg
---
Un crud d'article éditable avec express, sequelize et form

READMORE

Venant du monde symfony et php j'ai apprivoisé l'étrange animal qu'est node.js après avoir vu quelques concept de base j'ai voulu assez rapidement faire un CRUD basique et le plus simplement possible. Pour cela nous allons utiliser quelques librairies pratique pour nous aider à faire notre CRUD.

## Les [forms](https://github.com/caolan/forms) à la rescousse
Une chose que je trouve stupide au possible est de gérer les formulaires à la main, c'est pour cette raison que j'ai cherché une petite librairie qui pouvait faire ça pour moi, elle se nomme assez sobrement [form](https://github.com/caolan/forms). Nous allons intégrer la librairie dans notre projet, pour cela on edit le fichier package.json et on rajoute la ligne suivante : 

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

Un petit `npm install` vous permettra de finir l'installation dans votre projet. Maintenant que nous allons créer un nouveau dossier form ou nous mettrons les déclarations de formulaire. Petite paranthèse, je n'ai jamais vraiment su ou placer les formulaire dans le modèle MVC. Après réflexion c'est entre la vue et le controlleur, ou il s'agit plutôt d'un service, c'est pour cette raison que je le place en dehors de la vue et du controlleur. Nous allons créer notre formulaire à part dans le dossier form :

```coffeescript
forms = require "forms"
fields = forms.fields
validators = forms.validators
widgets = forms.widgets
  
articleForm = forms.create(
  title: fields.string(required: true)
  content: fields.string(
    required: true
    widget: widgets.textarea()
  )
)
  
ArticleForm = exports.ArticleForm = articleForm
```

Notre formulaire est assez simple, il s'agit d'un input et d'un textarea.Comme vous pouvez le voir les règles de validation se trouvent aussi dans la déclaration du formulaire. Nous avons ansi rendu les deux champs obligatoire. Maintenant nous allons rentrer dans le controlleur 

## La création
Nous allons faire d'abbord, l'action pour créer  un nouvel article. Pour être excate nous allons faire deux actions, une action qui affiche le formulaire et une autre qui gère le post du pormulaire. Nous allons déclarer une methode new et une create : 

```coffeescript
db = require("../db")
form = require("../form/article")

exports.newArticle = (req, res ) ->
  res.render "admin/newArticle",
    form: form.ArticleForm.toHTML()
    title: 'admin'

exports.createArticle = (req, res ) ->
  form.ArticleForm.handle req,
    success: (form) ->
      db.Article.create(
        form.data
      ).success (article) ->
          req.method = 'get'
          res.redirect '/admin/article/list'
    other: (form) ->
      res.render "admin/newArticle",
        form: form.toHTML()
        title: 'failed'
```
Avec le code vous avez les action pour afficher le formulaire et le créer en base de données. Nous rajoutons la vue, nous créons le fichier `admin/newArticle.jade` : 

```
extends ../layout
block content
  div.container
    div
    - if (typeof form !== 'undefined')
    form(method='post')
      != form
      input(type='submit')
```

Il vous reste maintenant à rajouter vos routes dans votre fichier `app.coffee`.

```coffeescript
app.get "/admin/article/new", admin.newArticle
app.post "/admin/article/new", admin.createArticle
```
Comme vous pourrez le voir vous définissez une route pour le get et le post. Maintenant que nous savons créer nous allons détruire

## La suppression
J'ai fais le choix de supprimer en get les articles mais c'est un choix arbitraire et vous pourriez très bien le faire en post (ou delete si l'on veut utiliser la syntaxe http complete) dans notre route on va rajouter l'action de supression de l'article:

```coffeescript
exports.deleteArticle = (req, res ) ->
  id = parseInt(req.params.id)
  db.Article.find(id).success (blog) ->
    blog.destroy().success ->
      req.method = 'get'
      res.redirect '/admin/article/list'
```
Notez bien que nous redirigeons vers une route que nous n'avons pas encore créé (mais ça vient un peu plus tard). Maintenant nous rajoutons notre route dans l'application

```coffeescript
app.get "/admin/article/:id/delete", admin.deleteArticle
```

## L'édition
Maintenant que nous savons créer, détruire nous voulons pouvoir changer. Nous allons encore une fois définir deux routes, une pour afficher le formulaire de création et une pour la mise à jour des données en base : 

```coffeescript
exports.editArticle = (req, res ) ->
  id = parseInt(req.params.id)
  db.Article.find(id).success (blog) ->
    formEdit = form.ArticleForm.bind(blog.values)
    res.render "admin/editArticle",
      form: formEdit.toHTML()
      title: "edit "+blog.title

exports.updateArticle = (req, res ) ->
  form.ArticleForm.handle req,
    success: (form) ->
      id = parseInt(req.params.id)
      db.Article.find(
        id
        ).success (article) ->
          article.updateAttributes(
            form.data
          ).success () ->
            req.method = 'get'
            res.redirect '/admin/article/list'
    other: (form) ->
      res.render "admin/editArticle",
        form: form.toHTML()
        title: 'failed'
```

Cette partie m'a un peu fait transpirer car la façon de faire communiquer la base et les formulaire (dans les deux sens) n'a rien de très évident. On rajoute la vue qui ressemble beaucoup à celle de la création `admin/editArticle.jade` :

```
extends ../layout
block content
  div.container
    div
    - if (typeof form !== 'undefined')
    form(method='post')
      != form
      input(type='submit')
```
Vous pouvez maintenant rajouter vos routes :

```coffeescript
app.get "/admin/article/:id/edit", admin.editArticle
app.post "/admin/article/:id/edit", admin.updateArticle
```

## La liste 
Maintenant nous allons afficher la liste des entrées  et donner accés aux différentes actions que nous avons créé. Dans le routing nous allons récupérer toutes les entrées : 

```coffeescript
exports.listArticle = (req, res ) ->
  db.Article.findAll().success (articles) ->
    res.render "admin/listArticle",
      articles: articles
      title: 'blog'
```

C'est le template qui va être un peu plus complexe, nous utiliserons les classes de bootstrap et les icons de ce dernier : 

```
extends ../layout
block content
  div.container
    table.table
      thead
        tr
          th id
          th title
          th content
          th action
      tbody
        each article in articles
          tr
            td #{article.id}
            td #{article.title}
            td #{article.content}
            td 
              a(href="/admin/article/"+article.id+"/delete"): i.icon-trash
              a(href="/admin/article/"+article.id+"/edit"): i.icon-edit
    a.btn(href="/admin/article/new") New
```

Comme toujours avec jade faite très attention à l'indentation sinon vous risquez d'avoir des trucs assez marrant, une fois le template en place vous rajoutez la route dans votre application : 

```coffeescript
app.get "/admin/article/list", admin.listArticle
```

Votre crud est terminé ...

## Conclusion

Maintenant que vous réalisez votre crud, je vous conseille de gérer qui a le droit d'accéder au CRUD (qui sera certainement l'objet d'un prochain article). Un autre point que j'ai passé sous silence, la gestion des erreurs de sequelize, en effet l'API ne propose pas une gestion d'erreur, ce qui pose problème lorsqu'on la base de donnée ne remonte aucun résultats. Bref si vous avez une solution à ce problème je suis preneur. Sinon amusez vous bien avec ce CRUD, et si vous souhaitez voir l'ensemble des sources ça se passe [ici](https://github.com/garciaf/FabbookJs).


