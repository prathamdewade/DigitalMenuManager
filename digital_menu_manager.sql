-- Create Database
CREATE DATABASE IF NOT EXISTS digital_menu_manager;
USE digital_menu_manager;

-- Table for categories
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- Table for menu items
CREATE TABLE menu_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    category_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Insert seed data into categories
INSERT INTO categories (name, description) VALUES
('Starters', 'Appetizers and starters'),
('Main Course', 'Main dishes'),
('Desserts', 'Sweet dishes');

-- Insert seed data into menu_items
INSERT INTO menu_items (name, description, category_id, price) VALUES
('Spring Rolls', 'Crispy veg spring rolls', 1, 4.50),
('Grilled Chicken', 'Spicy grilled chicken', 2, 9.99);
