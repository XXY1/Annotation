#!/usr/bin/perl -w
use strict;

die "Usage: <input.gff> <out>!\n" unless @ARGV == 2;
open IN,"$ARGV[0]" or die $!;
open OUT,">$ARGV[1]" or die $!;
my($ngene,$len_gene,$nexon,$len_exon,$nCDS,$len_CDS,$nfive_prime_UTR,$len_five_prime_UTR,$nthree_prime_UTR,$len_three_prime_UTR)=(0,0,0,0,0,0,0,0,0,0);
my($maxgene,$mingene,$maxexon,$minexon,$maxCDS,$minCDS,$maxthree_prime_UTR,$maxfive_prime_UTR)=(0,0,0,0,0,0,0,0);
while(<IN>){
	next if(/^#/);
	next if(/^\s+/);
	chomp;
	my @t=split;
	my $len=$t[4]-$t[3];
	if($t[2] eq "gene" or $t[2] eq "mRNA"){
		$ngene++;
		$len_gene +=$len;
		if($mingene ==0){
			$mingene=$len;
		}else{
			if($mingene>$len){
				$mingene=$len;
			}
		}
		if($len>$maxgene){
			$maxgene=$len;
		}
	}elsif($t[2] eq "exon"){
		$nexon++;
		$len_exon +=$len;
		if($minexon ==0){
			$minexon=$len;
		}else{
			if($minexon>$len){
				$minexon=$len;
			}
		}
		if($len>$maxexon){
			$maxexon=$len;
		}
	}elsif($t[2] eq "CDS"){
		$nCDS++;
		$len_CDS +=$len;
		if($minCDS ==0){
			$minCDS=$len;
		}else{
			if($minCDS>$len){
				$minCDS=$len;
			}
		}
		if($len>$maxCDS){
			$maxCDS=$len;
		}
	}elsif($t[2] eq "three_prime_UTR"){
		$nthree_prime_UTR++;
		$len_three_prime_UTR +=$len;

		if($len>$maxthree_prime_UTR){
			$maxthree_prime_UTR=$len;
		}
	}elsif($t[2] eq "five_prime_UTR"){
		$nfive_prime_UTR++;
		$len_five_prime_UTR +=$len;

		if($len>$maxfive_prime_UTR){
			$maxfive_prime_UTR=$len;
		}
	}
}
print OUT "Total_gene_number\t$ngene\n";
print OUT "Total_gene_length\t$len_gene\n";
print OUT "Average_gene_length\t",$len_gene/$ngene,"\n";
print OUT "Longest_gene\t$maxgene\n";
print OUT "Smallest_gene\t$mingene\n";

print OUT "Total_exon_number\t$nexon\n";
print OUT "Total_exon_length\t$len_exon\n";
print OUT "Average_exon_length\t",$len_exon/$nexon,"\n";
print OUT "Longest_exon\t$maxexon\n";
print OUT "Smallest_exon\t$minexon\n";

print OUT "Total_CDS_number\t$nCDS\n";
print OUT "Total_CDS_length\t$len_CDS\n";
print OUT "Average_CDS_length\t",$len_CDS/$nCDS,"\n";
print OUT "Longest_CDS\t$maxCDS\n";
print OUT "Smallest_CDS\t$minCDS\n";
