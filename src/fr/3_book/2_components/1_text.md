# Composant "Texte"

Le composant texte permet d'afficher un texte saisi par l'utilisateur en mode "riche" (via CKEditor), ou en "brut", aggrémenté d'images.

D'autres champs sont disponibles, tels qu'un titre, une accroche ou des liens.

## Définition

Le composant texte est défini dans la configuration par défaut de SynapseCmfBundle, sous la clé "text".

Si il n'est pas nécessaire, il est possible de ne pas l'inclure via la configuration suivante
```yml
# config.yml
synapse_cmf:
    components:
        text: ~
```

## Intégration dans un thème

Le composant texte présente des configurations à surcharger selon les besoins de thème qui l'utilise.

```yml
# src/Path/to/ThemeBundle/Resource/config/synapse.yml
synapse:
  my_theme:
    # ...
    components:
      text:
        path: 'PathtoThemeBundle:xxxx:text.html.twig'  # Symfony style template path for this component
        config:
          headline: false       # Activate "headline" field
          html: false           # Activate rich editor or not
          ckeditor_config: []   # CKEditor configuration, useless if html option is disabled
          read_more: false      # Activate read more links, as a link and a label into form
          images:               # "~" to disable images into text component
            multiple: false     # Enable multi-image selection
            format: "16/9"      # Image format used in this component template
```

_*NB*_: Toutes les configurations du composant texte supportent les variations.

## Template

Le composant texte expose toutes ses données, sa configuration compilée et le contenu courant au template.

Dans le détail :
```html
<!-- System vars -->
{{ config }}   # all compiled configurations from current theme / template / zone
{{ content }}  # current displayed content object

<!-- Component vars -->
{{ title }}      # component form title
{{ text }}       # component form text, use "|raw" filter if html is allowed
{{ headline }}   # component form headline, only defined if headline is allowed
{{ images }}     # component form selected images, as Synapse image objects, could be empty
{{ image }}      # shortcut to first image into collection, if only one image is allowed
{{ link }}       # url of "read more" link, if read more is allowed
{{ link_label }} # label of "read more" link, if read more is allowed
```

### Exemple

```html
<!-- PathtoThemeBundle/Resources/views/xxxx/text.html.twig -->
<article>
  <h3>{{ title|humanize }}</h3>
{% if config.headline is not empty and headline is not empty %}
  <p class="headline">{{ headline|capitalize }}</p>
{% endif %}
  <p>{{ config.html is empty ? html : html|raw }}</p>
{% if config.image is not empty %}
  <p class="gallery">
  {% if config.image.multiple is empty and image is not empty %}
    <img src="{{ asset(image.formatWebPath()) }}" title="{{ image.title }}" alt="{{ image.alt }}"/>
  {% else %}
    {% for image in images %}
      <img src="{{ asset(image.formatWebPath()) }}" title="{{ image.title }}" alt="{{ image.alt }}"/>
    {% endfor %}
  {% endif %}
  </p>
{% endif %}
{% if config.read_more is not empty and link is not empty %}
  <p class="links">
    <a href="{{ link }}">{{ link_label }}</a>
  </p>
{% endif %}
</article>
```
