CREATE DATABASE IF NOT EXISTS db_test;

USE db_test;

CREATE TABLE t_users (
   userId INT AUTO_INCREMENT,
   useUsername VARCHAR(50) NOT NULL,
   usePassword VARCHAR(400) NOT NULL,
   useRole VARCHAR(50)NULL,
   useSalt VARCHAR(400) NOT NULL,
   PRIMARY KEY (userId)
);


INSERT INTO t_users (useUsername, usePassword, useRole, useSalt) VALUES ('etml', '258912b7f291d7b5bc32c21618d658473aec00ce85670bf217cf125b002ff377', 'superadmin', 'aHAjZx9bffU5');


