# Architecture et partis pris

Rentrons maintenant dans le détail : comment Synapse permet de disposer à la fois d'une gestion de contenu puissante mais sans couplage fort ?
En premier lieu, grâce à deux design patterns très utilisés actuellement, en particulier dans Symfony : Decorator (composant Templating) et Prototype (composant Form).
Et d'autre part, grâce à une application des principes SOLID, en particulier la maitrise des dépendances des objets.

Le modèle de Synapse découle de ces deux éléments d'architecture, détaillée dans les rubriques suivantes.

## Décoration et inversion de contrôle

Comme décrit plus haut, Synapse n'est pas intrusif dans le modèle du projet qui l'utilise.
Pour ce faire, une inversion de contrôle a été implémentée entre les objets métiers et le modèle de Synapse, à travers la notion de __type de contenu__.

Traditionellement, quand il est possible d'implémenter des modèles personalisés, la conséquence est l'inclusion en dûr de code de la librairie de gestion de contenu dans le modèle métier, soit par classes abstraites / héritage, soit par composition. Dans les deux cas, le modèle métier est lié à la librairie, de manière forte : des méthodes dédiées sont présentes dans les objets et de fait, l'architecture du projet est contrainte.

Synapse prend le contrepied de ces habitudes en s'affranchissant du lien fort avec l'objet métier : il n'interviendra jamais dessus directement, et se contentera de le décorer à l'aide de son propre modèle. L'objet décoré doit simplement implémenter une interface, puis être référencé dans une configuration (voir la [configuration des types de contenu](../3_configuration/1_cmf_bundle.md)).

Il est donc possible de décorer n'importe quel objet métier grâce à Synapse, et ce sans corrompre son identité logicielle, allant d'une simple page web (comme dans la distribution [PageBundle]()), à un article de presse, en passant par un produit e-commerce avec de nombreux champs et/ou dépendances.

## Prototypage du rendu

