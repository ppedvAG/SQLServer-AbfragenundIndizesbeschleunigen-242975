-- Kompression

-- Daten verkleinern
-- Weniger Daten müssen geladen, beim dekomprimieren wird CPU Leistung verwendet

-- Zwei verschiedene Typen

-- Row Compression: 50%
-- Page Compression: 75%

Use Northwind;

USE Northwind;
SELECT  Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Orders.Freight, Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.Address, Customers.City, 
        Customers.Region, Customers.PostalCode, Customers.Country, Customers.Phone, Orders.OrderID, Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title, [Order Details].UnitPrice, 
        [Order Details].Quantity, [Order Details].Discount, Products.ProductID, Products.ProductName, Products.UnitsInStock
INTO AbfragenTest.dbo.M004_Kompression
FROM    [Order Details] INNER JOIN
        Products ON Products.ProductID = [Order Details].ProductID INNER JOIN
        Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
        Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
        Customers ON Orders.CustomerID = Customers.CustomerID

USE AbfragenTest

INSERT INTO M004_Kompression
SELECT * FROM M004_Kompression
GO 8

SELECT * FROM M004_Kompression

SET STATISTICS IO, TIME ON

-- Logische Lesevorgänge: 28245, CPU-Zeit = 1110ms, verstrichene Zeit = 8155ms
-- Ohne Kompression
SELECT * FROM M004_Kompression

-- Row Kompression:
-- Logische Lesevorgänge: 15794, CPU-Zeit = 2250ms, verstrichene Zeit = 11169ms
SELECT * FROM M004_Kompression

-- Page Kompression
-- Logische Lesevorgänge: 7530, CPU-Zeit = 2563ms, verstrichene Zeit = 9312ms
SELECT * FROM M004_Kompression


-- Partitionen können auch komprimiert werden
SELECT OBJECT_NAME(OBJECT_ID), * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')
WHERE compressed_page_count != 0

-- Alle Kompressionen ausgeben
SELECT t.name as TableName, p.partition_number AS PartitionNumber, p.data_compression_desc AS Compression
FROM sys.partitions AS p
JOIN sys.tables AS t ON t.object_id = p.object_id