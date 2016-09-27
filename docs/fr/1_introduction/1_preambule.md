# Préambule

Pour commencer, enfonçons les portes ouvertes : aujourd'hui, nous développons de moins en moins de sites webs, pour lesquels les Cms historiques sont faits, au profits d'applications web, riches en interactions, règles de gestion et interconnexions auxquelles répondent parfaitement les frameworks.

Synapse a été développé avec en ligne de mire d'être une offre supplémentaire dans la jungle de projets Open Source de gestion de contenus; mais orientée projet métier, en combinant le meilleur des deux mondes :

 - Avoir à disposition des modules de gestion de contenu "classiques", des interfaces pré-construites, des modules plug-and-play, une gestion de médias etc...
 - Une base framework, permettant d'implémenter tout ce qui est possible en Php, grâce à Symfony

Cependant, comme dit l'adage, "there's no silver bullet" en informatique : le compromis sur lequel est basé Synapse oblige à ne prendre aucune décision métier autre que pour la gestion éditoriale, ce qui veut dire que plus de travail sera nécessaire pour compléter le projet.
La conséquence : il pourrait convenir à la création de simples vitrines, mais n'a aucune plus value dans ce domaine par rapport à d'autres solutions, plus légères à installer et exploiter. Cependant, si la vitrine n'est que la première pierre d'un édifice beaucoup plus imposant comme par exemple un site e-commerce connecté à de nombreuses autre applications, c'est dans ce genre de cas que Synapse excelle.

Prenons maintenant le virage du sujet polémique avec l'affirmation habituelle, encore très ancrée dans les esprits : "Je ne veux pas réinventer la roue".
Cet adage est inadapté au web d'aujourd'hui, c'est un fait. Ne pas réinventer la roue signifie que nous allons toujours voir en premier si quelqu'un d'autre n'a pas produit et publié le travail que nous nous apprêtons à commencer. Souvent, on trouve. Très souvent. Et quand on ne trouve pas, on trouve quelque chose qui ressemble. Alors une fois trouvé on l'utilise, voir on l'adapte. Mais à l'utilisation, la roue est faite dans un matériau peu robuste, ou alors se déforme dans les virages. Ce n'est pas la faute du mécanicien, c'est le besoin du pilote de prendre des virages serrés. Il ne serait pas pilote dans le cas contraire. Ce n'est pas non plus la faute du premier concepteur de roue : il a peut-être conçue sa roue bien avant que le pilote ne sache se servir d'un volant. Le souci vient du postulat de départ : aucune roue ne pouvait être adaptée pour ce pilote.
Aujourd'hui sur le web, ceux qui réussissent sont ceux qui inventent, innovent, ceux qui ont un système de fonctionnement efficace, fiable. Qui ont la maîtrise de leur système d'information. Or, chaque module rendant un service métier inclus dans le système d'information de la dette technique : si la société innove, le module ne sera plus adapté et devra être remplacé. Et souvent cela a un coût très important, qui plus est en cas de dépendance du reste du système.
Prenons maintenant du recul par rapport à cette affirmation : qu'en est-il si ce n'est pas seulement la roue, mais le véhicule entier qui n'a pas été inventé ? Tout est potentiellement à refaire. Mais tant qu'on ne veut rouler qu'en ville, aucun souci. Mais de là à pouvoir rouler sur circuit, parfois il y a un pas.

Et c'est ici que Synapse créée de la valeur : aucune roue n'est proposée, seulement les outils pour créer la vôtre. Cela prend du temps, de l'énergie de concevoir une roue. Mais cette roue sera adaptée au pilote.

Ici se referme l'éternel débat du "custom vs out-of-the-box".

Le second principe est en fait un corollaire du premier : si Synapse est conçu pour que les développeurs usent de leurs talents, leur proposer des APIs simples et efficaces, des middlewares, des configurations, des logs et outils de debug coule de source. Toutes ces notions, appelées "Developper experience", ou DX, sont déjà des priorités du framework Symfony.

Synapse dispose donc d'une interface peu intrusive avec le reste du projet, privilégiant systématiquement le découplage, au prix parfois de complexité supplémentaire, pour rester dans cette logique d'isolation pour éviter les effets de bords et dépendances intempestives.

Pour conclure et résumer les points précédents, Synapse est orienté pour les développeurs de projets dits "custom", qui ne veulent pas rentrer dans l'engrenage d'un système complet. Il convient à tous types de projets, en particulier aux applications à forte concentration de règles de gestion.
