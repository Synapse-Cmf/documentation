# Good practices for your Synapse database

## 1. Use a separate database

Synapse tries to be the less intrusive and the as decoupled as possible. It is the same for any data, which have not to create conflict with the database of your business project.

So, We adise you to create a separate database for Synapse. All Synapse needs is a SQL Doctrine compatible database.

Here is an example of configuration to define an independent database for Synapse :

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

## 2.Migrations / deploy ?
How it works ? To be continued... (wip)
