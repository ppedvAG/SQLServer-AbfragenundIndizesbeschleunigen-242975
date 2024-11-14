/*
	Range Bereich von 0-300, 301-600, 600-1000
*/
-- Für Eure Datensätze
BEGIN TRAN
DECLARE @i int = 0
WHILE @i < 100000
BEGIN
	INSERT INTO M002_Umsatz VALUES
	(DATEADD(DAY, FLOOR(RAND()*1095), '20210101'), RAND() * 1000)
	SET @i += 1
END 
COMMIT


/*
	Ranges: 01.01.21 - 31.12.21	
			01.01.22 - 31.12.22
			01.01.23 - 31.12.23

*/