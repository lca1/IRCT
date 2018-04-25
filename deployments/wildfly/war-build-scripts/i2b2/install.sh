#!/usr/bin/env bash
set -e

AXIS2_VERSION="1.7.1"
AXIS2_LOGLEVEL="INFO"
I2B2_SRC_DIR="/tmp/i2b2-src"
I2B2_VERSION="tags/b1.7.10.003-QA"
I2B2_SERVICE_PASSWORD="pFjy3EjDVwLfT2rB9xkK"
I2B2_FR_FILES_DIR="$JBOSS_HOME/standalone/data/i2b2_FR_files"

# get axis2 war
pushd "$JBOSS_WAR_DEPLOYMENTS"
touch "i2b2.war.skipdeploy"
wget "http://archive.apache.org/dist/axis/axis2/java/core/$AXIS2_VERSION/axis2-$AXIS2_VERSION-war.zip"
mkdir "i2b2.war"
unzip -j "axis2-$AXIS2_VERSION-war.zip" "axis2.war"
unzip "axis2.war" -d "i2b2.war"
rm "axis2.war" "axis2-$AXIS2_VERSION-war.zip"
sed -i "/^log4j.rootCategory=/c\log4j.rootCategory=$AXIS2_LOGLEVEL, CONSOLE" i2b2.war/WEB-INF/classes/log4j.properties
popd

# get i2b2 sources & patch them
git init "$I2B2_SRC_DIR"
pushd "$I2B2_SRC_DIR"
git remote add origin https://github.com/i2b2/i2b2-core-server.git
git pull --depth=1 origin $I2B2_VERSION
git apply "$BUILD_SCRIPTS_FOLDER/i2b2/patches/"*.diff
popd

# write data sources
pushd "$BUILD_SCRIPTS_FOLDER/i2b2"
export  I2B2_DB_PASSWORD="pFjy3EjDVwLfT2rB9xkK" \
        I2B2_DEMO_DB_NAME="i2b2" \
        I2B2_SRC_DIR
bash write-datasources.sh
popd

# compile and deploy i2b2 cells
pushd "$I2B2_SRC_DIR"

## i2b2 core cell
pushd edu.harvard.i2b2.server-common
sed -i "/jboss.home/c\jboss.home=$JBOSS_HOME" build.properties
ant clean dist deploy jboss_pre_deployment_setup copy_new_jdbc_jar
popd

## i2b2 PM cell
pushd edu.harvard.i2b2.pm
sed -i "/jboss.home/c\jboss.home=$JBOSS_HOME" build.properties
ant -f master_build.xml clean build-all deploy
popd

## i2b2 ONT cell
pushd edu.harvard.i2b2.ontology
sed -i "/jboss.home/c\jboss.home=$JBOSS_HOME" build.properties
sed -i "/edu.harvard.i2b2.ontology.applicationdir/c\edu.harvard.i2b2.ontology.applicationdir=$JBOSS_HOME/standalone/configuration/ontologyapp" etc/spring/ontology_application_directory.properties
sed -i "/ontology.ws.pm.url/c\ontology.ws.pm.url=http://localhost:8080/i2b2/services/PMService/getServices" etc/spring/ontology.properties
sed -i "/edu.harvard.i2b2.ontology.ws.fr.url/c\edu.harvard.i2b2.ontology.ws.fr.url=http://localhost:8080/i2b2/services/FRService/" etc/spring/ontology.properties
sed -i "/edu.harvard.i2b2.ontology.ws.crc.url/c\edu.harvard.i2b2.ontology.ws.crc.url=http://localhost:8080/i2b2/services/QueryToolService" etc/spring/ontology.properties
sed -i "/edu.harvard.i2b2.ontology.pm.serviceaccount.password/c\edu.harvard.i2b2.ontology.pm.serviceaccount.password=$I2B2_SERVICE_PASSWORD" etc/spring/ontology.properties
ant -f master_build.xml clean build-all deploy
popd

## i2b2 CRC cell
pushd edu.harvard.i2b2.crc
sed -i "/jboss.home/c\jboss.home=$JBOSS_HOME" build.properties
sed -i "/edu.harvard.i2b2.crc.applicationdir/c\edu.harvard.i2b2.crc.applicationdir=$JBOSS_HOME/standalone/configuration/crcapp" etc/spring/crc_application_directory.properties
sed -i "/edu.harvard.i2b2.crc.loader.ws.fr.url/c\edu.harvard.i2b2.crc.loader.ws.fr.url=http://localhost:8080/i2b2/services/FRService/" etc/spring/edu.harvard.i2b2.crc.loader.properties
sed -i "/edu.harvard.i2b2.crc.loader.ws.pm.url/c\edu.harvard.i2b2.crc.loader.ws.pm.url=http://localhost:8080/i2b2/services/PMService/getServices" etc/spring/edu.harvard.i2b2.crc.loader.properties
sed -i "/edu.harvard.i2b2.crc.loader.ds.lookup.servertype/c\edu.harvard.i2b2.crc.loader.ds.lookup.servertype=PostgreSQL" etc/spring/edu.harvard.i2b2.crc.loader.properties
sed -i "/queryprocessor.ws.pm.url/c\queryprocessor.ws.pm.url=http://localhost:8080/i2b2/services/PMService/getServices" etc/spring/crc.properties
sed -i "/queryprocessor.ds.lookup.servertype/c\queryprocessor.ds.lookup.servertype=PostgreSQL" etc/spring/crc.properties
sed -i "/queryprocessor.ws.ontology.url/c\queryprocessor.ws.ontology.url=http://localhost:8080/i2b2/services/OntologyService/getTermInfo" etc/spring/crc.properties
sed -i "/edu.harvard.i2b2.crc.delegate.ontology.url/c\edu.harvard.i2b2.crc.delegate.ontology.url=http://localhost:8080/i2b2/services/OntologyService" etc/spring/crc.properties
sed -i "/edu.harvard.i2b2.crc.lockout.setfinderquery.count/c\edu.harvard.i2b2.crc.lockout.setfinderquery.count=-1" etc/spring/crc.properties
sed -i "/edu.harvard.i2b2.crc.pm.serviceaccount.password/c\edu.harvard.i2b2.crc.pm.serviceaccount.password=$I2B2_SERVICE_PASSWORD" etc/spring/crc.properties
ant -f master_build.xml clean build-all deploy
popd

## i2b2 WORK cell
pushd edu.harvard.i2b2.workplace
sed -i "/jboss.home/c\jboss.home=$JBOSS_HOME" build.properties
sed -i "/edu.harvard.i2b2.workplace.applicationdir/c\edu.harvard.i2b2.workplace.applicationdir=$JBOSS_HOME/standalone/configuration/workplaceapp" etc/spring/workplace_application_directory.properties
sed -i "/workplace.ws.pm.url/c\workplace.ws.pm.url=http://localhost:8080/i2b2/services/PMService/getServices" etc/spring/workplace.properties
ant -f master_build.xml clean build-all deploy
popd

## i2b2 FR cell
pushd edu.harvard.i2b2.fr
sed -i "/jboss.home/c\jboss.home=$JBOSS_HOME" build.properties
sed -i "/edu.harvard.i2b2.fr.applicationdir/c\edu.harvard.i2b2.fr.applicationdir=$JBOSS_HOME/standalone/configuration/frapp" etc/spring/fr_application_directory.properties
sed -i "/edu.harvard.i2b2.fr.ws.pm.url/c\edu.harvard.i2b2.fr.ws.pm.url=http://localhost:8080/i2b2/services/PMService/getServices" etc/spring/edu.harvard.i2b2.fr.properties
ant -f master_build.xml clean build-all deploy
mkdir -p "$I2B2_FR_FILES_DIR"
popd

## i2b2 IM cell
pushd edu.harvard.i2b2.im
sed -i "/jboss.home/c\jboss.home=$JBOSS_HOME" build.properties
sed -i "/edu.harvard.i2b2.im.applicationdir/c\edu.harvard.i2b2.im.applicationdir=$JBOSS_HOME/standalone/configuration/imapp" etc/spring/im_application_directory.properties
sed -i "/im.ws.pm.url/c\im.ws.pm.url=http://localhost:8080/i2b2/services/PMService/getServices" etc/spring/im.properties
ant -f master_build.xml clean build-all deploy
popd

popd

# deploy axis2 / i2b2 cells
pushd "$JBOSS_WAR_DEPLOYMENTS"
touch "i2b2.war.dodeploy"
rm "i2b2.war.skipdeploy"
popd
