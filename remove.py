import psycopg2
from psycopg2 import sql

def connect_to_db():
    return psycopg2.connect(
        user="postgres",
        password="54321",
        host="localhost",
        port="5432",
        database="salesInventory"
    )

def remove_duplicates():
    try:
        connection = connect_to_db()
        cursor = connection.cursor()
        print("Successfully connected to the database")

        # Step 1: Create a temporary table with unique products
        create_temp_table_query = """
        CREATE TEMP TABLE unique_products AS
        SELECT DISTINCT ON (ProductName, Category, Price) *
        FROM Products
        ORDER BY ProductName, Category, Price, ProductID;
        """
        cursor.execute(create_temp_table_query)
        print("Temporary table created with unique products")

        # Step 2: Update related rows in Inventory to refer to the correct ProductID
        update_inventory_query = """
        UPDATE Inventory inv
        SET ProductID = up.ProductID
        FROM unique_products up
        WHERE inv.ProductID = (
            SELECT p.ProductID
            FROM Products p
            WHERE p.ProductName = up.ProductName
              AND p.Category = up.Category
              AND p.Price = up.Price
              AND p.ProductID <> up.ProductID
            LIMIT 1
        );
        """
        cursor.execute(update_inventory_query)
        print("Related rows in Inventory updated")

        # Step 3: Delete duplicate rows from Products
        delete_duplicates_query = """
        DELETE FROM Products
        WHERE ProductID NOT IN (SELECT ProductID FROM unique_products);
        """
        cursor.execute(delete_duplicates_query)
        print("Duplicate rows removed from Products")

        connection.commit()

    except (Exception, psycopg2.Error) as error:
        print("Error while connecting to PostgreSQL or executing query:", error)
    finally:
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

if __name__ == "__main__":
    remove_duplicates()
