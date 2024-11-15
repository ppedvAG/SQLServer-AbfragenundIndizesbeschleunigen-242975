/*
	Seiten: 8192B => 8kB
	132B Metadaten nicht beschreibar
	8 Seiten = 1 Block
	dbcc showcontig('Tabelle')

	Kleine �nderungen von Abfragen �ndern auch die CPU-Zeit etc.

	SET STATISTICS IO, time ON => anschalten
	SET STATISTICS IO, time OFF => ausschalten

	- Ausf�hrungsplan

	-- Dateigruppen
	-- Standard: [PRIMARY] Hauptgruppe

	Dateien:
	1. [PRIMARY] = .mdf
	2. Log = .ldf
	3. Weiteren Files = .ndf

	- Gr��e der Datei
	- Maximale Gr��e der Datei
	- Datei zur Dateigruppe hinzuf�gen
	- Speicherpfad angeben


	Partitionierung:

	-- 2 Anforderungen
	1. Partitionsfunktion
	CREATE PARTITION FUNCTION [Name](Datentyp) AS
	RANGE LEFT FOR VALUES (Wert1, Wert2)

	2. Partitionsschema
	CREATE PARTITION SCHEME [Schemaname] AS
	PARTITION [Funktionsname] TO (DG1, DG2, DG3 ...)
*/

CREATE TABLE Test
(
	id int identity,
	zahl float
) ON [Schemaname](id)


/*
	SELECT $partition.[pf_Name](AbfrageWert)
*/

/*
	Kompression:
	--> Daten verkleinern, daf�r wird CPU-Leistung verwendet

	-- Zwei verschiedenen Typen
	1. Page Compression
	2. Row Compression

*/

/*
	Indizes:

	-- Table Scan: Durchsucht unsere Tabelle von oben nach unten durch (ziemlich, extrem, �berdimensional langsam)
	-- Index Scan: Durchsucht bestimmte Teile der Tabelle (Etwas, Minimal, Leicht erg�nzed, federgewicht besser)
	-- Index Seek: Gehe in einen Index gezielt zu den Daten hin (optimal, hervorragend am besten)

	-- Gruppierten Index:
	- Normaler Index der sich selber sortiert
	- BEI INSERT/DELETE werden die Daten herumgeschoben und neu sortiert
	- Kann nur 1 mal pro Tabelle existieren
	- Normalerwei�e liegt auf PK

	Wann brauch ich den Gruppierten Index?
	- Sehr gut bei Abfragen nach Bereichen und rel. gro�e Ergebnismengen: <, >, between, like

	-- Nicht-Gruppierten Index:
	- Zwei Komponenten: Schl�sselspalten, inkludierten Spalten

	Wann brauch ich den Nicht-gruppierten Index?
	- Sehr gut bei Abfragen rel. eindeutige Werte bzw geringere Ergebnismengen
	- Kann mehrfach verwendet werden (999-mal)

*/