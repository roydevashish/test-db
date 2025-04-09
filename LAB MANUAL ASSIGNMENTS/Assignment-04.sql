-- Create the following tables.
-- Table: challan_header
CREATE TABLE challan_header(
    challan_no varchar(6) NOT NULL PRIMARY KEY,
    s_order_no varchar(6) NOT NULL, FOREIGN KEY(s_order_no) REFERENCES sales_order(s_order_no),
    challan_date DATE NOT NULL,
    billed_yn char(1) DEFAULT 'N', CHECK(billed_yn LIKE 'Y' or billed_yn LIKE 'N')
)

-- Table: challan_details
CREATE TABLE challan_details(
    challan_no VARCHAR(6) NOT NULL, FOREIGN KEY(challan_no) REFERENCES challan_header(challan_no),
    product_no VARCHAR(6)NOT NULL, FOREIGN KEY(product_no) REFERENCES product_master(product_no),
    qty_disp NUMERIC(4) NOT NULL
)

-- Insert the following values into the challan header and challan_details tables:
-- Table: challan_header
-- Changed the value of s_order_no 046865 to 016865 as 046865 doesn't exist.
-- Changed the value of challan_no CH865 to CH6865.
INSERT INTO challan_header VALUES
('CH9001', '019001', '12-12-95', 'Y'),
('CH6865', '016865', '12-11-95', 'Y'),
('CH3965', '010008', '12-10-95', 'Y')

-- Table: challan_details
INSERT INTO challan_details VALUES
('CH9001', 'P00001', 4),
('CH9001', 'P07965', 1),
('CH9001', 'P07885', 1),
('CH6865', 'P07868', 3),
('CH6865', 'P03453', 4),
('CH6865', 'P00001', 10),
('CH3965', 'P00001', 5),
('CH3965', 'P07975', 2)

-- Answer the following questionries
-- 01. Make the primary key to client_no in client_master.
ALTER TABLE client_master ADD PRIMARY KEY(client_no)

-- 02. Add a new column phone_no in the client_master table.
ALTER TABLE client_master ADD phone_no NUMERIC(10)

-- 03. Add the not null constraint in the product_master table with the columns description, profit percent, sell price and cost price.
-- Column: desctiption
ALTER TABLE product_master
ALTER COLUMN description VARCHAR(50) NOT NULL

-- Column: profit_percent
ALTER TABLE product_master
ALTER COLUMN profit_percent DECIMAL(10,2) NOT NULL

-- Column: sell_price
ALTER TABLE product_master
ALTER COLUMN sell_price NUMERIC NOT NULL

-- Column: cost_price
ALTER TABLE product_master
ALTER COLUMN cost_price NUMERIC NOT NULL

-- 04. Change the size of client_no field in the client_master table.
ALTER TABLE client_master 
ALTER COLUMN client_no VARCHAR(9)

-- 05. Select product_no, description where profit percent is between 20 and 30 both inclusive.
SELECT product_no, description FROM product_master WHERE profit_percent >= 20 AND profit_percent <=30