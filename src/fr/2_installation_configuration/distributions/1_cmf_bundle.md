# SynapseCmfBundle

Cette distribution contient le strict minimum pour travailler avec Synapse; c'est en général celle que l'on va utiliser quand on dispose déjà de son back-office, où lorsque les modules métiers adjacents imposent une charte graphique ou un markup incompatible avec l'administration native.

Elle contient :

 - Le bundle d'interface avec les composants Symfony
 - La définition du modèle de données sous [Doctrine Orm](http://www.doctrine-project.org/projects/orm.html)
 - La définition et les APIs de gestion des éléments de Synapse :
    - Types de contenus
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

## Configuration

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
    content_types: ~
        # liste des types de content, référez vous à la section dédiée
    components: ~
        # liste des types de composants, référez vous à la section dédiée
    media:
        store:
            physical_path: %kernel.root_dir%/../../web/assets  # chemin de stockage des fichiers gérés par la médiathèque
            web_path: assets      # chemin d'accès des fichiers de la médiathèque à partir de la racine web

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

A propos de ces configurations :

  - découlant du fait d'avoir un entity manager séparé, les bundles doivent être référencés manuellement dans la configuration Doctrine
  - d'autres configurations sont incluses par défaut au container, voir [le fichier complet]()
  - il est possible de générer seulement le modèle Synapse via la commande `php bin/console doc:sch:update --em=synapse` ou `php bin/console doctrine:migrations:diff --filter-expression="/^synapse_.+/" --em=synapse` via les migrations

A propos de [MajoraFrameworkExtraBundle](https://github.com/LinkValue/MajoraFrameworkExtraBundle) : cette dépendance contient des classes et services utilitaires en extension à Symfony.

Synapse Cmf est également compatible avec DoctrineMigrationsBundle, pertinent lors du déploiement des futures mises à jour du projet.
