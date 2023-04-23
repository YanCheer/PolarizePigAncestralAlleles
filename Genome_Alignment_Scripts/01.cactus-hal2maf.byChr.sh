#! /usr/bin/env sh

ScriptDir=/Path_to_Your/ProgressiveCactus/Scripts
WorkDir=/Path_to_Your/ProgressiveCactus/MAF

cd $WorkDir

chr=XX
cactus-hal2maf ./jobstore/$chr ../evolverSuids.hal ./evolverSuids.$chr.maf.gz --refGenome Ssc_Duroc --refSequence $chr --chunkSize 1000000 --maxCores 22 --maxMemory 745.1Gi


date
echo Done
