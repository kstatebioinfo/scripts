#!/bin/perl

#  perl brute_force4.pl [integer_mass_table.txt]
#
#
#  Created by jennifer shelton on 11/17/13.
#
use strict;
use warnings;
use Math::Combinatorics;
use List::Util qw(sum);
######################################################################
######### catalog all aa's and coresponding masses ###################
######################################################################

my $mass_table=$ARGV[0];
open MASSES, '<', $mass_table or die "can't open $mass_table:$!";

my %my_try;
my %my_original;
while (<MASSES>)
{
    chomp;
    my($key,$value)=split / /;
    $my_try{$value}="$value ";
}
%my_original=%my_try;
my $goal_mass=1024;
# my $goal_mass=600;

############### add values ####################
sub my_add
{
    my ($sub_aminos)=$_[0];
    my @adding_aminos=split/ /,$sub_aminos;
    my $sum=sum(@adding_aminos);
    return $sum;
}

##################### create possible arrays ############
sub possible
{
    my $sub_answer=0;
    my $sub_sorted_hash=$_[0];
    my %sub_new_sorted_hash;
    for my $old_array (keys %{$sub_sorted_hash})
    {
        #########
        for my $aa_mass (keys %my_original)
        {
            my @new_array;
            my @olds_array=split/ /,$old_array;
            my @olds_array_sorted=sort @olds_array;
            push @new_array,$aa_mass;
            push @new_array,@olds_array_sorted;
            my @new_array_sorted = sort @new_array;
            my $key_n=join ' ',@new_array_sorted;
            my $key_o=join ' ',@olds_array_sorted;
            #            $ref->{'username'}
            my %combination;
            if ($sub_sorted_hash->{$key_o})
            {
                $sub_sorted_hash->{$key_n}=($sub_sorted_hash->{$key_o})+$aa_mass;
#                $sub_new_sorted_hash{$key_n}=$sub_sorted_hash->{$key_n};
                if ($sub_sorted_hash->{$key_n}<=$goal_mass)
                {
                    if ($sub_sorted_hash->{$key_n}==$goal_mass)
                    {
                        ########## find non-redundant permutations ######
                        my $combinat = Math::Combinatorics->new(count => (scalar(@new_array_sorted)),
                        data => [@new_array_sorted],
                        );
                        while(my @combo = $combinat->next_combination)
                        {
                            $combination{$combinat}=1;
                        }
                        
                        $sub_answer+= scalar(keys %combination);
                    }
                    elsif ($sub_sorted_hash->{$key_n}<$goal_mass)
                    {
                        $sub_new_sorted_hash{$key_n}=$sub_sorted_hash->{$key_n};
                        
                    }
                    
                }
            }
            elsif (!$sub_sorted_hash->{$key_o})
            {
                $sub_sorted_hash->{$key_o}=my_add($key_o);
                $sub_sorted_hash->{$key_n}=($sub_sorted_hash->{$key_o})+$aa_mass;
                if ($sub_sorted_hash->{$key_n} <=$goal_mass)
                {
                    if ($sub_sorted_hash->{$key_n}==$goal_mass)
                    {
                        ########## find non-redundant permutations ######
                        my $combinat = Math::Combinatorics->new(count => (scalar(@new_array_sorted)),
                        data => [@new_array_sorted],
                        );
                        while(my @combo = $combinat->next_combination)
                        {
                            $combination{$combinat}=1;
                        }
                        
                        $sub_answer+= scalar(keys %combination);
                    }
                    elsif ($sub_sorted_hash->{$key_n}<$goal_mass)
                    {
                        $sub_new_sorted_hash{$key_n}=$sub_sorted_hash->{$key_n};
                        
                    }
                    
                }
            }

        }
    }
    return $sub_answer,\%sub_new_sorted_hash;
}

################# call subs ###########################

my $answer=0;
while(1)
{
#    if (scalar keys(%my_try)==0){my %my_try};
    my ($return_answer,$return_sorted)=possible(\%my_try);
    $answer+=$return_answer;
    print "iteration x\n";
    print "$answer\n";
    %my_try=%{$return_sorted};
#    %sorted_hash=%{$return_sorted};
    next if (scalar keys(%my_try)!=0);
    last if (scalar keys(%my_try)==0);
}



############################

print "$answer\n";
