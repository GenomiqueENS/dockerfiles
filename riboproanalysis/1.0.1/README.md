RiboProAnalysis
===============

**RiboProAnalysis** is a pipeline for Ribosome Profiling analysis for all eukaryotic genome from Ensembl. 
It performs pre-processing steps (quality control, filtering, trimming and siez selection), reads mapping to rRNA and reference genome, counting on CDS for each gene and
differential analysis from raw Ribosome Profiling data.

##Use :
RiboProAnalysis can be used via a Docker image (URL) and a standard Bash script with several cases : it can performs demultiplexing on multiplexed FASTQ (reads MUST begin with the index sequence) and
use of RNA-seq counts to give a study of the mode of regulation of the translation.
If you use FASTQ files (no demultiplexing), the extension have to be .fastq

A configuration file .conf is mandatory to laucun the program. If there is no use of RNA-seq counts, a tabulated design file, target.txt, is needed.
User have to build rRNA and genome index before start with the pipeline.
If you have RNA-seq counts, files must be named : SAMPLENAME_mRNAcounts.txt

* Build Bowtie1 index for rRNA sequences
```
bowtie-build rRNA.fasta rRNA
```
* Build STAR index for reference genome
```
STAR --runMode genomeGenerate --genomeDir /path/to/genome/index --genomeFastaFiles /path/to/genome/fasta1 /path/to/genome/fasta2 ... --sjdbGTFfile /path/to/gtf/annotations \
--sjdbOverhang 28
```

Create a tmp/ directory in your working directory with command mkdir tmp/
 
Run RiboProAnalysis container with following command in the working directory :
````**docker run --rm --privileged --name ribopro -v /var/run/docker.sock:/var/run/docker.sock -v /etc/passwd:/etc/passwd -v $(pwd):/home -w /home** \
-v /path/to/rRNA/index:**/rRNAindexdirectory** -v /path/to/genome/index:**/genomeindexdirectory** -v /path/to/directory/containig/GTF/Ensembl75/annotations:**/root -v $(pwd)/tmp:/tmp **\
**genomicpariscentre/riboproanalysis bash -c "riboproanalysisDocker.sh** My_configuration_file.conf"
```

Run RiboProAnalysis bash program with following command in the working directory :
````
riboproanalysis.sh MyConfigurationFile.conf
```

### Available variables to set in the configuration file

| Variables                         | Explanation                                                                              | Choices/Examples                                                     | Default                            |                                           | 
|-----------------------------------|------------------------------------------------------------------------------------------|----------------------------------------------------------------------|------------------------------------|-------------------------------------------| 
| PATH_TO_GENOME_INDEX              | Absolute path to genome index previously built with STAR                                 | /absolute/path/to/genome/index/                                      | Mandatory (if not Docker mode)     |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| PATH_TO_rRNA_INDEX                | Absolute path to rRNA index previously built with Bowtie1                                | /absolute/path/to/rRNA/index                                         | Mandatory (if not Docker mode)     |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| PATH_TO_ANNOTATION_FILE           | Absolute path to GTF annotations file (Ensembl 75)                                       | /absolute/path/to/gtf/annotations                                    | Mandatory                          |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| USER_IDS                          | Result of the bash command : $(id -u):$(id -g)                                           | UserId:GroupId                                                       | Mandatory (if Docker mode)         |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| SAMPLE_ARRAY                      | Array containing sample names (if demultiplexing) or FASTQ file for each sample          | (Sample1 Sample 2 Sample 3) OR (Samp1.fastq Samp2.fastq Samp3.fastq) | Mandatory                          |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| ADAPTER_SEQUENCE_THREE_PRIME      | Adapter sequence for 3' trimming                                                         | AAAAAAAGGTCCTAA                                                      | Mandatory                          |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| STRANDED                          | Answer for stranded option of HTSeq-Count                                                | yes/no/reverse                                                       | Mandatory                          |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
|  PATH_TO_RAW_UNDEMULTIPLEXED_FILE | Absolute path to multiplexed FASTQ file                                                  | /absolute/path/to/multiplexed/fastq                                  | Mandatory for demultiplexing       |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| SAMPLE_INDEX_ARRAY                | Array containing 5' index used for demultiplexing. Respect same order as in SAMPLE_ARRAY |  so index match with respective sample name                          | (IndexSamp1 IndexSamp2 IndexSamp3) | Mandatory for demultiplexing. Never empty | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| ANSWER_DEMULTIPLEXING             | Option to launch demultiplexing step                                                     | YES / NO                                                             | NO                                 |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| ANSWER_REMOVE_PCR_DUPLICATES      | Option to launch PCR duplicates removing                                                 | YES / NO                                                             | NO                                 |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| ANSWER_RNASEQ_COUNTING            | Option to launch Babel OR SARTools for differential analysis                             | YES / NO                                                             | NO                                 |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| ANSWER_KEEP_MULTIREAD             | Option to keep multi-reads in a distinct SAM file                                        | YES / NO                                                             | NO                                 |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| DIFFERENTIAL_ANALYSIS_PACKAGE     | Choice of the R package launched by SARTools                                             | DESEQ2 / EDGER                                                       | EDGER                              |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| CONDITION_ARRAY                   | Array containig condition name of each sample respecting the same order                  | (Cond_Samp1 Cond_Samp2 Cond_Samp3)                                   | Mandatory with Babel               |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| AUTHOR                            | Author's name                                                                            | UserName                                                             | Mandatory for SARTools             |                                           | 
|                                   |                                                                                          |                                                                      |                                    |                                           | 
| REFERENCE_CONDITION               | Reference condition for the statistical analysis of SARTools                             | WT                                                                   | Mandatory for SARTools             |                                           | 


##Installation :
This software could be launched from a Docker container launcheing Docker containers itself, or from a Bash script launchine Docker containers.

You should :
* Install Docker on your computer
* Pull following docker images from the Genomic Paris Centre Docker public repository : 
	* genomicpariscentre/fastqc
	* genomicpariscentre/cutadapt
	* genomicpariscentre/bowtie1
	* genomicpariscentre/star:2.4.0k
	* genomicpariscentre/gff3-ptools
	* genomicpariscentre/samtools
	* genomicpariscentre/htseq
	* genomicpariscentre/babel
	* genomicpariscentre/sartools

* Pull RiboProAnalysis image

##Input files :

###Configuration file :
You have to create your configuration file .conf in the working directory. It is a little Bash script which is imported in the main Bash script.
You put mandatory and interesting variables presented in **Available variables to set in the configuration file**.
The syntax to declare a variable is :
```
export VARIABLE_NAME=MyVariable
```

###Target file (if SARTools is used) :
The target file should include following columns : label, files, group
* **label** the sample label
* **files** the Ribosome Profiling counts files. Syntaxe if demultiplexing : SAMPLENAME_htseq.txt (ex : sample MB1 --> MB1_htseq.txt). Syntaxe if no demultiplexing : BASENAME_FASTQFILE_htseq.txt (ex : file MB1.toto.fastq --> MB1.toto_htseq.txt)
IF you use Babel without demultiplexing, you have to name your FASTQ file : SAMPLENAME.fastq --> your file after HTSeq-Count will be SAMPLENAME_RPcounts.txt and your count files for RNA-seq will must be SAMPLENAME_mRNAcounts.txt.
* **group** the group/condition given to a sample

####Model of configuration file for run with Bash script
```
export PATH_TO_RAW_UNDEMULTIPLEXED_FILE=/import/disir01/bioinfo/RiboPro/Riboprotma_project/2015_240_NoIndex_L008_R1_001.fastq
export PATH_TO_GENOME_INDEX=/import/disir01/bioinfo/RiboPro/IndexAlignement/STAR/yeastGenomeEnsembl
export PATH_TO_rRNA_INDEX=/import/disir01/bioinfo/RiboPro/IndexAlignement/Bowtie1/rRNALevureNCBI
export PATH_TO_ANNOTATION_FILE=/import/rhodos01/shares-net/bioinfo/RiboPro/FichiersLevure/GenomeAnnotations_Ensembl/Saccharomyces_cerevisiae.R64-1-1.75.gtf
export ANSWER_DEMULTIPLEXING=YES
export ANSWER_REMOVE_PCR_DUPLICATES=YES
export ANSWER_RNASEQ_COUNTING=NO
export DIFFERENTIAL_ANALYSIS_PACKAGE=EDGER
export SAMPLE_ARRAY=(RT1 RT11 RT7 RT13)
export SAMPLE_INDEX_ARRAY=(NNNGGTTNN NNNAACCNN NNNTTAGNN NNNCGGANN)
export ADAPTER_SEQUENCE_THREE_PRIME=AGATCGGAAGAGCGGTTCAG
export STRANDED=yes
export AUTHOR=User
export REFERENCE_CONDITION=WildType
```

####Model of configuration file for run with Docker container
```
export USER_IDS=2747:100
export PATH_TO_RAW_UNDEMULTIPLEXED_FILE=$(pwd)/2015_240_NoIndex_L008_R1_001.fastq
export PATH_TO_ANNOTATION_FILE=/import/rhodos01/shares-net/bioinfo/RiboPro/FichiersLevure/GenomeAnnotations_Ensembl/Saccharomyces_cerevisiae.R64-1-1.75.gtf
export ANSWER_DEMULTIPLEXING=NO
export ANSWER_REMOVE_PCR_DUPLICATES=YES
export ANSWER_RNASEQ_COUNTING=YES
export SAMPLE_ARRAY=(RT1.fastq RT2.fastq RD1.fastq RD2.fastq)
export CONDITION_ARRAY=(RT RT RD RD)
export SAMPLE_INDEX_ARRAY=(NA)
export ADAPTER_SEQUENCE_THREE_PRIME=AGATCGGAAGAGCGGTTCAG
export STRANDED=yes
```

####Model of target.txt file
```
label	files	group
RT1	RT1_htseq.txt	RT
RT2	RT2_htseq.txt	RT
RD1	RD1_htseq.txt	RD
RD2	RD2_htseq.txt	RD
```

##Workflow :
![Pre-Processing steps](PreProcessingSteps.png)
![Pre-Processing steps](AlignmentAndCountingSteps.png)
![Pre-Processing steps](DifferentialAnalysisSteps.png)
