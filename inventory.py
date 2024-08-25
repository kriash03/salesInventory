import psycopg2
from datetime import datetime

def insert_products(cursor):
    product_data = []
    while True:
        product_name = input("Enter Product Name (or 'done' to finish): ")
        if product_name.lower() == 'done':
            break
        category = input("Enter Category: ")
        price = float(input("Enter Price: "))
        
        # Validate stock level input to accept float values
        while True:
            try:
                stock_level = float(input("Enter Stock Level: "))
                break
            except ValueError:
                print("Invalid input. Please enter a valid number for Stock Level.")

        product_data.append((product_name, category, price, stock_level))

    insert_product_query = """
    INSERT INTO Products (ProductName, Category, Price, StockLevel)
    VALUES (%s, %s, %s, %s)
    RETURNING ProductID;
    """
    
    product_ids = []
    for product in product_data:
        cursor.execute(insert_product_query, product)
        product_id = cursor.fetchone()[0]
        product_ids.append(product_id)
    
    return product_ids

def insert_suppliers(cursor):
    supplier_data = []
    while True:
        supplier_name = input("Enter Supplier Name (or 'done' to finish): ")
        if supplier_name.lower() == 'done':
            break
        contact_name = input("Enter Contact Name: ")
        contact_email = input("Enter Contact Email: ")
        contact_phone = input("Enter Contact Phone: ")
        supplier_data.append((supplier_name, contact_name, contact_email, contact_phone))
    
    insert_supplier_query = """
    INSERT INTO Suppliers (SupplierName, ContactName, ContactEmail, ContactPhone)
    VALUES (%s, %s, %s, %s)
    RETURNING SupplierID;
    """
    
    supplier_ids = []
    for supplier in supplier_data:
        cursor.execute(insert_supplier_query, supplier)
        supplier_id = cursor.fetchone()[0]
        supplier_ids.append(supplier_id)
    
    return supplier_ids

def insert_inventory(cursor, product_ids):
    inventory_data = []
    for product_id in product_ids:
        supplier_id = int(input(f"Enter SupplierID for ProductID {product_id}: "))
        quantity_received = float(input(f"Enter Quantity Received for ProductID {product_id}: "))
        receive_date = datetime.now().date()
        inventory_data.append((product_id, supplier_id, quantity_received, receive_date))
    
    insert_inventory_query = """
    INSERT INTO Inventory (ProductID, SupplierID, QuantityReceived, ReceiveDate)
    VALUES (%s, %s, %s, %s);
    """
    
    cursor.executemany(insert_inventory_query, inventory_data)

def main():
    try:
        # Connect to PostgreSQL
        connection = psycopg2.connect(
            user="yourusername",
            password="youruserpassword",
            host="localhost",
            port="5432",
            database="yourdatabasename"
        )
        cursor = connection.cursor()
        print("Successfully connected to the database")

        # Insert products, suppliers, and inventory records
        product_ids = insert_products(cursor)
        supplier_ids = insert_suppliers(cursor)
        
        if product_ids and supplier_ids:
            insert_inventory(cursor, product_ids)

        connection.commit()
        print("Data inserted successfully into Products, Suppliers, and Inventory tables")

    except (Exception, psycopg2.Error) as error:
        print("Error while connecting to PostgreSQL or executing query:", error)
    finally:
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

if __name__ == "__main__":
    main()
