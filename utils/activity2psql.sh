#!/bin/bash

# first argument is the database user; second argument is the password

T="track_points";

for f in $(ls *.gpx); do
  ogr2ogr -append -f "PostgreSQL" PG:"host=openhydro.de user=$1 dbname=dwd password=$2" -dsco INIT_WITH_EPSG=yes -t_srs epsg:4326 "$f" track_points -nln $T track_points
echo Finished $f
done
