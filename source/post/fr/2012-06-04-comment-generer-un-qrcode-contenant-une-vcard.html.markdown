---
title: Comment générer un QRCode contenant une vCard
date: 2012-06-04 00:00 UTC
tags: php
cover: symphony-php.jpg
lang: fr
alias: comment-generer-un-qrcode-contenant-une-vcard/blogarticle/
---

Ou comment fabriquer une carte de visite web 3.0 avec symfony2 et quelques Bundles

READMORE

Nous allons parler aujourd'hui de la génération d'un QRCode contenant
votre vCard avec symfony2 et le bundle
[MopaBarCodeBundle](https://github.com/phiamo/MopaBarcodeBundle). Cela
sera aussi l'occasion de faire du Web 3.0, pourquoi 3.0 ? Je
l'expliquerai à la fin. 

## Une VCard c'est quoi ? Comment on en fait une ?

Alors pour répondre à cette question, mon ami Wikipedia, donne une
définition très précise et un exemple bien utile. Pour résumer : ce
n'est ni plus, ni moins qu'une simple chaine de caractère avec une
certaine convention, pour les clefs et les attributs. Prenons comme
exemple ma carte de visite :

```
BEGIN:VCARD
VERSION:3.0
N:GARCIA;Fabien;
FN:Fabien GARCIA
TITLE:Ingenieur IT
TEL;TYPE=CELL,VOICE: +336000000
TEL;TYPE=HOME,VOICE:+336000000
EMAIL;TYPE=PREF,INTERNET:fab0670312047@gmail.com
REV:20080424T195243Z
END:VCARD
```
Voilà, pas de quoi casser trois pattes à un canard, dans un premier
temps  nous allons donc faire une fonction qui génère cette chaine de
caractère. Dans mon cas je la rattache à un objet utilisateur, mais
cette fonction pourrait aussi être dans un service. Ce qui donne donc : 

```php
<?php 
 class User extends BaseUser
 {

    ....
     /**
      * Get the vcard of the contact
      */

     public function getVcard(){

         return sprintf(

 "BEGIN:VCARD
 VERSION:3.0
 N:%s;%s;;;
 FN:%s %s
 TITLE:%s
 TEL;TYPE=CELL,VOICE: %s
 TEL;TYPE=HOME,VOICE:%s
 EMAIL;TYPE=PREF,INTERNET:%s
 REV:20080424T195243Z
 END:VCARD", $this->getName(), $this->getFirstName(), 

          $this->getFirstName(), $this->getName(), 

          $this->getTitle(),

          $this->getPhone(),

          $this->getPhone(),

          $this->getEmail());

     }

 }
 ?>
```
 
Vous voilà avec une fonction qui génère la chaine de caractère pour une
Vcard. A ce niveau vous pouvez décider d'inclure d'autres informations
sur vous ou pas. Jettez un oeil à l'article
[wikipedia](http://fr.wikipedia.org/wiki/VCard) qui explicite toutes les
possibilités des Vcard 3.0. Maintenant que vous avez votre chaine de
caractères passons au QRCode

## Dessine moi un QrCode 

Pour cela nous allons utiliser le bundle MopaBarCode Bundle qui offre
une fonction twig assez intéressante 

```html 
 <img alt="[barcode]" src="{{ mopa_barcode_url('qr', '123456789')
 }}"/>
```
Cette fonction génère une image qui encode toute chaine de caractère en
qrCode. Nous allons donc l'utiliser en lui donnant à manger notre chaine
de caractère Vcard. Ainsi le code pour générer la dite vCard en QRCode
est le suivant :

```html
<img alt="my QRCode Vcard" src="{{ mopa_barcode_url('qr',
 author.vcard , true) }}" />
```

Et ça donne quoi ? Voyez vous même avec ma vCard : 

![Qrcode
Vcard](2012-06-04-comment-generer-un-qrcode-contenant-une-vcard/fabienvcard.png)

Si vous scannez ce QrCode, je risque d'attérir dans la liste de vos
contacts de votre smart-phone. Et voilà !

## Et le Web 3.0 dans tout ça ?

J'y viens, au début il y avait le web 1.0, du contenu statique, puis
vint le web 2.0 les utilisateurs pouvaient intéragir directement avec le
contenu des pages web.

Et maintenant on commence à parler du web 3.0, selon moi (Grand
ingénieur es informatique ;-) le web 3.0 c'est tout ce qui lie le monde
physique et le monde virtuel. Les applications qui vous donnent du
contenue en fonction de l'endroit où vous vous trouvez physiquement
rentrent dans cette catégorie (FourSquare est un exemple). Et le lien
avec mon QrCode ? Et bien si vous décidez d'imprimer votre QrCode sur
une carte de visite avec les informations contenue dans la carte en
claire dans la carte de visite, vous venez de créer une Carte de visite
3.0. 

En effet l'objet physique "carte de visite" contient son alter ego
numérique "vCard" dans le QrCode. Ce qui permet à un n'importe qui
possedant votre carte et un smart-phone d'en transferer le contenue sur
son téléphone en le scannant, tout en conservant la possibilité de lire
les mêmes informations sur la carte de visite.