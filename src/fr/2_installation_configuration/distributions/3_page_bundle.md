# SynapsePageBundle

Cette distribution rajoute un type de contenu nommé "Page", ainsi que son interface d'administration à la distribution AdminBundle.

Le type de contenu "Page" représente une page web simple, avec une gestion des métadonnées HTML, une mécanique de publication / archivage et une gestion d'arborescence.

L'interface d'administration des pages implémente également le formulaire de thème de Synapse.

Cette distribution est idéale pour commencer à utiliser Synapse Cmf, elle propose un cas d'utilisation simple du framework. Elle peut être également utile pour les pages uniques d'un site, comme par exemple la homepage, des landings, des résultats de recherche et / ou comme base pour des features complexes comme par exemple un panier, un compte utilisateur etc...

**Attention** : cette distribution requiert le CmfBundle et l'AdminBundle, qui doivent eux aussi initialisés et configurés, tel que décrit [ici](1_cmf_bundle.md) et [là](2_admin_bundle.md).

## Installation

L'installation de passe également via Composer, et inclue `synapse-cmf-bundle` et `synapse-cmf/synapse-admin-bundle` :
```bash
composer require synapse-cmf/synapse-page-bundle ~1.0
```

Référencez ensuite le bundle dans le kernel de votre application :
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

## Configuration de référence

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

Note : vous n'avez pas besoin d'inclure le routing de l'admin bundle, page bundle s'en charge déjà.
