# Composants
Les thèmes / templates / zones sont la couche d'interface entre le contenu (votre objet métier), et la décoration. Ils sont l'équivalent de diverses accroches (velcro, boutons pressions etc...) fixés sur un uniforme à divers endroits. Sur chaque accroche, il est possible de fixer des badges, grades etc... Comme des composants dans les zones.

Dans chaque zone de chaque template, il est possible d'en ajouter, tout composant pouvant être rendu de manière indifférenciée dans n'importe quelle zone. D'un point de vue back ! Côté front, il est évident qu'un composant menu ne se rendra pas de la même manière dans une top bar et dans un footer. Cette gestion du rendu se passe dans le fichier synapse.yml du thème actif.

## Activation et personnalisation de composants built-in dans un template

La version de base de Synapse Cmf ([SynapseCmfBundle](../../2_installation_configuration/distributions/1_cmf_bundle.md)) inclue cinq composants :

  - Texte : affiche du texte, brut ou html, et des images.
  - Menu : affiche une liste de liens, sous un label paramétrable, sur plusieurs niveaux
  - Gallerie : affiche une galerie d'images, à partir de la médiathèque
  - Libre : affiche le texte brut saisi dans le back office
  - Statique : affiche un template Twig, sélectionné en back office

Ces composants doivent être activés dans des zones pour pouvoir être ajoutés. Prenons un exemple simple à partir du thème d'exemple :
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

Cette configuration active les composants built-in dans les zones dédiées, rendus dans les fichiers Twig définis par défaut.
Le prototypage terminé, il ne reste plus qu'à inclure des composants dans les zones des templates. Tout se passe dans l'interface d'administration, prenons exemple avec les Pages; dans votre formulaire d'édition de Page :

  - choisissez le template "home", puis la zone "body"
  - créez un nouveau composant "texte" via la select box
  - ouvrez ensuite le formulaire pour entrer votre titre et votre texte, puis sauvegardez
  - rendez vous sur votre page côté front

Le rendu est celui par défaut des composants natifs, au sein de chaque thème, il est bien entendu possible de modifier leur rendu, comme suit :
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

Note : les fichiers Twig de rendu des composants peuvent être architecturés et nommés comme bon vous semble, aucune sombre magie n'est à l'oeuvre à partir du système de fichier.

Note 2 : tous les composants disposent d'une clé "config", pas seulement le composant "static", voir la [référence de la configuration des composants natifs (wip)]().

Surchargez chaque configuration et créez autant de fichiers Twig que vous souhaitez pour personnaliser votre rendu.

Mais Synapse ne serait pas un framework s'il n'était pas possible de créer vos propres composants, pour répondre à vos besoins spécifiques.

## Création d'un composant personnalisé

Créer son propre composant est somme toute assez simple, Synapse ne requiert que trois fichiers et une configuration.

Pour les prochains exemples, nous allons créer un composant capable d'afficher les dernières news, en lisant dans une base mappée via Doctrine Orm.

### Configuration

Chaque composant se déclare dans la configuration du CmfBundle :
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

Puis s'active dans les thèmes comme un composant natif :
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

Les trois fichiers à créer ensuite sont les fichiers pointés par les configurations : le controller, le formulaire et le fichier Twig de rendu par défaut.

### Form type

Synapse génère un arbre de formulaires imbriqués pour permettre un paramétrage rapide et complet de toute la structure d'un template.
Cette arbre permet d'inclure dynamiquement des formulaires personnalisés, pour la saisie des données des composants.

Dans le cas de notre liste de news, l'utilisateur final du back office voudra par exemple saisir des contenus, et configurer le composant; il faudra donc lui mettre à disposition les options :

 - "title", le titre du composant
 - "nb_displayed_news", le nombre de news à afficher dans le composant
 - "read_more_label", le libellé des boutons-lien "En savoir plus" vers la page news

Pour supporter cette personnalisation des données des composants, Synapse attend donc qu'un form type (notion Symfony pour la définition des éléments de formulaires) soit défini pour chaque composant.
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

Les valeurs correspondant aux champs du formulaire sont toutes enregistrées avec le composant, dans une variable nommée `data`. Il est ensuite possible de récupérer ces données via la méthode `$component->getData()`, ou alors juste une clé avec une valeur par défaut via `$component->getData('nb_displayed_news', 5)`.

### Controller

Les composants sont appelés via les [sub-requests de Symfony](http://symfony.com/doc/current/templating/embedding_controllers.html), les controlleurs de composants ont donc la forme d'un controlleur classique, avec quelques adjonctions :
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

Dans l'exemple de controller ci-dessus, on rajoute aux données du template une liste d'objets News, tirée de la base via Doctrine, limité par le nombre de de news à afficher, définis par le formulaire dans les données du composant, 5 par défaut.

### Template

Une fois le composant définis, il reste à l'habiller.

Pour ce faire, procédez comme n'importe quel template Twig inclu via `{{ include() }}`, définissez seulement la structure HTML, sans vous soucier d'héritage.

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

Plusieurs points à noter :

 - Toutes les "data" saisies dans le formulaire du composant sont accessibles dans le template
 - Sont également accessibles toutes les variables envoyées via la méthode `decorate()` du décorateur Synapse
 - L'objet `app` de Symfony, toutes les options Twig standards et vos éventuels ajouts sont disponibles

## Mot de la fin

Ca y est, vous savez vous servir des fonctionnalités principales de Synapse Cmf !
Nombre de fonctionnalités, configurations et de modèles d'implémentation ne vous ont pas été présentées, mais le but était ailleurs : vous aider à rentrer dans Synapse en affichant rapidement un écran.

Tous les éléments non détaillés seront développés dans le [Cookbook]() en cours de rédaction. N'hésitez pas à revenir !

Merci pour votre lecture, en espérant que Synapse puisse combler vos attentes techniques les plus avancées !
