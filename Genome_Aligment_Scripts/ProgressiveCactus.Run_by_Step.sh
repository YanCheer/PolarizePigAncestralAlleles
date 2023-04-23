## generated by : cactus-prepare ../evolverSuids.withOut.txt --outDir ./ --outSeqFile ./evolverSuids.withOut.seq --outHal ./evolverSuids.hal --jobStore ./jobstore --defaultCores 22 --defaultMemory 800G
## date : 2023-03-04 17:33:32.386535
## cactus commit : 2d6c076af80c66f4948dade61043e68c6bec5a47

## Preprocessor
cactus-preprocess ./jobstore/0 ../evolverSuids.withOut.txt ./evolverSuids.withOut.seq --inputNames Horse Cow Sceb --realTimeLogging --logInfo --retryCount 0 --maxCores 22 --maxMemory 745.1Gi
cactus-preprocess ./jobstore/1 ../evolverSuids.withOut.txt ./evolverSuids.withOut.seq --inputNames Phac_wart Pota_river Ssc_DNSE --realTimeLogging --logInfo --retryCount 0 --maxCores 22 --maxMemory 745.1Gi
cactus-preprocess ./jobstore/2 ../evolverSuids.withOut.txt ./evolverSuids.withOut.seq --inputNames Ssc_Duroc Ssc_euw1 --realTimeLogging --logInfo --retryCount 0 --maxCores 22 --maxMemory 745.1Gi

## Alignment

### Round 0
cactus-blast ./jobstore/3 ./evolverSuids.withOut.seq ./afr.cigar --root afr --maxCores 22 --maxMemory 745.1Gi
cactus-align ./jobstore/4 ./evolverSuids.withOut.seq ./afr.cigar ./afr.hal --root afr --maxCores 22 --maxMemory 745.1Gi
hal2fasta ./afr.hal afr --hdf5InMemory > ./afr.fa 

cactus-blast --restart ./jobstore/5 ./evolverSuids.withOut.seq ./euro.cigar --root euro --maxCores 22 --maxMemory 745.1Gi
cactus-align ./jobstore/6 ./evolverSuids.withOut.seq ./euro.cigar ./euro.hal --root euro --maxCores 22 --maxMemory 745.1Gi
hal2fasta ./euro.hal euro --hdf5InMemory > ./euro.fa 

### Round 1
cactus-blast ./jobstore/7 ./evolverSuids.withOut.seq ./ssc.cigar --root ssc --maxCores 22 --maxMemory 745.1Gi 
cactus-align ./jobstore/8 ./evolverSuids.withOut.seq ./ssc.cigar ./ssc.hal --root ssc --maxCores 22 --maxMemory 745.1Gi 
hal2fasta ./ssc.hal ssc --hdf5InMemory > ./ssc.fa 

### Round 2
cactus-blast ./jobstore/9 ./evolverSuids.withOut.seq ./sus.cigar --root sus --maxCores 22 --maxMemory 745.1Gi
cactus-align ./jobstore/10 ./evolverSuids.withOut.seq ./sus.cigar ./sus.hal --root sus --maxCores 22 --maxMemory 745.1GiGi
hal2fasta ./sus.hal sus --hdf5InMemory > ./sus.fa

### Round 3
cactus-blast ./jobstore/11 ./evolverSuids.withOut.seq ./Suidae.cigar --root Suidae --maxCores 22 --maxMemory 745.1Gi
cactus-align ./jobstore/12 ./evolverSuids.withOut.seq ./Suidae.cigar ./Suidae.hal --root Suidae --maxCores 22 --maxMemory 745.1Gi
hal2fasta ./Suidae.hal Suidae --hdf5InMemory > ./Suidae.fa

### Round 4
cactus-blast ./jobstore/13 ./evolverSuids.withOut.seq ./Cetartiodactyla.cigar --root Cetartiodactyla --maxCores 22 --maxMemory 745.1Gi
cactus-align ./jobstore/14 ./evolverSuids.withOut.seq ./Cetartiodactyla.cigar ./Cetartiodactyla.hal --root Cetartiodactyla --maxCores 22 --maxMemory 745.1Gi
hal2fasta ./Cetartiodactyla.hal Cetartiodactyla --hdf5InMemory > ./Cetartiodactyla.fa

### Round 5
cactus-blast ./jobstore/15 ./evolverSuids.withOut.seq ./Anc0.cigar --root Anc0 --maxCores 22 --maxMemory 745.1Gi
cactus-align ./jobstore/16 ./evolverSuids.withOut.seq ./Anc0.cigar ./evolverSuids.hal --root Anc0 --maxCores 22 --maxMemory 745.1Gi
hal2fasta ./evolverSuids.hal Anc0 --hdf5InMemory > ./Anc0.fa

## HAL merging
halAppendSubtree ./evolverSuids.hal ./Cetartiodactyla.RefAll.hal Cetartiodactyla Cetartiodactyla --merge --hdf5InMemory
halAppendSubtree ./evolverSuids.hal ./Suidae.RefAll.hal Suidae Suidae --merge --hdf5InMemory
halAppendSubtree ./evolverSuids.hal ./sus.RefAll.hal sus sus --merge --hdf5InMemory
halAppendSubtree ./evolverSuids.hal ./ssc.RefAll.hal ssc ssc --merge --hdf5InMemory
halAppendSubtree ./evolverSuids.hal ./afr.RefAll.hal afr afr --merge --hdf5InMemory
halAppendSubtree ./evolverSuids.hal ./euro.RefAll.hal euro euro --merge --hdf5InMemory
