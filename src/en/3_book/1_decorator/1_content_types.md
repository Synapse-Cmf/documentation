# Content types

The content types are an abstraction of each business objects (or entities) of the project using Synapse.

These content types are decorated by the engine with a template. They are not directly modified, they are a simple view created from an object.

The reference of a content type is global to the whole application, via the CmfBundle configuration : 
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

The declared entity class must implement the interface ContentInterface :
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

Please take note that the Doctrine repository must implement an interface too to be referenced :
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

And... It's all, Synapse is now capable of decorting your object News, thanks to a theme.
