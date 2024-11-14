/*
	Seite:
	8192B groß
	8060B Tat. Daten
	132B Meta Daten

	8 Seiten = 1 Block


	- dbcc: database console commands
	- showcontig: Zeigt Seiteninformationen über ein Datenbankobjekt
*/

-- 98,19%
dbcc showcontig('Orders')

-- Messungen
SET STATISTICS time, IO ON
	-- Dauer in ms von CPU und der Ausführungszeit

SELECT * FROM Orders
-- CPU-Zeit 0ms, ausführungszeit 353ms

CREATE DATABASE AbfragenTest

CREATE TABLE M001_Test1
(
	id int identity,
	test char(4100)
)

-- Werte hinzufügen
INSERT INTO M001_Test1
VALUES('XYZ')
GO 20000

SET STATISTICS time, IO Off 

-- Tabelle M001_Test1, Seitendichte anschauen
dbcc showcontig('M001_Test1')
-- Seiten: 20000, Seitendichte: 50,79%

CREATE TABLE M001_Test2
(
	id int identity,
	test varchar(4100)
)

INSERT INTO M001_Test2
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Test2')
-- Seiten: 52, Seitendichte: 95,01%

SET STATISTICS IO, time off
-- alle Datensätze aus der Tabelle Orders aus dem Jahr 1997

SELECT * FROM Orders WHERE OrderDate LIKE '%1997%'
-- korrekt, aber langsam 
-- CPU-Zeit = 0ms, verstrichene Zeit = 75ms


SELECT * FROM Orders WHERE OrderDate BETWEEN '1.1.1997' AND '31.12.1997 23:59:59.997'
-- korrekt, aber langsam 
-- CPU-Zeit = 0ms, verstrichene Zeit = 80ms


SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997
-- korrekt, noch langsamer
-- CPU-Zeit = 0ms, verstrichene Zeit = 115ms

CREATE TABLE M001_Test3
(
	id int identity,
	test nchar(4000) --> 2 Byte pro Zeichen weil UTF-16
)

INSERT INTO M001_Test3
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Test3')
-- Seiten: 20000, Seitendichte: 98,87%


CREATE TABLE M001_Test4
(
	id int identity,
	test nvarchar(4000) --> 2 Byte pro Zeichen weil UTF-16
)

INSERT INTO M001_Test4
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Test4')
-- Seiten: 60, Seitendichte: 94,70%

CREATE TABLE M001_TestDecimal
(
	id int identity,
	zahl decimal(2,1)
)

INSERT INTO M001_TestDecimal
VALUES(2.2)
GO 20000


-- Schnellere Variante über Transactions
BEGIN TRAN
DECLARE @i int = 0
WHILE @i < 20000
BEGIN
	INSERT INTO M001_TestDecimal VALUES(2.2)
	SET @i += 1
END
COMMIT

dbcc showcontig('M001_TestDecimal') -- Seiten: 94, Seitendichte: 94,61%