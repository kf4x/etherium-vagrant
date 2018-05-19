#! /bin/bash

# Author: Javier Chavez

APP_DB_NAME=$1

apt-get install -qq libxml2-dev libproj-dev libjson0-dev xsltproc docbook-xsl docbook-mathml
apt-get install -qq libgdal1-dev



#############################
#           GEOS            #
#############################
wget --quiet http://download.osgeo.org/geos/geos-3.6.2.tar.bz2
tar xfj geos-3.6.2.tar.bz2
cd geos-3.6.2
./configure --quiet
make --quiet
make --quiet install
cd ..
rm -rf geos-3.6.2
rm -rf geos-3.6.2.tar.bz2

#############################
#         PostGIS           #
#############################
wget --quiet http://download.osgeo.org/postgis/source/postgis-2.4.3.tar.gz
tar xfz postgis-2.4.3.tar.gz
cd postgis-2.4.3
./configure --quiet
make --quiet
make --quiet install
ldconfig
make --quiet comments-install
cd ..
rm -rf postgis-2.4.3
rm -rf postgis-2.4.3.tar.gz


ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/shp2pgsql
ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/pgsql2shp
ln -sf /usr/share/postgresql-common/pg_wrapper /usr/local/bin/raster2pgsql


#GDAL bin
apt-get install -qq gdal-bin


# Add extensions to the Database
cat << EOF | su - postgres -c psql
\connect $APP_DB_NAME;
CREATE EXTENSION postgis;
-- Enable Topology
CREATE EXTENSION postgis_topology;
EOF