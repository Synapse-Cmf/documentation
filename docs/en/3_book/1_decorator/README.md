# Decorator

The main 5 notions to start a decoration of a content are the following :

 - **Content types** : abstraction of the business object of your project, a basic object around which the decoration engine will build the template. 
 - **Themes* : namespace of the Synapse elements, each underlying element is always referenced inside a theme. Physically, it correspond to the Symfony bundle which declares the theme of the templates, mainly your front application bundle.  
 - **Templates** : layout, core of the decorator pattern. It is usually the Twig template where the content will be rendered, and it is structured by zones.
 - **Zones** : zones in a template, declared via tags similar to Twig blocks, and in which it is possible to add and render the components.
 - **Components** : element of content decoration, added in a zone and owner of the available data in a render context.

These elements are typed. These types are created from the theme configuration and the theme prototyping. They provide information concerning the template rendering, like the Twig template to call, the default configuration, the allowed components for a zone, image format etc. 

The prototyping of these elements allows a big flexibility of the model and the rendering engine of Synapse, without writing a php line : the front-end developers can take back their right on the setting of their rendering, and controle the whole process of content decoration.

For the following examples of this documentation, we will use the following objects :

 - The object **Page**, from the PageBundle
 - A custom object **News**, with the fields :
   - Title
   - Date
   - Headline
   - Body

We consider that the database managed by Doctrine is initialized to manage the News objects.
