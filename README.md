# Example command to generate sequence reads.
perl ngs-read-simulator.pl -i chr22.fa -r 50 -n 1000 -o chr22.fastq

# Example bwa commands.
bwa index chr22.fa

bwa aln chr22.fa chr22.fastq > chr22.sai

bwa samse chr22.fa chr22.sai chr22.fastq > chr22.sam

# Sample log of each command.
#1 bwa index chr22.fa

[bwa_index] Pack FASTA... 1.08 sec
[bwa_index] Construct BWT for the packed sequence...
[BWTIncCreate] textLength=101636936, availableWord=19151484
[BWTIncConstructFromPacked] 10 iterations done. 31590664 characters processed.
[BWTIncConstructFromPacked] 20 iterations done. 58359704 characters processed.
[BWTIncConstructFromPacked] 30 iterations done. 82148056 characters processed.
[BWTIncConstructFromPacked] 40 iterations done. 101636936 characters processed.
[bwt_gen] Finished constructing BWT in 40 iterations.
[bwa_index] 87.74 seconds elapse.
[bwa_index] Update BWT... 0.51 sec
[bwa_index] Pack forward-only FASTA... 0.52 sec
[bwa_index] Construct SA from BWT and Occ... 21.66 sec
[main] Version: 0.7.12-r1039
[main] CMD: ./bwa index chr22.fa
[main] Real time: 111.773 sec; CPU: 111.518 sec

#2 bwa aln chr22.fa chr22.fastq > chr22.sai

[bwa_aln] 17bp reads: max_diff = 2
[bwa_aln] 38bp reads: max_diff = 3
[bwa_aln] 64bp reads: max_diff = 4
[bwa_aln] 93bp reads: max_diff = 5
[bwa_aln] 124bp reads: max_diff = 6
[bwa_aln] 157bp reads: max_diff = 7
[bwa_aln] 190bp reads: max_diff = 8
[bwa_aln] 225bp reads: max_diff = 9
[main] Version: 0.7.12-r1039
[main] CMD: ./bwa aln chr22.fa chr22.fastq
[main] Real time: 0.094 sec; CPU: 0.092 sec

#3 bwa samse chr22.fa chr22.sai chr22.fastq > chr22.sam

[main] Version: 0.7.12-r1039
[main] CMD: ./bwa samse chr22.fa chr22.sai chr22.fastq
[main] Real time: 0.004 sec; CPU: 0.004 sec
