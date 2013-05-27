---
layout: post
title:  "Les prommesses expliqué avec Ken et Barbie"
date:   2013-04-01 21:15:46
categories: article
language: fr
published: true
---

# Les prommesses expliqué avec Ken et Barbie
## L'histoire de ken et Barbie
La vie est pleine de promesses nous en faisons tous les jours. Prenons par exemple ken et barbie:
    
    ken = new PerfectMan()
    barbie = new PerfectWoman()


Les deux sont parfaits et maintenant voyons comment ses deux personnes vont intéragir. 
{% highlight ruby %}
ken.marry(barbie)
{% endhighlight %}

Ok c'est pas mal mais il se passe quoi aprés ? et bien dans les films ça s'arrête là, mais dans le monde réel ça continue.
{% highlight ruby %}
ken.marry(barbie)
  .then => ken.find(job)
  .then => child = Sexe(ken, barbie)
  .then (child) => ken.takeCare(child); barbie.takeCare(child)
  .then => ken.die()
  .then => barbie.die()
{% endhighlight %}

Et voilà une vie parfaite terminé. 

## L'histoire des gens nomaux
Mais tout ne se réalise pas toujours comme on le souhaite, et les promesses que l'on fait ne sont pas toujours tenues. 
{% highlight ruby %}
ted = new Man()
robin = new Woman()
{% endhighlight %}

Prenons le cas de ted Mosby et Robin scherbatsky, le plan ne va pas se réaliser comme prévu. 
{% highlight ruby %}
ted.marry(robin)
  .then => ted.find("job")
  .fail => otherWoman = ted.find("otherWoman")
{% endhighlight %}

Bon dans notre cas ted vas passer par la fonction fail, car robin n'est pas prête à s'engager dans une relation. Donc ted devra trouverune autre femme.

Parfois dans la vie pour réaliser une chose il faut avoir remplie plusieurs conditions. 
Si on suppose que barbie est uniquement intéressé par l'argent. Si on veut épouser barbie ça ne sera pas aussi simple. 
{% highlight ruby %}
me = new Man()
barbie = new PerfectWoman()
$.when(me.find("job"), me.do("sport"), me.earn("money"), me.do("surgery"))
  .then => me.marry(barbie)
  .then => child = Sexe(me, barbie)
  .then(child) => me.takeCare(child)
  .then => me.die()
  .then => barbie.die()
  .fail(error) => me.find("otherWoman")
{% endhighlight %}

Et voilà vous avez épousé barbie et bravo mais si jamais une des étapes à échoué vous n'aurez plus qu'à trouver une autre femme.
Bref c'est bien beau tout ça mais c'est quoi le lien avec javascript ? Et bien c'est la même chose (les histoires d'amours en moins) 

# Le lien avec javascript

## Exemples 

En js vous pouvez décider de retourner une promesse pour un événement asynchrone. 
Si tout s'est bien passé alors vous pourrez passez à la suite avec comme argument le ou les valeurs retourné.
Prenons un exemple classique:
{% highlight ruby %}
user.findWhere(name:"john").success(user) ->
  Email.send(user.email).success(response) ->
    fs.write response, (status) ->
      console.log "workflow finished"
{% endhighlight %}

On changera ce code avec les promesses de la façon suivante :
{% highlight ruby %}
user.findWhere(name:"john")
  .then (user) -> Email.send(user.email)
  .then (response) -> fs.write response
  .then (status) -> console.log "Workflow finished" 
{% endhighlight %}

Le code devient beaucoup plus lisible et plus facile à comprendre.
Prenons le cas où nous devont faire appel à deux fonctions asynchrone et traiter les données trouvé.
Une approche possible avec Backbone sera :
{% highlight ruby %}
checkAllFetched = (collection) =>
  collection.fetched = true
  if @collection1.fetched and @collection2.fetched
    @prepareData()
fetchOptions =
  success: checkAllFetched
  data: @params
@collection1.fetch fetchOptions
@collection2.fetch fetchOptions
{% endhighlight %}

On pourra utiliser jquery et la fonction when qui fera la même chose:
{% highlight ruby %}
$.when(@clicks.fetch(data: @params), @installs.fetch(data: @params))
  .done => @prepareTableData()
{% endhighlight %}

Les deux codes font exactement la même chose, mais dans le deuxième cas on gagne en clareté et nombre de lignes de codes.
Bien évéidemment vous pourrez faire toutes ses choses aussi du code serveur avec la librairie Q pour node qui est excellente. 
Voyons un workflow avec node :
{% highlight ruby %}
user.findWhere(name:"john").success(user) ->
  Email.send(user.email).success(response) ->
    fs.write response, (status) ->
      user.save(status: "message send"). success(err, res) ->
        console.log "workflow finished"
{% endhighlight %}

Pas vraiment sexy, si on décide d'utiliser les promesses, le code se transforme de la façon suivante
{% highlight ruby %}
user.findWhere(name:"john")
  .then (user) -> Email.send(user.email)
  .then (response) -> fs.write response
  .then (status) -> user.save(status: "message send")
  .then (status) -> console.log "Workflow finished" 
{% endhighlight %}

Le code est beaucoup plus lisible et du code plus claire est du code qui se maintient mieux. 

## Transformer des fonctions asynchrone en promesses
### Node
Tout cela est bien beau mais l'essentiel du monde javascript est plutôt friand de callback. 
Si l'on souhaite néanmoins utiliser les promesses au lieu des callback. 
On pourra utiliser la librairie Q excellente de cette façon :
{% highlight ruby %}
find: (email, callback) ->
  @query "SELECT `id`, `email` WHERE email = `?` LIMIT 1", email, (err, res) ->
    callback err, res[0]
{% endhighlight %}

deviendra : 

{% highlight ruby %}
find: (email) ->
  deferred = Q.defer()
  @query "SELECT `id`, `email` WHERE email = `?` LIMIT 1", 
    email, (err, res) ->
    if err
      deferred.reject new Error(err)
    else
      deferred.resolve res
    return deferred.promise
{% endhighlight %}

Une notation plus courte donnera

{% highlight ruby %}
find (email) ->
  Q.nfcall @query, "SELECT `id`, `email` WHERE email = `?` LIMIT 1", email 
{% endhighlight %}

ou encore: 
{% highlight ruby %}
find (email) ->
  Q.ninvoke @, "query", "SELECT `id`, `email` WHERE email = `?` LIMIT 1", email 

{% endhighlight %}
Ainsi la fonction pourra être utilisé de la façon suivante: 
{% highlight ruby %}
User.find("test@mail.com")
  .then (user) -> console.log user
  .fail (err) -> console.err err
{% endhighlight %}

### jQuery
jQuery utilise les promesses depuis la version 1.5. 
Si l'on souhaite convertir une fonction asynchrone en prommesse, Defered va devenir très utile. 
{% highlight ruby %}

promiseFunc = ->
  deferred = new jQuery.Deferred()
  ayncFunction param, (err, res) ->
    if err
      deferred.reject err
    else
      deferred.resolve res
  return deferred.promise()
       
{% endhighlight %}
et on utilisera toujours de cette façon:
{% highlight ruby %}
$.when(promiseFunc).then (res) ->
  alert status + ", things are going well"
{% endhighlight %}
 
## Liens

Pour terminer ce petit article quelques liens pour aller plus loin, car tout n'a pas été abordé. 
Et il y a beaucoup d'autre chose à en dire :
* [Q](http://documentup.com/kriskowal/q/)
* [Deferred object jQuery](http://api.jquery.com/category/deferred-object/)

## Conclusion 

Bien évidemment si vous souhaitez rajouter des points compléter ou corriger, il ne vous reste plus qu'à forker.