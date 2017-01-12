# SynapsePageBundle

This distribution adds a content type named "Page", and also its administration interface to the AdminBundle distribution.

The content type "Page" represent a simple web page, with the HTML metadata management, a mechanical of puslish/archiving and an tree management.

The administration interface of pages includes also the form of the Synapse theme.

This distribution is perfect to start to use Synapse Cmf. It offers a simple use case of the framework. It can be useful for unique page of a website too, like homepage, landing pages, search results, and/or as base for other complex features, like a cart, a user account etc.

**Warning** : this distribution requires [CmfBundle](1_cmf_bundle.md) and [AdminBundle](2_admin_bundle.md).

## Installation

The installation works with Composer, and includes both `synapse-cmf-bundle` and `synapse-cmf/synapse-admin-bundle` :
```bash
composer require synapse-cmf/synapse-page-bundle ~1.0
```

Please reference the bundler in your application kernel :
```php
<?php
// app/AppKernel.php

public function registerBundles()
{
    $bundles = array(
        // ...
        new Synapse\Page\Bundle\SynapsePageBundle(),
    );
}
```

## Reference configuration

```yml
# app/config/config.yml

# Synapse Cmf Configuration
synapse_cmf:
    content_types:
        Synapse\Page\Bundle\Entity\Page:    # you have to manually reference page content type into Cmf configuration
            alias: page
            provider: synapse.page.loader

# Synapse Page Configuration
synapse_page:
    rendering_route: synapse_content_type_page   # page rendering route, used into admin to generate frontend links
```

```yml
# app/config/routing.yml

# Front
synapse_page_content:
    resource: "@SynapsePageBundle/Resources/config/routing/content_type.yml"
    options:
        synapse_theme: bootstrap

# Admin
synapse_admin:
    resource: "@SynapsePageBundle/Resources/config/routing/admin.yml"
    prefix: "/synapse/admin/page"
    options:
        synapse_theme: bootstrap
```

Note : you don't need to include the AdminBundle routing, PageBundle already do it.
