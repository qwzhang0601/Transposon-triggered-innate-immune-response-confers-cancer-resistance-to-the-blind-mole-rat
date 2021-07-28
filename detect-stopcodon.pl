#!/usr/bin/perl -w
use strict;


open IN, "<$ARGV[0]";
open OUT, ">align-with-no-stop.txt";
$/="Score";
while (<IN>){
    
    if ($_=~ /\*/){
        
    }else{
        print OUT $_;
    }
}
close IN;
close OUT;