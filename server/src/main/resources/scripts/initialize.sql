INSERT INTO app_roles VALUES (1,'SUPER_ADMIN'),(2,'ROLE_ADMIN'),(3,'ROLE_USER');

INSERT INTO app_users VALUES (1,'superadmin@gmail.com','superdami','$2a$14$gpB/H4MkpMqrPEBDuZDrc.s6p3EUL1GCmuO8bu8Yj3nG1VkAFHU0W');
INSERT INTO app_users VALUES (2,'admin@gmail.com','dami','$2a$14$gpB/H4MkpMqrPEBDuZDrc.s6p3EUL1GCmuO8bu8Yj3nG1VkAFHU0W');
INSERT INTO app_users VALUES (3,'dami@gmail.com','zwklydami','$2a$14$gpB/H4MkpMqrPEBDuZDrc.s6p3EUL1GCmuO8bu8Yj3nG1VkAFHU0W');

INSERT INTO user_roles VALUES (1,1);
INSERT INTO user_roles VALUES (2,1);
INSERT INTO user_roles VALUES (3,1);
INSERT INTO user_roles VALUES (2,2);
INSERT INTO user_roles VALUES (3,2);
INSERT INTO user_roles VALUES (3,3);