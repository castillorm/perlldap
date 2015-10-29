#!/usr/bin/perl
#
# @File SimpleLDAPQuery.pl
# @Author Rod Castillo
# @Created Oct 29, 2015 6:09:09 AM
#

use strict;
use warnings;
 
#use Net::LDAP;
use Net::LDAPS;

my $server = "$Server_Host_Name";

# Use the below line for LDAP
#my $ldap = Net::LDAP->new( $server ) or die $@;
# Use the below line for LDAPS
my $ldap = Net::LDAPS->new( $server ) or die $@;

# Use the below line to bind with userid and password
$ldap->bind ( "cn=Directory Manager",
            password =>"$password",
            version =>3);
 
my $result = $ldap->search(
    base   => "dc=lab,dc=com",
    filter => "(objectclass=*)",
);
 
die $result->error if $result->code;
 
printf "COUNT: %s\n", $result->count;
 
foreach my $entry ($result->entries) {
    $entry->dump;
}
print "===============================================\n";
 
foreach my $entry ($result->entries) {
    printf "%s <%s>\n",
        $entry->get_value("displayName"),
        ($entry->get_value("mail") || '');
}
 
$ldap->unbind;
