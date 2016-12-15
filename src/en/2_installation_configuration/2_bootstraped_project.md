# Installation dans un projet initialisé

The installation works with [Composer](https://getcomposer.org/), as many Symfony bundles do?
You also need a Sql database to store Synapse Cmf data.

## Bundle inclusion

In the first place, you need to add the Synapse Cmf bundles to your project :

```bash
composer require synapse-cmf/synapse-cmf ~1.0@dev
```

Then, include them in your kernel application :
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

### Synapse Cmf bundles

Here, we use the default parameters of Synapse. For further details about configurations, please read the reference configurations of each bundles :

 - [SynapseCmfBundle](distributions/1_cmf_bundle.md)
 - [SynapseAdminBundle](distributions/2_admin_bundle.md)
 - [SynapsePageBundle](distributions/3_page_bundle.md)

```yml
# app/config/config.yml

# Synapse Cmf Configuration
synapse_cmf:
    content_types:
        Synapse\Page\Bundle\Entity\Page:
            alias: page
            provider: synapse.page.loader
```
### Dependencies
To continue, please configure the database access for Synapse.

The minimum configuration is the following :
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

Synapse Cmf uses a dedicated entity manager, for more flexibility. For furthers details, please read the configuration of [CmfBundle](distributions/1_cmf_bundle.md).

The other dependendies [MajoraFrameworkExtraBundle](https://github.com/LinkValue/MajoraFrameworkExtraBundle) et [StofDoctrineExtensionsBundle](https://github.com/stof/StofDoctrineExtensionsBundle) are directly configured by default in CmfBundle.

### Routing

Add the Synapse Cmf routing to your project so you can access to administration modules and frontpages.

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

Lastly, please test the installation with the following commands :
```bash
php bin/console debug:container | grep synapse
php bin/console debug:router | grep synapse
```

## Initiation

Once the the configuration is operational, build the database with the following commands :
```bash
# It creates the database if none exists
php bin/console doctrine:database:create --connection=synapse --if-not-exists
# Table building
php bin/console doctrine:schema:update --force --em=synapse
```

Then, install assets and clear the cache :
```bash
php bin/console assets:install
php bin/console cache:clear
```

## Best practices for the versioning

The meda librady of Synapse Cmf uses the directory `web/assets` to store uploaded media files (the path is configurable). In general, we don't want to put these file in our version control system (eg. Git). So add this directory to your `.gitignore`.
```
#.gitignore
web/assets
```

## Site building

Synapse Cmf is now operational in its simplest version, the power is yours to build your pages with the administration interface, available here http://your.env.dev/app_dev.php/synapse/admin/page (for default configuration).

Please take note that the used theme is the demo theme, a simple theme built with Boostrap 3. It contains only one template, only one content type (the "page"), and only one built-in component.
In order to create your own content types, templates and components, please read the dedicated sections.
