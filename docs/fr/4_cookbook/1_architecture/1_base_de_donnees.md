# Bonnes pratiques pour votre base de données Synapse

## 1. Utilisez une base séparée

Synapse essaye d'être le moins intrusif et le plus découplé possible. Cela va de pair avec toutes ses données, qui ne doivent polluer ou rentrer en conflit avec la base de données de votre projet métier.

Nous vous conseillons donc d'utiliser une base séparée pour synapse. Tout ce dont a besoin synapse est d'une base SQL compatible avec Doctrine.

Voici un exemple de configuration pour définir une base indépendante pour Synapse :

```yml
# app/config/config.yml

# Doctrine Configuration
doctrine:
    dbal:
        connections:
            default:
                # default connection here
            synapse:
                driver:   "%synapse_database_driver%"
                host:     "%synapse_database_host%"
                port:     "%synapse_database_port%"
                dbname:   "%synapse_database_name%"
                user:     "%synapse_database_user%"
                password: "%synapse_database_password%"
                charset:  UTF8
    orm:
        auto_generate_proxy_classes: "%kernel.debug%"
        default_entity_manager: default
        entity_managers:
            synapse: ~
            default:
                # default em configuration

# app/config/parameters.yml
parameters:
    # ...
    synapse_database_driver: pdo_mysql
    synapse_database_host: your_host
    synapse_database_port: your_port
    synapse_database_name: synapse
    synapse_database_user: your_user
    synapse_database_password: your_password
```

## 2.Migrations / déploiement ?
Comment ça marche ?
