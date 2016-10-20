# Templates et zones

Les templates sont le cœur de la décoration d'un type de contenu, ce sont eux qui définissent styles, positionnements, habillages et informations à afficher. De même que dans n'importe quelle application Symfony en somme.

Physiquement, les templates sont des fichiers Twig, le moteur de templating inclut nativement dans Symfony. Ils tirent parti des extensions de la librairie pour ajouter des options, en particulier l'inclusion de zones.

Ces zones sont des emplacements dans lesquels peuvent être ajoutés des composants. Elles sont appelées via des tags Twig, et définies dans le prototype du thème.

## Création d'un template

Pour commencer, initialisons un fichier Twig pour notre premier template :
```html
<!-- src/Acme/Bundle/DemoThemeBundle/Resources/views/homepage.html.twig -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Acme Demo</title>
    <link rel="stylesheet" href="http://v4-alpha.getbootstrap.com/dist/css/bootstrap.min.css">
</head>
<body>
    {% block main_nav %}
    <nav class="main_nav">{{ synapse_zone('menu') }}</nav>
    {% endblock %}
    {% block content %}
    <div class="container">
        {% block main_content %}
        <section class="main">{{ synapse_zone('body') }}</section>
        {% endblock %}
        {% block sidebar %}
        <aside>{{ synapse_zone('sidebar') }}</aside>
        {% endblock %}
    </div>
    {% endblock %}
    <footer>Acme Demo powered by SynapseCmf</footer>
</body>
</html>
```

La structure des blocks Twig est à votre apréciation, blocks internes ou externes par rapport à la structure HTML etc... Aucune importance du point de vue de Synapse.

Ensuite, dans le prototype du thème, le template doit être référencé dans Synapse, et ajouté au thème.
```yml
# src/Acme/Bundle/DemoThemeBundle/Resources/config/synapse.yml
synapse:
    acme_demo:
        structure:
            home:          # ajout de l'alias du template à la structure du thème
                # ...
        templates:
            home:          # définition de l'alias du template dans Synapse
                path: "AcmeDemoThemeBundle::homepage.html.twig"     # chemin physique du template Twig
        # ...
```

## Ajout des zones

Comme expliqué précédemment, les templates Synapse sont constitués de zones. Ces zones sont appelées depuis le fichier Twig du template, via le tag `{{ synapse_zone('zone_name', { hello: 'world' }) }}`. Elles doivent également être déclarées dans le fichier `synapse.yml`. En reprenant le fichier Twig ci dessus, les zones se configureraient comme suit :
```yml
# src/Acme/Bundle/DemoThemeBundle/Resources/config/synapse.yml
synapse:
    acme_demo:
        structure:
            home:
                menu: ~
                body: ~
                sidebar: ~
            # ...
        # ...
        zones:
            menu: ~
            body: ~
            sidebar: ~
```

Le namespace "synapse.acme_demo.zones" déclare les zones du thème, ainsi que leurs configurations (voir la [référence (wip)]() du fichier synapse.yml), et sont reliées à des templates via le prototype de la structure du thème.

## Rendre un contenu dans un template

Après le paramétrage, il est temps de tester.
La création d'une réponse HTTP avec Synapse se passe comme tout autre projet Symfony : via un Controller.
Créons donc un Controller pour rendre un contenu Page dans le template "home".
```php
// src/Acme/Bundle/AppBundle/Controller/PageController.php

class PageController extends Controller
{
    // ...

    public function renderAction($path, Request $request)
    {
        if (!$page = $this->get('acme.news.repository')->retrieveByPath($path)) {
            throw new NotFoundHttpException(sprintf('No online page found at path "%s".',
                $path
            ));
        }

        return $this->get('synapse')           // get Synapse engine
            ->createDecorator($page, 'home')        // create a decorator for $page content into "home" template
            ->decorate(array('page' => $page)       // render template with $page parameter (like render() method with Twig)
        ;
    }
}
```

Le rendu d'un contenu dans un template se passe en deux étapes : d'abord on instancie le prototype du thème pour le contenu et le template en paramètre dans un objet Decorator; puis on résout ce Decorator pour générer une réponse HTTP.

Note : il est également possible de résoudre un rendu de template sous forme de chaine de caractères via la méthode `render()`, pour par exemple décorer des email, générer des Pdf etc...

Ensuite, pour afficher la réponse générée, une route est nécessaire :
```yml
# src/Acme/Bundle/DemoThemeBundle/Resources/config/routing.yml

# Page content type
acme_page_render:
    path: "/{path}.{_format}"
    defaults:
        _controller: "AcmeAppBundle:Page:render"
        _format: html
    requirements:
        path: "[^.]*"
```

Notez bien qu'il s'agit ici d'une implémentation propre au type de contenu Page, natif à Synapse. L'implémentation de ce type de contenu peut varier dans vos propres types de contenu, de même qu'il est possible d'appeler les pages différemment, comme à partir de l'identifiant.

Dernière étape : créer un objet Page. Pour ce faire, vous pouvez utiliser l'interface inclue avec SynapsePageBundle, accessible à l'adresse `/synapse/admin/page/create` (si vous avez suivi l'installation d'exemple).

  - Remplissez les champs, le nom est un nom back office, qui ne devrait jamais être utilisé en front, et le chemin, l'identifiant textuel (ou "slug") de la page, dans l'url. Lors de votre première utilisation, vous ne devriez pas pouvoir sélectionner de page parente, votre base étant vide.
  - Une fois la page créée, dans le fieldset "Synapse", sélectionnez votre template "home", cochez la case pour initialiser ce template, vérifiez que votre page est en ligne, puis sauvegardez.

Votre page sera du coup visible, décorée avec le template créé, à l'url choisie.
