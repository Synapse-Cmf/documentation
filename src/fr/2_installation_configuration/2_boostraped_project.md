# Installation dans un projet initialisé

L'installation se passe via [Composer](https://getcomposer.org/), comme n'importe quel autre bundle / librairie compatible avec Symfony.
Vous aurez aussi besoin d'une base de données SQL pour stocker la configuration de synapse.

## Ajout des Bundles

Pour commencer, il vous rajouter les bundles synapse :

```bash
./bin/composer require synapse-cmf/synapse-cmf ~1.0@dev
```


Puis les inclures dans votre application (comment n'importe quel autre bundle) :
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
            new Synapse\Admin\Bundle\SynapseAdminBundle(),
            new Synapse\Page\Bundle\SynapsePageBundle(),
        ]
    }
}
```

## Configuration

### Configuration de l'accès à la base de données
Ensuite, Configurez l'accès à la base de donnée pour synapse.
La configuration minimale est la suivante :
```yml
# app/config/config.yml

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

Ici vous utiliserez la configuration en base par défaut de symfony, libre à vous ensuite de les personnaliser (voir tuto LINK - good practices ?).


### Configuration de Synapse

Nous utiliserons ici les paramètres par défaut de synapse. Pour en savoir plus LINK

```yml
# app/config/config.yml


# Synapse Cmf Configuration
synapse_cmf: ~
```

Avec cette configuration de base, synapse rajoutera ses assets dans le dossier /web/assets. Nous vous recommendons de rajouter ce dossier dans votre gitignore :

```
#.gitignore
web/assets
```

### Ajout des routes

Pour utiliser l'interface d'administration de synapse, nous avons besoin de rajouter ses routes à notre application:

```yml
# app/config/routing.yml

# Synapse Page Admin
synapse_page_admin:
    resource: "@SynapsePageBundle/Resources/config/routing/admin.yml"
    prefix: "/{_locale}/page"
    defaults:
        _locale: "%locale%"
    options:
        synapse_theme:
            host: "^(\\w+)"
```

Ici l'ensemble des routes de l'interface d'administration seront préfixées par /fr/page si votre locale est fr.

Libre à vous de sécurisez ensuite ces routes, voir TUTO / Good practices ?

## Mise en fonctionnement

Pour finir, il ne nous reste qu'à :

 - installer le schéma de la base de donnée grâce à doctrine :

```bash
# Création de la base de données synapse si elle n'existe pas
php bin/console doctrine:database:create --connection=synapse
# Mise en place du schéma de base de données de synapse
php bin/console doctrine:schema:update --force --em=synapse
```

 - installer les assets de synapse

```bash
php bin/console assets:install
```


@todo gitignore
