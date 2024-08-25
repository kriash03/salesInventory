--this includes any misc schema that can be used and may be beneficial for some

--used to check the tables made and stored as a list
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

-- Reset table ProductID manually if you want to enter linear IDs

SELECT setval(pg_get_serial_sequence("products", "productid"), coalesce(max("productid"), 1), max("productid") IS NOT NULL) 
FROM "products";

--check if the column exists or not
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'enter_table_name';