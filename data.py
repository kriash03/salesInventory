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
        stock_level = int(input("Enter Stock Level: "))
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

def insert_inventory(cursor, product_ids):
    inventory_data = []
    for product_id in product_ids:
        supplier_id = int(input(f"Enter SupplierID for ProductID {product_id}: "))
        quantity_received = int(input(f"Enter Quantity Received for ProductID {product_id}: "))
        receive_date = input(f"Enter Receive Date (YYYY-MM-DD) for ProductID {product_id}: ")
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
            user="postgres",
            password="54321",
            host="localhost",
            port="5432",
            database="salesInventory"
        )
        cursor = connection.cursor()
        print("Successfully connected to the database")

        # Insert products and inventory records
        product_ids = insert_products(cursor)
        if product_ids:
            insert_inventory(cursor, product_ids)

        connection.commit()
        print("Data inserted successfully into Products and Inventory tables")

    except (Exception, psycopg2.Error) as error:
        print("Error while connecting to PostgreSQL or executing query:", error)
    finally:
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

if __name__ == "__main__":
    main()
