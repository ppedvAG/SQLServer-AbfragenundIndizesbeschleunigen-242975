USE Northwind

-- Abfrage Plan cache l�schen
dbcc freeproccache

-- Pl�ne werden in Hashwert gespeicherte ... bl�d, wenn man mal gro� oder klein schreibt

SELECT * FROM orders WHERE customerid = 'HANAR'

SELECT * FROM orders WHERE CustomerID = 'HANAR'

SELECT * FROM Orders WHERE customerid = 'HANAR'


SELECT * FROM Orders WHERE OrderID = 10

SELECT * FROM Orders WHERE orderID = 30

SELECT * FROM Orders WHERE orderid = 50000

SELECT * FROM Orders WHERE OrderID = '10000'

select usecounts, cacheobjtype,[TEXT] from
	sys.dm_exec_cached_plans p CROSS APPLY
	sys.dm_exec_sql_text(plan_handle)
	where cacheobjtype = 'Compiled PLan'
		AND [TEXT] not like '%dm_exec_cached_plans%'