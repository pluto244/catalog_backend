-- Clear existing data to ensure a clean slate on every run.
-- Order is important due to foreign key constraints.
TRUNCATE TABLE notification, followed_products_of_user, products, users RESTART IDENTITY CASCADE;

-- Insert Users
-- Passwords are 'password' (not hashed due to current app limitations)
INSERT INTO USERS (id, name, email, password, role) VALUES
(1, 'Test User', 'user@example.com', 'password', 'ROLE_USER'),
(2, 'Test Admin', 'admin@example.com', 'password', 'ROLE_ADMIN'),
(3, 'Another User', 'another@example.com', 'password', 'ROLE_USER');

-- Insert Products (owner_id is the foreign key to users table)
INSERT INTO PRODUCTS (id, title, owner_id, status, description, category, email_of_support, link_to_web_site, time_of_last_approval) VALUES
(1, 'Super Widget', 1, 'APPROVED', 'The best widget money can buy.', 'Widgets', 'support@widget.com', 'http://widget.com', NOW()),
(2, 'Pending Gadget', 1, 'ON_MODERATION', 'A gadget that is pending approval.', 'Gadgets', 'support@gadget.com', 'http://gadget.com', NULL),
(3, 'Cool Gizmo', 3, 'APPROVED', 'A very cool gizmo for everyday use.', 'Gizmos', 'support@gizmo.com', 'http://gizmo.com', NOW()),
(4, 'Archived Thing', 3, 'ARCHIVED', 'This thing is no longer available.', 'Things', 'support@thing.com', 'http://thing.com', NOW() - INTERVAL '10 day');

-- User subscriptions (join table for the ManyToMany relationship)
INSERT INTO followed_products_of_user (user_id, followed_product_id) VALUES
(1, 3), -- Test User (id=1) follows Cool Gizmo (id=3)
(3, 1);  -- Another User (id=3) follows Super Widget (id=1) 