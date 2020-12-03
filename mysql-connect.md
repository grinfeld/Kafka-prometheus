Mysql Kafka-Connect debezium
============

Taken from [debezium manual](https://debezium.io/documentation/reference/1.3/connectors/mysql.html#enable-the-mysql-binlog-for-cdc_debezium)

Check if binlog enabled:

    SELECT variable_value as "BINARY LOGGING STATUS (log-bin) ::"
    FROM information_schema.global_variables WHERE variable_name='log_bin';

Enable bin-log (if not enabled yet):

open **/etc/my.cnf**, find or create section **[mysqld]**:

    [mysqld]
    log-bin=mysql-bin.log
    show_compatibility_56 = ON

restart mysql:

    sudo service mysql restart
    
Ensure you have permissions:

    GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'user' IDENTIFIED BY 'password';

After the connector is up - setting its configuration by creating/posting configuration as appears in example below:

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
        "database.history.kafka.topic": "schema-changes.inventory"
        }
    }

[Example of docker](docker-compose-debezium-mysql.yaml). You need to have [kafka, zookeeper](docker-compose-kafkas-light.yml)

Before starting create network:

    docker network create -d bridge kafka