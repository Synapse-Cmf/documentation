# Préambule

First of all, let's start by stating the obvious: today, we develop fewer websites which fit with the historical CMS favour of web app development. These latters are rich in interactions, management rules and interconnections, everything a framework can handle.

Synapse has been developed with one main purpose : being an additional offer in the jungle of the open source content management projects, but business development centred, combining of the best of these two worlds :

 - Owning classic content management modules, prebuilt interfaces, plug-and-play modules, media management...
 - A framework base, allowing implementation of everything you have in PHP, thanks to Symfony.

However, as the old sayings goes "there's no silver bullet" in computing : the compromise on which Synapse is based force it to take no business decision but for the content management. In other words, the work needed to fill up the project is more important. 
Conseqnently: Synapse can fit to the creation of a showcase website, but it will bring no plus-value compared to the other solutions, lighter in installation and exploitation. Nevertheless, if the showcase is just the first step of a bigger project - as a company can do for a multi connected e-commerce website - Synapse is the way to do it.

Let's take time to reconsider a controversial subject, the following statment "I won't reinvent the wheel".
This old saying does not suit to the web of today, it's a fact. Don't reinventing the wheel means we will always check if anyone else has already developed and published a project we are close to begin. We often find it. Very often. At least, we find something slightly different. But once we found it, the wheel can work wrong.But it is neither the mecanician's fault, nor the pilot's. The problem is somewhere else: no wheel can fit to the needs of the pilot.

Today, on the web, successful people are the those who think up, who innovate, who have a efficient and reliable operating system. They need to master their information system. However, each module delivering a business service brings technical debt in the system: if the company innovate, the module will not fit to the need anymore and will be replaced. This is often expensive, furthermore if some dependencies from the rest of the system are involved.
Let's take a step back from this statement : what if not only the wheel, but the whole vehicle which are not invented ? Everything potentially needs to be redone. But, as long as we can drive in city, no issue. Concerning driving on a circuit, there is a step.

It is there Synapse creates value : no wheel is proposed but tools to build your own. It takes time and energ to build a wheel. But this wheel will fit to the driver.

Here we close the"custom vs out-of-the-box" debate.

The second principle is actually a corollary of the former principle : if Synapse is designed to let the developer use their skills, it is obvious that Synapse must offer simple and efficient APIs, middlewares, configs, logs and debug tools. All these notions, called "Developer experience", or DX, are already some of the priorities of the framework Symfony.

Synapse owns a non-intrusive interface with the rest of the project, systematically fostering decoupling, sometimes costing more complexity to stay in the isolation logic, in order to avoid side-effects and intempestive dependencies.

To conclude and sum up previous outlined isseues, Synapse is oriented for "custom" project developers who don't want to be part of the wheel of a whole system. Synapse suits to any projects, particularly to applications with plenty of management rules.
