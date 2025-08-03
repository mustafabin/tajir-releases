@echo off
:: Modify pg_hba.conf to allow remote connections
echo host    all             all             0.0.0.0/0            md5 >> "C:\Program Files\PostgreSQL\16\data\pg_hba.conf"

:: Modify postgresql.conf to listen on all IP addresses
echo listen_addresses = '*' >> "C:\PostgreSQL\data\postgresql.conf"

:: Restart PostgreSQL service to apply changes
net stop postgresql-16
net start postgresql-16

echo == Firewall Configuration ==
:: Open firewall port 5432 for PostgreSQL
netsh advfirewall firewall add rule name="PostgreSQL" dir=in action=allow protocol=TCP localport=5432

echo == Creating Database and User ==

:: Create an SQL script for setting up the database and user
echo ALTER USER postgres WITH PASSWORD 'vitapay'; > setup_database.sql
echo CREATE DATABASE vitapaydb; >> setup_database.sql
echo CREATE USER admin WITH ENCRYPTED PASSWORD 'vitapay' SUPERUSER; >> setup_database.sql
echo GRANT ALL PRIVILEGES ON DATABASE vitapaydb TO admin; >> setup_database.sql

:: Run the SQL script using psql
"C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d postgres -f setup_database.sql

if %ERRORLEVEL% NEQ 0 (
    echo Database setup failed!
    exit /b %ERRORLEVEL%
)

echo == PostgreSQL Configuration Completed Successfully ==

:: Cleanup temporary files
del setup_database.sql

echo == PostgreSQL Setup Complete ==
pause
