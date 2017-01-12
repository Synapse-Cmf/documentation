# SynapseAdminBundle

This distribution adds an administration interface to the basic distribution.
It can be used as a base to build a backoffice for the project.

Added features :

 - Bundle providing an interface with Symfony components, Twig and javascript
 - Synapse backoffice theme (built with Sass and Bootstrap 3)
 - Management intergace of skeletons (global templates - see the chapter concerning [themes](../../3_book/1_decorator/2_themes.md))
 - Management interface of medias
    - Image uploads
    - Management module of image metadata and formatting

**Warning** : this distribution requires CmfBundle, which must be initialised and configured, as [described prefiously](1_cmf_bundle.md).

## Installation

The installation works with Composer (`synapse-cmf-bundle` is included) :

```bash
composer require synapse-cmf/synapse-admin-bundle ~1.0
```

Please reference the bundle in you application kernel :
```php
<?php
// app/AppKernel.php

public function registerBundles()
{
    $bundles = array(
        // ...
        new Synapse\Admin\Bundle\SynapseAdminBundle(),
    );
}
```

## Reference configuration

```yml
# app/config/config.yml

# Synapse Admin Configuration
synapse_admin:
    base_layout: 'SynapseAdminBundle::base.html.twig'  # base template to use for all Synapse admin Twig templates (use extends keywords, see the template to guess all used blocks)
```

```yml
# app/config/routing.yml

# Synapse Admin
synapse_cmf_admin:
    resource: "@SynapseAdminBundle/Resources/config/routing.yml"
```
