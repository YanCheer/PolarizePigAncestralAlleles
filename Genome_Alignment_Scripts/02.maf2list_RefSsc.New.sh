#! /usr/bin/env sh

ScriptDir=/Path_to_Your/ProgressiveCactus/Scripts
WorkDir=/Path_to_Your/ProgressiveCactus/MAF


cd $WorkDir
chr=XX
sed "s/YY/$chr/g" $ScriptDir/01.convertMaf2List.YC.pl > $ScriptDir/01.convertMaf2List.YC.pl.Chr$chr
perl $ScriptDir/01.convertMaf2List.YC.pl.Chr$chr
rm $ScriptDir/01.convertMaf2List.YC.pl.Chr$chr

