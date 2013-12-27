#!/bin/perl
##################################################################################
#   
#	USAGE: perl find_super-scaffolds.pl
#	perl find_super-scaffolds.pl test.pctgs
#
#  Created by jennifer shelton
#
##################################################################################
use strict;
use warnings;
# use List::Util qw(max);
# use List::Util qw(sum);
##################################################################################
##############                      notes                       ##################
##################################################################################
my $pctgs = $ARGV[0];
open (SUMMARY, '<', $pctgs) or die "can't open $pctgs!\n";
$pctgs =~ /(.*).pctgs/;
print "$1\n";
open (OUT, '>', "$1.txt") or die "can't open $1.txt\n";
my ($PairedContig,$Assembly,$ContigID,$Begin,$End,$Reversed);
my $line=0;
my %super_scaff;
my @columns;
#Name	Size	Assembly	ContigID	Begin	End	Reversed
while (<SUMMARY>)
{
	unless (/^#/)
	{
		unless ($line==0)
		{
			chomp;
			@columns=split/\t/;
			
			###############################################
			########## check for new contig on paired #####
			###############################################
 			if (($PairedContig eq $columns[0])&&($ContigID ne $columns[3]))
 			{
				 push @{ $super_scaff{$columns[0]} },$columns[3];
				 print "$ContigID ne $columns[3]\n";
 			}
			###############################################
			########## check for skipped contig       #####
			###############################################
			elsif (($PairedContig eq $columns[0])&&(($End + 1 ) != $columns[4])&& ($Reversed eq 'F')&&($columns[6] eq 'F'))
 			{
 				print OUT "Prior: $PairedContig,$Assembly,$ContigID,$Begin,$End,$Reversed\n";
 				print OUT "Next: $columns[0],$columns[2],$columns[3],$columns[4],$columns[5],$columns[6]\n";
 			}
		($PairedContig,$Assembly,$ContigID,$Begin,$End,$Reversed)=($columns[0],$columns[2],$columns[3],$columns[4],$columns[5],$columns[6]);
		}
		###############################################
		########## initialize first row     ###########
		###############################################
		###############################################
		## initialize the first entry for a paired ####
		###############################################
		elsif (($line==0)||($PairedContig ne $columns[0]))
		{
			chomp;
			@columns=split/\t/;
		($PairedContig,$Assembly,$ContigID,$Begin,$End,$Reversed)=($columns[0],$columns[2],$columns[3],$columns[4],$columns[5],$columns[6]);
			push @{ $super_scaff{$columns[0]} },$columns[3];
			++$line;
			
		}
	}
}
		
