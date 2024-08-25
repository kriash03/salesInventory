import os
os.system("PGPASSWORD='userpassword' psql -h localhost -U userName -d databas_name -f dataQueries.sql")