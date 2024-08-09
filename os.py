import os
os.system("PGPASSWORD='54321' psql -h localhost -U postgres -d salesInventory -f dataQueries.sql")