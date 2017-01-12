# Templates and zones

Templates are the core of the decoration of a content type. They are the one which define styles, positions, layouts and shown informations. As well as any Symfony application.

Physically, templates are Twig files, the native templating engine included in Symfony. Templates take advantage of library extensions to add options, particularly the zone include.

These zones are areas where components can be added. They are called from Twig tags, and defined in the theme prototype.

## Template creation

To start, here is the twig file initialization for our first template : 
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

You can customize the HTML structure to fit to your need.

Then, in the theme prototype, the template must be referenced in Synapse, and added to the theme.
```yml
# src/Acme/Bundle/DemoThemeBundle/Resources/config/synapse.yml
synapse:
    acme_demo:
        structure:
            home:          # Add the template alias to the theme structure
                # ...
        templates:
            home:          # Definition of the template alias in Synapse
                path: "AcmeDemoThemeBundle::homepage.html.twig"     # Physical path of the Twig template
        # ...
```

## Inclusion of zones

As previously explained, Synapse templates are built with zones. These zones are called from the Twig file of the template with the tag `{{ synapse_zone('zone_name', { hello: 'world' }) }}`. They must be declared in the file `synapse.yml` too. 
The zone configuration of the twig file aboce would be :

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

The namespace "synapse.acme_demo.zones" state the theme zones and  their configuration (see the [reference (wip)]() du fichier synapse.yml), and are linked to templates within theme structure prototype.

## Rendering a content in a template

After the setting, it is time to test.
The creation of a HTTP response with Synapse takes place in the Controller.
Let's create a controller in order to render the content PAge in the template "home".
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

The rendering of a content in a template has two steps : first of all, we instantiate in a Decorator the theme prototype for the content with the template name as a paremeter. Then we resolve the Decorator in order to generate a HTTP response.
Le rendu d'un contenu dans un template se passe en deux étapes : d'abord on instancie le prototype du thème pour le contenu et le template en paramètre dans un objet Decorator; puis on résout ce Decorator pour générer une réponse HTTP.

Note : it is possible to resolve a template rendering under a string form via the method `render()`, to decorate email, generate pdf...

Then, a route is required to display the generated response : 
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

Please notice that the code above is a specific implementation for the native content type Page. The implementation of this content type may vary in your own content types, as well as it is possible to call a page in a different way. Fore example, you can use the identifier.

Last step : create a Page object.  For this purpose, you can use the interface included in the SynapseBundle, available at this address : `/synapse/admin/page/create` (if you kept the default settings).

  - Fill up the fields. The name is a backoffice identifier and will never be used in the frontoffice. The path is the textual identifier (or "slug") of the page in the URL. During your first use, you could not select the parent page, because your database is empty.
  - Once the page is created, select your template named "home" in your fieldset "Synapse". Then check the box to initialize this template, check if your page is online, and save.

From now, your page is visible at the chosen url, decorated with the created template.
