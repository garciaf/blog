---
lang: fr
title: Gérer l'upload de fichier avec symfony2
date: 2012-11-14 00:00 UTC
tags: php, symphony
cover: symphony-php.jpg
alias: gerer-l-upload-de-fichier-avec-symfony2/blogarticle/
---
Présentation d'une méthode alternative pour gérer l'upload de ficher avec symfony2

READMORE

Lorsque j'ai commencé la réalisation de mon site, je voulais pouvoir y mettre des photos. Pour cela il fallait pouvoir uploader les fichiers vers le serveur, stocker le nom du fichier en base et être capable de récupérer les photos tout simplement. Pour commencer j'ai essayé le cookbook du site officiel qui traite le [sujet](http://symfony.com/doc/current/cookbook/doctrine/file_uploads.html). Bon ça marche mais quelques critiques peuvent être faite :

  - C'est spécifique à Doctrine (Pour Propel tu peux te brosser) 
  - Si différentes entitées doivent faire de l'upload on duplique le code. (une astuce de doctrine permet d'éviter ça, ceci dit)

Je vais donc vous proposer un moyen de faire la même chose différement et par la même occasion présenter des concepts très intéressant du framework de sensio. Avant de commencer je tiens à signaler qu'il existe déjà un bundle qui permet de faire ça, il s'appel [VichUploaderBundle](https://github.com/dustin10/VichUploaderBundle) (je ne l'ai pas testé cependant...) et il permet de faire ce que l'on va coder dans ce tutoriel. Le but de cet article est surtout d'apprendre à utiliser l'injection de dépendance avec un cas pratique. Si vous avez un peu plus de temps je vous invite à continuer la lecture de cet article. 

## Créons un service pour gérer l'upload
Nous allons donc créer un service qui nous rendra ce petit service. Mais c'est quoi un service ? Je peux vous renvoyer à ce très bon tuto ou à la doc officielle, mais si on voulait résumer cela permet de rendre une instance de classe d'objet disponible dans l'ensemble de notre projet. En claire un service, va pouvoir faire un certain travail, n'importe où dans le projet. C'est un bon moyen de factoriser du code ou d'alléger des contrôlleurs trop volumineux.

Nous allons donc créer un service d'upload qui uploadera les fichiers, anonymisera le nom du fichier et chargera le nom du fichier dans l'entité.

### Déclaration du service

Pour commencer nous allons configurer dans le fichier `service.yml` de notre bundle, nous allons déclarer une classe PictureUploader.php dans un dossier Uploader :

```yml
services:
    fabfoto_gallery.picture_uploader:
        class:      Fabfoto\GalleryBundle\Uploader\PictureUploader
        arguments:  [%fabfoto_gallery.picture_directory%]
```

Au passage on passera dans les arguments le nom du dossier où l'on enregistrera le fichier chargé. De plus nous allons rendre l'argument obligatoire pour notre bundle. Pour commencer on se rends dans le fichier DependencyInjection/FabfotoGalleryExtension.php et on rajoute notre argument comme contrainte :

```php
<?php
namespace Fabfoto\GalleryBundle\DependencyInjection;

use Symfony\Component\Config\Definition\Builder\TreeBuilder;
use Symfony\Component\Config\Definition\ConfigurationInterface;

/**
 * This is the class that validates and merges configuration from your app/config files
 *
 * To learn more see {@link http://symfony.com/doc/current/cookbook/bundles/extension.html#cookbook-bundles-extension-config-class}
 */
class Configuration implements ConfigurationInterface
{
    /**
     * {@inheritDoc}
     */
    public function getConfigTreeBuilder()
    {
        $treeBuilder = new TreeBuilder();
        $rootNode = $treeBuilder->root('fabfoto_gallery');
        // Here you should define the parameters that are allowed to
        // configure your bundle. See the documentation linked above for
        // more information on that topic.
        $rootNode
                ->children()
                ->scalarNode('picture_directory')->isRequired()->end()
                ->scalarNode('import_directory')->isRequired()->end()
                ->scalarNode('mailsender')->isRequired()->end()
                ->scalarNode('nbArticle')->isRequired()->end()
                ->scalarNode('nbAlbum')->isRequired()->end()
                ->end()
        ;
        return $treeBuilder;
    }
}

```

Maintenant on va charger l'argument dans notre projet

```php
<?php
namespace Fabfoto\GalleryBundle\DependencyInjection;

use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\Config\FileLocator;
use Symfony\Component\HttpKernel\DependencyInjection\Extension;
use Symfony\Component\DependencyInjection\Loader;

/**
 * This is the class that loads and manages your bundle configuration
 *
 * To learn more see {@link http://symfony.com/doc/current/cookbook/bundles/extension.html}
 */
class FabfotoGalleryExtension extends Extension
{
    /**
     * {@inheritDoc}
     */
    public function load(array $configs, ContainerBuilder $container)
    {
        $configuration = new Configuration();
        $config = $this->processConfiguration($configuration, $configs);
        $container->setParameter('fabfoto_gallery.picture_directory', $config['picture_directory']);
        $loader = new Loader\YamlFileLoader($container, new FileLocator(__DIR__.'/../Resources/config'));
        $loader->load('services.yml');
    }
}
```

### Le service à proprement parler
Voilà il reste à créer un fichier PictureUploader qui fera le travail : 

```php
<?php
class PictureUploader
{
    private $directory;
    public function __construct($directory)
    {
        $this->directory = $directory;
    }
    public function update(Picture $picture, $randomize = true)
    {
        $file = $picture->getLocation();
        if (!$file instanceof File) {
            throw new \InvalidArgumentException(
                    'There is no file to upload!'
            );
        }
        $fileName = $this->generateFilename($file, $randomize);
        $file->move($this->directory, $fileName);
        $picture->setLocation($fileName);
    }
    public function upload(ImageInterface $picture, $randomize = true)
    {
        $file = $picture->getLocation();
        if (!$file instanceof UploadedFile) {
            throw new \InvalidArgumentException(
                    'There is no file to upload!'
            );
        }
        $fileName = $this->generateFilename($file, $randomize);
        $file->move($this->directory, $fileName);
        $picture->setLocation($fileName);
    }
    private function generateFilename(File $file, $randomize = true)
    {
        if ($randomize) {
            $filename = sprintf('%s.%s'
                    , md5(uniqid($file, true)), $file->guessExtension());
        } else {
            $filename = sprintf('%s.%s', $file->getBasename(), $file->guessExtension());
        }
        return $filename;
    }
}
```
Le constructeur permet de récupérer le nom du dossier. On laisse la possibilité de garder le nom du fichier original. 

### Utilisation du service

Votre service est créé et déclaré maintenant vous pourrez l'appeller dans votre application comme n'importe quel autre service. Dans votre controlleur pour la création d'un objet Portrait qui contient un fichier vous pourrez utiliser le code suivant :

```php
<?php
/**
     * Creates a new Portrait entity.
     *
     * @Route("/create", name="user_portrait_create")
     * @Method("post")
     * @Template("FabfotoUserBundle:Portrait:new.html.twig")
     */t
    public function createAction()
    {
        $entity = new Portrait();
        $request = $this->getRequest();
        $form = $this->createForm(new PortraitType(), $entity);
        $form->bind($request);
        if ($form->isValid()) {
            try {
            $currentUser = $this->get('security.context')->getToken()->getUser();
            $entity->setUser($currentUser);
            $em = $this->getDoctrine()->getEntityManager();
            $this->get('fabfoto_gallery.picture_uploader')->upload($entity);
            $em->persist($entity);
            $em->flush();
        $this->get('session')->setFlash('success', $this->get('translator')->trans("object.saved.success", array(), 'Ad    mingenerator') );
            return $this->redirect($this->generateUrl('user_portrait_show',
                                    array('id' => $entity->getId())));
            } catch (Exception $e) {
                $this->get('session')->setFlash('error',  $this->get('translator')->trans("object.saved.error", array(), 'Admingenerator') );
            }
        }
        return $this->render('FabfotoUserBundle:Portrait:new.html.twig', array(
            'entity' => $entity,
            'form' => $form->createView()
    ));
    }
```
Vous noterez au passage que le travail de l'upload est fait grâce au code suivant `$this->get('fabfoto_gallery.picture_uploader')->upload($entity);` voilà et c'est terminé votre fichier est uploadé et le nom est aléatoire.

### Gestion de la suppression et héritage
Maintenant on voudrait pouvoir supprimer notre fichier en même temps que notre entité. Afin de rendre réutilisable à différentes entité le service je créé une interface pour filter tous les objets héritant de cette interface

```php
<?php
namespace Fabfoto\GalleryBundle\Uploader;

interface ImageInterface
{
    public function getWebPath();
    public function getThumbPath();
    public function getAbsoluteThumbPath();
    public function getAbsolutePath();
    public function getFilterPath();
    public function removeUpload();
}
``` 
Maintenant on va déclarer une classe abstraite qui va faire tout le travail en base et en gestion du cycle de vie de l'entité grâce au MappedSuper Class. Lidée m'est venu en tombant sur ce très bon [post](http://devyourdream.net/2012/08/28/integrer-google-maps-dans-vos-entites-sur-symfony2-avec-doctrine2/) de [Sulivan SENECHAL](http://devyourdream.net/author/soullivaneuh/). Maintenant notre class abstraite va ressembler à ceci :

```php
<?php
namespace Fabfoto\GalleryBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
 
use Fabfoto\GalleryBundle\Uploader\ImageInterface as ImageInterface;
/**
 * Test\TestBundle\Entity\AbstractGMapEntity
 *
 * @author garciaf
 *
 * @ORM\MappedSuperclass
 * @ORM\HasLifecycleCallbacks()
 */
abstract class AbstractImage implements ImageInterface
{
    /**
     * @var string $location
     *
     * @ORM\Column(name="location", type="string", length=255)
     */
    protected $location;
    /**
     * Set location
     *
     * @param string $location
     */
    public function setLocation($location)
    {
        $this->location = $location;
    }
    /**
     * Get location
     *
     * @return string
     */
    public function getLocation()
    {
        return $this->location;
    }
    /**
     * @ORM\PostRemove()
     */
    public function removeUpload()
    {
        if (file_exists($this->getAbsolutePath())) {
            if ($file = $this->getAbsolutePath()) {
                unlink($file);
            }
        }
    }
    public function getWebPath()
    {
        return null === $this->getLocation() ? null : '/'.$this->getUploadDir() . '/' . $this->getLocation();
    }
    public function getThumbPath()
    {
        return null === $this->getLocation() ? null : $this->getUploadDir() . '/mini' . $this->getLocation();
    }
    public function getAbsoluteThumbPath()
    {
        return null === $this->getLocation() ? null : $this->getUploadRootDir() . '/mini' . $this->getLocation();
    }
    public function getAbsolutePath()
    {
        return null === $this->getLocation() ? null : $this->getUploadRootDir() . '/' . $this->getLocation();
    }
    public function getFilterPath()
    {
        return "/".$this->getWebPath();
    }
    protected function getUploadRootDir()
    {
        // the absolute directory path where uploaded documents should be saved
        return __DIR__ . '/../../../../www/' . $this->getUploadDir();
    }
    protected function getUploadDir()
    {
        // get rid of the __DIR__ so it doesn't screw when displaying uploaded doc/image in the view.
        return 'uploads';
    }
    public function getFileExtension()
    {
        return pathinfo($this->getLocation(), PATHINFO_EXTENSION);
    }
}
```

Maintenant la suppression de l'entité entraine aussi la suppression du fichier qui lui est associé. Si vous souhaité qu'une entité puisse contenir un fichier à uploder vous n'avez plus qu'à le faire hériter de la classe `AbstractImage` et le tour est joué. Voyez l'exemple :

```php
<?php
namespace Fabfoto\UserBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Fabfoto\GalleryBundle\Entity\AbstractImage as AbstractImage;
/**
 * Fabfoto\GalleryBundle\Entity\Picture
 *
 * @ORM\Table()
 * @ORM\Entity
 */
class Portrait extends AbstractImage
{
    public function __toString()
    {
        return (string) $this->id;
    }
    /**
     * @var integer $id
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;
    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

}
```

Vous n'avez pas besoin de rajouter le champs avec le nom du fichier car il est déjà dans la classe abstraite. 

## Conclusion

Voilà une méthode alternative qui a le mérite de mettre le nez sur l'un des points le plus important de symfony2 l'injection de dépendance et l'utilisation de service. Cette méthode a pour autre mérite de sortir le maximum de logique du modèle, et en mettre d'avantage dans les services. Si vous avez des idées pour optimiser ou améliorer n'hésitez pas à écrire votre prose dans les commentaires. 