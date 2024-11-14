/*
	Partitionierung:
	Aufteilung in "mehrere" Tabllen
	Einzelne Tabelle bleibt bestehen, aber intern werden die Daten partitioniert
*/

-- Anforderungen:
-- Partitionsfunktion: Stellt Bereiche dar (0-100, 101-200, 201-Ende)
-- Partitionsschema: Weist die einzelnen Partitionen auf Dateigruppen zu

-- 0-100, 101-200, 201-Ende
CREATE PARTITION FUNCTION pf_Zahl(int) AS
RANGE LEFT FOR VALUES(100, 200)

-- Partitionsschema: muss immer eine extra Dateigruppe existieren
CREATE PARTITION SCHEME sch_ID as
PARTITION pf_Zahl TO (Range1, Range2, Range3)

-- Hier muss die Tabelle auf das Schema gelegt werden
CREATE TABLE M003_Test
(
	id int identity,
	zahl float
) ON sch_ID(id)


BEGIN TRAN
DECLARE @i int = 0;
WHILE @i < 1000
BEGIN
	INSERT INTO M003_Test VALUES (RAND() * 1000)
	SET @i += 1
END 
COMMIT

SELECT * FROM M003_Test

-- Übersicht über Partition verschaffen
SELECT OBJECT_NAME(OBJECT_ID), * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')

SELECT $partition.pf_Zahl(50)
SELECT $partition.pf_Zahl(150)
SELECT $partition.pf_Zahl(250)


-- Pro Datensatz die Partition + Filegroup anhängen
SELECT * FROM M003_Test t
JOIN
(
	SELECT name, ips.partition_number
	FROM sys.filegroups fg --Name

	JOIN sys.allocation_units au
	ON fg.data_space_id = au.data_space_id

	JOIN sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED') ips
	ON ips.hobt_id = au.container_id

	WHERE OBJECT_NAME(ips.object_id) = 'M003_Test'
) x
ON $partition.pf_Zahl(t.id) = x.partition_number


-- Code Beispiele

-- Dateigruppe per Code
ALTER DATABASE AbfragenTest ADD FILEGROUP Test1

-- Datei per Code
ALTER DATABASE AbfragenTest
ADD FILE
(
	NAME = N'Test1'
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSSQL16.SQLKURS\MSSQSL\DATA\Test1.ndf'
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
)
TO FILEGROUP Test1

