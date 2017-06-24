TITLE Nástroj na reset databáze závodu BRAZDA
ECHO OFF

chcp 65001

SET PGCLIENTENCODING=UTF-8
SET PGUSER=postgres
SET PGPASSWORD=
SET PGDATABASE=brazda

ECHO Ruším starou databázi BRAZDA...
"C:\Program Files\PostgreSQL\9.5\bin\dropdb.exe" brazda
if errorLevel 1 (
    exit /b %errorLevel%;
)

ECHO Vytvářím novou databázi BRAZDA...
"C:\Program Files\PostgreSQL\9.5\bin\createdb.exe" -O brazda -E UTF8 -T template0
if errorLevel 1 (
    exit /b %errorLevel%;
)

SET PGUSER=brazda
SET PGPASSWORD=FzwtMS/jq.XSQ
SET PGDATABASE=brazda

ECHO Importuji schéma...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f schema.sql
if errorLevel 1 (
    exit /b %errorLevel%;
)

ECHO Importuji základní data...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f data.sql
if errorLevel 1 (
    exit /b %errorLevel%;
)

ECHO Importuji data o stanovištích...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f posts.sql
if errorLevel 1 (
    exit /b %errorLevel%;
)

ECHO Vytvářím pohled na výsledky...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f results.sql

ECHO Hotovo!
