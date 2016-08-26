
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
