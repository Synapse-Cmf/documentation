# SynapseAdminBundle

Cette distribution rajoute une interface d'administration à la distribution de base.
Elle peut servir de base pour construire un back office pour le projet.

Fonctionnalités ajoutées :

 - Bundle d'interface avec les composants Symfony, Twig et javascript
 - Thème de back office Synapse (construit avec Sass et Bootstrap 3)
 - Interface de gestion des skeletons (templates globaux - voir chapitre sur [les thèmes](../../3_book/1_decorator/2_themes.md))
 - Interface de gestion des médias
    - Upload d'images
    - Module de gestion des métadonnées d'images et formatage

**Attention** : cette distribution requiert le CmfBundle, qui doit lui être aussi initialisé et configuré, tel que décrit dans la [section précédente](1_cmf_bundle.md).

## Installation

L'installation se passe via Composer (`synapse-cmf-bundle` est inclu) :
```bash
composer require synapse-cmf/synapse-admin-bundle ~1.0
```

Référencez le bundle dans le kernel de votre application :
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

## Configuration de référence

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
