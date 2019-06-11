DockerCompose-MySQL
mysql -u root -pn_root_pwd -h localhost mysql

 CHANGE MASTER TO 
    -> MASTER_HOST='master',
    -> MASTER_USER='repl_user',
    -> MASTER_PASSWORD='repl_pwd',
    -> GET_MASTER_PUBLIC_KEY=1;
