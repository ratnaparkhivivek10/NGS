# Example command to generate sequence reads.
perl ngs-read-simulator.pl -i chr22.fa -r 50 -n 1000 -o chr22.fastq

# Example bwa commands.
bwa index chr22.fa

bwa aln chr22.fa chr22.fastq > chr22.sai

bwa samse chr22.fa chr22.sai chr22.fastq > chr22.sam

# Command to calculate error rate.
perl alignment_eval.pl chr22.sam
