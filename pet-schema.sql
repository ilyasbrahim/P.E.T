CREATE TABLE IF NOT EXISTS Grupp(
    group_id int auto_increment not null,
    group_name varchar(65) unique not null,
    date_created date default current_timestamp,

    primary key(group_id)
);

CREATE TABLE IF NOT EXISTS Roles(
    id int auto_increment not null,
    role_name varchar(55) not null,

    primary key(id)
);

CREATE TABLE IF NOT EXISTS Stores(
    store_id int auto_increment,
    store_name varchar(50) not null,

    primary key(store_id)
);

CREATE TABLE IF NOT EXISTS Address(
    address_id int auto_increment not null,
    street_address varchar(70) not null,
    zip_code varchar(25) not null,
    city varchar(50) not null,
    country varchar(50) not null,

    primary key(address_id)
);

CREATE TABLE IF NOT EXISTS Users(
    user_id int auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    age int not null,
    email varchar(50) unique not null,
    password varchar(50) not null,
    date_registered date default current_timestamp,

    primary key(user_id)
);

CREATE TABLE IF NOT EXISTS UserAddress(
    id int not null auto_increment,
    user_id int not null,
    address_id int not null,

    primary key(id),
    CONSTRAINT user_FK FOREIGN KEY(user_id) REFERENCES Users(user_id),
    CONSTRAINT user_address_FK FOREIGN KEY(address_id) REFERENCES Address(address_id)
);

CREATE TABLE IF NOT EXISTS StoreAddress(
    id int not null auto_increment,
    store_id int not null,
    address_id int not null,

    primary key(id),
    CONSTRAINT store_id_FK FOREIGN KEY(store_id) REFERENCES Stores(store_id),
    CONSTRAINT store_address_FK FOREIGN KEY(address_id) REFERENCES Address(address_id)
);

CREATE TABLE IF NOT EXISTS InventoryList(
    inventory_id int auto_increment not null,
    store_id int not null,

    primary key(inventory_id),
    CONSTRAINT FK_store_id foreign key(store_id) REFERENCES Stores(store_id)
);

CREATE TABLE IF NOT EXISTS Products(
   product_id BINARY(16) PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   description TEXT
);

CREATE TABLE IF NOT EXISTS ProductInventory(
    id INT NOT NULL auto_increment PRIMARY KEY,
    quantity INT NOT NULL,
    inventory_id INT NOT NULL,
    product_id BINARY(16) NOT NULL,
    last_updated DATETIME DEFAULT current_timestamp,

    CONSTRAINT inventory_id_FK FOREIGN KEY(inventory_id) REFERENCES InventoryList(inventory_id),
    CONSTRAINT FK_product FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

CREATE TABLE IF NOT EXISTS OrderStatus(
    status_id int auto_increment not null,
    status enum('submitted', 'packing', 'ready to ship', 'shipped', 'cancelled'),
    primary key(status_id)
);


CREATE TABLE IF NOT EXISTS Orders(
    order_id int auto_increment,
    user_id int not null,
    total_amount int not null,
    store_id int not null,
    order_status int not null,
    order_date date default current_timestamp,

    primary key(order_id),
    CONSTRAINT FK_order_status foreign key(order_status) REFERENCES OrderStatus(status_id),
    CONSTRAINT FK_user_id_Orders foreign key(user_id) REFERENCES Users(user_id),
    CONSTRAINT store_FK foreign key(store_id) REFERENCES Stores(store_id)
);

CREATE TABLE IF NOT EXISTS Messages(
    message_id int auto_increment, 
    sender_id int not null,
    message_body  text not null,
    date_sent datetime default current_timestamp,

    primary key(message_id),
    CONSTRAINT FK_user_id_messages foreign key(sender_id) REFERENCES Users(user_id)
 );


CREATE TABLE IF NOT EXISTS MessageRecipientList(
    id int auto_increment,
    recipient_id int not null,
    message_id int not null,

    primary key(id),
    CONSTRAINT FK_recipient foreign key(recipient_id) REFERENCES Users(user_id),
    CONSTRAINT FK_message_id foreign key(message_id) REFERENCES Messages(message_id)
);

CREATE TABLE IF NOT EXISTS UserGroup(
    id int auto_increment not null,
    group_id int not null,
    user_id int not null,

    primary key(id),
    CONSTRAINT FK_group_id foreign key(group_id) REFERENCES Grupp(group_id),
    CONSTRAINT FK_user_id foreign key(user_id) REFERENCES Users(user_id)
);

CREATE TABLE IF NOT EXISTS UserRolesList(
    id int auto_increment not null,
    role_id int not null,
    user_id int not null,

    primary key(id),
    CONSTRAINT FK_role_id foreign key(role_id) REFERENCES Roles(id),
    CONSTRAINT FK_user foreign key(user_id) REFERENCES Users(user_id)
);

CREATE TABLE IF NOT EXISTS OrderItems(
    id int auto_increment not null,
    order_id int not null,
    product_id BINARY(16) not null,

    primary key(id),
    CONSTRAINT order_id_FK foreign key(order_id) REFERENCES Orders(order_id),
    CONSTRAINT product_id_FK foreign key(product_id) REFERENCES Products(product_id)
);

CREATE TABLE IF NOT EXISTS GroupPosts(
    id int auto_increment,
    post text not null,
    recipient_group int not null,
    date_sent datetime default current_timestamp,

    primary key(id),
    CONSTRAINT group_id_FK foreign key(recipient_group) REFERENCES Grupp(group_id)
);



DELIMITER $$
CREATE TRIGGER RoleLimit 
BEFORE INSERT
ON UserRolesList
FOR EACH ROW
BEGIN
   DECLARE role_qty BIGINT;
   SELECT COUNT(*) AS qty
     FROM UserRolesList usr
    WHERE usr.user_id = NEW.user_id
     INTO role_qty;
     
   -- if user already have 3 entries, send error
   IF role_qty >= 3 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Users can only have up to three different roles';
   END IF;
END$$
DELIMITER ;
