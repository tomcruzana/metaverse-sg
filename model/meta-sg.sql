#sql data

#admin credentials
create table role_admin (
    id int primary key auto_increment,
    a_username varchar(255) not null unique,
    a_password varchar(255) not null,
    a_isactive boolean default true
);

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
