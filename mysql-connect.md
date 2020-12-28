Mysql Kafka-Connect debezium
============

Taken from [debezium manual](https://debezium.io/documentation/reference/1.3/connectors/mysql.html#enable-the-mysql-binlog-for-cdc_debezium)

Check if binlog enabled:

    SELECT variable_value as "BINARY LOGGING STATUS (log-bin) ::"
    FROM information_schema.global_variables WHERE variable_name='log_bin';

Enable bin-log (if not enabled yet):

Connect to mysql docker (**docker ps**)

    docker -f docker-compose-debezium-mysql.yaml exec -it dockerId /bin/bash

open for edit (you'll need to install **vim** for the container used in this docker `apt-get update && apt-get install -y vim`) **/etc/mysql/my.cnf**, find or create section **[mysqld]**:

    [mysqld]
    log-bin=mysql-bin.log
    show_compatibility_56 = ON

restart mysql:

    sudo service mysql restart
    
Ensure you have permissions:

    GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'user' IDENTIFIED BY 'password';

After the connector is up - set its configuration by creating/posting configuration as appears in example below:

    {
    "name": "inventory-connector",
        "config": {
            "connector.class": "io.debezium.connector.mysql.MySqlConnector",
            "tasks.max": "1",
            "database.hostname": "mysql-1",
            "database.port": "3306",
            "database.user": "mysqluser",
            "database.password": "mysqlpw",
            "database.server.id": "184054",
            "database.server.name": "stamname",
            "database.whitelist": "inventory",
            "database.history.kafka.bootstrap.servers": "kafka-1:9092",
            "database.history.kafka.topic": "schema-changes.inventory",
            "snapshot.mode": "when_needed",
            "table.include.list": "inventory.customers,inventory.addresses,inventory.geom,inventory.orders,inventory.products"
        }
    }

* Note: "snapshot.mode" defines the behaviour of connect when it starts. The default value is "initial", means connect makes snapshot only once when it starts the first time. The "when_needed" - it creates snapshot every time when some problem exists, like expired offsets, values and so on.

[Here](docker-compose-debezium-mysql.yaml) example with docker-compose. You need to have kafka, zookeeper, so [here](docker-compose-kafkas-light.yml) docker-compose file with kafka and so on.

Before starting create network:

    docker network create -d bridge kafka

During initial fist time start up, connector will take the current snapshot of data, populate relevant kafka topic (according to connector configuration - by default table name), 
and every time we made change on selected tables, it will send the update to appropriate kafka topic.

* Note: For globalStore, seems we need some intermediate topic, since querying globalState created from original CDC topic (with its complex structure) cause globalStore to be non-queryable.

