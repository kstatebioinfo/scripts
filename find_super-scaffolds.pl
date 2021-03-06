#!/bin/perl
##################################################################################
#	
#	USAGE: perl find_super-scaffolds.pl PCTG_FILE
#	perl find_super-scaffolds.pl test.pctgs
#	Script lists changes gam-ngs has made to a genome assembly and reverts 
#	scaffold headers to original headers if they have not been altered by 
#	gam-ngs.
#
#	Created by jennifer shelton
#
##################################################################################
use strict;
use warnings;
use Text::Wrap;
$Text::Wrap::columns = 61; #includes terminal \n
# use List::Util qw(max);
# use List::Util qw(sum);
##################################################################################
############## 					  notes 					   ##################
##################################################################################
my $pctgs = $ARGV[0];
open (SUMMARY, '<', $pctgs) or die "can't open $pctgs!\n";

my ($PairedContig,$Size,$Assembly,$ContigID,$Begin,$End,$Reversed);
my $line=0;
my $firstBegin;
my (%keepnames,%losenames);
my @columns;
#Name	Size	Assembly	ContigID	Begin	End	Reversed
while (<SUMMARY>)
{
	unless (/^#/)
	{
		chomp;
		@columns=split/\t/;
		unless ($line==0)
		{
			
			###############################################
			########## check for new contig on paired #####
			###############################################
 			if (($PairedContig eq $columns[0])&&($ContigID ne $columns[3]))
 			{
				 $losenames{$columns[0]}=$columns[3];
				 print "\nSUPER-SCAFFOLD: $ContigID to $columns[3]\n";
 			}
			###############################################
			########## check for skipped contig       #####
			###############################################
			elsif (($PairedContig eq $columns[0])&&(($End + 1 ) != $columns[4])&& ($Reversed eq 'F')&&($columns[6] eq 'F'))
 			{
 				$losenames{$columns[0]}=$columns[3];
 				print "\nBROKEN SCAFFOLD: Prior: $PairedContig,$Assembly,$ContigID,$Begin,$End,$Reversed\n";
 				print "Next: $columns[0],$columns[2],$columns[3],$columns[4],$columns[5],$columns[6]\n";
 			}
 			###############################################
 			########## check for reversed sections    #####
 			###############################################
 			elsif ($columns[6] eq 'R')
 			{
 				print "\nPARTIALLY REVERSED SCAFFOLDED: $columns[3]\n";
 				$losenames{$columns[0]}=$columns[3];
 			}
 			################################################################
 			##########    check that the contig is still full length   #####
 			################################################################
 			if ($PairedContig ne $columns[0])
 			{
 				if (($firstBegin!=0)||(($Size-1) != $End))
 				{
 					$losenames{$PairedContig}=$ContigID;
 				}
 				elsif (!$losenames{$PairedContig})
 				{
 					$keepnames{$PairedContig}=$ContigID;
 				}

 			}
 			###############################################
 			##########    redefine the last contig    #####
 			###############################################
 			($PairedContig,$Size,$Assembly,$ContigID,$Begin,$End,$Reversed)=($columns[0],$columns[1],$columns[2],$columns[3],$columns[4],$columns[5],$columns[6]);
		}
		###############################################
		########## initialize first row     ###########
		###############################################
		###############################################
		## initialize the first entry for a paired ####
		###############################################
		if ($line==0)
		{
			
 			($PairedContig,$Size,$Assembly,$ContigID,$Begin,$End,$Reversed)=($columns[0],$columns[1],$columns[2],$columns[3],$columns[4],$columns[5],$columns[6]);
			$firstBegin=$Begin;
			++$line;
			
		}
		if (eof)
		{
 			if (($firstBegin!=0)||(($Size-1) != $End))
 			 {
 				$losenames{$columns[0]}=$columns[3];
 			 }
 			 elsif (!$losenames{$columns[0]}) 
 			{
 				$keepnames{$columns[0]}=$columns[3];
 			}
		}
	}
}
print "\n";
##################################################################################
##############		  Revert unaltered fasta headers		  ##################
##################################################################################
my $fasta=$ARGV[1];
open FASTA,'<', $fasta or die "Can't open $fasta\n!";
my $out=$ARGV[2];
open NEWFASTA,'>', $out or die "Can't open $out\n!";
$/ = ">"; ### each input will equal an entire fasta record
my $seq_count=0;
while (<FASTA>)
{
	unless (${seq_count} == 0) ## skip first record (it is a blank line)
	{
		s/>//g;
		my ($header, @seqLines) = split /\n/;
		if ($keepnames{$header})
		{
 			print NEWFASTA ">$keepnames{$header}\n";
 			@seqLines=join ('', @seqLines);
 			print NEWFASTA wrap('','',@seqLines);
 			print NEWFASTA "\n";
		}
		else
		{
 			print NEWFASTA ">$header\n";
 			@seqLines=join ('', @seqLines);
 			print NEWFASTA wrap('','',@seqLines);
 			print NEWFASTA "\n";
		}
	}
	else {$seq_count=1};
}


for my $con (keys %losenames)
{
	print "$con has been altered\n";
}

		
