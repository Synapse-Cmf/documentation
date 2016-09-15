# Distributions

Pour rester dans la logique d'apporter le maximum à un projet, sans pour autant le surcharger, Synapse propose plusieurs distributions.
A vous de choisir celle qui vous convient, en fonction de la typologie de votre projet.

| Distribution | Package composer | Features | Type de projet |
| -------------| ---------------- | -------- | -------------- |
| [SynapseCmfBundle](https://github.com/synapse-cmf/SynapseCmfBundle) | `"synapse-cmf/synapse-cmf-bundle": "~1.0"` | Moteur de rendu, module médiathèque, API programatique | Projet sans back office, où les interfaces extérieures ne sont pas forcément des écrans (architectures CQRS, web services, ...) |
| [SynapseAdminBundle](https://github.com/synapse-cmf/SynapseAdminBundle) | `"synapse-cmf/synapse-admin-bundle": "~1.0"` | Inclu SynapseCmfBundle, ajoute une interface html de gestion des éléments de Synapse (skeletons, mediathèque) et le thème backoffice par défaut | Projet de type "interface de gestion", quand d'autres écrans doivent être implémentés, et les contenus décorés par des éditorialistes. |
| [SynapsePageBundle](https://github.com/synapse-cmf/SynapsePageBundle) | `"synapse-cmf/synapse-page-bundle": "~1.0"` |
Inclu SynapseAdminBundle, ajoute le type de contenu "Page", qui représente une page web simple, gère le référencement et l'arborescence. Il ajoute également un écran au backoffice Synapse pour créer et éditer les pages. | Distribution dédiée "vitrine" à utiliser pour des sites simples, à vocation évolutive vers de l'exposition d'autres données. |

Il est également possible d'inclure directement la totalité du projet, via `"synapse-cmf/synapse-cmf" : "~1.0"`, comme décrit dans la [partie suivante](2_projet_complet.md). Il n'est cependant pas recommandé de l'utiliser en production pour ne pas surcharger l'autoloader, et ralentir la génération du cache.

Enfin, la dernière distribution est une [édition standard](3_edition_standard.md) de [Symfony](https://github.com/symfony/symfony-standard), avec Synapse Cmf pré-installé.

Voyons en détail le contenu des trois bundles principaux de Synapse Cmf et comment les installer.

## SynapseCmfBundle

Cette distribution contient le strict minimum pour travailler avec Synapse; c'est en général celle que l'on va utiliser quand on dispose déjà de son back-office, où lorsque les modules métiers adjacents imposent une charte graphique ou un markup incompatible avec l'administration native.

Elle contient :

 - Le bundle d'interface avec les composants Symfony
 - La définition du modèle de données sous [Doctrine Orm](http://www.doctrine-project.org/projects/orm.html)
 - La définition et les APIs de gestion des éléments de Synapse :
    - Types de contenus
    - Thème (templates, zones et composants)
    - Médiathèque (média, images et fichiers)
 - Le moteur de rendu
 - Composants built-in, avec contrôleur, configurations par défaut et formulaire
    - Static
    - Free
    - Text
    - Menu
    - Gallery

L'installation se passe via [Composer](https://getcomposer.org/), comme la plupart des bundles Symfony :
```bash
composer require synapse-cmf/synapse-cmf-bundle ~1.0
```

Comme habituellement lorsqu'on travaille avec Symfony, le bundle doit être inclu et configuré dans le projet, au même titre que ses dépendances, reportez vous à la [section dédiée](../3_configuration/1_cmf_bundle.md).

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

Voir la [configuration](../3_configuration/1_admin_bundle.md) de l'admin bundle.

## SynapsePageBundle

