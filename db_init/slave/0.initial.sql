CREATE USER 'db_user'@'%' IDENTIFIED BY 'db_user';
GRANT SELECT ON *.* TO 'db_user'@"%" IDENTIFIED BY 'db_user';

FLUSH PRIVILEGES;
