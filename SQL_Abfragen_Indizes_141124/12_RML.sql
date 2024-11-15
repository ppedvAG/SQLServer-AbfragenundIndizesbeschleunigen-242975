/*
	
	Replay Markup Language (RML)
	=> Ermöglicht Administratoren SQL Abfragen und Befehle zu erfassen, erneut auszuführen
	und zu untersuchen => Um Probleme mit der Abfrageleistung & Ressourcenverbauch zu identifizieren
	und beheben

	Funktionen und Hauptmerkmale von RML:

	1. Workload-Replay: Zuvor erfasste Workload erneut abspielen

	2. Leistungsanalyse und Vergleichen: RML Workloads vor und nach Ändernungen
	(z.B Indexänderungen oder Abfrageoptimierungen) abspielen und die Leistung vergleichen

	3. Ermittlung problematische Abfragen: Zeit und Ressourcen der Abfragen

	4. Benutzer- und Sitzungsüberwachung:
	- Kann Abfragen einzelnen Benutzern und Sitzungen zuordner
	=> Hilfreich zum analysieren, wie bestimmte Benutzer oder Anwendungen die
	SQL Server Instanzen belasten

	5. Parallelisierung und Lasttests:
	- Unterstützt das parallele Abspiele von Workloads, was sich für Lasttests eignen


	Anwendungsfälle:

	Migrationstests:
	- Beim verschieben der Datenbank auf eine neue Serverversion oder konfiguration, sorgt der 
	RML-Dienst das die Leistung erhalten bleibt oder verbessert wird

	Troubleshooting und Performance Tuning:
	- Durch erneutes Abspielen und Analysieren von Workloads lassen sich
	Leistungsprobleme erkennen und gezielt angehen.

	Kapazitätsplanung und Skalierbarkeit
	- Unternehmen können simulieren, wie Ihre Workloads auf größeren Servern
	oder anderen Hardwarekonfigurationen laufen würden,
	um die Skalierbarkeit zu bewerten


*/