SELECT * from car_sales

--Q. To create a trigger function for setting availability true on each new entry in the db

-- Creating a function 
CREATE OR REPLACE FUNCTION set_availability_true() 
RETURNS TRIGGER AS $$
BEGIN
    NEW.availability := TRUE;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP FUNCTION IF EXISTS set_availability_true;


-- Creating the trigger function

CREATE TRIGGER car_sales_insert
BEFORE INSERT ON car_sales
FOR EACH ROW
EXECUTE FUNCTION set_availability_true();

-- Calling the function

INSERT INTO car_sales (
    date,customer_id,customer_name, car_name,company_name,manufracturing_date,miles_driven,state,city, 
    price,availability)  
	VALUES (
    '2023-07-21', 'a5f3f2c8-3d1c-4a8e-bd0a-b2d7b6d4c1a9', 'John Doe', 'Tesla CYBERTRUCK', 'Tesla Inc.', '2023-05-01', 5000, 'California', 
    'San Francisco',55000.00,FALSE);


select availability from car_sales where car_name ='Tesla CYBERTRUCK';