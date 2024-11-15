-- Erstellt eine Abfrage von der Tabelle M005_Indizes 
-- wo ihr 2 Schlüsselspalten habt und probiert die verschieden
-- MAXDOP Optionen durch (1, 2, 4, 8)

SELECT OrderDate, Freight, OrderID FROM M005_Index
WHERE City = 'COWES' AND LastName = 'Peacock'

SET STATISTICS TIME, IO ON

-- MAXDOP Versuch
SELECT OrderDate, Freight, OrderID FROM M005_Index
WHERE City = 'COWES' AND LastName = 'Peacock'
OPTION(MAXDOP 1)
-- CPU-Zeit = 156ms, verstrichene Zeit = 237ms
-- Mit Index: CPU-Zeit = 0ms, verstrichene Zeit = 79ms

SELECT OrderDate, Freight, OrderID FROM M005_Index
WHERE City = 'COWES' AND LastName = 'Peacock'
OPTION(MAXDOP 2)
-- CPU-Zeit = 125ms, verstrichene Zeit = 133ms
-- Mit Index: CPU-Zeit = 32ms, verstrichene Zeit = 64ms


SELECT OrderDate, Freight, OrderID FROM M005_Index
WHERE City = 'COWES' AND LastName = 'Peacock'
OPTION(MAXDOP 4)
-- CPU-Zeit = 173ms, verstrichene Zeit = 89ms
-- Mit Index: CPU-Zeit = 0ms, verstrichene Zeit = 86ms


SELECT OrderDate, Freight, OrderID FROM M005_Index
WHERE City = 'COWES' AND LastName = 'Peacock'
OPTION(MAXDOP 8)
-- CPU-Zeit = 249ms, verstrichene Zeit = 100ms
-- Mit Index: CPU-Zeit = 0ms, verstrichene Zeit = 66ms
