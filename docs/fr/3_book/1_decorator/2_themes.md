# Thèmes

Les éléments de décoration des types de contenu sont déclarés au sein d'un thème.
Ces thèmes sont de véritables namespaces au sein duquel chaque élément et chaque configuration sont cloisonnés.

Au-delà de l'aspect technique, ils sont le moyen de changer facilement le thème graphique de toute une application.

## Créer un thème

Un thème se créé à partir d'un bundle Symfony.
L'intérêt est de pouvoir activer et partager des thèmes Synapse aussi facilement que des bundles, et de pouvoir regrouper tout type de ressources à l'intérieur : templates, configurations, routes, assets...

Partons d'un bundle vierge pour créer notre nouveau thème, via la commande `php bin/console generate:bundle`.

Dans la classe de bundle, utilisez l'héritage Synapse au lieu de Symfony :
```php
// src/Acme/Bundle/DemoThemeBundle/AcmeDemoThemeBundle.php

use Synapse\Cmf\Bundle\Distribution\Theme\Bundle\Bundle as SynapseThemeBundle;

class AcmeDemoThemeBundle extends SynapseThemeBundle
{
}
```

Cet héritage permet de fournir des configurations supplémentaires, en particulier un fichier de configuration permettant de paramétrer facilement un thème.

Ce fichier de configuration est à placer dans le dossier `Resources/config` de votre bundle :
```yml
# src/Acme/Bundle/DemoThemeBundle/Resources/config/synapse.yml

synapse:
    acme_demo:           # your theme name
        structure:          # all theme structure will be defined here (templates, zones, components)
            home:              # template name
                menu:             # zone name
                    menu: ~          # allowed component in this zone
                body:
                    text: ~
                    gallery: ~
                    news_list: ~
            landing:
                menu:
                    menu: ~
                body:
                    news_list: ~
                sidebar:
                    news_list: ~
            news:
                menu:
                    menu: ~
                body:
                    news_body: ~
                sidebar:
                    news_list: ~
```

La traduction littérale d'une partie de la configuration ci-dessus est :
```
La structure du thème "acme_demo" est constituée de 3 templates :
  - home : deux zones,
    - menu, n'autorisant que le composante "menu"
    - body, autorisant les composants "text", "gallery" et "news_list"
  - landing : trois zones,
    - menu, n'autorisant que le composante "menu"
    - body, n'autorisant cette fois que "news_list"
    - sidebar, n'autorisant lui aussi que "news_list"
  etc...
```

Nous reviendrons en détail sur le paramétrage des templates, zones et composants plus tard, l'important ici est de remarquer qu'un thème ne se définit que par son nom, et sa structure.

Notez que le fichier `synapse.yml` est le **coeur du pattern prototype de Synapse**.

Pour finir, ne pas oublier d'activer le bundle dans le Kernel de votre application.

## Activation d'un thème

Synapse ne peut utiliser qu'un seul thème à la fois, et doit être initialisé avec ce thème.

Plusieurs options sont disponibles, la plus simple étant via le routing vers vos contrôleurs front et admin :
```yml
# app/config/routing.yml

# Synapse Admin
synapse_admin:
    resource: "@SynapsePageBundle/Resources/config/routing/admin.yml"
    prefix: "/synapse/admin/page"
    options:
        synapse_theme: acme_demo         # Theme to activate

# Acme front
acme_front :
    resource: "@AcmeAppBundle/Resources/config/routing/front.yml"
    options:
        synapse_theme: acme_demo

# Synapse Page
synapse_page_content:
    resource: "@SynapsePageBundle/Resources/config/routing/content_type.yml"
    options:
        synapse_theme: acme_demo
```

L'admin de Synapse a également besoin du thème qu'il doit éditer, pour activer certaines configurations "lazy-loadées".

D'autres options sont disponibles pour gérer plus finement l'activation des thèmes, voir l'article du [cookbook dédié (wip)](../../4_cookbook/2_decorator/multi_themes.md).
