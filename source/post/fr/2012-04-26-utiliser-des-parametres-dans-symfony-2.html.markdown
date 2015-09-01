---
title: Utiliser des paramètres dans symfony 2
date: 2012-04-26 00:00 UTC
tags: php, symphony
cover: symphony-php.jpg
lang: fr
---

Parfois des choses simples peuvent parfois devenir compliqué si on si
prend mal. Aujourd'hui j'ai voulu utiliser un paramètre dans un fichier
de config pour pour m'en servir dans mon application symfony2. Pas de
quoi casser trois pattes à un canard mais quand on est habitué à symfony
1.4 les choses sont un peu différentes 

READMORE

## Symfony 1.4 old way 

Avant avec symfony 1.4 les choses étaient assez simple, pour récupérer
une donnée dans un fichier de configuration yml et après on pouvait
appeller une une classe dédiée en donnant le nom de la variable : 

`sfConfig::get('your_variable');`

## Symfony2 the new way 

Dans symfony2 les choses sont un peu plus complexe mais aussi plus
logique (paradoxale non ?). Tout d'abbord si l'on souhaite que la la
variable soit renseignée dans le fichier de config il faut faire de
l'injection de dépendance pour commencer. Je vous invite à lire la doc
[officiel](http://symfony.com/doc/master/components/dependency_injection/introduction.html)
pour bien comprendre comment cela fonctionne, il y a aussi le site du
zero qui propose un très bon tutoriel sur cette partie. Alors pour faire
simple on va dire au framework quels sont les paramètres que l'on
attend, on va ensuite régler dans notre bundle que faire de ces données,
les intégrer dans un service où les utiliser comme paramètre globale.
Dans le détail ça donne quoi ?

### Injection de dépendance 

dans le `Bundle/DependencyInjection/Configuration.php`:


```php
<?

public function getConfigTreeBuilder(){
  ->scalarNode('yourVariable')->isRequired()->end() 
}

?>
```
Ensuite il faut déclarer dans `DependencyInjection/FabfotoGalleryExtension.php` les fichier que l'on attend ce paramètre et qu'il suffit de le récupérer : 

```php
<?
$container->setParameter('your_bundle.yourVariable',
$config['yourVariable']);
?>
```

Il suffira de déclarer votre variable avec sa valeur dans votre fichier
config.yml et pour y accéder dans un controller vous ferez la commande
suivante 

```php
<?
$this->container->getParameter('yourVariable')
?>
```
Et voilà le tour est joué ...

