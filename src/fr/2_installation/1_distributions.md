# Distributions

Pour rester dans la logique d'apporter le maximum à un projet, sans pour autant le surcharger, Synapse propose plusieurs distributions.
A vous de choisir celle qui vous convient, en fonction de la typologie de votre projet.

| Distribution | Package composer | Features | Type de projet |
| -------------| ---------------- | -------- | -------------- |
| [SynapseCmfBundle](https://github.com/synapse-cmf/SynapseCmfBundle) | `"synapse-cmf/synapse-cmf-bundle": "~1.0"` | Moteur de rendu, module médiathèque, API programatique | Projet sans back office, où les interfaces extérieures ne sont pas forcément des écrans (architectures CQRS, web services, ...) |
| [SynapseAdminBundle](https://github.com/synapse-cmf/SynapseAdminBundle) | `"synapse-cmf/synapse-admin-bundle": "~1.0"` | Inclu SynapseCmfBundle, ajoute une interface html de gestion des éléments de Synapse (skeletons, mediathèque) et le thème backoffice par défaut | Projet de type "interface de gestion", quand d'autres écrans doivent être implémentés, et les contenus décorés par des éditorialistes. |
| [SynapsePageBundle](https://github.com/synapse-cmf/SynapsePageBundle) | `"synapse-cmf/synapse-page-bundle": "~1.0"` |
Inclu SynapseAdminBundle, ajoute le type de contenu "Page", qui représente une page web simple, gère le référencement et l'arborescence. Il ajoute également un écran au backoffice Synapse pour créer et éditer les pages. | Distribution dédiée "vitrine" à utiliser pour des sites simples, à vocation évolutive vers de l'exposition d'autres données. |

Il est également possible d'inclure directement la totalité du projet, via `"synapse-cmf/synapse-cmf" : "~1.0"`, comme décrit dans la [partie suivante](2_projet_complet.md). Il n'est cependant pas recommandé de l'utiliser en production.

Enfin, la dernière distribution est une [édition standard](3_edition_standard.md) de [Symfony](https://github.com/symfony/symfony-standard), avec Synapse Cmf pré-installé.

Voyons en détail le contenu des trois bundles principaux de Synapse Cmf et comment les installer.

## SynapseCmfBundle

## SynapseAdminBundle

## SynapsePageBundle

