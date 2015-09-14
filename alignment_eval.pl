use warnings;
use strict;

my $sam_file = $ARGV[0];
open my $sam_file_fh, '<', $sam_file or die "Could not open file '$sam_file' $!";

my $total = 0;
my $unaligned = 0;

foreach my $line ( <$sam_file_fh> ) {
	if($line !~ m/^@/) {
		my @sam_fields = split(/\t/, $line);
		my ($chromosome_name, $start_pos) = get_chromosome_name_and_start_pos( $sam_fields[0] );
		#my $rname = $sam_fields[2];
		my $pos = $sam_fields[3];
		
		$unaligned++ if $start_pos != $pos;
	}
	$total++;
	
}close($sam_file_fh);

print "Total unaligned reads: $unaligned\n";
print "Total reads: $total\n";
print "Error rate: ($unaligned/$total)*100";
print " = ";
printf "%.2f", (($unaligned/$total)*100);
print "%\n";

sub get_chromosome_name_and_start_pos {
	return ( split(/:/, shift) )[1, 2];
}
