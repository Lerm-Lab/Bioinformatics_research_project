# 1. Load required libraries
library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene) 
library(clusterProfiler)

# 2. Load your MACS3 Peak files 
peaks_M2 <- readPeakFile("Me_InHouse_Donor1_peaks.broadPeak")
peaks_M4 <- readPeakFile("Me_Commercial_Donor1_peaks.broadPeak")

# 3. Annotate the peaks relative to hg19 TSS regions
anno_M2 <- annotatePeak(peaks_M2, tssRegion=c(-3000, 3000), 
                        TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene, annoDb="org.Hs.eg.db")

anno_M4 <- annotatePeak(peaks_M4, tssRegion=c(-3000, 3000), 
                        TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene, annoDb="org.Hs.eg.db")

# 4. Generate the Comparison Bar Plot
peakAnnoList <- list(InHouse_M2 = anno_M2, Commercial_M4 = anno_M4)

png("Genomic_Distribution_Comparison_M2_M4.png", width=1000, height=600)
plotAnnoBar(peakAnnoList, main="Genomic Feature Distribution: In-House vs. Commercial MBD")
dev.off()

# 5. Generate a Pie chart for M2
png("Genomic_Annotation_M2.png", width=800, height=600)
plotAnnoPie(anno_M2, main="\nGenomic Distribution of In-House MBD (M2) Peaks")
dev.off()
