#!/bin/bash
bed=$1
loop=$2
genome=$3

lib=bin/
chmod 777 $lib/convert.loop.to.bb.pl
chmod 777 $lib/bedToBigBed
chrom_size=ref/${genome}.chrom.sizes

ln -s /mnt/rstor/genetics/JinLab/ssz20/zshanshan/human_islet/UCSC_bb/interact.as
$lib/convert.loop.to.bb.pl $chrom_size $bed $loop 1000 | bedtools sort > $loop.reformat
$lib/bedToBigBed -as=ref/interact.as -type=bed5+13 $loop.reformat $chrom_size $loop.bb
echo `cat $loop.reformat | wc -l` lines
cp $loop.bb ~/../fxj45/WWW/ssz20/bb/
echo track type=bigInteract name=$loop description=$loop useScore=true visibility=full bigDataUrl=http://intron.cwru.edu/~fxj45/ssz20/bb/$loop.bb color=0,0,0
