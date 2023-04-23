#! /usr/env perl
use strict;
# use warnings;

my $maf="evolverSuids.YY.maf.gz";
my $output="evolverSuids.YY.maf.lst.New.gz";
my $ref="Ssc_Duroc";
my @species=("Ssc_Duroc","ssc","sus","Suidae");

open O,"| gzip - > $output";
my @head=("chr","pos",@species);
my $head=join "\t",@head;
print O "$head\n";

my $control=0;
my $content="";
open I,"zcat $maf |";
while(<I>){
	my $RefRef=0;
	# print "$_";
    next if(/^#/);
    if(/^a/){
        $content=$_;
		# print "$content\n";
        while(<I>){
            if(/^s/){
	my ($s,$chr,$start,$alignment_length,$strand,$sequence_length,$sequence)=split(/\s+/,$_);
	$chr=~/^([^\.]+)\.(.*)/;
	my $species=$1;
	if($species eq $ref){
		$RefRef=$RefRef+1;
		# print "$RefRef\n";
		if($RefRef==1){
			$content.=$_;
		}
	}
	if($species ne $ref){
		$content.=$_;
	}	
	# print "$content\n";
            }
            else{
	last;
            }
        }
		# print "$content\n";
        &analysis($content);
    }
    # last if($control++>=0);
}
close I;
close O;

sub analysis{
    my $content=shift;
    my @line=split(/\n/,$content);
    # my $head=shift @line;
    # $head=~/score=([\d\.]+)/;
    # my $score=$1;
    # # print "$score\n";
    my %pos;
    my $isRefFound=0;
    my $ref_chr="NA";
    foreach my $line(@line){
		# print "$line\n";
        my @a=split(/\s+/,$line);
        my ($s,$chr,$start,$alignment_length,$strand,$sequence_length,$sequence)=@a;
        $chr=~/^([^\.]+)\.(.*)/;
        my $species=$1;
        $chr=$2;
        if($species eq $ref){
            $ref_chr=$chr;
            $isRefFound=1;
            my @base=split(//,$sequence);
            if($strand eq "+"){
	my $pos=$start;
	for(my $i=0;$i<@base;$i++){
	    if($base[$i] ne "-"){
	        $pos++;
	        $pos{$i}=$pos;
	    }
	}
            }
            if($strand eq "-"){
	my $pos=$start;
	for(my $i=0;$i<@base;$i++){
	    if($base[$i] ne "-"){
	        $pos++;
	        my $real_pos = $sequence_length-1-($pos-1)+1;
	        $pos{$i}=$real_pos;
	    }
	}
            }
        }
    }
    if($isRefFound == 0){
        die "$ref not found!\nspecies name should be added before chr such as chr01 should be cattle.chr01\n";
    }
    my %data;
    foreach my $line(@line){
        my @a=split(/\s+/,$line);
        my ($s,$chr,$start,$alignment_length,$strand,$sequence_length,$sequence)=@a;
        $chr=~/^([^\.]+)\.(.*)/;
        my $species=$1;
        $chr=$2;
        my @base=split(//,$sequence);
        for(my $i=0;$i<@base;$i++){
            next if(!exists $pos{$i});
            my $pos=$pos{$i};
            $data{$pos}{$species}=$base[$i];
        }
    }
    my @output_line;
    foreach my $pos(sort {$a<=>$b} keys %data){
        @output_line=($ref_chr,$pos);
        foreach my $species(@species){
	my $base="-";
	if(exists $data{$pos}{$species}){
	    $base = $data{$pos}{$species};
	}
	push @output_line,$base;
            }
        my $output_line=join "\t",@output_line;
        print O "$output_line\n";
    }
}
