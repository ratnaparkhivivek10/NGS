use warnings;
use strict;
use Bio::DB::Fasta;

use Getopt::Std;
use vars qw( $opt_i $opt_r $opt_n $opt_o);
# usage statement
my $usage = "ngs-read-simulator.pl - generate random reads from a genome.
Usage: perl script.pl options
 required:
  -i	fasta input file.
 optional:
  -r	read length [default = 50].
  -n	number of reads to generate [default = 1000].
  -o	fastq output file name [default = out.fq].

";

# command line processing.
getopts('i:r:n:o:');
die $usage unless ($opt_i);

my $nucleotide_input_file = $opt_i if $opt_i;
my $read_length	= $opt_r ? $opt_r : 50;
my $number_of_reads_to_generate	= $opt_n ? $opt_n : 1000;
my $nucleotide_output_file = $opt_o ? $opt_o : "out.fq";

# Open connection for writing fastq file
open my $nucleotide_output_file_fh, '>', $nucleotide_output_file or die "Could not open file '$nucleotide_output_file' $!";
my $db = Bio::DB::Fasta->new($nucleotide_input_file);
my @ids = $db->get_all_primary_ids;

my $read_count = 1;

while( $read_count <= $number_of_reads_to_generate ) {
	# Pick a random DNA sequence
	my $chromosome_name = $ids[int( rand(@ids) )];
	my $chromosome_size = $db->length( $chromosome_name );
	my $random_start_position = int( rand($chromosome_size - $read_length) );
	my $end_position = $random_start_position + $read_length-1; #[)
	
	# DNA sequence mutated by introducing 0.01% error rate
	my $seq_read = mutate_sequence($db->seq($chromosome_name, $random_start_position => $end_position));

	# Write output to fastq file
	print $nucleotide_output_file_fh "\@SEQ_ID:$chromosome_name:$random_start_position:$end_position\n";
	print $nucleotide_output_file_fh "$seq_read\n";
	print $nucleotide_output_file_fh "+\n";	
	print $nucleotide_output_file_fh get_dummy_quality_value_seq($read_length),"\n";
	
	$read_count++;
}

# Pick a random position in the DNA
sub get_random_position {
	return int( rand($read_length) );
}

# Pick a random nucleotide
sub get_random_base {
	my @bases = ('A', 'T', 'G', 'C');
	return $bases[ int( rand(@bases) ) ];
}

# Only substitution mutation is handled
sub mutate_sequence {
	my $seq = shift;
	substr( $seq, get_random_position(), 1, get_random_base() );
	return $seq;
}

# Sanger format can encode a Phred quality score from 0 to 93 using ASCII 33 to 126
# Reference: http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2847217/
sub get_encoded_quality_values {
	return chr( int( 33+rand(127-33) ) );
}

# Pick a sequence of random quality values
sub get_dummy_quality_value_seq {
	my $read_length = shift;
	my $qual_value_seq = '';
	$qual_value_seq .= get_encoded_quality_values() for(1..$read_length);
	return $qual_value_seq;
}