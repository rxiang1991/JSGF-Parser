#!/usr/bin/perl 

use strict; 

sub substring() { 
    my ($str, $maxlen) = @_; 
    my $trim = 0; 
    return $str if (length($str) <= $maxlen); 

    ### Count length of chinese charaters 
    (my $cn = substr($str,0,$maxlen)) =~ s/[^\x7f-\xff]//g; 

    ### if the length is not the multiple of 3, trim the redundant chars 
    $trim = length($cn) % 3; 

    ### get the substring 
    my $retval = substr($str,0,$maxlen-$trim); 

    ### recursion to get the remain string 
    return " $retval" . &substring(substr($str,$maxlen-$trim),$maxlen); 
#    return "$retval\n" . &substring(substr($str,$maxlen-$trim),$maxlen); 
} 

my $input_file = shift;
my $str = `cat $input_file`; 
print &substring($str, 3) . "\n"; 


=pod
http://www.programgo.com/article/86393910360/
=cut


