import psycopg2
from datetime import datetime

def insert_customers(cursor):
    customer_data = []
    while True:
        customer_name = input("Enter Customer Name (or 'done' to finish): ")
        if customer_name.lower() == 'done':
            break
        email = input("Enter Email: ")
        phone = input("Enter Phone: ")
        customer_data.append((customer_name, email, phone))
    
    insert_customer_query = """
    INSERT INTO Customers (CustomerName, Email, Phone)
    VALUES (%s, %s, %s)
    RETURNING CustomerID;
    """
    
    customer_ids = []
    for customer in customer_data:
        cursor.execute(insert_customer_query, customer)
        customer_id = cursor.fetchone()[0]
        customer_ids.append(customer_id)
    
    return customer_ids

def insert_sales(cursor, customer_ids):
    sale_data = []
    for customer_id in customer_ids:
        sale_date = input(f"Enter Sale Date (YYYY-MM-DD) for CustomerID {customer_id}: ")
        total_amount = float(input(f"Enter Total Amount for CustomerID {customer_id}: "))
        sale_data.append((sale_date, customer_id, total_amount))
    
    insert_sale_query = """
    INSERT INTO Sales (SaleDate, CustomerID, TotalAmount)
    VALUES (%s, %s, %s)
    RETURNING SaleID;
    """
    
    sale_ids = []
    for sale in sale_data:
        cursor.execute(insert_sale_query, sale)
        sale_id = cursor.fetchone()[0]
        sale_ids.append(sale_id)
    
    return sale_ids

def insert_sale_details(cursor, sale_ids, product_ids):
    sale_detail_data = []
    for sale_id in sale_ids:
        for product_id in product_ids:
            quantity = int(input(f"Enter Quantity for SaleID {sale_id} and ProductID {product_id}: "))
            price = float(input(f"Enter Price for SaleID {sale_id} and ProductID {product_id}: "))
            sale_detail_data.append((sale_id, product_id, quantity, price))
    
    insert_sale_detail_query = """
    INSERT INTO SaleDetails (SaleID, ProductID, Quantity, Price)
    VALUES (%s, %s, %s, %s);
    """
    
    cursor.executemany(insert_sale_detail_query, sale_detail_data)

def main():
    try:
        connection = psycopg2.connect(
            user="postgres",
            password="54321",
            host="localhost",
            port="5432",
            database="salesInventory"
        )
        cursor = connection.cursor()
        print("Successfully connected to the database")

        customer_ids = insert_customers(cursor)
        product_ids = [1, 2, 3, 4]  # Assuming you already have product IDs
        
        if customer_ids:
            sale_ids = insert_sales(cursor, customer_ids)
            insert_sale_details(cursor, sale_ids, product_ids)

        connection.commit()
        print("Data inserted successfully into Customers, Sales, and SaleDetails tables")

    except (Exception, psycopg2.Error) as error:
        print("Error while connecting to PostgreSQL or executing query:", error)
    finally:
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

if __name__ == "__main__":
    main()
