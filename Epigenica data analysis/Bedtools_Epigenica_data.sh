# Run MACS3 with --broad
macs3 callpeak \
 -t my_experiment/final/bam/M2_S2_Donor1_S1_pooled.hg19.bam \
 -c my_experiment/final/bam/INP_Donor1_S1_pooled.hg19.bam \
 -f BAM \
 -g hs \
 -n Me_InHouse_Donor1 \
 --broad \
 --outdir my_experiment/peaks


 macs3 callpeak \
 -t my_experiment/final/bam/M4_S4_Donor1_S1_pooled.hg19.bam \
 -c my_experiment/final/bam/INP_Donor1_S1_pooled.hg19.bam \
 -f BAM \
 -g hs \
 -n Me_Commercial_Donor1 \
 --broad \
 --outdir my_experiment/peaks


 macs3 callpeak \
 -t my_experiment/final/bam/M3_S3_Donor1_S1_pooled.hg19.bam \
 -c my_experiment/final/bam/INP_Donor1_S1_pooled.hg19.bam \
 -f BAM \
 -g hs \
 -n Unmethylated_Donor1 \
 --outdir my_experiment/peaks


bedtools intersect \
  -a Me_InHouse_Donor1_peaks.broadPeak \
  -b ~/Epigenica_data/Klaudia_analysis_new/my_experiment/hg19_gencode.gtf \
  -wa -wb \
  > Me_InHouse_Annotated.txt


bedtools intersect \
  -a Me_Commercial_Donor1_peaks.broadPeak \
  -b ~/Epigenica_data/Klaudia_analysis_new/my_experiment/hg19_gencode.gtf \
  -wa -wb \
  > Me_Commercial_Annotated.txt



bedtools intersect \
  -a Unmethylated_Donor1_peaks.narrowPeak \
  -b ~/Epigenica_data/Klaudia_analysis_new/my_experiment/hg19_gencode.gtf \
  -wa -wb \
  > Unmethylated_Annotated.txt


# 1. Clean In-House Methylated List
 grep -o 'gene_name "[^"]*"' ~/Epigenica_data/Klaudia_analysis_new/my_experiment/my_experiment/peaks/Me_InHouse_Annotated.txt \
 | cut -d '"' -f 2 | sort | uniq \
 > ~/Epigenica_data/Klaudia_analysis_new/my_experiment/my_experiment/peaks/Genes_Methylated_InHouse.txt


# 2. Clean Commercial Methylated List
grep -o 'gene_name "[^"]*"' ~/Epigenica_data/Klaudia_analysis_new/my_experiment/my_experiment/peaks/Me_Commercial_Annotated.txt \
 | cut -d '"' -f 2 | sort | uniq \
 > ~/Epigenica_data/Klaudia_analysis_new/my_experiment/my_experiment/peaks/Genes_Methylated_Commercial.txt


# 3. Clean Unmethylated List
grep -o 'gene_name "[^"]*"' ~/Epigenica_data/Klaudia_analysis_new/my_experiment/my_experiment/peaks/Unmethylated_Annotated.txt \
 | cut -d '"' -f 2 | sort | uniq \
 > ~/Epigenica_data/Klaudia_analysis_new/my_experiment/my_experiment/peaks/Genes_Unmethylated.txt

# Verify that the pluripotency markers are silenced (methylated)
 echo "--- Checking Stem Cell Markers (Should be SILENCED) ---"
grep -E "POU5F1|NANOG|SOX2" Genes_Unmethylated.txt
grep -E "POU5F1|NANOG|SOX2" Genes_Methylated_InHouse.txt
grep -E "POU5F1|NANOG|SOX2" Genes_Methylated_Commercial.txt


# Verify that the PBMC makers are unmethylated

echo "--- Checking PBMC Identity (Should be UNMETHYLATED) ---"

# 1. Pan-Hematopoietic Marker (CD45)
echo "CD45 (PTPRC):"
grep "PTPRC" Genes_Unmethylated.txt

# 2. T-Cell Markers (CD3, CD4, CD8)
echo "T-Cell Markers:"
grep -E "CD3D|CD3E|CD4$|CD8A" Genes_Unmethylated.txt

# 3. B-Cell Marker (CD19, CD20)
echo "B-Cell Markers:"
grep -E "CD19|MS4A1" Genes_Unmethylated.txt

# 4. Monocyte Marker (CD14)
echo "Monocyte Marker:"
grep "CD14" Genes_Unmethylated.txt

# Verify that the housekeeping genes are unmethylated
echo "--- Housekeeping Genes ---"
grep -E "GAPDH|ACTB" Genes_Unmethylated.txt


