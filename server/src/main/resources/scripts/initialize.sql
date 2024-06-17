INSERT INTO app_roles VALUES (1,'SUPER_ADMIN'),(2,'ADMIN'),(3,'USER');

INSERT INTO app_users VALUES (1,'superadmin@gmail.com','superdami','$2a$14$gpB/H4MkpMqrPEBDuZDrc.s6p3EUL1GCmuO8bu8Yj3nG1VkAFHU0W');
INSERT INTO app_users VALUES (2,'admin@gmail.com','dami','$2a$14$gpB/H4MkpMqrPEBDuZDrc.s6p3EUL1GCmuO8bu8Yj3nG1VkAFHU0W');
INSERT INTO app_users VALUES (3,'dami@gmail.com','zwyklydami','$2a$14$gpB/H4MkpMqrPEBDuZDrc.s6p3EUL1GCmuO8bu8Yj3nG1VkAFHU0W');

insert into monument_pois values (51.110981479712436,17.034813759782907,421,'Monument1','Monument1','');
insert into monument_pois values (51.110550392125845,17.01781928358599,521,'Monument2','Monument2','');
insert into monument_pois values (51.114645561843766,17.055584786245806,621,'Monument3','Monument3','');

INSERT INTO user_roles VALUES (1,1);
INSERT INTO user_roles VALUES (2,2);
INSERT INTO user_roles VALUES (3,2);
INSERT INTO user_roles VALUES (3,3);