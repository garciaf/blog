---
title: Trucs et astuces pour augmenter son référencement
date: 2012-10-18 00:00 UTC
tags: php
cover: seo-symfony.jpg
---

 Toujours au travail après avoir rencontré le collègue qui aimait
optimiser ses applications,
j'en ai rencontré un autre qui m'a ouvert sur un tout autre sujet :
"Comment faire en sorte que son site soit vue" ou "comment être dans les
premières pages de google". La question semble simple mais la résolution
du problème est, au contraire de la performance, pas une science exacte
et les règles d'aujourd'hui ne seront pas celle de demain. Ceci dit
voici quelques règles que l'on peut appliquer ainsi que le code associé
en symfony pour y parvenir

## Faire de belles URLs avec StofDoctrineExtensionsBundle

Une des premières règles assez sommaire c'est d'avoir de belles URLs
pour ses articles en effet www.moblog.com/nom-de-mon-article/blog c'est
plus sympa que www.moblog.com/1/blog et c'est l'un des premiers éléments
sur lequel on peut faire quelque chose sans trop se casser la tête.

Pour commencer on peut installer le bundle
[StofDoctrineExtensionsBundle](https://github.com/l3pp4rd/DoctrineExtensions)qui
offre une la possibilité d'enregistrer des slugs uniques pour votre
entité. c'est quoi un slug ? Et bien c'est une limace en anglais mais
sinon c'est un identifiant unique sous forme de mots attachés que l'on
peut mettre dans une URL. Ainsi "Salut à vous" deviendra "salut-a-vous".
On va donc transformer notre entité pour qu'elle ai ce nouveau
paramètre. Dans l'entité article on aura donc ceci : 

```php
<?php 
classArticleBlog

{
/**
* @var string $title
*
* @ORM\Column(name="title", type="string", length=255)
*/
    private $title;
    /**
* @Gedmo\Slug(fields={"title"})
* @ORM\Column(name="slugblog", type="string", length=255)
*/
    private $slugblog;

}
?>
```

Ensuite vous n'aurez plus qu'à changer votre controlleur pour qu'il
prenne en compte le slug au lieu de l'Id comme paramètre, au passage
utilisez param converter pour rendre les choses plus éléguantes :

```php
<?
/**
* @Route("/{slugblog}/blogarticle", name="show_article_blog")
* @ParamConverter("article", class="FabfotoGalleryBundle:ArticleBlog")
*/
    public function showBlogArticleAction(ArticleBlog $article)
    {
        return $this->render('FabfotoGalleryBundle:Default:ShowArticleBlog.html.twig', array(
                    'article' => $article,
                ));
        }
    }
?>
```

 Vous aurez maintenant de belles URL que votre moteur de recherche
préféré indexera au mieux.

## Tagger ses articles

Et oui je vous conseille de tagger vos articles. En fait d'une manière
il faut pouvoir organiser votre contenue de façon à le rendre accéssible
facilement, des catégories et des tags rendront la chose plus aisés,
pour vos utilisateurs et les robots de  google. Un petit nuage de tag
dans un footer ou autre ne fera pas de mal.

## Utiliser les balises Meta avec parcimonie

Pour continuer à donner de l'information utile au robots et qu'il vous
index au mieux, il faut remplir les balises mais de manière
intelligente. Il faut que les mots clefs correspondent au contenu. Pas
la peine de mettre le dictionnaire larousse en mot clefs sur chacune de
vos pages cela risque juste d'énerver le robot si le contenu par la
suite ne correspond pas. Pour ma part je remet dans mes balises
l'intitulé des tags de l'article, dans la meta Keyword ensuite j'indique
le titre de l'article dans la balise title, et le sous titre me sert de
description. Bref comme pour toute chose misez sur la qualité plutôt que
sur la quantité.

## Connaitre son visiteur

Et oui il faut arriver à connaître les personnes qui viennent sur votre
site, pas personnellement bien sûr mais que font elles, que voient elles
et qu'est ce qui peut les intéresser. J'ai utilisé google analitycs et
je dois dire que la qualité des rapports ainsi que la clareté de
l'information m'on fait oublié que par ce biais je donnais d'avantage de
pouvoir à Google. Mais si vous connaissez une solution plus respectueuse
de la vie privé des lecteurs de mon blog je suis preneur. Ceci dit cela
permet de voir le scénario d'utilisation de votre application et cela
permet d'imaginer d'autre fonctionnalité ou adapter vos écran en
fonction.

## Donnez des titres à vos pages

Une autre chose que les robots (et les utilisateurs) apprécient ce sont
des pages avec un titre de page en rapport avec le contenu. En effet si
toute les pages ont pour titre "mon super site" tout d'abbord cela ne
donne pas d'information utile, et surtout si une de vos page remonte
dans une recherche le nom du lien sera "mon super site" bref pas très
parlant. Alors que si votre page possède un titre le lien portera le
titre de la page, du coup le moteur de google (et vos utilisateurs)
préfère indexer des pages avec des titres dépendant du contenu. Un
exemple de layout symfony2 permettant de tout faire :

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        {% block metainfo %}{% endblock metainfo %}
        <title> {% block title %}Fabbook{%endblock title%}</title>
   </head>
    <body>
    {% block content %}lipso lium{%endblock%} 
        </script>
        {%block importjs %}
        {%endblock importjs%
    </body>
</html>
```
Voilà avec type de layout vous pourrez redéfinir le
titre de la page et gérer les Meta-données.

## Mettez du contenu de qualité

Tout est dans le titre, si votre site web n'a aucun contenu, et bien ça va être un peu compliqué. 
Bref mettez des articles des news et si vous avez implémenté le système de tag il y aura beaucoup de liens qui pointent à l'intérieur de votre site.

## Rendez votre site performant

Inutile de vous dire que si votre site a besoin de
trois heures pour charger vos utilisateurs et le robot d'indexation ne
vont pas vous aimer, render votre site aussi rapide que possible (si
vous voulez savoir comment faire jettez un oeil
[ici](../../../optimiser-son-site-symfony2-pour-la-performance/blogarticle "Optimiser la performance en symfony2"))

## Le SEO est-il mort ?

On voit souvent des blogs qui titre que le SEO est mort
mais j'ai trouvé une infographie (merci Yohan!) assez interessant sur le
sujet
[ici](http://www.pureconcept.fr/images/illustrations/La-mort-du-SEO.jpg)

## Postez du lien

Attention avec ce conseil, poster des liens vers
d'autre site que si cela est pertinent avec le site de destination ou la
question du forum. N'écrivez pas un pavé pour vendre votre site à chaque
page de forum. Sinon vous risquez de vous faire passer pour un spammeur
et là vous riquez d'obtenir l'effet inverse...</span>

## Conclusion

Tout d'abbord je dois avouer que je ne suis pas un SEO
manager mais un simple développeur plutôt curieux. Je me suis donc basé
sur les recommandations de Google et un peu de bon sens. En effet les
algorithmes d'indexation sont fait autour de la question "Comment
trouver l'information la plus pertinente et la plus intéressante" du
coup, du point de vue du développement on peut programmer en se
demandant " comment fournir l'information la plus pertinente ?" et
finalement ce n'est rien de plus. Ceci étant dis si certains d'entre
vous connaissent d'autre astuces, d'autre trucs je me ferai un plaisir
de mettre à jour mon post en même temps que mes connaissances sur le
sujet. A bon entendeur salut ...
