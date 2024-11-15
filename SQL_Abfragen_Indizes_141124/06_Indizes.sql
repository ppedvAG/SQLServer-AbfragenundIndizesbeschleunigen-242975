/*
	-Index


	Table Scan: Durchsucht die ganze Tabelle (langsam)
	Index Scan: Durchsucht bestimmte Teile der Tabelle (besser)
	Index Seek: Gezielt zu den Daten (am besten)


	Gruppierter Index:
	- Kann nur einmal vorhanden sein (Standardm‰ﬂig der PK)
	- Wenn INSERT/UPDATE/DELETE => Daten werden herumgeschoben, sortiert sich immer selbst

	Wann brauch ich den Gruppierten Index?
	- Sehr gut bei Abfragen nach Bereichen und rel. Groﬂen Ergebnismengen: <, >, between, like


	Nicht-gruppierter Index:
	- Bis zu 999 mal 
	- Zwei Komponenten: Schl¸sselspalten, inkludierten Spalten

	Wann brauch den Nicht-gruppierten Index?
	- Sehr gut bei Abfragen auf rel. eindeutige Werte bzw. geringeren Ergebnismengen
	
*/

USE AbfragenTest

SELECT * INTO M005_Index
FROM M004_Kompression

SET STATISTICS IO , TIME ON

-- Table Scan
SELECT * FROM M005_Index

SELECT * FROM M005_Index
WHERE OrderID >= 11000
-- Cost: 21, logische Lesevorg‰nge: 28265, CPU-Zeit: 592ms, verstrichene Zeit = 1060ms

-- Neuer Index: NCIX_OrderID

SELECT * FROM M005_Index
WHERE OrderID >= 11000
-- Cost: 2,17, logische Lesevorg‰nge: 2887, CPU-Zeit = 94ms, verstrichene Zeit = 1236ms

-- Indizes anschauen
SELECT OBJECT_NAME(OBJECT_ID), index_level, page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')

-- Index aufbauen
SELECT CompanyName, ContactName, ProductName, QUantity * UnitPrice
FROM M005_Index
WHERE ProductName = 'Chocolade'
-- Cost: 21,09 , Logische Lesevorg‰nge: 28265, CPU-Zeit = 220ms, verstrichene Zeit = 106ms

SELECT CompanyName, ContactName, ProductName, QUantity * UnitPrice
FROM M005_Index
WHERE ProductName = 'Chocolade'
-- Cost: 0,02 , Logische Lesevorg‰nge: 26, CPU-Zeit = 16ms, verstrichene Zeit = 94ms

-- Hier wird auch NCIX_ProductName durchgegangen
-- Hier fehlt die CompanyName Spalte
SELECT CompanyName, ProductName, QUantity * UnitPrice
FROM M005_Index
WHERE ProductName = 'Chocolade'

-- Hier wird NCIX_ProductName teils durchgegangen
-- Alle Included Columns werden geholt + ein Lookup auf die fehlenden Dten gemacht
SELECT CompanyName, ProductName, QUantity * UnitPrice, CompanyName, Freight
FROM M005_Index
WHERE ProductName = 'Chocolade'
-- Cost: 4,94, logische Lesevorg‰nge: 1562, CPU-Zeit = 0ms, verstrichene Zeit = 95ms

-- Indizierte Sicht
-- View mit Index
-- Benˆtigt SCHEMABINDING
-- WITH SCHEMABINDING: Solange die View existiert, kann die Tabellenstruktur nicht ge‰ndert werden

ALTER TABLE M005_Index ADD id int identity
GO

SELECT * FROM M005_Index
GO

CREATE VIEW Adressen_Test WITH SCHEMABINDING
AS
SELECT id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M005_Index

SELECT * FROM Adressen_Test


-- Clustered Index Insert
INSERT INTO M005_Index (CompanyName, Address, City, Region, PostalCode, Country, CustomerID, OrderID, EmployeeID)
VALUES('PPEDV', 'Eine Straﬂe', 'Irgendwo', NULL, NULL, NULL, 'PPEDV', 1023)

CREATE TABLE M005_InsertTest
(
	id int identity,
	CompanyName nvarchar(40),
	Address nvarchar(60),
	City nvarchar(15),
	Region nvarchar(15),
	PostalCode nvarchar(10),
	Country nvarchar(15)
)

INSERT INTO M005_InsertTest 
SELECT id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M005_Index


SELECT * FROM M005_InsertTest

INSERT INTO M005_InsertTest (CompanyName, Address, City, Region, PostalCode, Country)
VALUES('PPEDV', 'Eine Straﬂe', 'Irgendwo', NULL, NULL, NULL)