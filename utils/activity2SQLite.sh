#!/bin/bash

DB="tracks.sqlite";
T="track_points";

spatialite $DB "alter table $T add column trackname text;"

for f in $(ls *.gpx); do
  LASTROW=$(spatialite $DB "SELECT COUNT(ROWID) FROM $T");
  ogr2ogr -append -f "SQLite" -dsco SPATIALITE=yes -dsco INIT_WITH_EPSG=yes -t_srs epsg:4326 $DB "$f" track_points -nln $T track_points
  spatialite $DB "UPDATE $T SET trackname='$f' WHERE ROWID>$LASTROW";
done
