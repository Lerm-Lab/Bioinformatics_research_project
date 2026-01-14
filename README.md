# Bioinformatics_research_project
# Epigenica and Illumina data analysis
#
This repository contains code and information from Klaudia who has analyzed the samples.
# Contact information
Klaudia Orfin
Uppsala Univeristy 
klaudia.orfin.8677@student.uu.se

Supervisor: Shumaila Sayyab 
Linköping University 
shumaila.sayyab@liu.se

Step 1 - Running MINUTE on test data
Test data was analysed following the protocol from Kumar et al., 2025 _Multiplexed chromatin immunoprecipitation sequencing for quantitative study of histone modifications and chromatin factors. 
_ The test data was downloaded from their GitHub repositories, MINUTE was installed and run locally to see that the pipeline functions correctly on (histone) data. The results from the test data are not part of this repository. 

Step 2 - Running MINUTE on the PBMC samples (after sequencing)

The MINUTE pipeline was run according to Epigenica's instructions. All the necessary files (excluding the data itself) are found in the 'MINUTE run' folder. 
These steps were followed to run MINUTE:
1. conda activate minute
2. mkdir hg19_reference
3. download hg19.fa.gz from UCSC
4. download hg19-blacklist.v2.bed.gz from UCSC
5. bowtie2-build hg19.fa.gz hg19
6. setting up directories to point to the data files
7. initializing minute run by specifying the barcodes.tsv file, the directory where FASTQ files are and which FASTQ pair is the input sample:
minute init my_experiment --reads data --barcodes barcodes.tsv --input INP
8. This created a directory named 'my_experiment' and inside it:
- A fastq directory pointing to the location of the original data directory
- A pair of files, groups.tsv, libraries.tsv, ready to use
- A template minute.yaml to configure the parameters of the run
9. minute.yaml file was edited so that:
- the reference genome is hg19
- specified a path to BED files with regions to exclude (the file from step 4.)
- the length of the 5' UMI was set to 8
- fragment size was set to 470
- max barcode errors was set to 1
- mapping quality was set to 0
- mapping quality bigwig was set to 20
- aligner: bowtie2
10. minute run (this run took ~8h)


Step 3 - Data analysis with deepTools
Data analysis files and plots can be found in 'Epigenica data analysis' folder. 

Step 4 - Data analysis of Illumina 850k EPIC Array data
Data analysis files can be found under the corresponding folder. 

Step 5 - Comparing lists of genes from Epigenica and the Array
The gene lists and code can be found under 'Method comparison'.

The project report is available in the main repository as a pdf file.
