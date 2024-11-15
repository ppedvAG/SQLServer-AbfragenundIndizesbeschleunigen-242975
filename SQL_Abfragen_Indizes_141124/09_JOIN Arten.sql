-- JOIN

/*
	SQL Server versucht aus einer Reihe von Ausführungsplänen, die er vorab
	ermittelt den günstigstens herauszufinden

	Stimmt meist nicht

	- unter anderem tauchen Sortieroperatoren auf, obwohl kein
	Order by zu finden war. Kann an den JOIN Methoden liegen


	inner hash join
	wird eine hashtabelle zu ermitteln der übereinstimmenden
	JOIN spalte der tabellen
	Gilt bei großen Tabellen, leicht parallelisierbar, kein Index vorhanden ist

	inner merge join
	beide tabellen werden jeweils gleichzeitig durchsucht
	kann aber nur funktionieren wenn die sortiert werden
	(entweder durch Sortieroperator & Index)

	inner loop join
	kleine Tabellen wird zeilenweise durchlaufen pro zeile
	wird in der größereren Tabelle nach dem Wert gesucht
	- gut wenn eine Tabelle bzw (WHERE) Ergebnis sehr klein ist und die größere
	Sortiert ist
*/

SELECT * FROM customers 
inner HASH join orders on Customers.CustomerID = Orders.CustomerID

SELECT * FROM Customers
INNER MERGE JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT * FROM Customers
INNER LOOP JOIN Orders ON Customers.CustomerID = Orders.CustomerID
