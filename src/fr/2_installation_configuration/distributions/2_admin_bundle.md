## SynapseAdminBundle

Cette distribution rajoute une interface d'administration à la distribution de base.
Elle peut servir de base pour construire un back office pour le projet.

Fonctionnalités ajoutées :

 - Bundle d'interface avec les composants Symfony, Twig et javascript
 - Thème de back office Synapse (construit avec Sass et Bootstrap 3)
 - Interface de gestion des skeletons (templates globaux - voir chapitre sur [les thèmes](../4_modules/1_decorator/2_themes.md))
 - Interface de gestion des médias
    - Upload d'images
    - Module de gestion des métadonnées d'images et formatage

L'installation de passe également via Composer, et inclue synapse-cmf-bundle :
```bash
composer require synapse-cmf/synapse-admin-bundle ~1.0
```

Voir la [configuration](../3_configuration/3_admin_bundle.md) de l'admin bundle.
