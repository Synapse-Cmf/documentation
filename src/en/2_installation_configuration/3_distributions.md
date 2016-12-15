# Distributions

L'édition complète permet de rapidement arriver à un résultat fonctionnel, seulement certaines fois il nécessaire d'optimiser le code chargé, ou tout simplement, vous n'aurez pas toujours besoin de toutes les fonctionnalités.

Pour rester dans la logique d'apporter le maximum à un projet, sans pour autant le surcharger, Synapse Cmf dispose de trois distributions supplémentaires, contenant chacune un bundle du kernel du Cmf (et ses dépendances).
À vous de choisir celle qui vous convient, en fonction de la typologie de votre projet.

| Distribution | Package composer | Features | Type de projet | Configuration |
| -------------| ---------------- | -------- | -------------- | --------------|
| [SynapseCmfBundle](https://github.com/synapse-cmf/SynapseCmfBundle) | `"synapse-cmf/synapse-cmf-bundle": "~1.0"` | Moteur de rendu, module médiathèque, API programatique | Projet sans backoffice, où les interfaces extérieures ne sont pas forcément des écrans (architectures CQRS, web services, ...) | [Voir](distributions/1_cmf_bundle.md) |
| [SynapseAdminBundle](https://github.com/synapse-cmf/SynapseAdminBundle) | `"synapse-cmf/synapse-admin-bundle": "~1.0"` | Inclu SynapseCmfBundle, ajoute une interface html de gestion des éléments de Synapse (skeletons, mediathèque) et le thème backoffice par défaut | Projet de type "interface de gestion", quand d'autres écrans doivent être implémentés, et les contenus décorés par des éditorialistes. | [Voir](distributions/2_admin_bundle.md) |
| [SynapsePageBundle](https://github.com/synapse-cmf/SynapsePageBundle) | `"synapse-cmf/synapse-page-bundle": "~1.0"` | Inclu SynapseAdminBundle, ajoute le type de contenu "Page", qui représente une page web simple, gère le référencement et l'arborescence. Il ajoute également un écran au backoffice Synapse pour créer et éditer les pages. | Distribution dédiée "vitrine" à utiliser pour des sites simples, à vocation évolutive vers de l'exposition d'autres données. | [Voir](distributions/3_page_bundle.md) |
