TITLE Nástroj na reset databáze závodu BRAZDA
REM ECHO OFF

REM chcp 65001

SET PGVERSION=9.5
SET PGCLIENTENCODING=UTF8
SET PGUSER=postgres
SET PGPASSWORD=
SET PGDATABASE=brazda_test

ECHO Ruším starou databázi BRAZDA...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\dropdb.exe" brazda_test

ECHO Vytvářím novou databázi BRAZDA...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\createdb.exe" -O brazda_test -E UTF8 -T template0  -U postgres -O brazda
if errorLevel 1 ( exit /b %errorLevel%; )

SET PGUSER=brazda
SET PGPASSWORD=FzwtMS/jq.XSQ
SET PGDATABASE=brazda_test

ECHO Importuji schéma...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f schema.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Importuji základní data...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f data.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 001...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p001.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 002...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p002.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 003...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p003.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 004...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p004.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 005...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p005.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 006...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p006.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 007...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p007.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 008...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p008.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 009...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p009.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 010...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p010.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 011...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p011.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 012...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p012.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 013...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p013.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 014...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p014.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 015...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p015.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 016...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p016.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 017...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p017.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 018...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p018.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Aplikuji patch 019...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f p019.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Importuji základní data...
"C:\Program Files\PostgreSQL\%PGVERSION%\bin\psql.exe" -f default.sql
if errorLevel 1 ( exit /b %errorLevel%; )

ECHO Hotovo!
