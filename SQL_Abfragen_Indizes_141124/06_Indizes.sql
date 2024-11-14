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
