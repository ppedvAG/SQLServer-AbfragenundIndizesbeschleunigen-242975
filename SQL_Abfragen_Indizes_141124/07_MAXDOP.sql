-- MAXDOP
-- Maximum Degree of Parallelism
-- Steuerung der Anzahl Prozessorkerne pro Abfrage

-- Kann auf drei Ebenen gesetzt
-- Query > DB > Server

SET STATISTICS TIME, IO ON

SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
-- Diese Abfrage wird parallelisiert durch Zwei schwarzen Pfeile in diesem Gelben Kreis
--> Tatsächlicher Ausführungsplan

SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 1)
-- CPU-Zeit = 454ms, verstrichene Zeit = 1253ms

SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 2)
-- CPU-Zeit = 641ms, verstrichene Zeit = 1068ms


SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 4)
-- CPU-Zeit = 468ms, verstrichene Zeit = 1082ms

SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 8)
-- CPU-Zeit = 593ms, verstrichene Zeit = 1144ms