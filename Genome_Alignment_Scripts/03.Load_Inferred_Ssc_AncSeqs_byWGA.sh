#! /usr/bin/env sh


WorkDir=/Path_to_Your/ProgressiveCactus/MAF

cd $WorkDir

	chr=XX
	### Load into SQL by Chromosome
	# for chr in `seq 1 18; echo X Y`; do
	zgrep -v ^chr evolverSuids.$chr.maf.lst.New.gz > ./evolverSuids.$chr.maf.lst.New.tmp
	
echo "
-- ChrXX_AncSites.db
PRAGMA temp_store_directory = './';
.separator \t \n

DROP TABLE Chr_XX_Ref_Pos_Anc_Seq_WGA;

CREATE TABLE Chr_XX_Anc_Seq_WGA (chr char(2), pos integer(9),
								ref    char(1), 
								Anc    char(1), 
								sus    char(1),
								Suidae char(1)
							);
CREATE INDEX Chr_XX_Anc_Seq_WGA_idx ON Chr_XX_Anc_Seq_WGA (chr,pos);
.import ./evolverSuids.$chr.maf.lst.New.tmp Chr_XX_Anc_Seq_WGA

CREATE TABLE Chr_XX_Ref_Pos_Anc_Seq_WGA (chr char(2), pos integer(9), 
										ref                char(1), 
										Anc_Final          char(1),
										Conf_Final         varchar(17),
										Anc_WGA            char(1),
										Conf_WGA           varchar(17),
										Anc_MP             char(1), 
										Conf_MP            varchar(17)
									);
CREATE INDEX Chr_XX_Ref_Pos_Anc_Seq_WGA_idx ON Chr_XX_Ref_Pos_Anc_Seq_WGA (chr,pos);

INSERT INTO Chr_XX_Ref_Pos_Anc_Seq_WGA
SELECT a.chr, a.pos, 
	a.ref, 
	CASE 
		WHEN UPPER(a.Anc)=UPPER(b.Anc) and 
			(a.Anc IS NOT NULL and a.Anc!='-') and 
			(b.Anc IS NOT NULL and b.Anc!='-') and 
			((UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G') and 
			 (UPPER(a.Anc)='A' or UPPER(a.Anc)='T' or UPPER(a.Anc)='C' or UPPER(a.Anc)='G')) 
		THEN UPPER(b.Anc)
		WHEN UPPER(a.Anc)!=UPPER(b.Anc) or 
			a.Anc IS NULL or b.Anc IS NULL or 
			b.Anc!='-' or a.Anc!='-' or 
			(UPPER(b.Anc)!='A' and UPPER(b.Anc)!='T' and UPPER(b.Anc)!='C' and UPPER(b.Anc)!='G') or 
			(UPPER(a.Anc)!='A' and UPPER(a.Anc)!='T' and UPPER(a.Anc)!='C' and UPPER(a.Anc)!='G') 
		THEN '-'
	END Anc_Final,
	CASE 
		WHEN UPPER(a.Anc)=UPPER(b.Anc) and 
			(a.Anc IS NOT NULL and a.Anc!='-') and 
			(b.Anc IS NOT NULL and b.Anc!='-') and 
			((UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G') and 
			 (UPPER(a.Anc)='A' or UPPER(a.Anc)='T' or UPPER(a.Anc)='C' or UPPER(a.Anc)='G')) and
			(a.Conf LIKE '%High_Confidence%'   and (UPPER(b.Anc)=UPPER(b.sus) and UPPER(b.sus)=UPPER(b.Suidae))) 
		THEN 'High_Confidence'
		WHEN UPPER(a.Anc)=UPPER(b.Anc) and 
			(a.Anc IS NOT NULL and a.Anc!='-') and 
			(b.Anc IS NOT NULL and b.Anc!='-') and 
			((UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G') and 
			 (UPPER(a.Anc)='A' or UPPER(a.Anc)='T' or UPPER(a.Anc)='C' or UPPER(a.Anc)='G')) and
			(a.Conf LIKE '%Medium_Confidence%' and (UPPER(b.Anc)=UPPER(b.sus) and UPPER(b.sus)=UPPER(b.Suidae))) 
		THEN 'Medium_Confidence'
		WHEN UPPER(a.Anc)=UPPER(b.Anc) and 
			(a.Anc IS NOT NULL and a.Anc!='-') and 
			(b.Anc IS NOT NULL and b.Anc!='-') and 
			((UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G') and 
			 (UPPER(a.Anc)='A' or UPPER(a.Anc)='T' or UPPER(a.Anc)='C' or UPPER(a.Anc)='G')) and
			(a.Conf LIKE '%Low_Confidence%'    and (UPPER(b.Anc)=UPPER(b.sus) and UPPER(b.sus)=UPPER(b.Suidae))) 
		THEN 'Medium_Confidence'
		WHEN UPPER(a.Anc)=UPPER(b.Anc) and 
			(a.Anc IS NOT NULL and a.Anc!='-') and 
			(b.Anc IS NOT NULL and b.Anc!='-') and 
			((UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G') and 
			 (UPPER(a.Anc)='A' or UPPER(a.Anc)='T' or UPPER(a.Anc)='C' or UPPER(a.Anc)='G')) and
			(a.Conf LIKE '%High_Confidence%'   and (UPPER(b.Anc)=UPPER(b.sus) and UPPER(b.sus)!=UPPER(b.Suidae))) 
		THEN 'Medium_Confidence'
		WHEN UPPER(a.Anc)=UPPER(b.Anc) and 
			(a.Anc IS NOT NULL and a.Anc!='-') and 
			(b.Anc IS NOT NULL and b.Anc!='-') and 
			((UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G') and 
			 (UPPER(a.Anc)='A' or UPPER(a.Anc)='T' or UPPER(a.Anc)='C' or UPPER(a.Anc)='G')) and
			(a.Conf LIKE '%High_Confidence%'   and (UPPER(b.Anc)!=UPPER(b.sus) and UPPER(b.sus)=UPPER(b.Suidae))) 
		THEN 'Medium_Confidence'
		WHEN UPPER(a.Anc)=UPPER(b.Anc) and 
			(a.Anc IS NOT NULL and a.Anc!='-') and 
			(b.Anc IS NOT NULL and b.Anc!='-') and 
			((UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G') and 
			 (UPPER(a.Anc)='A' or UPPER(a.Anc)='T' or UPPER(a.Anc)='C' or UPPER(a.Anc)='G')) and
			((a.Conf LIKE '%Medium_Confidence%' or a.Conf LIKE '%Low_Confidence%') and 
			((UPPER(b.Anc)=UPPER(b.sus) and UPPER(b.sus)!=UPPER(b.Suidae)) or 
			 (UPPER(b.Anc)!=UPPER(b.sus) and UPPER(b.sus)=UPPER(b.Suidae))))
		THEN 'Low_Confidence'
	END Conf_Final,
	a.Anc Anc_MP,
	a.Conf Conf_MP,
	b.Anc Anc_WGA,
	CASE 
		WHEN (b.Anc IS NOT NULL and b.Anc!='-' and 
			  (UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G')) and 
			UPPER(b.Anc)=UPPER(b.sus) and UPPER(b.sus)=UPPER(b.Suidae)
		THEN 'High_Confidence'
		WHEN (b.Anc IS NOT NULL and b.Anc!='-' and 
			  (UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G')) and 
			UPPER(b.Anc)=UPPER(b.sus) and UPPER(b.sus)!=UPPER(b.Suidae)
		THEN 'Low_Confidence'
		WHEN (b.Anc IS NOT NULL and b.Anc!='-' and 
			  (UPPER(b.Anc)='A' or UPPER(b.Anc)='T' or UPPER(b.Anc)='C' or UPPER(b.Anc)='G')) and 
			UPPER(b.Anc)!=UPPER(b.sus) and UPPER(b.sus)=UPPER(b.Suidae) 
		THEN 'Low_Confidence'
	END Conf_WGA 
	FROM Chr_XX_Ref_Pos_Anc_Seq a LEFT JOIN Chr_XX_Anc_Seq_WGA b 
	ON a.pos=b.pos and a.chr=b.chr 
	;
	
DROP TABLE Chr_XX_Anc_Seq_WGA;
VACUUM;

.quit
" |sed "s/XX/$chr/g" > Chr${chr}_AncSeqs.db.sql

sqlite3 -init Chr${chr}_AncSeqs.db.sql ../../../Allele_Freq/Chr${chr}_AncSites.db << EOF
.quit
EOF

	rm Chr${chr}_AncSeqs.db.sql
	rm ./evolverSuids.$chr.maf.lst.New.tmp

	# done

date
echo Done
