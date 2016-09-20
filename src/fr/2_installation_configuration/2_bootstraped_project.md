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
            // dependencies
            new Stof\DoctrineExtensionsBundle\StofDoctrineExtensionsBundle(),
            new Majora\Bundle\FrameworkExtraBundle\MajoraFrameworkExtraBundle($this),

            // core
            new Synapse\Cmf\Bundle\SynapseCmfBundle(),
            new Synapse\Admin\Bundle\SynapseAdminBundle(),
            new Synapse\Page\Bundle\SynapsePageBundle(),

            // demo
            new Synapse\Demo\Bundle\AppBundle\SynapseDemoAppBundle(),
            new Synapse\Demo\Bundle\ThemeBundle\SynapseDemoThemeBundle(),
        ]
    }
}
```

## Configuration

### Bundles de Synapse Cmf

Nous utiliserons ici les paramètres par défaut de Synapse. Pour plus de détails sur les configurations, veuillez vous reporter aux références des configurations de chaque bundle :

 - [SynapseCmfBundle](distribution/1_cmf_bundle.md)
 - [SynapseAdminBundle](distribution/2_admin_bundle.md)
 - [SynapsePageBundle](distribution/3_page_bundle.md)

```yml
# app/config/config.yml

# Synapse Cmf Configuration
synapse_cmf:
    content_types:
        Synapse\Page\Bundle\Entity\Page:
            alias: page
            provider: synapse.page.loader
```
### Dépendances
Ensuite, configurez l'accès à la base de donnée de Synapse.

La configuration minimale est la suivante :
```yml
# app/config/config.yml

# Doctrine Configuration
doctrine:
    dbal:
        connections:
            default:
                # your project default connection here
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
                # your project default em configuration
```

Synapse Cmf utilise un entity manager dédié, pour permettre plus de flexibilité, pour plus de détails, voir la configuration du [CmfBundle](distribution/1_cmf_bundle.md).

Les autres dépendances [MajoraFrameworkExtraBundle](https://github.com/LinkValue/MajoraFrameworkExtraBundle) et [StofDoctrineExtensionsBundle](https://github.com/stof/StofDoctrineExtensionsBundle) sont configurées par défaut directement par le CmfBundle.

### Routing

Synapse Cmf fournit des routes à ajouter au projet pour accéder aux modules d'administration et aux pages en front.

```yml
# app/config/routing.yml

# Front
synapse_page_content:
    resource: "@SynapsePageBundle/Resources/config/routing/content_type.yml"
    prefix: /{_locale}
    defaults: { _locale: %locale% }
    requirements: { _locale: fr|en }
    options:
        synapse_theme: bootstrap

# Admin
synapse_admin:
    resource: "@SynapsePageBundle/Resources/config/routing/admin.yml"
    prefix: "/synapse/admin/page"
    options:
        synapse_theme: bootstrap         # theme actif du projet (voir configuration des thèmes)
```

Pour finir, testez votre installation avec les commandes suivantes :
```bash
php bin/console debug:container | grep synapse
php bin/console debug:router | grep synapse
```

## Mise en route

Une fois toute la configuration opérationnelle, construisez la base de données avec les commandes suivantes :
```bash
# Création de la base si elle n'existe pas
php bin/console doctrine:database:create --connection=synapse --if-not-exists
# Construction des tables
php bin/console doctrine:schema:update --force --em=synapse
```

Puis installez les assets et videz le cache :
```bash
php bin/console assets:install
php bin/console cache:clear
```

## Bonnes pratiques pour le versioning

La médiathèque de Synapse Cmf utilise le dossier `web/assets` pour déposer les médias uploadés (le chemin est configurable). En général, nous ne souhaitons pas versionner ces données, ajoutez donc ce dossier à votre `.gitignore`.
```
#.gitignore
web/assets
```

## Construction du site

Synapse Cmf est à présent opérationnel dans sa version la plus simple, à vous de jouer pour construire vos pages via l'interface d'administration, à l'url http://your.env.dev/app_dev.php/synapse/admin/page pour cette configuration.

Notez bien que le thème utilisé est celui de démonstration, un thème simple construit avec Bootstrap 3. Il ne contient qu'un seul template, un seul type de contenu (la "page") et seulement les composants built-in.

Pour créer vos propres types de contenus, templates et composants, référez-vous aux sections dédiées.
