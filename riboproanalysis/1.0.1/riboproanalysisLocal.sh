#!/bin/bash

#########################################################################
## 								       ##
## This script runs all steps of a Ribosome Profiling analysis         ##
##								       ##
## Version 1.0.0						       ##
## Maintener : Alexandra Bomane <bomane@biologie.ens.fr>	       ##
##								       ##
#########################################################################

########################## Variables section #############################
## Environment

export WORKDIR=$(pwd)

# Import configuration (.conf) file edited by th user
source $1

# Allow to stop the program after an error, BUT doesn't display the error
#set -e

if [ ! -e tmp/ ]
then
        mkdir -p tmp/
fi

export TMPDIR=$(readlink -f tmp/)

## Scripts

# Main Bash script

MAIN_SCRIPT_CANONICAL_PATH=$(readlink -f $0) ## basename $0
CANONICAL_PATH=$(dirname $MAIN_SCRIPT_CANONICAL_PATH)

# Python and R scripts paths
export PYTHON_SCRIPTS_PATH="${CANONICAL_PATH}/PythonScripts"
export R_SCRIPTS_PATH="${CANONICAL_PATH}/RScripts"

export PYTHON_SCRIPT_DEMULTIPLEXING="run_demultiplexing.py"
export PYTHON_SCRIPT_REMOVE_PCR_DUP="rmDupPCR.py"
export PYTHON_SCRIPT_REMOVE_BAD_IQF="remove_bad_reads_Illumina_passing_filter.py"
export PYTHON_SCRIPT_READ_LENGTH_DISTRIBUTION="read_length_distribution.py"
export PYTHON_SCRIPT_SAM_FILTERING="sam_file_filter.py"
export PYTHON_SCRIPT_LONGEST_TRANSCRIPT="get_longest_transcripts_from_ensembl_gtf.py"

# R scripts
export R_SCRIPT_BUILD_COUNTING_TABLE_RNASEQ="RNAseqCountDataMatrix.R"
export R_SCRIPT_BUILD_COUNTING_TABLE_RP="RPCountDataMatrix.R"
export R_SCRIPT_ANADIFF_BABEL="babel_RP_differentialAnalysis.R"
export R_SCRIPT_PERMT_TEST_BABEL="babel_RP_permutationTest.R"
export R_SCRIPT_ANADIFF_SARTOOLS_DESEQ2="script_DESeq2.R"
export R_SCRIPT_ANADIFF_SARTOOLS_EDGER="script_edgeR.R"

export WORKING_SAMPLE_ARRAY=$(echo ${SAMPLE_ARRAY[*]})

WORKING_SAMPLE_INDEX_ARRAY=$(echo ${SAMPLE_INDEX_ARRAY[*]})

export $WORKING_SAMPLE_INDEX_ARRAY

export SAMPLES=($(echo ${SAMPLE_ARRAY[@]%.fastq}))

WORKING_CONDITION_ARRAY=$(echo ${CONDITION_ARRAY[*]})

export SHELL=$(type -p bash)

export PROJECT_NAME=$(basename $1 .conf)



### Tools parameters


	## 3' trimming : Cutadapt

export MIN_READ_LENGTH="25"

	## Align to rRNA sequences : Bowtie 1

export BOWTIE_OPTIONS="-q -S --un"

		# Bowtie 1 Options details : -q --> Fastq file as input ; --un --> write unaligned reads to another file (.fastq) ; -S --> write hits in SAM format

	## HTSeq-Count

export MODE_FOR_MULTIPLE_FEATURES_READS="union"
export FEATURE_TYPE="CDS"
export IDATTR="gene_id"
export FILETYPE="bam"

###########################################################################

# We run the demultiplexing to get our Fastq files
# $1 = SAMPLE $2 = ADAPTER

demultiplexing()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
		then
			LOGFILE="$1_demultiplexing.log"
			OUTFILE=$1_demultiplex.fastq
		
			if [ -s $LOGFILE ]
			then
				return
			else
				echo "Starting of demultiplexing :"

				$PYTHON_SCRIPT_DEMULTIPLEXING -i $PATH_TO_RAW_UNDEMULTIPLEXED_FILE -o $OUTFILE -a $2 > $LOGFILE && cat $LOGFILE

				if [ ! -s $OUTFILE ]
				then
					echo "run_demultiplexing cannot run correctly !"
					exit 1
				fi
	
				echo "End of demultiplexing."
			fi
		else
			return
		fi
	}

# We run FastQC to check input
# $1 = directory output ; $2 = input

fastqc_quality_control()
	{
		if [ -e $1 ]
                then
                        NB_FILE_IN_DIR_=$(ls -R $1 | wc -l)

                        let NB_FILE_IN_DIR=$NB_FILE_IN_DIR-1

                        if [ $NB_FILE_IN_DIR -gt 1 ]
                        then
                                return
                        fi
                else
                        mkdir -p $1

                        if [ $? -ne 0 ]
                        then
                                echo "$1 cannot be created !"
                                exit 1
                        fi
                                echo "Starting of FastQC :"

				docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home genomicpariscentre/fastqc:0.11.2 bash -c "fastqc -o $1 $2"

                        if [ $? -ne 0 ]
                        then
                                echo "FastQC cannot run correctly !"
                                exit 1
                        fi
				echo "End of FastQC."
                fi
	}

export -f fastqc_quality_control 

# We run FastQC to check our demultiplexing
# This function will be renamed raw_quality_control_report()

raw_quality_report()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
		then
			DIR_RAW_FASTQ_REPORT="$1_raw_fastqc_report"
			INPUT_RAW_FASTQ="$1_demultiplex.fastq"
		else
                        INPUT_RAW_FASTQ="${1}.fastq"
		fi
			DIR_RAW_FASTQ_REPORT="$1_raw_fastqc_report"
		
		if [ -s $INPUT_RAW_FASTQ ]
		then
			fastqc_quality_control $DIR_RAW_FASTQ_REPORT $INPUT_RAW_FASTQ
		else
			echo "$INPUT_RAW_FASTQ doesn't exist"
			exit 1
		fi
	}

# We remove bas passing filter reads
removeBadIQF()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
		then
                        INPUT_FASTQ="$1_demultiplex.fastq"
		else
                        INPUT_FASTQ="$1.fastq"
		fi
			LOGFILE="$1_rmIQF.log"
			RM_BADIQF_OUTPUT="$1_rmIQF.fastq"

		if [ -s $LOGFILE ] && [ -s $RM_BADIQF_OUTPUT ]
		then
			return
		else
			echo "Removing bad IQF :"

			$PYTHON_SCRIPT_REMOVE_BAD_IQF -i $INPUT_FASTQ -o $RM_BADIQF_OUTPUT > $LOGFILE && cat $LOGFILE

			if [ $? -ne 0 ]
			then
				echo "Removing bad IQF cannot run correctly !"
				exit 1
			fi

			echo "End of removing bad IQF"
		fi
	}

# Check remove bad passing filter
removeBadIQF_report()
	{
		RM_BADIQF_DIR="$1_rmIQF_report"
                RM_IQF_INPUT="$1_rmIQF.fastq"

		if [ -s $RM_IQF_INPUT ]
		then
			fastqc_quality_control $RM_BADIQF_DIR $RM_IQF_INPUT
		else
			echo "$RM_IQF_INPUT doesn't exist"
			exit 1
		fi
	}

# Remove PCR duplicates --> % Amplification in log file
removePCRduplicates()

	{
		WORKING_ANSWER_REMOVE_PCR_DUPLICATES=${ANSWER_REMOVE_PCR_DUPLICATES^^}

		if [ $WORKING_ANSWER_REMOVE_PCR_DUPLICATES = YES ]
		then
			LOGFILE="$1_rmPCR.log"
			RM_PCRDUP_OUTPUT="$1_rmPCR.fastq"
			RM_PCRDUP_INPUT="$1_rmIQF.fastq"
		
			if [ -s $RM_PCRDUP_INPUT ]
			then
				if [ -s $RM_PCRDUP_OUTPUT ] && [ -s $LOGFILE ]
				then
					return
				else
					echo "Removing PCR duplicates :"

					awk '{ i=(NR-1) % 4; tab[i]=$0 ; if (i==3) { print tab[1]"\t"tab[0]"\t"tab[3]"\t"tab[2]} }' $RM_PCRDUP_INPUT | sort | $PYTHON_SCRIPT_REMOVE_PCR_DUP -i $RM_PCRDUP_INPUT -o $RM_PCRDUP_OUTPUT > $LOGFILE && cat $LOGFILE

					if [ ! -s $RM_PCRDUP_OUTPUT ]
					then
						echo "Cannot run rmDupPCR correctly !"
						exit 1
					fi

					echo "End of PCR duplicates removing."
				fi
			else
				echo "You need a file which was filtered on bad Illumina Qualitiy Filter (_rmIQF.fastq) !"
				exit 1
			fi
		else
			return
		fi
	}

# We run the 5' trimming

Index_Adapter_trimming()
	{
		WORKING_ANSWER_REMOVE_PCR_DUPLICATES=${ANSWER_REMOVE_PCR_DUPLICATES^^}
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
		then
			INDEX_TRIM_OUTPUT="$1_TrimIndex.fastq"
			
			if [ $WORKING_ANSWER_REMOVE_PCR_DUPLICATES = YES ]
			then
				INDEX_TRIM_INPUT="$1_rmPCR.fastq"
			else
				INDEX_TRIM_INPUT="$1_rmIQF.fastq"
			fi
			
			INDEX_LENGTH=$(expr length $2)			

			LOGFILE="$1_TrimIndex.log"

			if [ -s $INDEX_TRIM_OUTPUT ]
			then
				return
			else
		
				echo "Index adapter trimming :"

				docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home genomicpariscentre/cutadapt:1.7.1 bash -c "cutadapt -u $INDEX_LENGTH -o $INDEX_TRIM_OUTPUT $INDEX_TRIM_INPUT" > $LOGFILE && cat $LOGFILE
				if [ ! -s $INDEX_TRIM_OUTPUT ]
				then
					echo "Index adapter trimming cannot run correctly !"
					exit 1
				fi
		
				echo "End of index adapter trimming."
			fi
		else
			return
		fi
	}

# We shake the 5' trimming

Index_Adapter_trimming_report()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
		then
			DIR_INDEX_TRIM_FASTQC="$1_TrimIndex_report"
			INDEX_TRIM_INPUT="$1_TrimIndex.fastq"

			if [ -s $INDEX_TRIM_INPUT ]
			then
				fastqc_quality_control $DIR_INDEX_TRIM_FASTQC $INDEX_TRIM_INPUT
			else
				echo "$INDEX_TRIM_INPUT doesn't exist"
				exit 1
			fi
		fi
	}

# We run Cutadapt for the 3' trimming

ThreePrime_trimming()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}
		WORKING_ANSWER_REMOVE_PCR_DUPLICATES=${ANSWER_REMOVE_PCR_DUPLICATES^^}

		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
		then
			THREEPRIME_TRIM_INPUT="$1_TrimIndex.fastq"
		else
                        if [ $WORKING_ANSWER_REMOVE_PCR_DUPLICATES = YES ]
                        then
                                THREEPRIME_TRIM_INPUT="$1_rmPCR.fastq"
                        else
                                THREEPRIME_TRIM_INPUT="$1_rmIQF.fastq"
                        fi
		fi

		THREEPRIME_TRIM_OUTPUT="$1_ThreePrime_Trim.fastq"
		LOGFILE="$1_ThreePrimeTrim.log"

		if [ -s $THREEPRIME_TRIM_OUTPUT ] && [ -s $LOGFILE ]
		then
			return
		else
			echo "3' trimming :"

			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home genomicpariscentre/cutadapt:1.7.1 bash -c "cutadapt -a $2 -o $THREEPRIME_TRIM_OUTPUT $THREEPRIME_TRIM_INPUT > $LOGFILE && cat $LOGFILE"

			if [ $? -ne 0 ]
			then
				echo "Cutadapt cannot run correctly !"
				exit 1
			fi

			echo "End of Cutadapt."
		fi
	}

# We shake the 3' trimming

ThreePrime_trimming_report()
	{
		DIR_THREEPRIME_TRIM_FASTQC="$1_ThreePrime_Trim_report"
		THREEPRIME_TRIM_INPUT="$1_ThreePrime_Trim.fastq"

		if [ -s $THREEPRIME_TRIM_INPUT ]
		then
			fastqc_quality_control $DIR_THREEPRIME_TRIM_FASTQC $THREEPRIME_TRIM_INPUT
		else
			echo "$THREEPRIME_TRIM_INPUT doesn't exist"
			exit 1
		fi
	}

Size_Selection()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}
                WORKING_ANSWER_REMOVE_PCR_DUPLICATES=${ANSWER_REMOVE_PCR_DUPLICATES^^}

                if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
                then
			THREEPRIME_TRIM_INPUT="$1_ThreePrime_Trim.fastq"
                        SIZE_SELECT_OUTPUT="$1_SizeSelection.fastq"
                        LOGFILE="$1_SizeSelection.log"
                else
			BASENAME=$(basename $1 .f*q)
                        THREEPRIME_TRIM_INPUT="${BASENAME}_ThreePrime_Trim.fastq"
                        SIZE_SELECT_OUTPUT="${BASENAME}_SizeSelection.fastq"
                        LOGFILE="${BASENAME}_SizeSelection.log"
                fi

                if [ -s $THREEPRIME_TRIM_OUTPUT ] && [ -s $LOGFILE ]
                then
                        return
                else
                        echo "Size selection :"

			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home genomicpariscentre/cutadapt:1.7.1 bash -c "cutadapt -m $MIN_READ_LENGTH -o $SIZE_SELECT_OUTPUT $THREEPRIME_TRIM_INPUT > $LOGFILE && cat $LOGFILE"

                        if [ $? -ne 0 ]
                        then
                                echo "Cutadapt cannot run correctly !"
                                exit 1
                        fi

                        echo "End of Cutadapt."
                fi
	}

# We shake the size selection

Size_Selection_report()
        {
		DIR_SIZE_SELECT_FASTQC="$1_Size_Selection_report"
		SIZE_SELECT_INPUT="$1_SizeSelection.fastq"

		if [ -s $SIZE_SELECT_INPUT ]
		then
	               fastqc_quality_control $DIR_SIZE_SELECT_FASTQC $SIZE_SELECT_INPUT
		else
			echo "$SIZE_SELECT_INPUT doesn't exist"
			exit 1
		fi
        }

# We run Bowtie 1 to align reads to rRNA sequences : we get unmapped reads for next steps and mapped reads to have length distribution (Python script using matplotlib)

align_To_R_RNA()
	{
		for sample in ${SAMPLE_ARRAY[*]}
		do
			WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

			if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
			then
				UNMAPPED_RNA_FASTQ_FILE="${sample}_no_rRNA.fastq"
	                        MAPPED_RNA_SAM_FILE="${sample}_rRNA_mapped.sam"
        	                LOGFILE_BOWTIE="${sample}_rRNA_mapping.log"
                	        INPUT_RNA_MAPPING="${sample}_SizeSelection.fastq"
			else
				BASENAME=$(basename $sample .fastq)
 	              	        UNMAPPED_RNA_FASTQ_FILE="${BASENAME}_no_rRNA.fastq"
  	                     	MAPPED_RNA_SAM_FILE="${BASENAME}_rRNA_mapped.sam"
	                        LOGFILE_BOWTIE="${BASENAME}_rRNA_mapping.log"
    	   	                INPUT_RNA_MAPPING="${BASENAME}_SizeSelection.fastq"
			fi

			rRNA_INDEX_BASENAME=$(echo $(basename ${PATH_TO_rRNA_INDEX}/*.1.ebwt | cut -f1 -d'.'))

			if [ -s $UNMAPPED_RNA_FASTQ_FILE ] && [ -s $MAPPED_RNA_SAM_FILE ] && [ -s $LOGFILE_BOWTIE ]
			then
				return
			else
				echo "Starting of Bowtie1 :"

				docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home -v $PATH_TO_rRNA_INDEX:/root genomicpariscentre/bowtie1:1.1.1 bash -c "bowtie -p $(nproc) $BOWTIE_OPTIONS $UNMAPPED_RNA_FASTQ_FILE /root/$rRNA_INDEX_BASENAME $INPUT_RNA_MAPPING $MAPPED_RNA_SAM_FILE 2> $LOGFILE_BOWTIE"

				if [ $? -ne 0 ]
				then
					echo "Bowtie1 cannot run correctly !"
					exit 1
				fi
	
				echo "End of Bowtie1."
			fi
		done
	}

# We run FASTQC on unmapped fastq
Unmmaped_to_rRNA_report()
        {
		DIR_UNMAPPED_RRNA_FASTQC="$1_no_rRNA_report"
		UNMAPPED_RRNA_INPUT="$1_no_rRNA.fastq"
		
		if [ -s $UNMAPPED_RRNA_INPUT ]
		then
	                fastqc_quality_control $DIR_UNMAPPED_RRNA_FASTQC $UNMAPPED_RRNA_INPUT
		else
			echo "$UNMAPPED_RRNA_INPUT doesn't exist"
			exit 1
		fi
        }

# We run the Python library matplotlib

mapped_to_R_RNA_distrib_length()
	{
		DISTR_LGT_PNG="$1_mapped_to_rRNA_read_length_distribution.png"
		INPUT_SAM_MAPPED_RNA="$1_rRNA_mapped.sam"

		if [ -s $DISTR_LGT_PNG ]
		then
			return
		else
			echo "Computing mapped to rRNA reads length distribution :"

			grep -v '^@' $INPUT_SAM_MAPPED_RNA | awk '$2 != 4 {print $0}' | awk '{print length($10)}' | $PYTHON_SCRIPT_READ_LENGTH_DISTRIBUTION -i $INPUT_SAM_MAPPED_RNA -o $DISTR_LGT_PNG

			if [ ! -s $DISTR_LGT_PNG ]
			then
				echo "Cannot computing mapped to rRNA reads length distribution !"
				exit 1
			fi
	
			echo "End of computing mapped to rRNA reads length distribution."
		fi
	}

# We run STAR to align reads to the reference genome

align_to_ref_genome()
	{
		for sample in ${SAMPLE_ARRAY[*]}
		do
			WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

			if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
			then
				DIR_ALIGN_STAR="${sample}_align_star/"
	                        INPUT_ALIGN_GENOME="${sample}_no_rRNA.fastq"
			else
				BASENAME=$(basename $sample .fastq)
                       		DIR_ALIGN_STAR="${BASENAME}_align_star/"
	                        INPUT_ALIGN_GENOME="${BASENAME}_no_rRNA.fastq"
			fi	

			if [ -e $DIR_ALIGN_STAR ]
			then
				if [ -s "${DIR_ALIGN_STAR}Log.final.out" ] && [ -s "${DIR_ALIGN_STAR}Aligned.out.sam" ]
				then
					return
				fi
			else
				mkdir -p $DIR_ALIGN_STAR

				if [ $? -ne 0 ]
	                        then
        	                        echo "Cannot create the directory !"
                	                exit 1
                        	fi
			
				echo "Starting of STAR :"
			
				docker run --rm -u $(id -u):$(id -g) -v $(pwd):/home -v $PATH_TO_GENOME_INDEX:/root -w /home genomicpariscentre/star:2.4.0k bash -c "STAR --runThreadN $(nproc) --genomeDir /root --readFilesIn $INPUT_ALIGN_GENOME --outFileNamePrefix $DIR_ALIGN_STAR"

				if [ ! -s "${DIR_ALIGN_STAR}Aligned.out.sam" ]
				then
					echo "STAR cannot run correctly !"
					exit 1
				fi

				echo "End of STAR."
			fi
		done
	}

# We filter the SAM file to get conserve uniq reads

samFiltering()
	{
		WORKING_ANSWER_KEEP_MULTIREAD=${ANSWER_KEEP_MULTIREAD^^}
	
		SAM_INPUT="$1_align_star/Aligned.out.sam"
		FILTERED_SAM_UNIQUE_OUTPUT="$1_align_filtered.sam"
		FILTERED_SAM_MULTI_OUTPUT="$1_align_multi.sam"
		LOGFILE="$1_align_filtering.log"

		if [ -s $SAM_INPUT ]
		then
			if [ -s $FILTERED_SAM_UNIQUE_OUTPUT ]
			then
				return
			else
				echo "Starting of SAM file filtering :"

				if [ "$WORKING_ANSWER_KEEP_MULTIREAD" = YES ]
				then
					grep -v '^@' $SAM_INPUT | awk '$2 != 4 {print $0}' | sort -k 1,1 | $PYTHON_SCRIPT_SAM_FILTERING -i $SAM_INPUT -o $FILTERED_SAM_UNIQUE_OUTPUT -m $FILTERED_SAM_MULTI_OUTPUT > $LOGFILE && cat $LOGFILE
				else
					grep -v '^@' $SAM_INPUT | awk '$2 != 4 {print $0}' | sort -k 1,1 | $PYTHON_SCRIPT_SAM_FILTERING -i $SAM_INPUT -o $FILTERED_SAM_UNIQUE_OUTPUT > $LOGFILE && cat $LOGFILE
				fi

				if [ $? -ne 0 ]
				then
					echo "SAM file filtering cannot run correctly !"
					exit 1
				fi

				echo "End of SAM file filtering."
			fi
		else
			echo "You need a SAM file to launch this step !"
		fi
	}

# We compute the reads length distribution after alignment to the reference genome and the SAM fil filtering

mapped_to_genome_distrib_length()
	{
		SAM_FILTERED_INPUT="$1_align_filtered.sam"
		DISTR_LGT_PNG="$1_mapped_to_genome_read_length_distribution.png"

                if [ -s $DISTR_LGT_PNG ]
                then
                        return
                else
                        echo "Computing mapped to genome reads length distribution :"

			grep -v '^@' $SAM_FILTERED_INPUT | awk '{print length($10)}' | $PYTHON_SCRIPT_READ_LENGTH_DISTRIBUTION -i $SAM_FILTERED_INPUT -o $DISTR_LGT_PNG

                        if [ ! -s $DISTR_LGT_PNG ]
                        then
                                echo "Cannot computing mapped to genome reads length distribution !"
                                exit 1
                        fi

                        echo "End of computing mapped to genome reads length distribution."
                fi
	}

# We convert the filtered SAM file into a BAM file

sam_to_bam()
	{
		FILTERED_BAM="$1_align_filtered.bam"
		FILTERED_SAM="$1_align_filtered.sam"

		if [ -s $FILTERED_SAM ]
		then
			if [ -s $FILTERED_BAM ]
			then
				return
			else
				echo "Starting of Samtools"
			
				docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home genomicpariscentre/samtools:0.1.19 bash -c "samtools view -Sb $FILTERED_SAM > $FILTERED_BAM"

				if [ ! -s $FILTERED_BAM ]
				then
					echo "Samtools cannot run correctly !"
					exit 1
				fi

				echo "End of Samtools."
			fi
		else
			echo "You need a filtered SAM file to launch this step !"
			exit 1
		fi
	}


# We get longest transcript of each gene for CDS annotations from Ensembl 75 GTF
get_longest_transcripts_from_annotations()
	{		
		INPUT_ANNOTATION=$(basename $PATH_TO_ANNOTATION_FILE)
		DIRNAME_ANNOTATIONS=$(dirname $PATH_TO_ANNOTATION_FILE)

		ANNOTATION_PREFIX=${INPUT_ANNOTATION:0:-4}

		CDS_ANNOTATIONS="${ANNOTATION_PREFIX}_only_cds.gtf"
		LONGEST_TRANSCRIPTS="${ANNOTATION_PREFIX}_longest_transcripts.txt"

		CDS_LONGEST_TRANSCRIPTS_LIST="${ANNOTATION_PREFIX}_only_cds_longest_transcripts.txt"
		CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS="${ANNOTATION_PREFIX}_only_cds_longest_transcripts.gtf"

		if [ ! -s $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS ]
		then
			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -v $DIRNAME_ANNOTATIONS:/root -w /home genomicpariscentre/gff3-ptools:0.4.0 bash -c "gtf-filter --keep-comments -o $CDS_ANNOTATIONS \"field feature == CDS\" /root/$INPUT_ANNOTATION"

			$PYTHON_SCRIPT_LONGEST_TRANSCRIPT -i $PATH_TO_ANNOTATION_FILE -o $CDS_LONGEST_TRANSCRIPTS_LIST

			grep -Ff $CDS_LONGEST_TRANSCRIPTS_LIST $CDS_ANNOTATIONS > $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS
		else
			return
		fi
	}

# We compute the number of reads in CDS (HTSeq-count)
htseq_count()
	{
		WORKING_ANSWER_RNASEQ_COUNTING=${ANSWER_RNASEQ_COUNTING^^}

		FILTERED_BAM="$1_align_filtered.bam"
		HTSEQCOUNT_FILE="$1_htseq.txt"
		HTSEQCOUNT_FILE_ANADIF_BABEL="$1_RPcounts.txt"

		ANNOTATIONS_FILE=$(basename $PATH_TO_ANNOTATION_FILE)
                ANNOTATION_PREFIX=${ANNOTATIONS_FILE:0:-4}

                CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS="${ANNOTATION_PREFIX}_only_cds_longest_transcripts.gtf"
		
		if [ -s $FILTERED_BAM ] && [ -s $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS ]
		then
			if [ -s $HTSEQCOUNT_FILE ] || [ -s DifferentialAnalysis/$HTSEQCOUNT_FILE ]
			then
				return
			else
				echo "Starting of HTSeq-count :"

				docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home genomicpariscentre/htseq bash -c "htseq-count --mode $MODE_FOR_MULTIPLE_FEATURES_READS --type $FEATURE_TYPE --idattr $IDATTR --stranded $STRANDED --format $FILETYPE $FILTERED_BAM $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS > $HTSEQCOUNT_FILE"

				mkdir -p DifferentialAnalysis

				if [ $WORKING_ANSWER_RNASEQ_COUNTING = YES ]
				then
					grep -v __.* $HTSEQCOUNT_FILE > $HTSEQCOUNT_FILE_ANADIF_BABEL

					cp $HTSEQCOUNT_FILE_ANADIF_BABEL DifferentialAnalysis
					cp $1_mRNAcounts.txt DifferentialAnalysis
				else
					cp $HTSEQCOUNT_FILE DifferentialAnalysis
				fi

				if [ -s target.txt ]
				then
					cp target.txt DifferentialAnalysis
				fi

				if [ $? -ne 0 ]
				then
					echo "HTSeq-Count cannot run correctly !"
					exit 1
				fi
	
				echo "End of HTSeq-Count."
			fi
		else
			echo "You need a filtered BAM file to launch this step !"
			exit 1
		fi
	}

# If user has RNA-seq counts, we run Babel : here, build of counts matrix
build_rnaseq_ribopro_counting_tables()
	{
		if [ -e DifferentialAnalysis ]
		then
			WORKDIR_ANADIFF=$(readlink -f DifferentialAnalysis)
		fi

		WORKING_ANSWER_RNASEQ_COUNTING=${ANSWER_RNASEQ_COUNTING^^}

		# If user has RNA-seq countings, we build RNAseq and Ribosome Profiling counting tables
		if [ $WORKING_ANSWER_RNASEQ_COUNTING = YES ]
		then
			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR_ANADIFF:/home -w /home genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_BUILD_COUNTING_TABLE_RNASEQ}" ${SAMPLES[@]}

			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR_ANADIFF:/home -w /home genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_BUILD_COUNTING_TABLE_RP}" ${SAMPLES[@]}
		else
			return
		fi
	}

# If user has RNA-seq counts, we run Babel : here differntial analysis and its permutation test
anadif_babel()
	{
		WORKDIR_ANADIFF=$(readlink -f DifferentialAnalysis)
		WORKING_ANSWER_RNASEQ_COUNTING=${ANSWER_RNASEQ_COUNTING^^}

		# If user has RNA-seq counting, we use Babel R package
		if [ $WORKING_ANSWER_RNASEQ_COUNTING = YES ]
		then
			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR_ANADIFF:/home -w /home genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_BABEL}" ${CONDITION_ARRAY[@]}

			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR_ANADIFF:/home -w /home genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_PERMT_TEST_BABEL}" ${CONDITION_ARRAY[@]}
		else
			return
		fi
	}

anadif_sartools()
	{
		WORKING_ANSWER_RNASEQ_COUNTING=${ANSWER_RNASEQ_COUNTING^^}
		WORKING_DIFFERENTIAL_ANALYSIS_PACKAGE=${DIFFERENTIAL_ANALYSIS_PACKAGE^^}

		# If user hasn't RNA-seq counting, we use SARTools R package
		if [ ! $WORKING_ANSWER_RNASEQ_COUNTING = YES ]
		then
			if [ -e DifferentialAnalysis ]
                	then
                        	WORKDIR_ANADIFF=$(readlink -f DifferentialAnalysis)
                	fi

			PARAM=(/home $1 $2 target.txt /home $3)
			WORK_PARAM=$(echo ${PARAM[*]})
			PARAMETERS=$(echo $WORK_PARAM)

			# EdgeR is launch by default if not specified (because Babel uses edgeR)
                        if [ $WORKING_DIFFERENTIAL_ANALYSIS_PACKAGE = DESEQ2 ]
	                then
				docker run --rm -u $(id -u):$(id -g) -v $WORKDIR_ANADIFF:/home -w /home genomicpariscentre/sartools Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_SARTOOLS_DESEQ2}" $PARAMETERS
			else
				docker run --rm -u $(id -u):$(id -g) -v $WORKDIR_ANADIFF:/home -w /home genomicpariscentre/sartools Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_SARTOOLS_EDGER}" $PARAMETERS
			fi
		else
			return
		fi
	}
	

export -f demultiplexing
export -f raw_quality_report
export -f removeBadIQF
export -f removeBadIQF_report
export -f removePCRduplicates
export -f Index_Adapter_trimming
export -f Index_Adapter_trimming_report
export -f ThreePrime_trimming
export -f ThreePrime_trimming_report
export -f Size_Selection
export -f Size_Selection_report
export -f align_To_R_RNA
export -f Unmmaped_to_rRNA_report
export -f mapped_to_R_RNA_distrib_length
export -f align_to_ref_genome
export -f samFiltering
export -f mapped_to_genome_distrib_length
export -f sam_to_bam
export -f get_longest_transcripts_from_annotations
export -f htseq_count
export -f build_rnaseq_ribopro_counting_tables
export -f anadif_babel
export -f anadif_sartools

### MAIN ###

parallel --xapply demultiplexing ::: $WORKING_SAMPLE_ARRAY ::: $WORKING_SAMPLE_INDEX_ARRAY

wait

parallel raw_quality_report {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel removeBadIQF {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel removeBadIQF_report {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel removePCRduplicates {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel --xapply Index_Adapter_trimming {.} ::: $WORKING_SAMPLE_ARRAY ::: $WORKING_SAMPLE_INDEX_ARRAY

wait

parallel Index_Adapter_trimming_report {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel --xapply ThreePrime_trimming {.} ::: $WORKING_SAMPLE_ARRAY ::: $ADAPTER_SEQUENCE_THREE_PRIME

wait

parallel ThreePrime_trimming_report {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel Size_Selection {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel Size_Selection_report {.} ::: $WORKING_SAMPLE_ARRAY

wait

align_To_R_RNA

wait

parallel Unmmaped_to_rRNA_report {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel mapped_to_R_RNA_distrib_length {.} ::: $WORKING_SAMPLE_ARRAY

wait

align_to_ref_genome

wait

parallel samFiltering {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel mapped_to_genome_distrib_length {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel sam_to_bam {.} ::: $WORKING_SAMPLE_ARRAY

wait

get_longest_transcripts_from_annotations

wait

parallel htseq_count {.} ::: $WORKING_SAMPLE_ARRAY

wait

build_rnaseq_ribopro_counting_tables

wait

anadif_babel

wait

anadif_sartools $PROJECT_NAME $AUTHOR $REFERENCE_CONDITION

# Write final report
FINALLOGFILE="${PROJECT_NAME}.final.report"

for file in $(ls -c *log); do stat -c '%y' $file >> $FINALLOGFILE; printf "\n" >> $FINALLOGFILE; cat $file >> $FINALLOGFILE; done
