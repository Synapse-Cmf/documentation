# Installation dans un projet initialisé

L'installation se passe via [Composer](https://getcomposer.org/), comme n'importe quel autre bundle / librairie compatible avec Symfony.

```bash
curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer
chmod +x bin/composer
./bin/composer require synapse-cmf/synapse-cmf ~1.0@dev
```

Synapse Cmf est basé sur plusieurs bundles, qu'il faut activer puis configurer.

Tout d'abord, inclure les bundles (et dépendances) de Synapse Cmf dans votre application :
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

Ensuite, toujours comme n'importe quel autre bundle, configurez les pour votre projet.
La configuration minimale est la suivante :
```yml
# app/config/config.yml

# Synapse Cmf Configuration
synapse_cmf: ~

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




@todo gitignore
