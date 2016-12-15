# Architecture and bias

Let's go into further details : how Synapse allows to have a strong content management without strong coupling ?
Firstly, it is thanks to the two popular design patterns, particularly in Symfony : Deorator (Templating component) and Prototype (Form component). 
On the other hand, it is thanks to a SOLID based design, especially the mastery of object dependencies.

The Synapse model is built from these two design patterns, detailled in the next rubrics.


## Decoration and inversion of control

As previously described, Synapse is non-intrusive for the project which includes it.
To that end, an inversion of control is implemented between business objects and  the Synapse model, through the notion of __content type__.

Traditionnally, when it is possible to implement custom models, it results to hard code the include of the librarie in the business model,  either by abstract class / inheritance, or by composition. In both cases, the business model is hardly linked to the librarie : dedicated methods are implemented, thereby the architecture include a constrainst.

Synapse take the counter of these habits by throwing off the strong bond with the business object : it will never directly take action, it just decorate the object through its own model. The decorated object must just implement the interface, and be referenced in a configuration (refer to [content type configuration](../2_installation_configuration/distributions/1_cmf_bundle.md)).

Then, it is possible to decorate any business object thanks to Synapse without corrupt its software entity, from the simple web page (like in the [PageBundle](../2_installation_configuration/distributions/3_page_bundle.md) disctribution), to an press article, going through e-commerce products with plenty of fields and/or dependencies.

## Render prototyping

The DX (Developer eXperience) come from a task sharing between coworkers too. The frameworks let each person work efficientely on his task. 

In a standard team organisation, containing designers, web integrators and backend developers, mockups are designed by the design team, then integrated in HTML/CSS (and more) by frontend team, and finally "brought to life" by the backend team.

Synapse allows the team to simplify the process by setting up a prototyping of the rendering of content types through simple configuration file, formatted in Yaml.

So, the workflow becomes :

 - The designer produces the mockups for the layouts. Then, he initializes the description file of the theme by state each template, zones and components and sometimes, see the [reference]().
 - The web integrator receives the mockups and the configuration files, and creates the corresponding Twig files, then refrences them in the configuration file.
 - The backend developer creates the needed components to display the dynamics data in the integrated prototypes.

This prototyping gives to the team more flexibility to work in parallel than the classic system, bacause it leads to a decoupling. In detail :
 
 - The designer does not need to create mockups for all website pages. He don't even need to design the whole site before the start of the development.
 - The frontend developer the latitude to design his technical ways involved by the design needs, (eg. file slicing, Twig extensions and Twig includes, responsive and adaptive design).
 - The backend developer just needs to implement the template structure, to expose needed data to the frontend developer. Moreover, he needs to handle with the data access, forms implementations...

From a macroscopic view, thanks to the prototyping, the team will be able to change a whol theme without involving a heavy backend development, as long as the data and component configurations stand still. 
