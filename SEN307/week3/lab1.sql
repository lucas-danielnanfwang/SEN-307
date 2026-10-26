mysql> create database Daniel;
Query OK, 1 row affected (0.260 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| Daniel            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.026 sec)

mysql> CREATE DATABASE sen307_11431;
Query OK, 1 row affected (0.255 sec)

mysql> USE sen307_11431;
Database changed
mysql> SELECT DATABASE();
+--------------+
| DATABASE()   |
+--------------+
| sen307_11431 |
+--------------+
1 row in set (0.007 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| Daniel           |
| information_schema |
| mysql              |
| performance_schema |
| sen307_11431       |
| sys                |
+--------------------+
6 rows in set (0.015 sec)

mysql> SELECT VERSION();
+-----------+
| VERSION() |
+-----------+
| 26.7.0    |
+-----------+
1 row in set (0.009 sec)

mysql> SELECT CURRENT_USER();
+----------------+
| CURRENT_USER() |
+----------------+
| root@localhost |
+----------------+
1 row in set (0.007 sec)

mysql> SELECT NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2026-10-19 15:05:14 |
+---------------------+
1 row in set (0.007 sec)

mysql> STATUS;
--------------
mysql  Ver 26.7.0 for Win64 on x86_64 (MySQL Community Server - GPL)

Connection id:          10
Current database:       sen307_11431
Current user:           root@localhost
SSL:                    Cipher in use is TLS_AES_128_GCM_SHA256
Using delimiter:        ;
Server version:         26.7.0 MySQL Community Server - GPL
Protocol version:       10
Connection:             localhost via TCP/IP
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    cp850
Conn.  characterset:    cp850
TCP port:               3306
Binary data as:         Hexadecimal
Uptime:                 18 min 23 sec

Threads: 8  Questions: 117  Slow queries: 0  Opens: 308  Flush tables: 3  Open tables: 227  Queries per second avg: 0.106
--------------

mysql> SHOW VARIABLES LIKE "port" ;
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| port          | 3306  |
+---------------+-------+
1 row in set (0.068 sec)

mysql> SHOW TABLES;
Empty set (0.032 sec)
