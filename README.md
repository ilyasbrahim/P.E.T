# Project: Install MariaDB

## Description
This project provides instructions for installing MariaDB, a popular open-source relational database management system. By following these steps, you can set up MariaDB on your system and secure it to ensure the safety of your database environment.

## Installation Instructions

### Step 1: Download MariaDB
- Visit the [official website](https://mariadb.org/download/) to download the latest version of MariaDB.
- Depending on your operating system, follow the appropriate installation instructions.

### Step 2: Install MariaDB
- For Ubuntu users, open a terminal and run the following commands:
    ```bash
    sudo apt update
    sudo apt install mariadb-server
    ```

### Step 3: Secure your Installation
- MariaDB provides a script called `mysql_secure_installation` to secure your installation. Run the script by typing the following command in your terminal:
    ```bash
    sudo mysql_secure_installation
    ```
- Follow the prompts to set a root password, remove anonymous users, disable remote root login, and remove test databases.

### Step 4: Create a New User
- It's recommended to create a new user with limited privileges instead of using the root user. Run the following commands in your terminal:
    ```bash
    sudo mysql
    ```
    ```sql
    CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';
    FLUSH PRIVILEGES;
    ```
    Replace `'newuser'` with the desired username and `'password'` with a strong password.

### Step 5: Configure Firewall
- To enhance security, configure your firewall to only allow incoming traffic from trusted sources. Use the following commands:
    ```bash
    sudo ufw allow from trusted_ip_address to any port 3306
    sudo ufw enable
    ```
    Replace `trusted_ip_address` with the IP address of the trusted source.

## Conclusion
Congratulations! You have successfully installed MariaDB and set up a secure environment for your database server. You can now start using MariaDB to manage your databases efficiently. If you encounter any issues or need further assistance, refer to the MariaDB documentation or seek help from the community.
