---
lang: fr
title: Déployer son application symfony2 sur OVH
date: 2011-12-12 00:00 UTC
tags: ovh, symfony
cover: symphony-php.jpg
alias: deployer-son-application-symfony2-sur-ovh/blogarticle/
---

Le nouveau framework symfony 2 rock's mais comment mettre en ligne ses oeuvres sur une offre perso d'OVH quand on a pas de ligne de commande ?
READMORE
Alors tout d'abbord cet article est issu du déploiement de ce site. En effet il n'est pas évident de déployer quand on a pas "la main" sur son serveur et que l'on a accés simplement à un système de fichier. Alors pour démarrer quelques changements s'imposent dans votre projet :

### Arborescence du projet
Bien évidemment le répertoire par défaut sur lequel pointe OVH ne peut pas être changé. Si votre objectif est de déployer dans le domaine principal il vous faudra changer le nom du doosier web et le remplacer par www

```bash
mv web/ www
```

Rien d'autre à faire...

Bien évidemment cette manipulation n'est pas nécessaire si vous souhaiter déployer votre application dans un autre sous domaine. Car dans ce cas le dossier sur lequel pointe le serveur est configurable.

### Configuration du htaccess
Ensuite il vous faut configurer le fichier .htaccess que vous placerez dans le dossier `www/` (anciennement dossier `web/`) et il vous faudra configurer différents paramètre. Dans un premier temps il faut activer le PHP 5.3 et procéder à quelques optimisation (cf [benjamin-leveque.me](http://benjamin.leveque.me/installer-symfony2-sur-une-offre-perso-ovh.html?PHPSESSID=vdd9brek06ue3iot3t7r46ogb5) je ne l'ai pas inventé)

```
SetEnv SHORT_OPEN_TAGS 0
SetEnv REGISTER_GLOBALS 0
SetEnv MAGIC_QUOTES 0
SetEnv SESSION_AUTOSTART 0
SetEnv ZEND_OPTIMIZER 1
SetEnv PHP_VER 5_3
SetEnv SESSION_USE_TRANS_SID 0
```
La dernière ligne est une petite astuce pour ne pas avoir l'ID de la session PHP qui s'affiche dans l'URL. Ensuite dans ce même fichier il vous faut configurer votre réécriture d'URL pour accéder à votre fichier app.php sans que cela aparraisse dans votre url et que l'application fonctionne correctement. Nous sommes dans le cas où le fichier par défaut se nomme "app.php"

```
<IfModule mod_rewrite.c>
    Options -MultiViews
    RewriteEngine On
    #RewriteBase /path/to/app
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ app.php [L]
</IfModule>
```
La configuration va en plus activer la réécriture d'URL pour vous permettre d'avoir de belles url ne contenant pas "app.php" dedans.

### Configurer les dossiers 
N'oubliez pas de donner les autorisations nécessaire pour votre dossier app/cache et app/logs/ afin que le serveur ait le droit d'écrire dedans (sans cela l'application ne fonctionnera tout simplement pas) 

```bash
chmod 777 app/logs app/cache
```
Voilà il vous reste plus qu'à copier votre projet directement à la racine. Vous viderez ensuite le dossier cache de tout ce qu'il contient. Si à la fin vous avez encore un dossier web, vous pouvez le supprimer car il ne vous servira plus. N'oubliez pas de publier les assets dans le dossier www (si ce n'est pas déjà fait) Vous vous connecterez une fois ou deux à votre application, deux cuillères à soupe de sel et ça marche ...

N'oubliez pas qu'à cause de la configuration de base des serveurs OVH, vous devez mettre votre projet directement dans le / c'est pour cette raison que l'on renomme le dossier web en www pour l'avoir directement dans l'arboresence de base

### Vous faciliter la vie quand on a pas d'accès SSH
L'autre problème quand on a pas d'accès SSH c'est qu'il n'y a point de console pour votre serveur, heureusement il existe un très bon Bundle pour palier à ce problème [CoreSphereConsoleBundle](https://github.com/CoreSphere/ConsoleBundle) qui vous permettra de faire comme si vous aviez une console. Attention par contre l'accès à ce bundle doit sécurisé car si un petit malin y accède adieu vote site ...

### Conclusion
Bien évidemment je n'imagine pas que ce soit la meilleure solution, mais cela fonctionne, et ce site en est la preuve. Il existe certainement des manières plus élégantes mais pour avoir été confronté au problème et ayant eu du mal à trouver de solution facile et toute faite, je me permet de partager mon expérience. Si vous avez des commentaires ou des remarques à faire sur ce tuto, n'hésitez pas à me les faire via la rubrique contact. (Les commentaires ne sont pas encore mis en place, peut-être l'occasion de faire un autre article ?). Sinon n'hésitez pas à découvrir ou utiliser ce superbe framework qu'est Symfony2...

Allez à plus ! 