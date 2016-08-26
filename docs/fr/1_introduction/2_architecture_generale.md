# Architecture et partis pris

Rentrons maintenant dans le détail : comment Synapse permet de disposer à la fois d'une gestion de contenu puissante mais sans couplage fort ?
En premier lieu, grâce à deux design patterns très utilisés actuellement, en particulier dans Symfony : Decorator (composant Templating) et Prototype (composant Form).
Et d'autre part, grâce à une application des principes SOLID, en particulier la maitrise des dépendances des objets.

Le modèle de Synapse découle de ces deux éléments d'architecture, détaillée dans les rubriques suivantes.

## Inversion de contrôle

Comme décrit plus haut, Synapse n'est pas intrusif dans le modèle du projet qui l'utilise.
Pour ce faire, une inversion de contrôle a été implémentée entre les objets métiers et le modèle de Synapse, à travers la notion de type de contenu.

Traditionellement, quand il est possible d'implémenter des modèles personalisés, la conséquence est l'inclusion en dûr de code de la librairie de gestion de contenu dans le modèle métier, soit par classes abstraites / héritage, soit par composition. Dans les deux cas, le modèle métier est lié à la librairie, de manière forte : des méthodes dédiées sont présentes dans les objets et de fait, l'architecture du projet est contrainte.

Synapse prend le contrepied de ces habitudes en s'affranchissant du lien fort avec l'objet métier : il n'interviendra jamais dessus directement, et se contentera de le décorer à l'aide de son propre modèle. L'objet décoré doit simplement implémenter une interface, puis être référencé dans une configuration (voir la [configuration des types de contenu]()).

Grâce à ces éléments, Synapse dispose de quoi abstraire n'importe quel objet métier derrière la notion de Contenu et de Type de Contenu, lien entre les modèles, comme l'illuste le diagramme de classes ci-dessous.

Il est donc possible de décorer n'importe quel objet métier grâce à Synapse, et ce sans corrompre son identité logicielle, allant d'une simple page web (comme dans la distribution [PageBundle]()), à un article de presse, en passant par un produit e-commerce avec de nombreuses dépendances.

## Diagramme de classes - Modèle d'entités

-- diagramme ici --

Le diagramme ci-dessus représente le modèle interne de Synapse, ainsi que ses intéraction avec les objets métiers du projet.

Quatres éléments importants se distinguent :

 - Les thèmes : namespace des éléments Synapse, chaque élément sous-jacent est toujours référencé à l'intérieur d'un thème. Physiquement, il correspond au bundle Symfony qui déclare le thème et les templates.
 - les templates : gabarits de pages, layout, coeur du pattern decorator, il est en particulier le template Twig dans lequel sera rendu le contenu, et est composé de zones.
 - les zones : espaces dans un template, déclarés via des tags similaires à des blocks Twig, dans lequelles il est possible d'ajouter et de rendre des composants.
 - les composants : éléments de décoration d'un contenu, ajoutés dans une zone et porteurs de données utilisables dans leur contexte de rendu seulement.

Ces éléments sont chacun adjoints d'un "type". Ces types sont créés depuis la configuration, le prototypage, des thèmes. Ils définissent les informations spécifiques au rendu d'un template, comme en particulier les templates Twig à appeler, les configurations par défaut, les composants autorisés pour telle ou telle zone, les formats d'images etc...

Le prototypage des ces éléments permet de disposer d'une grande flexibilité sur le modèle et le moteur de rendu de Synapse, sans pour autant écrire la moindre ligne de code Php : les développeurs en charge du front peuvent donc reprendre leurs droits sur le paramétrage de leurs rendus, et ainsi maitriser toute la chaine de décoration d'un contenu.
