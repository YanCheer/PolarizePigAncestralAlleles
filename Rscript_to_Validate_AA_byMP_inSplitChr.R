chr	pos	    ref	 Babi	Bush	Cwart	Dwart	Pygmy	Redhog	Sbar	Scebi	Scele	Sver
1	548663	A	 A	     A		A		A		A		A		A		A		A		A
1	548664	T	 T	     T		T		T		T		T		T		T		T		T
1	548665	T	 T	     T		T		T		T		T		T		T		T		T
1	548666	T	 T	     T		T		T		T		T		T		T		T		T
1	548667	A	 A	     A		A		A		A		A		A		A		A		A
1	548668	T	 T	     T		T		T		T		T		T		T		T		T
1	548669	T	 T	     T		T		T		T		T		T		T		T		T
1	548670	T	 T	     T		T		T		T		T		T		T		T		T
1	548671	G	 C	     G		G		G		G		G		G		G		G		G
############ The above is an example of Chr%s_AncSites.txt #################################


AncSeqs = read.table(sprintf("./AAA_Temp/Chr%s_AncSites.txt", "Chr_name"), header=T, fill=NA, stringsAsFactors=F)
AncSeqs$AA = NA; AncSeqs$Conf = NA
AncSeqs = AncSeqs[,c(1:3,c(length(colnames(AncSeqs))-1, length(colnames(AncSeqs))),4:(length(colnames(AncSeqs))-2))]

AncSeqs_v2 = c()
for(i in 1:length(AncSeqs$pos)){
  O1=NA; O2=NA; O3=NA
  tmp = AncSeqs[i,]
  if(i==1){write.table(sprintf("Running for Chr%s at position %d (%f Percent) on %s.", "Chr_name", tmp$pos, i/length(AncSeqs$pos)*100, date()), "./AAA_Results_New/Chr_name/Running_for_Chr_name.log", append=F, quote=F, col.names=F, row.names=F)}
  if(i>1 & i%%5000==0){write.table(sprintf("Running for Chr%s at position %d (%f Percent) on %s.", "Chr_name", tmp$pos, i/length(AncSeqs$pos)*100, date()), "./AAA_Results_New/Chr_name/Running_for_Chr_name.log", append=T, quote=F, col.names=F, row.names=F)}

  if(tmp$Anc_Babirusa!=""){O3=tmp$Anc_Babirusa
    if(tmp$Anc_Sus_cebifrons!=""){O1=tmp$Anc_Sus_cebifrons}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus!=""){O1=tmp$Anc_Sus_barbatus}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis!=""){O1=tmp$Anc_Sus_celebensis}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis=="" & tmp$Anc_Sus_verrucosus!=""){O1=tmp$Anc_Sus_verrucosus}    
    if(tmp$Anc_Redriverhog!=""){O2=tmp$Anc_Redriverhog}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog!=""){O2=tmp$Anc_Commonwarthog}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig!=""){O2=tmp$Anc_Bushpig}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig=="" & tmp$Anc_Desertwarthog!=""){O2=tmp$Anc_Desertwarthog}
	if(!is.na(O1) & !is.na(O2) & !is.na(O3) & (O1!="" & O2!="" & O3!="")){
	  if(O1==O2 & O2==O3){tmp$AA=O1; tmp$Conf="High_Confidence"}
	  if(O1==O2 & O2!=O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2==O3){tmp$AA=O2; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O1==O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2!=O3 & O1!=O3){
		if(tmp$ref==O1){tmp$AA=O1; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O2){tmp$AA=O2; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O3){tmp$AA=O3; tmp$Conf="Low_Confidence"}}
	  AncSeqs_v2 = rbind(AncSeqs_v2, tmp)}}
    
  if(tmp$Anc_Babirusa=="" & tmp$Anc_Pygmyhog!=""){O2=tmp$Anc_Pygmyhog
    if(tmp$Anc_Sus_cebifrons!=""){O1=tmp$Anc_Sus_cebifrons}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus!=""){O1=tmp$Anc_Sus_barbatus}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis!=""){O1=tmp$Anc_Sus_celebensis}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis=="" & tmp$Anc_Sus_verrucosus!=""){O1=tmp$Anc_Sus_verrucosus}	
    if(tmp$Anc_Redriverhog!=""){O3=tmp$Anc_Redriverhog}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog!=""){O3=tmp$Anc_Commonwarthog}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig!=""){O3=tmp$Anc_Bushpig}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig=="" & tmp$Anc_Desertwarthog!=""){O3=tmp$Anc_Desertwarthog}
	if(!is.na(O1) & !is.na(O2) & !is.na(O3) & (O1!="" & O2!="" & O3!="")){
	  if(O1==O2 & O2==O3){tmp$AA=O1; tmp$Conf="High_Confidence"}
	  if(O1==O2 & O2!=O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2==O3){tmp$AA=O2; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O1==O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2!=O3 & O1!=O3){
		if(tmp$ref==O1){tmp$AA=O1; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O2){tmp$AA=O2; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O3){tmp$AA=O3; tmp$Conf="Low_Confidence"}}
	  AncSeqs_v2 = rbind(AncSeqs_v2, tmp)}}
	
  if(tmp$Anc_Babirusa=="" & tmp$Anc_Pygmyhog==""){
    if( (length(which(tmp[,c(7:9,11)]!=""))>=2 & length(which(tmp[,c(12:15)]!=""))>=1) ){
      if(tmp$Anc_Sus_cebifrons!=""){O1=tmp$Anc_Sus_cebifrons}
      if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus!=""){O1=tmp$Anc_Sus_barbatus}
      if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis!=""){O1=tmp$Anc_Sus_celebensis}
      if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis=="" & tmp$Anc_Sus_verrucosus!=""){O1=tmp$Anc_Sus_verrucosus}	  
      if(tmp$Anc_Redriverhog!=""){O2=tmp$Anc_Redriverhog
	    if(tmp$Anc_Commonwarthog!=""){O3=tmp$Anc_Commonwarthog}
		if(tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig!=""){O3=tmp$Anc_Bushpig}
		if(tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig=="" & tmp$Anc_Desertwarthog!=""){O3=tmp$Anc_Desertwarthog}}
      if(tmp$Anc_Redriverhog==""){
	    if(tmp$Anc_Commonwarthog!=""){O2=tmp$Anc_Commonwarthog
	      if(tmp$Anc_Bushpig!=""){O3=tmp$Anc_Bushpig}
		  if(tmp$Anc_Bushpig=="" & tmp$Anc_Desertwarthog!=""){O3=tmp$Anc_Desertwarthog}}
		if(tmp$Anc_Commonwarthog==""){O2=tmp$Anc_Bushpig; O3=tmp$Anc_Desertwarthog}}}	
    if( (length(which(tmp[,c(7:9,11)]!=""))>=1 & length(which(tmp[,c(12:15)]!=""))>=2) ){
      if(tmp$Anc_Redriverhog!=""){O3=tmp$Anc_Redriverhog}
      if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog!=""){O3=tmp$Anc_Commonwarthog}
      if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig!=""){O3=tmp$Anc_Bushpig}
      if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig=="" & tmp$Anc_Desertwarthog!=""){O3=tmp$Anc_Desertwarthog}      
      if(tmp$Anc_Sus_cebifrons!=""){O2=tmp$Anc_Sus_cebifrons
	    if(tmp$Anc_Sus_barbatus!=""){O3=tmp$Anc_Sus_barbatus}
		if(tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis!=""){O3=tmp$Anc_Sus_celebensis}
		if(tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis=="" & tmp$Anc_Sus_verrucosus!=""){O3=tmp$Anc_Sus_verrucosus}}
      if(tmp$Anc_Sus_cebifrons==""){
	    if(tmp$Anc_Sus_barbatus!=""){O2=tmp$Anc_Sus_barbatus
	      if(tmp$Anc_Sus_celebensis!=""){O3=tmp$Anc_Sus_celebensis}
		  if(tmp$Anc_Sus_celebensis=="" & tmp$Anc_Sus_verrucosus!=""){O3=tmp$Anc_Sus_verrucosus}}
		if(tmp$Anc_Sus_barbatus==""){O2=tmp$Anc_Sus_celebensis; O3=tmp$Anc_Sus_verrucosus}}}
	if(!is.na(O1) & !is.na(O2) & !is.na(O3) & (O1!="" & O2!="" & O3!="")){
	  if(O1==O2 & O2==O3){tmp$AA=O1; tmp$Conf="High_Confidence"}
	  if(O1==O2 & O2!=O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2==O3){tmp$AA=O2; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O1==O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2!=O3 & O1!=O3){
		if(tmp$ref==O1){tmp$AA=O1; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O2){tmp$AA=O2; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O3){tmp$AA=O3; tmp$Conf="Low_Confidence"}}
	  AncSeqs_v2 = rbind(AncSeqs_v2, tmp)}}
	  
  if(tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_celebensis=="" & tmp$Anc_Sus_verrucosus==""){
    O1=tmp$Anc_Pygmyhog; O3=tmp$Anc_Babirusa
	if(tmp$Anc_Redriverhog!=""){O2=tmp$Anc_Redriverhog}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog!=""){O2=tmp$Anc_Commonwarthog}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig!=""){O2=tmp$Anc_Bushpig}
    if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig=="" & tmp$Anc_Desertwarthog!=""){O2=tmp$Anc_Desertwarthog}
	if(!is.na(O1) & !is.na(O2) & !is.na(O3) & (O1!="" & O2!="" & O3!="")){
	  if(O1==O2 & O2==O3){tmp$AA=O1; tmp$Conf="High_Confidence"}
	  if(O1==O2 & O2!=O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2==O3){tmp$AA=O2; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O1==O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2!=O3 & O1!=O3){
		if(tmp$ref==O1){tmp$AA=O1; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O2){tmp$AA=O2; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O3){tmp$AA=O3; tmp$Conf="Low_Confidence"}}
	  AncSeqs_v2 = rbind(AncSeqs_v2, tmp)}}

  if(tmp$Anc_Redriverhog=="" & tmp$Anc_Commonwarthog=="" & tmp$Anc_Bushpig=="" & tmp$Anc_Desertwarthog==""){
    O2=tmp$Anc_Pygmyhog; O3=tmp$Anc_Babirusa
    if(tmp$Anc_Sus_cebifrons!=""){O1=tmp$Anc_Sus_cebifrons}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus!=""){O1=tmp$Anc_Sus_barbatus}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis!=""){O1=tmp$Anc_Sus_celebensis}
    if(tmp$Anc_Sus_cebifrons=="" & tmp$Anc_Sus_barbatus=="" & tmp$Anc_Sus_celebensis=="" & tmp$Anc_Sus_verrucosus!=""){O1=tmp$Anc_Sus_verrucosus}    
	if(!is.na(O1) & !is.na(O2) & !is.na(O3) & (O1!="" & O2!="" & O3!="")){
	  if(O1==O2 & O2==O3){tmp$AA=O1; tmp$Conf="High_Confidence"}
	  if(O1==O2 & O2!=O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2==O3){tmp$AA=O2; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O1==O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2 & O2!=O3 & O1!=O3){
		if(tmp$ref==O1){tmp$AA=O1; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O2){tmp$AA=O2; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O3){tmp$AA=O3; tmp$Conf="Low_Confidence"}}
	  AncSeqs_v2 = rbind(AncSeqs_v2, tmp)}}
	
	if(!is.na(O1) & !is.na(O2) & (is.na(O3) | O3=="") & (O1!="" & O2!="")){
	  if(O1==O2){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O2){
		if(tmp$ref==O1){tmp$AA=O1; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O2){tmp$AA=O2; tmp$Conf="Low_Confidence"}}
	  AncSeqs_v2 = rbind(AncSeqs_v2, tmp)}
	if(!is.na(O1) & (is.na(O2) | O2=="") & !is.na(O3) & (O1!="" & O3!="")){
	  if(O1==O3){tmp$AA=O1; tmp$Conf="Medium_Confidence"}
	  if(O1!=O3){
		if(tmp$ref==O1){tmp$AA=O1; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O3){tmp$AA=O3; tmp$Conf="Low_Confidence"}}
	  AncSeqs_v2 = rbind(AncSeqs_v2, tmp)}
	if((is.na(O1) | O1=="") & !is.na(O2) & !is.na(O3) & (O2!="" & O3!="")){
	  if(O2==O3){tmp$AA=O2; tmp$Conf="Medium_Confidence"}
	  if(O2!=O3){
		if(tmp$ref==O2){tmp$AA=O2; tmp$Conf="Low_Confidence"}
		if(tmp$ref==O3){tmp$AA=O3; tmp$Conf="Low_Confidence"}}
	  AncSeqs_v2 = rbind(AncSeqs_v2, tmp)}
}
write.table(AncSeqs_v2, sprintf("./AAA_Results_New/Chr%s/Chr%s_AncSites.AA_Polarized_byMP.txt", "Chr_name", "Chr_name"), quote=F, sep="\t", col.names=T, row.names=F)
