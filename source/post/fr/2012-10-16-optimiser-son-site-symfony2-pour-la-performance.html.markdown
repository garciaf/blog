---
lang: fr
title: Optimiser son site symfony2 pour la performance
date: 2012-10-16 00:00 UTC
tags: php
cover: symphony-php.jpg
alias: optimiser-son-site-symfony2-pour-la-performance/blogarticle/
---

Où comment rendre un site dynamique (presque) aussi performant qu'un site statique
READMORE

Ayant croisé sur mon chemin un développeur passioné par l'optimisation,
je me suis demandé ce que je pouvais faire de manière efficace pour
optimiser mon code de façon à le rendre plus performant. retour
d'expérience...

## Mon premier truc : Le cache

"le echo est plus rapide que le printf", ce genre de conseil me donne
des boutons pourquoi ? Même si dans l'absolue ce genre de conseil est
vrai ce n'est pas significatif comme gain de performance et reprendre
tout le code pour mettre des echos à la place des printf... hum ..non
merci.

Le truc qui m'interesse un peu plus c'est la mise en cache et
l'utilisation de reverse proxy pour éviter de recalculer la page à
chaque fois qu'on la demande. Comment on fait ? ben avec symfony c'est
vraiment pas compliqué. On va suivre la [documentation
officielle](http://symfony.com/doc/current/book/http_cache.html). En
gros quelques petits changements, dans le fichier app.php premièrement.

```php
<?
require_once __DIR__.'/../app/AppKernel.php';
require_once __DIR__.'/../app/AppCache.php';
 
$kernel = new AppKernel('prod', false);
$kernel->loadClassCache();
$kernel = new AppCache($kernel);
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
?>
```

 ensuite on va pouvoir spécifier dans le controleur le temps que l'on
souhaite garder son cache, spécifier si le cache est publique, la date
d'expiration etc ...

### Le cache pour les flemmards

Il est à noter que symfony2 prévoit son petit lot d'annotation pour
configurer rapidement et proprement le cache au moyen des annotations.
Cela permet de faire des configurations très simple pour chaque action
mais cela ne permet pas de faire des choses évoluées. (Comme remplacer
dynamiquement le cache en fonction des dernières mise à jour). 

Ceci dit cela peut valoir le coup si vous avez des pages qui ne changent
pas (Page de contact par exemple), ci dessous un petit exemple de ma
page de contact :
```php
<?
useSensio\Bundle\FrameworkExtraBundle\Configuration\Cache;
class MessageController extends Controller
{
/**
* Displays a form to create a new Message entity.
* @Cache(expires="tomorrow")
* @Route("contact/", name="contact_new")
* @Template()
*/
    public function newAction()
    {
        $entity = new Message();
        $form = $this->createForm(new MessageType(), $entity);
 
        return $this->render('FabfotoGalleryBundle:Default:contact.html.twig',array(
            'entity' => $entity,
            'form' => $form->createView(),
        ));
    }
?>
```

Voilà c'est symple et vous pourrez mettre en cache facilement grâce aux
annotations. Mais pour les pages plus dynamiques il vaut mieux mettre
les mains dans le code. Voir la [doc](http://symfony.com/doc/2.0/book/http_cache.html) à ce sujet 

## Ensuite on compresse, réduit les js et le css

Assetic permet de faire pas mal de chose, assez facilement une prmeière
chose que l'on peut faire est de compresser les fichier css et js avec
le YUI\_Compressor, il y a une très bonne
[recette](http://symfony.com/doc/2.0/cookbook/assetic/yuicompressor.html)
pour l'installer. Je conseille aussi l'activation du css rewritting ou
css embed. Pour voir rapidement comment ça marche voilà un exemple de ma
config : 

```yml
# Assetic Configuration
assetic:
    debug: %kernel.debug%
    use_controller: false
    read_from: %kernel.root_dir%/../www
    filters:
        yui_css:
            jar: "%kernel.root_dir%/Resources/java/yuicompressor.jar"
            apply_to: "\.css$"
        yui_js:
            jar: "%kernel.root_dir%/Resources/java/yuicompressor.jar"
            apply_to: "\.js$"
        cssembed:
            jar: %kernel.root_dir%/Resources/java/cssembed-0.4.5.jar
            apply_to: "\.css"
```
 
Ensuite il faut voir comment intégrer les ressources dans le template : 

```twig
{%stylesheets
    '@FabfotoGalleryBundle/Resources/public/css/style.css'
    '@FOSCommentBundle/Resources/assets/css/comments.css'
    %}
    <link rel="stylesheet" href="{{ asset_url }}" type="text/css" />
    {% endstylesheets %}
    {% javascripts
    '@FabfotoGalleryBundle/Resources/public/jquery/jquery-1.7.2.min.js'
    '@FabfotoGalleryBundle/Resources/public/vegas/jquery.vegas.js'
    '@FabfotoGalleryBundle/Resources/public/bootstrap/js/bootstrap.min.js'
    %}
    <script type="text/javascript" src="{{ asset_url }}"></script>
    {% endjavascripts %}
```

Voilà les filtres seront automatquement appliqué aux fichiers.

## Troisièmement on compresse la sortie avec Gzip

Après ça se joue au niveau d'apache et du htaccess, on va utiliser le
code suivant : 

```
# Activate filter
SetOutputFilter DEFLATE
 
# Some probleme with some browser
BrowserMatch ^Mozilla/4 gzip-only-text/html
BrowserMatch ^Mozilla/4\.0[678] no-gzip
BrowserMatch \bMSIE !no-gzip !gzip-only-text/html
 
# Picture don't need to be compress
SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png)$ no-gzip dont-vary
 
# Pour les proxy
Header append Vary User-Agent env=!dont-vary
```

Bien évidemment pour que celà fonctionne il faut que le navigateur du
client supporte la compression mais rassurez vous tous les "bons"
navigateurs le supportent. 

## Optimiser son autoload

Composer permet de génrer un autoload plus efficace avec la commande
suivante : 

```
composer.phar dump-autoload --optimize
```

Et votre autoload sera plus performant ...

## Avec APC on partage la mémoire et le chargement ...

Je donne la procédure avec symfony 2.1 car cela fonctionne, il suffit de
modifier le fichier `app.php`

```php
<?
$loader = new ApcClassLoader('fabbook', $loader);
$loader->register(true);
?>
```

Remplacer 'fabbook' par le nom de votre application et c'est bon. Bien
entendu il faut que votre serveur supporte apc mais si c'est le cas
alors celà devrait encore accélérer les choses. 

## La touche finale : Varnish c'est quand même mieux

Bon j'aurai bien aimé pouvoir utiliser ce reverse proxy sur mon serveur
de prod mais un ovh mutalisé ne permet pas de faire ce que l'on veut.
Ceci dit tous les mécanismes de mise en cache que l'on aura mis en place
seront valide avec varnish. 

## Conclusion 

Le contact avec le collegue fut finalement profitable car celà m'a
poussé à me poser des questions et à trouver des solutions techniques
plus satisfaisantes que *"echo est plus rapide que print"* * *et
finalement la vrai question que l'on doit se poser c'est comment faire
en sorte de solliciter mon application le moins possible ? J'espère que
cet article vous sera utilie et si vous avez d'autres idées n'hésitez
pas à vous manifester. 

