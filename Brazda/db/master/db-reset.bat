TITLE Nástroj na reset databáze závodu BRAZDA
ECHO OFF

chcp 65001

SET PGCLIENTENCODING=UTF-8
SET PGUSER=postgres
SET PGPASSWORD=
SET PGDATABASE=brazda

ECHO Ruším starou databázi BRAZDA...
"C:\Program Files\PostgreSQL\9.5\bin\dropdb.exe" brazda

ECHO Vytvářím novou databázi BRAZDA...
"C:\Program Files\PostgreSQL\9.5\bin\createdb.exe" -O brazda -E UTF8 -T template0
if errorLevel 1 ( exit /b %errorLevel%; )

SET PGUSER=brazda
SET PGPASSWORD=FzwtMS/jq.XSQ
SET PGDATABASE=brazda

ECHO Importuji schéma...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f schema.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Importuji základní data...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f data.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 001...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p001.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 002...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p002.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 003...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p003.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 004...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p004.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 005...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p005.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 006...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p006.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 007...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p007.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 008...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p008.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 009...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p009.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 010..
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p010.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 010...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f p011.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Importuji data o stanovištích...
"C:\Program Files\PostgreSQL\9.5\bin\psql.exe" -f posts.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Hotovo!
