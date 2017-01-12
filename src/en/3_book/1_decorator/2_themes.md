# Themes

The decoration elements o the content types are declared within the theme.
These themes are true namespaces where each element and each configuration are partitioned.

Over the technical aspect, they are a way to easily change the graphic theme of the whole application.

## Theme creation

A theme is created from a Symfony bundle.
The benefit of this consist in activing and sharing Synapse themes as well as bundles, and gathering all resource types inside : templates, configurations, routes, assets...

Let's start from a brand new bundle, via the command `php bin/console generate:bundle`.

In the bundle class, use the Synapse inheritance instead of the Symfony inheritance :
```php
// src/Acme/Bundle/DemoThemeBundle/AcmeDemoThemeBundle.php

use Synapse\Cmf\Bundle\Distribution\Theme\Bundle\Bundle as SynapseThemeBundle;

class AcmeDemoThemeBundle extends SynapseThemeBundle
{
}
```

This inheritance provides additional configurations, particularly a configuration file allowing an easy theme configuration.

This configuration file goes in the directory `Resources/config` of your bundle :
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
The literal translation of a part of the former configuration is :
```
The theme structure "acme_demo" is constituted with 3 tremplates :
  - home : two zones,
    - menu, allowing only the component "menu"
    - body, allowing components : "text", "gallery" and "news_list"
  - landing : three zones,
    - menu, allowing only the component "menu"
    - body, allowing only the component "news_list"
    - sidebar, allowing only the component "news_list"
  etc...
```
We will come back in detail on the template/zone/component setting later. The important here is to notice taht one theme is defined only by its name and its structure.

Please note that the file `synapse.yml` is the  **core of the prototype pattern of Synapse**.

Lastly, don't forget to activate the bundle in your application Kernel.

## Theme activation

Synapse can use only one theme at once, and have to be initialized with this theme.

Many options are available, the most simple is via the routing of your front and admnin controlers :
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

The admin of Synapse requires the theme too in way to know which theme he has to edit to activate some lazy loaded configurations.
L'admin de Synapse a également besoin du thème qu'il doit éditer, pour activer certaines configurations "lazy-loadées".

More options are available to manage more specificaly the theme activation, see the article of the [dedicated cookbook (wip)](../../4_cookbook/2_decorator/multi_themes.md).
