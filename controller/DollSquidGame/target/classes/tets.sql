use user44_db;

SELECT * FROM user44_db.user_names;

create table user_names (
id int primary key auto_increment,
username varchar(255)
);

insert into user_names (username, urole, isactive, usalary, dependents) values("thomas", "se", true, 57000.00, "janeth");
delete from user_names where id=1;

commit;

create table dependents ( 
id int primary key auto_increment, 
dependent varchar(255),
userid int,
FOREIGN KEY (userid) REFERENCES user_names(id)
);
insert into dependents (dependent, userid) values ("janeth", 2);
insert into dependents (dependent, userid) values ("ton ton", 2);
select * from dependents;
drop table dependents;