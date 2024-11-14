/*
	Dateigruppen:
	Datenbank aufteilen in mehrere Dateien, und verschiedene Datentr‰ger 
	[Primary]: Hauptgruppe, existiert immer, enth‰lt standarm‰ﬂig alle Files

	- Hauptfile Endung .mdf
	- Weitere File Endungen .ndf
	- Log Files Endung .ldf
*/

USE AbfragenTest

CREATE TABLE M002_FG2
(
	id int identity,
	test char(4100)
)

INSERT INTO M002_FG2
VALUES('XYZ')
GO 20000

-- Wie verschiebe ich die Tabelle auf eine andere Dateigruppe?
-- Neu erstellen, Daten verschieben => Alte Tabelle Lˆschen

CREATE TABLE M002_FG_2
(
	id int identity,
	test char(4100)
) ON P1

INSERT INTO M002_FG_2
SELECT * FROM M002_FG2

-- Identity entfernen per Designer
-- Extras -> Optionen -> Designer -> Speichern von ƒnderungen verhindern, die die Neuerstellung der Tabelle erfordern -> Ausschalten

-- Salamitaktik
-- Groﬂe Tabellen in kleinere aufzuteilen
-- Mit Partionierter Sicht

CREATE TABLE M002_Umsatz
(
	datum date,
	umsatz float
)

BEGIN TRAN
DECLARE @i int = 0
WHILE @i < 100000
BEGIN
	INSERT INTO M002_Umsatz VALUES
	(DATEADD(DAY, FLOOR(RAND()*1095), '20210101'), RAND() * 1000)
	SET @i += 1
END 
COMMIT

SELECT * FROM M002_Umsatz


CREATE TABLE M002_Umsatz2021
(
	datum date,
	umsatz float
) -- ON [Umsatz2021]
INSERT INTO M002_Umsatz2021
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2021

CREATE TABLE M002_Umsatz2022
(
	datum date,
	umsatz float
) -- ON [Umsatz2022]
INSERT INTO M002_Umsatz2022
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2022


CREATE TABLE M002_Umsatz2023
(
	datum date,
	umsatz float
) -- ON [Umsatz2023]
INSERT INTO M002_Umsatz2023
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2023

--DROP TABLE M002_Umsatz2021
--DROP TABLE M002_Umsatz2022
--DROP TABLE M002_Umsatz2023
GO

CREATE VIEW UmsatzGesamt
AS
SELECT * FROM M002_Umsatz2021
UNION ALL
SELECT * FROM M002_Umsatz2022
UNION ALL 
SELECT * FROM M002_Umsatz2023

SELECT * FROM UmsatzGesamt