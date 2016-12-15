# SynapseCmfBundle

Cette distribution contient le strict minimum pour travailler avec Synapse; c'est en général celle que l'on va utiliser quand on dispose déjà de son back-office, où lorsque les modules métiers adjacents imposent une charte graphique ou un markup incompatible avec l'administration native.

Elle contient :

 - Le bundle d'interface avec les composants Symfony
 - La définition du modèle de données sous [Doctrine Orm](http://www.doctrine-project.org/projects/orm.html)
 - La définition et les APIs de gestion des éléments de Synapse :
    - Types de contenu
    - Thème (templates, zones et composants)
    - Médiathèque (média, images et fichiers)
 - Le moteur de rendu
 - Composants built-in, avec contrôleur, configurations par défaut et formulaire
    - Static
    - Free
    - Text
    - Menu
    - Gallery

## Installation

L'installation se passe via [Composer](https://getcomposer.org/), comme la plupart des bundles Symfony :
```bash
composer require synapse-cmf/synapse-cmf-bundle ~1.0
```

## Configuration de référence

Ce bundle requiert l'inclusion d'autres packages de la communauté en plus de ceux de l'édition standard de Symfony tels que décrit ci-après :
```php
// app/AppKernel.php

class AppKernel extends Kernel
{
    public function registerBundles()
    {
        $bundles = [
            // ...
            new Stof\DoctrineExtensionsBundle\StofDoctrineExtensionsBundle(),
            new Majora\Bundle\FrameworkExtraBundle\MajoraFrameworkExtraBundle($this),
            new Synapse\Cmf\Bundle\SynapseCmfBundle(),
        ]
    }
}
```
De plus, certains doivent être configurés pour que Synapse puisse les utiliser, tel que Doctrine :
```yml
# app/config/config.yml

# Synapse Cmf Configuration
synapse_cmf:
    content_types:
        Content\Type\Entity\Full\Qualified\Class\Name:
            alias: content_type     # content type alias into Cmf Admin and configurations
            loader: content_type.provider.id   # service id of a service which can load this content type
        // ...
    components:
        social_sharing:    # component name
            form: Acme\Bundle\AppBundle\Form\Component\SocialSharingType.php   # component data form type
            controller: AcmeAppBundle:SocialSharingComponent:render   # component rendering controller
            template_path: "AcmeAppBundle:Demo:social_sharing.html.twig"  # component default template
        // ...
    media:
        store:
            physical_path: %kernel.root_dir%/../../web/assets  # define where store all files uploaded through media manager
            web_path: assets      # path to media storage, after web root
    forms:
        enabled: true    # you can disable Synapse form extension if you don't use them into your own content type forms

# Doctrine Configuration
doctrine:
    dbal:
        connections:
            default:
                # default connection here
            synapse:
                driver:   pdo_mysql
                host:     "%database_host%"
                port:     "%database_port%"
                dbname:   "%database_name%"
                user:     "%database_user%"
                password: "%database_password%"
                charset:  UTF8
    orm:
        auto_generate_proxy_classes: "%kernel.debug%"
        default_entity_manager: default
        entity_managers:
            synapse: ~
            default:
                # default em configuration
```

À propos de ces configurations :

  - découlant du fait d'avoir un entity manager séparé, les bundles doivent être référencés manuellement dans la configuration Doctrine
  - d'autres configurations sont incluses par défaut au container, voir [le fichier complet](https://github.com/Synapse-Cmf/synapse-cmf/blob/master/src/Synapse/Cmf/Bundle/Resources/config/config.yml)
  - il est possible de générer seulement le modèle Synapse via la commande `php bin/console doc:sch:update --em=synapse` ou `php bin/console doctrine:migrations:diff --filter-expression="/^synapse_.+/" --em=synapse` via les migrations

À propos de [MajoraFrameworkExtraBundle](https://github.com/LinkValue/MajoraFrameworkExtraBundle) : cette dépendance contient des classes et services utilitaires en extension à Symfony.

Synapse Cmf est également compatible avec [DoctrineMigrationsBundle](http://symfony.com/doc/current/bundles/DoctrineMigrationsBundle/index.html), pertinent lors du déploiement des futures mises à jour du projet.
