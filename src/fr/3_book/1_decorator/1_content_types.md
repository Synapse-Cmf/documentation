# Types de contenus

Les types de contenus sont une abstraction de chacun des objets métiers (ou entités) du projet utilisant Synapse.

Ce sont eux qui sont décorés par le moteur à l'aide d'un template; ils ne sont pas modifiés directement, ce sont des vues qui sont créées autour de l'objet.

La référence d'un type de content est globale pour toute l'application, via la configuration du CmfBundle :
```yml
# app/config/config.yml

synapse_cmf:
    content_types:
        Synapse\Page\Bundle\Entity\Page:      # Synapse built-in page content type
            alias: page
            provider: synapse.page.loader
        Acme\Bundle\AppBundle\Entity\News:    # Custom content type
            alias: news
            provider: acme.news.repository
```

La classe de l'entité déclacrée doit implémenter l'interface ContentInterface :
```php
// src/Acme/Bundle/AppBundle/Entity/News.php

use Synapse\Cmf\Framework\Theme\Content\Model\ContentInterface;

class News implements ContentInterface
{
    protected $id;

    public function getId()
    {
        return $this->id;
    }

    /**
     * @see ContentInterface::getContentId()
     */
    public function getContentId()
    {
        return $this->getId();
    }
}

```

Notez bien que le repository Doctrine doit également implémenter une interface pour pouvoir être référencé :
```php
// src/Acme/Bundle/AppBundle/Repository/NewsOrmRepository.php

use Doctrine\ORM\EntityRepository;
use Synapse\Cmf\Framework\Theme\Content\Provider\ContentProviderInterface;

class NewsRepository extends EntityRepository implements ContentProviderInterface
{
    // ....

    /**
     * @see ContentProviderInterface::retrieveContent()
     */
    public function retrieveContent($contentId)
    {
        return $this->find($contentId);
    }
}
```

Et c'est tout, Synapse est maintenant capable de décorer notre objet News, grâce à un thème.
