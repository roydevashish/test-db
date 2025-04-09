-- Create the following tables:
-- Table: Sales_master
CREATE TABLE sales_master(
    salesman_no VARCHAR(7) PRIMARY KEY, CHECK(salesman_no LIKE 'S%'),
    salesman_name VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    city VARCHAR(20),
    state VARCHAR(20),
    pincode NUMERIC(6),
    sales_amt NUMERIC(8,2) NOT NULL, CHECK(sales_amt > 0),
    tgt_to_get NUMERIC(6,2) NOT NULL, CHECK(tgt_to_get > 0),
    ytd_sales NUMERIC(6,2) NOT NULL, CHECK(ytd_sales > 0),
    remarks VARCHAR(30)
)

-- Table: Sales_order
-- Alter the table client_master to set the column client_no to primary key
ALTER TABLE client_master ALTER COLUMN client_no VARCHAR(6) NOT NULL
ALTER TABLE client_master ADD PRIMARY KEY(client_no)

CREATE TABLE sales_order(
    s_order_no VARCHAR(6) PRIMARY KEY, CHECK(s_order_no LIKE '0%'),
    s_order_date DATE, 
    client_no VARCHAR(6), FOREIGN KEY(client_no) REFERENCES client_master(client_no),
    dely_add VARCHAR(6),
    salesman_no VARCHAR(7), FOREIGN KEY(salesman_no) REFERENCES sales_master(salesman_no),
    dely_type CHAR(1) DEFAULT 'F', CHECK(dely_type LIKE 'P' OR dely_type LIKE 'F'),
    billed_yn CHAR(1),
    dely_date DATE, CHECK(dely_date > s_order_date),
    order_status VARCHAR(10), CHECK(order_status LIKE 'in process' OR order_status LIKE 'fulfilled' OR order_status LIKE 'back order' OR order_status LIKE 'canceled')
)

-- Table: Sales_order_details
-- Alter the table product_master to set the column product_no to primary key
ALTER TABLE product_master ALTER COLUMN product_no VARCHAR(6) NOT NULL
ALTER TABLE product_master ADD PRIMARY KEY(product_no)

CREATE TABLE sales_order_details(
    s_order_no VARCHAR(6),
    product_no VARCHAR(6),
    qty_order NUMERIC(8),
    qty_disp NUMERIC(8),
    product_rate NUMERIC(10,2)
    FOREIGN KEY(s_order_no) REFERENCES sales_order(s_order_no),
    FOREIGN KEY(product_no) REFERENCES product_master(product_no)
)

-- Insert the following data into their respective tables using insert statement:
-- Insert data for Sales_master table.
INSERT INTO sales_master(salesman_no, salesman_name, address, city, pincode, state, sales_amt, tgt_to_get, ytd_sales, remarks)
VALUES
('S500001', 'Kiran', 'A/14 worli', 'Bombay', 400002, 'Mah', 3000, 100, 50, 'Good'),
('S500002', 'Manish', '65, nariman', 'Bombay', 400001, 'Mah', 3000, 200, 100, 'Good'),
('S500003', 'Ravi', 'P-7 Bandra', 'Bombay', 400032, 'Mah', 3000, 200, 100, 'Good'),
('S500004', 'Ashish', 'A/5 Juhu', 'Bombay', 400044, 'Mah', 3500, 200, 150, 'Good')

-- Set date format to dmy
SET DATEFORMAT dmy

-- Insert details of client with client_no 0001 to avoid foregin key error 
-- as this client was deleted in assignment 02.
INSERT INTO client_master (client_no, name, city, pincode, state, bal_due) 
VALUES ('0001', 'Ivan', 'Bombay', 400054, 'Maharashtra', 15000)

-- Insert data for Sales_order table.
INSERT INTO sales_order(s_order_no, s_order_date, client_no, dely_type, billed_yn, salesman_no, dely_date, order_status)
VALUES
('019001', '12-01-96', '0001', 'F', 'N', 'S500001', '20-01-1996', 'in process'),
('019002', '25-01-96', '0002', 'P', 'N', 'S500002', '27-01-96', 'canceled'),
('016865', '18-02-96', '0003', 'F', 'Y', 'S500003', '20-02-96', 'fulfilled'),
('019003', '03-04-96', '0001', 'F', 'Y', 'S500001', '07-04-96', 'fulfilled'),
('046866', '20-05-96', '0004', 'P', 'N', 'S500002', '22-05-96', 'canceled'),
('010008', '24-05-96', '0005', 'F', 'N', 'S500004', '26-05-96', 'in process')

-- Insert data for Sales_order_details table.
-- Edited S_order_no for 046865 to 016865.
INSERT INTO sales_order_details(s_order_no, product_no, qty_order, qty_disp, product_rate)
VALUES
('019001', 'P00001', 4, 4, 525),
('019001', 'P07965', 2, 1, 8400),
('019001', 'P07885', 2, 1, 5250),
('019002', 'P00001', 10, 0, 525),
('016865', 'P07868', 3, 3, 3150),
('016865', 'P07885', 10, 10, 5250),
('019003', 'P00001', 4, 4, 1050),
('019003', 'P03453', 2, 2, 1050),
('046866', 'P06734', 1, 1, 12000),
('046866', 'P07965', 1, 0, 8400),
('010008', 'P07975', 1, 0, 1050),
('010008', 'P00001', 10, 5, 525)