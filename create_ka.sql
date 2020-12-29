
--connect to system to create new user. 
CONNECT system/system

CREATE USER ka IDENTIFIED BY ka;
GRANT CONNECT, RESOURCE, CREATE ANY VIEW TO ka;

DISCONNECT system;