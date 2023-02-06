#!/usr/bin/perl
use strict;
my $usage = "Usage: pick.same.looping.pl <anchor_to_anchor_all_dynamic> <an2an_cell1_loops> <dummy> <an2an_cell2_loops> <dummy>\n";
my ($chrom_size,$anchor_bed,$loop,$score) = @ARGV;
my $size_hash;
open(IN, $chrom_size);
while(my $line= <IN>){
        chomp $line;
        my ($chr,$size)= split "\t", $line;
        $size_hash->{$chr}=$size;
}
close(IN);
my $anchor_chr_lis;
my $anchor_start_lis;
my $anchor_end_lis;
open(IN, $anchor_bed);
while(my $line= <IN>){
        chomp $line;
        my ($chr,$start,$end,$id)= split "\t", $line;
	my $chr_size=$size_hash->{$chr};
	if($end>$chr_size){
		$end=$chr_size;
	}
	$anchor_chr_lis->{$id}=$chr;
	$anchor_start_lis->{$id}=$start;
	$anchor_end_lis->{$id}=$end;
}
close(IN);
my $myhash;
my $NR=0;
#my $tmp_rank=1;
open(IN, $loop);
while(my $line= <IN>){
        chomp $line;
        my ($tmp_A1,$tmp_A2,$ratio)= split "\t", $line;
	$NR++;
	my $A1=$tmp_A1;
	my $A2=$tmp_A2;
	my @str1 = split /_/, $tmp_A1;
        my $ss1=@str1[1];
        my @str2 = split /_/, $tmp_A2;
        my $ss2=@str2[1];
        if($ss1 > $ss2){
                $A1=$tmp_A2;
		$A2=$tmp_A1;
        }
        my $chr=$anchor_chr_lis->{$A1};
	my $start=$anchor_start_lis->{$A1};
	my $end=$anchor_end_lis->{$A2};
	my $chr1=$anchor_chr_lis->{$A1};
	my $chr2=$anchor_chr_lis->{$A2};
	my $start1=$anchor_start_lis->{$A1};
	my $start2=$anchor_start_lis->{$A2};
	my $end1=$anchor_end_lis->{$A1};
	my $end2=$anchor_end_lis->{$A2};
	my $col="51,102,255";
	if($ratio>0){
		$col="255,102,0";
	}
        if($NR<100000){$score=999;}
        if($NR<200000 && $NR>=100000){$score=899;}
        if($NR<300000 && $NR>=200000){$score=799;}
        if($NR<400000 && $NR>=300000){$score=699;}
        if($NR<500000 && $NR>=400000){$score=599;}
        if($NR<600000 && $NR>=500000){$score=499;}
        if($NR<700000 && $NR>=600000){$score=399;}
        if($NR<800000 && $NR>=700000){$score=299;}
        if($NR<900000 && $NR>=800000){$score=199;}
        if($NR>=900000){$score=99;}
	print join("\t",$chr,$start,$end,".",$score,$ratio,".",$col,$chr1,$start1,$end1,$A1,".",$chr2,$start2,$end2,$A2,".")."\n";
}
close(IN);
exit;
