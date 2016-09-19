# Templates et zones

Les templates sont le cœur de la décoration d'un type de contenu, ce sont eux qui définissent styles, positionnements, habillages et informations à afficher. De même que dans n'importe quelle application Symfony en somme.

Physiquement, les templates sont des fichiers Twig, le moteur de templating inclus nativement dans Symfony. Ils tirent parti des extensions de la librairie pour ajouter des options, en particulier l'inclusion de zones.

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
