# Compnents

The themes / templates / zones are the interface layer between the content (your business object) and the decoration. They are like a uniform with multiple slots for medals. It's up to you to decorate your uniform with your medals.

In Synaps Cmf, these medals are the components.

In each zone of each template, you can add some components. Each component can be rendered in any zone, from a backend point of view.
From a frontend point of view, it is obvious that a component "menu" can't be rendered like a top bar or a footer. This rendering management is defined in `synapse.yml` of the active theme.

## Activation and built-in component customization in a template
## Activation et personnalisation de composants built-in dans un template

The basic version of Synapse Cmf ([SynapseCmfBundle](../../2_installation_configuration/distributions/1_cmf_bundle.md)) includes 5 components :

  - Text : display a raw text, html text, and images
  - Menu : display a list of links, under a configurable label, with multiple levels
  - Gallery : Display a image gallery from a media library
  - Free : Display a raw text defined in the backoffice.
  - Static : Display a Twig template, selected from the backoffice.

These components must be activated in zones to be added. LEt's take a simple example from the example theme :
```yml
# src/Acme/Bundle/DemoThemeBundle/Resources/config/synapse.yml
synapse:
    acme_demo:
        structure:
            home:
                menu:
                    menu: ~
                body:
                    text: ~
                    gallery: ~
                sidebar:
                    static: ~
                    free: ~
        # ...
```

This configuration activate built-in components in the dedicated zones, rendered in Twig files, defined by default.
The prototypung is finished. Only remains the inclusion of compoenents in the template zones.
The prototyping is finished, now we need to include some components in template zones. Everything is managed from the administration interface. For example, in you Page edition form:
  - Choose te template "home", then the zone "body"
  - Create a new component named "text" via the select box
  - Then, open the form to fill the title and your text and save it
  - Now, open you front page


Inside each theme, Synapse use the default rendering of ntavie components. Obviously, you can custom the rendering by this way :
```yml
# src/Acme/Bundle/DemoThemeBundle/Resources/config/synapse.yml
synapse:
    acme_demo:
        structure :
            # ...

        # ...

        components:
            menu:
                path: "AcmeDemoBundle:Demo:menu.html.twig"
            text:
                path: "AcmeDemoBundle:Demo:text.html.twig"
            gallery
                path: "AcmeDemoBundle:Demo:gallery.html.twig"
            static:
                config:
                    templates:
                        contact: "AcmeDemoBundle:Demo:contact_widget.html.twig"
                        advertising: "AcmeDemoBundle:Demo:advertising.html.twig"
            free: ~
```

Note : Twig files of a component rendering can be achritectured and named as your wish, no black magic here.

Note 2 : all the components have a "config" key, not only the "static" components. (see the [reference of native component configuration (wip)]()).

Override each configuration and create as many twig file as you want to customize your rendering.

By the way, Synapse would not be a framework if it was not possible to create your own components to answer to your specific needs.

## Creation of a custom component

Create your own comopnent is simple. Synapse requires nothing but 3 configuration files.

For the further examples, we will create a component which can display the last news, reading in a Doctrine Orm mapped database.

### Configuration

Each component is declared in the CmfBundle configuration :
```yml
# app/config/config.yml

# ...
synapse_cmf:
    # ...
    components:
        news_list:
            controller: "AcmeAppBundle:News:listComponent"                # specific Symfony style controller reference
            form: Acme\Bundle\AppBundle\Form\Type\NewsListComponentType   # form type FQCN
            template_path: "AcmeAppBundle:Demo:news_list.html.twig"       # default template Symfony style reference
        # ...
```

Then, it must be activated in the themes as a native component :
```yml
# src/Acme/Bundle/DemoThemeBundle/Resources/config/synapse.yml
synapse:
    acme_demo:
        structure :
            home:
                body:
                    news_list: ~
        # ...
```

Then, you need to create 3 files declared in the configurations : the controller, the form and the default Twig file.

### Form type

Synapse creates a nested form tree to let a quick and compelte settting of the whole structure of a template. 
This tree dynamically includes the custom forms required to manage your component data.

In the case of the news list, the final user of the backoffice would add contents, and configure the components, for example. He requires the options :
 - "title", component title
 - "nb_displayed_news", the number of displayed news in the component
 - "read_more_label", the label of the link-button "read more" pointing on the news page

To support this data customization of a component, Synapse requires a definition of a form type (a Symfony notion for the definition of the form elements) for each componenent.

```php
// src/Acme/Bundle/AppBundle/Form/Type/NewsListType.php

namespace Motion\Bundle\AdminBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Validator\Constraints\GreaterThan;
use Synapse\Cmf\Bundle\Form\Type\Framework\Component\DataType;

class NewsListComponentType extends AbstractType
{
    public function getParent()
    {
        return DataType::class;
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('title', TextType::class, array())
            ->add('read_more_label', TextType::class, array())
            ->add('nb_displayed_news', IntegerType::class, array(
                'constraints' => array(new GreaterThan(array('value' => 0))),
            ))
        ;
    }
}
```

All these values matching the form fields are saved with the component, in a variable named `data`. Then, it is possible to fetch these data via the method `$component->getData()`, or only one data with the key and a default value via `$component->getData('nb_displayed_news', 5)`.

### Controller

The componenents are called via the [Symfony sub-requests](http://symfony.com/doc/current/templating/embedding_controllers.html), the component controllers look like classic controllers, with some additions:
```php
// src/Acme/Bundle/AppBundle/Controller/NewsController.php

namespace Acme\Bundle\AppBundle\Controller;

use Synapse\Cmf\Framework\Theme\Component\Model\ComponentInterface;
// ...

class NewsController extends Controller
{
    // ...

    public function listComponentAction(ComponentInterface $component)
    {
        return $this->container->get('synapse')
            ->createDecorator($component)
            ->decorate(array(
                'last_news' => $this->container->get('doctrine')
                    ->getRepository(News::class)
                    ->createQueryBuilder('news')
                        ->orderBy('news.date', 'desc')
                    ->getQuery()
                        ->setMaxResults($component->getData('nb_displayed_news', 5))
                    ->getResult()
            ))
        ;
    }
}
```

In the above example of a controller, we add a list of objects News to the data, from the database via Doctrine, limited by the number of news to display, and defined by the form given in the data of the component, by default 5.

### Template

Once the component is defined, it remains to skin it.

To do that, proceed like any Twig templates included with `{{ include() }}`. Define only the HTML structure, regardless the inheritance.

```html
<section class="news_list_component">
    <h2 class="separator">{{ title }}</h2>
    <div class="news_wrapper">
    {% for news in last_news %}
        <article>
            <h3>
                {{ news.title|capitalize }}
                <span class="lower">{{ news.date|date('d/m/Y') }}</span>
            </h3>
            <p>{{ news.headline }}</p>
        {% if news.body is not empty %}
            <button href="{{ path('acme_news_render', { id: news.id }) }}">
                {{ read_more_label }}
            </button>
        {% endif %}
        </article>
    {% endfor %}
    </div>
</section>
```

Some tips:

 - All the input "data" in the form of the component are reachable in the template
 - You can access to sent variables via the method `decorate()` of the Synapse decorator
 - The object `app` of Symfony, you can access to the standard Twig options and your possible additions

## Last word

That's it, you now know how to use the main features of Synapse Cmf !
Many features, configurations and models of implementation was not presented, but the purpose was elsewhere : help you to start a synapse project by fastly displaying a screen.

All the non detailed components will be developed in the [Cookbook]() in the course of writing. Do not hesitate to come back later !

Thank you for reading, we hope that Synapse can fill your technical needs the most advanced !
