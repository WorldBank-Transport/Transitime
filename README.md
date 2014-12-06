Transitime
==========

Code for improving accuracy of GTFS schedules using transit Automatic Vehicle Location (AVL) data, obtained via GPS.

Software developed by Michael Smith (Transitime,  http://transitime.github.io/core/), in collaboration with the World Bank. 

There are three steps required for generating the more accurate GTFS stop_times files:

1.	Loading existing GTFS configuration data into the database
2.	Processing GPS based AVL data to determine accurate arrival and departure times for each stop.
3.	Using statistics to determine optimal schedule based on arrival and departure times and output that information into new GTFS stop_times.txt files.

See Word document "CreatingMoreAccurateStopTimes.docx" in the repository for full instructions. 

Output from the script, "stop_times.txt_new ", may be imported into the Open Transit Tools application (https://github.com/WorldBank-Transport/open-transit-indicators) for generating system on-time performance indictors and maps. 
