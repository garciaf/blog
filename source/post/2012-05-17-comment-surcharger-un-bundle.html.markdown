---
title: Comment surcharger un bundle
date: 2012-05-17 00:00 UTC
tags: php, symphony, fr
cover: symphony-php.jpg
lang: fr
---

Parfois, dans Symfony2, on trouve un bundle sympa qui fait presque tout
ce qu'on veut. Et parfois on aimerait juste changer un petit truc sans
tout refaire.

C'est ce qui m'est arrivé avec le
[KnpLastTweetBundle](https://github.com/KnpLabs/KnpLastTweetsBundle). Il
s'agit d'un bundle permettant d'afficher les derniers tweets publiques
d'un compte tweeter. C'est un très bon bundle, facile à utiliser, bien
documenté, mais ce qui ne me plaisait pas c'était l'affichage des tweets
en question. Bref comment changer cette "petite choses" ?

## La mauvaise manière : forker le bundle

Au début j'ai voulu faire au plus simple, je suis allé sur github, j'ai
forké le projet en question, j'ai changé le fichier view et j'ai importé
ce bundle personnalisé en lieu et place de l'original. C'est très mal !
Et pourquoi c'est mal ? 

-   On freeze le bundle et on se passe des mises à jour apportées au
    projet,notamment en matière de sécurité et correction de bug.
-   On doit maintenir un bundle supplémentaire, pour une
    personnalisation spécifique d'un projet.

Bref il fallait trouver autre chose heureusement symfony2 est un
framework plein de ressources, et il permet de surcharger des bundles

## La bonne manière : La surchage de bundle avec symfony2

Pour surcharger un bundle il faut tout d'abbord créer un bundle qui va
acceuillir la surharge, une petit commande devrait vous aider :  

`./app/console generate:bundle`

Notre nouveau bundle s'appellera "FabfotoLastTweetBundle" ensuite
direction le premier fichier de l'arborescence de votre nouveau bundle
dans mon cas il s'agit du fichier "FabfotoLastTweetBundle.php" nous
allons donner le nom du bundle que l'on surchage dans ce cas
"KnpLastTweetsBundle", ce qui donne en code : 

```php
<?
namespace Fabfoto\\LastTweetBundle;
use Symfony\\Component\\HttpKernel\\Bundle\\Bundle;
class FabfotoLastTweetBundle extends Bundle
{
    public function getParent()
    {
        return 'KnpLastTweetsBundle';
    }
}
?>
```

Ensuite il faut respecter la même arborescence que celle du bundle
original, pour surcharger une partie du code, dans mon cas j'ai donc
créer un fichier twig pour la partie que je voulais changer : 

`touch src/Fabfoto/LastTweetBundle/Resources/views/Tweet/lastTweets.html.twig `

et dans le fichier fraichement créé j'ai mis le code de ma vue, pour
exemple : 
```html
<div class="knp_last_tweets">
    {% if tweets %}
        <div id="tweet_list">
        {% for tweet in tweets %}
        <div class="tweet">
            <div class="tweetText">{{ tweet.text|knp_tweet_urlize }}</div> 
            <div class="date_twitter">le {{tweet.createdAt|date('d/m/Y')}}</div>
        </div>
        {% endfor %}
        </div>
    {% else %}
        No tweets
    {% endif %}
</div>
```

Et voilà le bundle est surchargé de manière propre et finalement ce
n'était pas si compliqué. Voir à ce sujet la documentation sur le [site
officiel](http://symfony.com) qui est très bien faites.