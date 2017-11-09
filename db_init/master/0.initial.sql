CREATE USER 'repl_user'@'%' IDENTIFIED BY 'repl_user';
GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%' IDENTIFIED BY 'repl_user';

CREATE USER 'db_user'@'%' IDENTIFIED BY 'db_user';
GRANT ALL PRIVILEGES ON *.* TO 'db_user'@"%" IDENTIFIED BY 'db_user';

FLUSH PRIVILEGES;
