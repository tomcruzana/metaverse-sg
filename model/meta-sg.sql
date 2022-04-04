#sql data
create database doll_sg_mv_db;
use doll_sg_mv_db;

#admin credentials
create table role_admin (
    id int primary key auto_increment,
    a_username varchar(255) not null unique,
    a_password varchar(255) not null,
    a_isactive boolean default true
);

#add user
insert into role_admin (a_username, a_password) values("admin", "password123");

#avatar player info
create table avatar_player_info (
    id int primary key auto_increment,
    uuid varchar(255) not null unique,
    username varchar(255) not null,
    displayname varchar(255) not null,
    wins int default 0,
    date_joined date not null,
    region varchar(255),
    coordinates varchar(255)
);

#DML queries
select * from role_admin;
select * from avatar_player_info;
