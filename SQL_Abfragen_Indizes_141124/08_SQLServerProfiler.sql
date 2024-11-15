/*
	-- Profiler
	-- Live-Verfolgung was auf der Datenbank passiert
	-- Kann in weiterer Folge f�r den DB-Optimierer verwendet werden

	-- Extras -> SQL Server Profiler

		-- Einstellungen auf der ersten Seite setzen
	-- Events ausw�hlen auf dem zweiten Reiter
	---- StmtStarted
	---- StmtCompleted
	---- BatchStarted
	---- BatchCompleted
	---- ....
	-- DatabaseName LIKE Name

	-------------------------------------------------------

	-- Nach der Trace -> Tuning Advisor

	-- Tools -> Database Engine Tuning Advisor

	-- Trace File laden oder Query Store ausw�hlen

	-- Tuning Options -> Indizes und/oder Partitionen ausw�hlen

	-- Oben -> Start Analysis

	-- Actions -> Apply Recommendations
*/

SELECT * FROM M005_Index

CREATE CLUSTERED INDEX [_dta_index_M005_Index_c_13_1205579333__K15] ON [dbo].[M005_Index]
(
	[OrderID] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]


CREATE NONCLUSTERED INDEX [_dta_index_M005_Index_13_1205579333__K4_17_18] ON [dbo].[M005_Index]
(
	[Freight] ASC
)
INCLUDE([LastName],[FirstName]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

