/*
	
	Replay Markup Language (RML)
	=> Erm�glicht Administratoren SQL Abfragen und Befehle zu erfassen, erneut auszuf�hren
	und zu untersuchen => Um Probleme mit der Abfrageleistung & Ressourcenverbauch zu identifizieren
	und beheben

	Funktionen und Hauptmerkmale von RML:

	1. Workload-Replay: Zuvor erfasste Workload erneut abspielen

	2. Leistungsanalyse und Vergleichen: RML Workloads vor und nach �ndernungen
	(z.B Index�nderungen oder Abfrageoptimierungen) abspielen und die Leistung vergleichen

	3. Ermittlung problematische Abfragen: Zeit und Ressourcen der Abfragen

	4. Benutzer- und Sitzungs�berwachung:
	- Kann Abfragen einzelnen Benutzern und Sitzungen zuordner
	=> Hilfreich zum analysieren, wie bestimmte Benutzer oder Anwendungen die
	SQL Server Instanzen belasten

	5. Parallelisierung und Lasttests:
	- Unterst�tzt das parallele Abspiele von Workloads, was sich f�r Lasttests eignen


	Anwendungsf�lle:

	Migrationstests:
	- Beim verschieben der Datenbank auf eine neue Serverversion oder konfiguration, sorgt der 
	RML-Dienst das die Leistung erhalten bleibt oder verbessert wird

	Troubleshooting und Performance Tuning:
	- Durch erneutes Abspielen und Analysieren von Workloads lassen sich
	Leistungsprobleme erkennen und gezielt angehen.

	Kapazit�tsplanung und Skalierbarkeit
	- Unternehmen k�nnen simulieren, wie Ihre Workloads auf gr��eren Servern
	oder anderen Hardwarekonfigurationen laufen w�rden,
	um die Skalierbarkeit zu bewerten


*/