#!/usr/bin/env sh

region='us-northeast-latest'

wget http://download.geofabrik.de/north-america/${region}.osm.pbf
splitter ${region}.osm.pbf
osmconvert ${region}.osm.pbf --out-o5m > ${region}.o5m
osmfilter ${region}.o5m \
    --keep-nodes= \
    --keep-ways-relations="boundary=administrative =postal_code postal_code=" \
    --out-o5m \
    > ${region}-boundaries.o5m
java -cp /usr/share/java/mkgmap/mkgmap.jar \
    uk.me.parabola.mkgmap.reader.osm.boundary.BoundaryPreprocessor \
    ${region}-boundaries.o5m \
    bounds
mkgmap \
    --route \
    --add-pois-to-areas \
    --bounds=bounds \
    --index \
    --gmapsupp \
    6324*.osm.pbf
