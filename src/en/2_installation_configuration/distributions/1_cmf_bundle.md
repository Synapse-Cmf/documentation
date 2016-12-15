# SynapseCmfBundle

This distribution contains the minimum requirements to work with Synapse. It is actually used when there is an existing backoffice, or when adjacent business modules set a graphic chart or an incompatible markup with the native adminsitration.

It contains :

 - The interface bundle with Symfony components
 - The data model definition under [Doctrine Orm](http://www.doctrine-project.org/projects/orm.html)
 - The definition and the management APIs of Synapse elements :
    - Content types
    - Themes (templates, areas and components)
    - Media library (medias, images and files)
 - Rendering engine
 - Built-in compoents, with controller, default configurations and forms
    - Static
    - Free
    - Text
    - Menu
    - Gallery

## Installation

The installation works with [Composer](https://getcomposer.org/), as many Symfony bundles do :

```bash
composer require synapse-cmf/synapse-cmf-bundle ~1.0
```

## Reference configuration

This bundle requires other packages of the community in additional of the Symfony standard edition's packages :

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
Furthermore, some of them need to me configured so that Synapse can use them, (eg. Doctrine) :

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

About these configurations :

  - Resulting of the fact there is a separated entity manager, the bundles must be manually referenced in the Doctrine configuration. 
  - Some other configurations are includes by default to the container, see [the wole file](https://github.com/Synapse-Cmf/synapse-cmf/blob/master/src/Synapse/Cmf/Bundle/Resources/config/config.yml)
  - It is possible to only generate the Synapse model through the command `php bin/console doc:sch:update --em=synapse` or `php bin/console doctrine:migrations:diff --filter-expression="/^synapse_.+/" --em=synapse` via the migrations

About [MajoraFrameworkExtraBundle](https://github.com/LinkValue/MajoraFrameworkExtraBundle) : this dependency contains classes and utilitary services in extension of Symfony. 

Synapse Cmf is also compatible with [DoctrineMigrationsBundle](http://symfony.com/doc/current/bundles/DoctrineMigrationsBundle/index.html), useful during deployments of further project updates.
