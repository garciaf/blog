---
title: Créer un backend avec node.js
tags: nodejs, javascript, fr
cover: nodejs.jpg
lang: fr
alias: ["creer-un-backend-avec-node-js/blogarticle/", "post/2012/11/01/creer-un-backend-avec-node-js/"]
---

Comment faire un backend avec des utilisateurs en base, des forms, passport.js quand on est flemmard et que l'on vient de symfony2 ?

READMORE

Quand on vient de symfony2 et que l'on découvre node.js on fait d'abbord connaissance, ensuite on cherche à faire un CRUD et pour terminer on veut faire un backend avec une authentification et les utilisateurs en base de données. Mais comment on fait ? Avec symfony2 on installe FOSUserBundle et ça roule tout seul, et avec node.js ? C'est la question que je me suis posé et pour laquel je vais exposer ma vision de la chose.

### Le Formulaire de login
Au risque de me répéter coder des formulaires n'est pas le truc que je trouve le plus excitant, c'est pour ça que je vais m'appuyer sur une librairie qui fait ça pour moi ( pour plus de détail sur cette librairie voir mon article précédent ) on va donc créer un nouveau formulaire que l'on appellera login.coffee et que l'on placera dans le dossier form. Son code ressemblera à ça : 

```coffeescript
forms = require "forms"
fields = forms.fields
validators = forms.validators
widgets = forms.widgets
  
loginForm = forms.create(
  username: fields.string(required: true)
  password: fields.password(required: true)
)
  
LoginForm = exports.LoginForm = loginForm
```
Votre formulaire de contact est fait, maintenant nous allons sécuriser la zone avec passport.js

## Vos papiers SVP avec passport.js
Pour l'authentification il y a le choix entre différentes librairie, j'ai fais le choix arbitraire de passport.js mais libre à vous d'en choisir une autre bien entendu. Les exemples de l'API sont intéressants mais ils ne traitent pas de l'autentification avec les utilisateurs en base de données, et la définition de pattern de route pour l'autentification. je vais donc réparer ce tord. Tout d'abbord installons la librairie avec tout ce qui va bien. On édite le fichier package.json : 

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
    "forms": "*",
    "passport": "*",
    "connect-flash": "*",
    "passport-local": "*"
  }
}
```
Comme d'habitude vous lancez la commande `npm install` et vous aurez toutes les librairies nécessaires pour ce tuto. Maintenant on va gerer l'autentification à part, je n'aime pas que le fichier app.coffee soit trop chargé. Je créé donc un fichier auth.coffee et c'est parti : 

```coffeescript
db = require("./db")
passport = require 'passport'
util = require 'util'

# asynchronous verification, for effect...
ensureAuthenticated = (req, res, next) ->
  return next()  if req.isAuthenticated()
  res.redirect "/login"

findById = (id, fn) ->
  db.User.find(id).success (user) ->
    if user
      fn null, user
    else
      fn new Error("User " + id + " does not exist")

findByUsername = (username, fn) ->
  db.User.find
  db.User.find(where:
    username: username
  ).success (user) ->
    return fn(null, user)


LocalStrategy = require("passport-local").Strategy

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  findById id, (err, user) ->
    done err, user

passport.use new LocalStrategy((username, password, done) ->
  # asynchronous verification, for effect...
  process.nextTick ->  
  findByUsername username, (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "Unknown user " + username
        )
      unless user.password is password
        return done(null, false,
          message: "Invalid password"
        )
      done null, user
)

Passport = exports.Passport = passport
EnsureAuthenticated = exports.EnsureAuthenticated = ensureAuthenticated
```
Vous noterez qu'il s'agit d'une adapation de l'exemple de base. En effet les utilisateurs sont désomais récupéré en base de données, pour que cela fonctionne il faut aussi déclarer dans le modele un 'user' qui contiendra les données nécessaires pour l'autentification, dans models/user.coffee : 

```coffeescript
module.exports = (sequelize, DataTypes) ->
  model = define_model(sequelize, DataTypes)
  
define_model = (sequelize, DataTypes) ->
  properties =
    id:
      type: DataTypes.INTEGER
      allowNull: false
    username:
     type: DataTypes.STRING
      allowNull: false
    password:
      type: DataTypes.STRING
      allowNull: false
    email:
      type: DataTypes.STRING
      allowNull: true
  model_options =
  freezeTableName: true
    paranoid: false
    underscored: true
    timestamps: false
  sequelize.define 'user', properties, model_options
```

Et une petite adapatation à notre fichier db.coffee où l'on rajoute la ligne suivante:

```coffeescript
User = exports.User = connections[config.database].import "#{__dirname}/models/user.js"
```
maintenant il faut s'aoccuper de l'app.coffee
### Déclarer un pattern de route nécessitant une autentification
Ce que je préfère pour l'authentification c'est qu'une famille de route necessite de montrer patte blanche, plutôt que de définir pour chaque route si il faut ou non une authentification (flemme quand tu nous tient), cela se traduit donc par l'utilisation de app.all dans mon fichier app.coffee. Cela nous donne ça au final : 

```coffeescript
###
Module dependencies.
###
express = require 'express'
passport = require 'passport'
flash = require 'connect-flash'
routes = require './routes'
admin= require './routes/admin'
security= require './routes/security'
http = require 'http'
path = require 'path'
app = express()
util = require("util")
auth = require ('./auth')

# configure Express
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()
  app.use passport.initialize()
  app.use passport.session(secret: "keyboard cat")
  app.use flash()
  app.use auth.Passport.initialize()
  app.use auth.Passport.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

# Routing rules
# Global pattern admin routes need authentication
app.all "/admin/*", auth.EnsureAuthenticated

app.get "/", routes.news

app.get "/hello/:name", routes.hello

app.get "/news/:id/article", routes.show

app.get "/login", security.login

app.post "/login", security.authenticate, admin.listArticle

app.get "/logout", security.logout

app.get "/admin/article/new", admin.newArticle

app.get "/admin/article/list", admin.listArticle

app.post "/admin/article/new", admin.createArticle

app.get "/admin/article/:id/edit", admin.editArticle

app.post "/admin/article/:id/edit", admin.updateArticle

app.get "/admin/article/:id/delete", admin.deleteArticle
```

J'en ai aussi profité pour mettre mes routes liés à l'autentification dans un controlleur à part dans le fichier routes/security.coffee qui ressemble à ça : 

```coffeescript
form = require("../form/login")
auth = require("../auth")

exports.login = (req, res) ->
  res.render "admin/login",
    form: form.LoginForm.toHTML()
    title: 'login'

exports.authenticate =  auth.Passport.authenticate("local",
  successRedirect: '/admin/article/list'
  failureRedirect: '/login'
)

exports.logout = (req, res) ->
  req.logout()
  res.redirect '/'
```
Pour info la vue 'admin/login.jade' ressemble à ça :

```jade
extends ../layout
block content
  div.container
    div
    - if (typeof form !== 'undefined')
    form(method='post')
      != form 
      input(type='submit')
```
Et voilà vous avez maintenant une application qui vous demandera patte blanche pour toutes les URL de la famille admin/* et ira récupérer les informations dans votre base de données, pas mal non ?

### Bonus et si on rajoutait un peu de salt ?
e met une grosse mise en garde avec la solution que je viens de présenter, en effet les données des utilisateurs sont stockées en claire dans la base de données pour pouvoir fonctionner. Cela ne doit jamais être fait de cette manière en production (cela arrive malheureusement, vous n'avez qu'à voir le nombre de grandes enseignes qui se sont fait volé les mots de passes par des hackers) en effet si votre site est attaqué et la base de donnée substitué les hackers auront accès directement au mots de passes de vos utilisateurs. Bref on va faire quelques changements pour que cela n'arrive pas.

### On ajoute une librairie qui gère la hash et le salt
il y a un choix de librairie qui propose de gérer la hash et le salt j'ai pour ma part choisi sechash on l'ajoute dans sa liste de package et on l'installe. Je vais ajouter un champ salt sur mon user pour que chaque utilisateur possède un salt différent. De cette façon vous vous protégez que deux utilisateurs avec un même mot de passe aient le même hash. Il va falloir adpter notre code de vérification des utilsateurs. Allez dans le fichier auth.coffee : 

```coffeescript
sechash = require 'sechash'
...

checkPassword = (user, password) ->
  opts =
    algorithm: "sha512"
    salt: user.salt
    includeMeta: false
  return sechash.testHashSync password, user.password, opts

...


passport.use new LocalStrategy((username, password, done) ->
  # asynchronous verification, for effect...
  process.nextTick ->
    findByUsername username, (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "Unknown user " + username
        )
      unless checkPassword user, password
        return done(null, false,
          message: "Invalid password"
        )
      done null, user
)
```

Nous avons rajouté une fonction checkPassword que nous appellons dans le processus de vérification et voilà vos mot de passes sont plus sûr. Bien entendu vous devez maintenant créer un utilisateur et implémenter des méthodes de changement par email ou en console, mais ce n'est pas le propos de cet article...

##Conclusion
Pour ceux qui veulent voir le code de leur propres yeux ça se passe [ici](https://github.com/garciaf/FabbookJs). Si vous avez des suggestions ou autre les commentaires sont là pour ça.  
