-- get all addresses for a specefic user

SELECT Address.*
FROM UserAddress
JOIN Address ON UserAddress.address_id = Address.address_id
WHERE UserAddress.user_id = 14;


-- get an address for a specefic store

SELECT Address.*
FROM StoreAddress
JOIN Address ON StoreAddress.address_id = Address.address_id
WHERE StoreAddress.store_id = 11;


-- get the inventories for a specefic store

SELECT InventoryList.inventory_id, Stores.store_name
FROM InventoryList
JOIN Stores ON InventoryList.store_id = Stores.store_id
WHERE InventoryList.store_id = 3;


-- get the store that sells the product and the inventory where it can be found 

SELECT Stores.store_name, InventoryList.inventory_id
FROM Products
JOIN ProductInventory ON Products.product_id = ProductInventory.product_id
JOIN InventoryList ON ProductInventory.inventory_id = InventoryList.inventory_id
JOIN Stores ON InventoryList.store_id = Stores.store_id
WHERE Products.product_id = 18;


-- get the status for all orders by a user

SELECT Users.user_id, Orders.order_id, OrderStatus.status
FROM Orders
JOIN OrderStatus ON Orders.order_status = OrderStatus.status_id
JOIN Users ON Orders.user_id = Users.user_id
WHERE Orders.user_id = 25;


-- get all messages sent by a user

SELECT * FROM Messages WHERE sender_id = 38;


-- get all messages recieved by a user

SELECT Messages.message_id, Messages.sender_id, Messages.message_body, Messages.date_sent 
FROM Messages 
JOIN MessageRecipientList ON Messages.message_id = MessageRecipientList.message_id 
WHERE MessageRecipientList.recipient_id = 19;


-- get all users in a group 

SELECT UserGroup.group_id, Users.first_name, Users.last_name
FROM UserGroup
JOIN Users ON UserGroup.user_id = Users.user_id
WHERE UserGroup.group_id = 10;


-- get all groups a user belongs to 

SELECT UserGroup.group_id, Grupp.group_name
FROM UserGroup
JOIN Grupp ON UserGroup.group_id = Grupp.group_id
WHERE UserGroup.user_id = 2;


-- get all users with a specefic role 
SELECT  Roles.role_name, Users.first_name, Users.last_name
FROM Users
JOIN UserRolesList ON Users.user_id = UserRolesList.user_id
JOIN Roles ON UserRolesList.role_id = Roles.id
WHERE UserRolesList.role_id = 2;

SELECT Roles.role_name, Users.first_name, Users.last_name
FROM Users
JOIN UserRolesList ON Users.user_id = UserRolesList.user_id
JOIN Roles ON UserRolesList.role_id = Roles.id
WHERE Roles.role_name = 'manager';


-- get all posts in a group 

SELECT post
FROM GroupPosts
WHERE recipient_group = 13;

