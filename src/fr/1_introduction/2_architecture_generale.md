# Architecture et partis pris

Rentrons maintenant dans le détail : comment Synapse permet de disposer à la fois d'une gestion de contenu puissante mais sans couplage fort ?
En premier lieu, grâce à deux design patterns très utilisés actuellement, en particulier dans Symfony : Decorator (composant Templating) et Prototype (composant Form).
Et d'autre part, grâce à une application des principes SOLID, en particulier la maitrise des dépendances des objets.

Le modèle de Synapse découle de ces deux éléments d'architecture, détaillés dans les rubriques suivantes.

## Décoration et inversion de contrôle

Comme décrit plus haut, Synapse n'est pas intrusif dans le modèle du projet qui l'utilise.
Pour ce faire, une inversion de contrôle a été implémentée entre les objets métiers et le modèle de Synapse, à travers la notion de __type de contenu__.

Traditionnellement, quand il est possible d'implémenter des modèles personnalisés, la conséquence est l'inclusion en dur de code de la librairie de gestion de contenu dans le modèle métier, soit par classes abstraites / héritage, soit par composition. Dans les deux cas, le modèle métier est lié à la librairie, de manière forte : des méthodes dédiées sont présentes dans les objets et de fait, l'architecture du projet est contrainte.

Synapse prend le contrepied de ces habitudes en s'affranchissant du lien fort avec l'objet métier : il n'interviendra jamais dessus directement, et se contentera de le décorer à l'aide de son propre modèle. L'objet décoré doit simplement implémenter une interface, puis être référencé dans une configuration (voir la [configuration des types de contenu](../2_installation_configuration/distributions/1_cmf_bundle.md)).

Il est donc possible de décorer n'importe quel objet métier grâce à Synapse, et ce sans corrompre son identité logicielle, allant d'une simple page web (comme dans la distribution [PageBundle](../2_installation_configuration/distributions/3_page_bundle.md)), à un article de presse, en passant par un produit e-commerce avec de nombreux champs et/ou dépendances.

## Prototypage du rendu

La DX (Developper eXperience) passe aussi par une aide au partage des tâches au sein d'une équipe, que le framework permette que chacun puisse effectuer sa tâche facilement et de manière optimisée.

Dans une organisation d'équipe standard, comprenant designers, intégrateurs et développeurs back, des maquettes sont réalisées par l'équipe design, puis sont intégrées en HTML / CSS (etc..) par l'équipe front, et enfin "dynamisées" par l'équipe back.

Synapse permet de simplifier ce processus en mettant en place un prototypage du rendu des types de contenu à l'aide de fichiers de configuration simples, au format Yaml.

Le workflow devient donc :

 - le designer produit des maquettes pour des types d'habillage (layouts), les templates dans Synapse. Puis il initialise le fichier de description du thème en déclarant les différents templates, zones et composants, voire la [référence]().
 - l'intégrateur reçoit ces maquettes et fichiers de configuration et va créer les fichiers Twig correspondants, puis les référencer dans le fichier de configuration.
 - le développeur back va ensuite créer des composants permettant d'afficher les données dynamiques dans les prototypes intégrés.

Ce prototypage permet donc plus de flexibilité à l'équipe pour travailler en parallèle, par rapport à un système classique, car il induit là aussi un découplage. Dans le détail :

 - le designer n'a pas besoin de créer des maquettes pour toutes les pages du site; il n'a même pas besoin de concevoir le site entier avant que les développements commencent.
 - le développeur front a toute latitude pour concevoir sa réponse technique aux besoins du designer, découpage des fichiers, extensions et inclusions Twig, responsive et adaptive design etc...
 - le développeur back n'a plus à s'occuper d'implémenter la structure des templates et des pages, seulement à exposer des données aux templates du développeur front. Il lui reste également le reste de son travail bien entendu : gérer les accès aux données, l'implémentation des formulaires etc...

D'un point de vue macro, le prototypage va également permettre de pouvoir changer tout un thème sans impliquer une grosse charge de développement back, tant que les données et configurations des composants resteront les mêmes.
