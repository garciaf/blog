---
lang: fr
title: Configurer sa machine linux pour un projet symfony2
date: 2012-04-25 00:00 UTC
tags: symphony, php, unix, fr
cover: symphony-php.jpg
---

Passant la plus grande partie de mon temps à coder des web applications, il m'arrive malheureusement d'oublier comment on installe une web application sur Linux avec une adresse du type `http://localhost/8080`, c'est donc pour ça que j'écris ces quelques lignes pour pouvoir m'en souvenir

READMORE

### httpd.conf  

Alors pour commencer on va changer le fichier httpd.conf pour cela : 

```
nano /etc/apache2/httpd.conf
```

Dans le cas où vous utilisez nano, une fois le fichier ouvert rajouter les lignes suivantes:

```
#/etc/apache2/httpd.conf
Listen *:8080
<VirtualHost 127.0.0.1:8080>
DocumentRoot "/home/user/symfony2/web"
DirectoryIndex app.php
<Directory "/home/user/symfony2/web">
AllowOverride All
Allow from All
</Directory>
</VirtualHost>
```
### Apache.conf
Vérifiez dans le fichier "apache2.conf"que la ligne suivante n'est pas commentée:

```
# Include all the user configurations:
Include httpd.conf
```

### Redémarrer son service apache
Vous devrez à ce moment redémarrer votre service avec la commande suivante : 

```
sudo service apache2 restart
```
Vous n'avez plus quà vous rendre sur le http://localhost:8080/ et votre projet symfony devrait prendre vie sous vos yeux.