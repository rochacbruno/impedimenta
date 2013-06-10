#!/usr/bin/env sh

region='us-northeast-latest'
random=`echo $RANDOM | sed -e :a -e 's/^.\{1,7\}$/&0/;ta'`

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
    --mapname=$random \
    bounds
mkgmap \
    --route \
    --add-pois-to-areas \
    --bounds=bounds \
    --index \
    --gmapsupp \
    --mapname=$random \
    6324*.osm.pbf
