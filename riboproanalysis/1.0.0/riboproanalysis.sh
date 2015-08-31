#!/bin/bash

#########################################################################
## 								       ##
## This script will run all steps of a Ribosome Profiling analysis     ##
## It is executed in a Docker image				       ##
##								       ##
## Version 1.0.0						       ##
## Maintener : Alexandra Bomane <bomane@biologie.ens.fr>	       ##
##								       ##
#########################################################################

########################## Variables section #############################
## Environment

#export WORKDIR=$(pwd)

source $1

if [ ! -e tmp/ ]
then
	mkdir -p tmp/
fi 

#set -e

#export TMPDIR=$(readlink -f tmp/)

## Scripts

MAIN_SCRIPT_CANONICAL_PATH=$(readlink -f $0) ## basename $0
CANONICAL_PATH=$(dirname $MAIN_SCRIPT_CANONICAL_PATH)

#export PYTHON_SCRIPTS_PATH="${MAIN_SCRIPT_CANONICAL_PATH}/PythonScripts"
#export R_SCRIPTS_PATH="${MAIN_SCRIPT_CANONICAL_PATH}/RScripts"

export PYTHON_SCRIPTS_PATH="${CANONICAL_PATH}/PythonScripts"
export R_SCRIPTS_PATH="${CANONICAL_PATH}/RScripts"

#export ETC_PASSWD="/etc/passwd" # Vrai lancement avec docker run --rm -v /etc/passwd:/etc/passwd .......

export PYTHON_SCRIPT_DEMULTIPLEXING="run_demultiplexing.py"
export PYTHON_SCRIPT_REMOVE_PCR_DUP="rmDupPCR.py"
export PYTHON_SCRIPT_REMOVE_BAD_IQF="remove_bad_reads_Illumina_passing_filter.py"
export PYTHON_SCRIPT_READ_LENGTH_DISTRIBUTION="read_length_distribution.py"
export PYTHON_SCRIPT_SAM_FILTERING="sam_file_filter.py"
export PYTHON_SCRIPT_LONGEST_TRANSCRIPT="get_longest_transcripts_from_ensembl_gtf.py"

export R_SCRIPT_BUILD_COUNTING_TABLE_RNASEQ="RNAseqCountDataMatrix.R"
export R_SCRIPT_BUILD_COUNTING_TABLE_RP="RPCountDataMatrix.R"
export R_SCRIPT_ANADIFF_BABEL="babel_RP_differentialAnalysis.R"
export R_SCRIPT_PERMT_TEST_BABEL="babel_RP_permutationTest.R"
export R_SCRIPT_ANADIFF_SARTOOLS_DESEQ2="script_DESeq2.R"
export R_SCRIPT_ANADIFF_SARTOOLS_EDGER="script_edgeR.R"

export WORKING_SAMPLE_ARRAY=$(echo ${SAMPLE_ARRAY[*]})
#export $WORKING_SAMPLE_ARRAY

WORKING_SAMPLE_INDEX_ARRAY=$(echo ${SAMPLE_INDEX_ARRAY[*]})
export $WORKING_SAMPLE_INDEX_ARRAY

#export SAMPLES=$(echo $WORKING_SAMPLE_INDEX_ARRAY) ## trompé d'array
export SAMPLES=($(echo ${SAMPLE_ARRAY[@]%.fastq}))

#export WORKING_SAMPLE=$(echo $SAMPLES)

WORKING_CONDITION_ARRAY=$(echo ${CONDITION_ARRAY[*]})
#export $WORKING_CONDITION_ARRAY
#export CONDITIONS=$(echo $WORKING_CONDITION_ARRAY)

#export USER_IDS ###### Dans fichier de conf

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

		if [ $WORKING_ANSWER_DEMULTIPLEXING = 'YES' ]
		then
			LOGFILE="$1_demultiplexing.log"
			OUTFILE=$1_demultiplex.fastq
		
			if [ -s $LOGFILE ]
			then
				return
			else
				echo "Starting of demultiplexing :"

#				python $PYTHON_SCRIPTS_PATH$PYTHON_SCRIPT_DEMULTIPLEXING -i $PATH_TO_RAW_UNDEMULTIPLEXED_FILE -o $OUTFILE -a $2 > $LOGFILE && cat $LOGFILE
				$PYTHON_SCRIPT_DEMULTIPLEXING -i $PATH_TO_RAW_UNDEMULTIPLEXED_FILE -o $OUTFILE -a $2 > $LOGFILE && cat $LOGFILE
				chown $USER_IDS $OUTFILE
				chown $USER_IDS $LOGFILE

				if [ ! -s $OUTFILE ]
				then
					echo "extract_reads_matching_anAdapter_fromFastq.py cannot run correctly !"
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

				docker run --rm --volumes-from ribopro -w /home genomicpariscentre/fastqc:0.11.2 bash -c "fastqc -o $1 $2"
				echo chown -R $USER_IDS $1
				chown -R $USER_IDS $1


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

		if [ $WORKING_ANSWER_DEMULTIPLEXING = 'YES' ]
		then
			DIR_RAW_FASTQ_REPORT="$1_raw_fastqc_report"
			INPUT_RAW_FASTQ="$1_demultiplex.fastq"
		else
#			BASENAME=$(basename $1 .f*q)
#			DIR_RAW_FASTQ_REPORT="${BASENAME}_raw_fastqc_report"
                        INPUT_RAW_FASTQ="${1}.fastq"
		fi
			DIR_RAW_FASTQ_REPORT="$1_raw_fastqc_report"
		
		fastqc_quality_control $DIR_RAW_FASTQ_REPORT $INPUT_RAW_FASTQ
	}

# We remove PCR duplicates
# $1 = INFILE	$2 = OUTFILE
# obtention % Amplification ? --> donné par le programme rmExactDup_fastq : voir fichier log.

removeBadIQF()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

		if [ $WORKING_ANSWER_DEMULTIPLEXING = 'YES' ]
		then

#			LOGFILE="$1_rmIQF.log"
 #                      RM_BADIQF_OUTPUT="$1_rmIQF.fastq"
                        INPUT_FASTQ="$1_demultiplex.fastq"
		else
#			BASENAME=$(basename $1 .f*q)
#
 #                       LOGFILE="${BASENAME}_rmIQF.log"
#                        RM_BADIQF_OUTPUT="${BASENAME}_rmIQF.fastq"
                        INPUT_FASTQ="$1.fastq"
		fi
			LOGFILE="$1_rmIQF.log"
                       RM_BADIQF_OUTPUT="$1_rmIQF.fastq"

		if [ -s $LOGFILE ] && [ -s $RM_BADIQF_OUTPUT ]
		then
			return
		else
			echo "Removing bad IQF :"

			#python $PYTHON_SCRIPTS_PATH$PYTHON_SCRIPT_REMOVE_BAD_IQF -i $INPUT_FASTQ -o $RM_BADIQF_OUTPUT > $LOGFILE && cat $LOGFILE
			$PYTHON_SCRIPT_REMOVE_BAD_IQF -i $INPUT_FASTQ -o $RM_BADIQF_OUTPUT > $LOGFILE && cat $LOGFILE
			chown $USER_IDS $RM_BADIQF_OUTPUT
			echo chown $USER_IDS $RM_BADIQF_OUTPUT

			chown $USER_IDS $LOGFILE
			echo chown $USER_IDS $LOGFILE

			if [ $? -ne 0 ]
			then
				echo "Removing bad IQF cannot run correctly !"
				exit 1
			fi

			echo "End of removing bad IQF"
		fi
	}

removeBadIQF_report()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

#		if [ $WORKING_ANSWER_DEMULTIPLEXING = 'YES' ]
#		then
			RM_BADIQF_DIR="$1_rmIQF_report"
                        RM_IQF_INPUT="$1_rmIQF.fastq"
#		else
#			BASENAME=$(basename $1 .f*q)
 #                       RM_BADIQF_DIR="${BASENAME}_rmIQF_report"
  #                      RM_IQF_INPUT="${BASENAME}_rmIQF.fastq"
#		fi

		if [ -s $RM_IQF_INPUT ]
		then
			fastqc_quality_control $RM_BADIQF_DIR $RM_IQF_INPUT
		fi
	}

removePCRduplicates()

	{
		WORKING_ANSWER_REMOVE_PCR_DUPLICATES=${ANSWER_REMOVE_PCR_DUPLICATES^^}
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

		if [ $WORKING_ANSWER_REMOVE_PCR_DUPLICATES = 'YES' ]
		then
#			if [ $WORKING_ANSWER_DEMULTIPLEXING = 'YES' ]
#			then
				LOGFILE="$1_rmPCR.log"
				RM_PCRDUP_OUTPUT="$1_rmPCR.fastq"
				RM_PCRDUP_INPUT="$1_rmIQF.fastq"
#			else
#				BASENAME=$(basename $1 .f*q)
#				LOGFILE="${BASENAME}_rmPCR.log"
 #                       	RM_PCRDUP_OUTPUT="${BASENAME}_rmPCR.fastq"
#	                        RM_PCRDUP_INPUT="${BASENAME}_rmIQF.fastq"
#			fi
		
			if [ -s $RM_PCRDUP_INPUT ]
			then
				if [ -s $RM_PCRDUP_OUTPUT ] && [ -s $LOGFILE ]
				then
					return
				else
					echo "Removing PCR duplicates :"

					#awk '{ i=(NR-1) % 4; tab[i]=$0 ; if (i==3) { print tab[1]"\t"tab[0]"\t"tab[3]"\t"tab[2]} }' $RM_PCRDUP_INPUT | sort | python $PYTHON_SCRIPTS_PATH$PYTHON_SCRIPT_REMOVE_PCR_DUP -i $RM_PCRDUP_INPUT -o $RM_PCRDUP_OUTPUT > $LOGFILE && cat $LOGFILE
					awk '{ i=(NR-1) % 4; tab[i]=$0 ; if (i==3) { print tab[1]"\t"tab[0]"\t"tab[3]"\t"tab[2]} }' $RM_PCRDUP_INPUT | sort | $PYTHON_SCRIPT_REMOVE_PCR_DUP -i $RM_PCRDUP_INPUT -o $RM_PCRDUP_OUTPUT > $LOGFILE && cat $LOGFILE
					chown $USER_IDS $RM_PCRDUP_OUTPUT
					echo chown $USER_IDS $RM_PCRDUP_OUTPUT

					chown $USER_IDS $LOGFILE
					echo chown $USER_IDS $LOGFILE

					if [ ! -s $RM_PCRDUP_OUTPUT ]
					then
						echo "Cannot run rmExactDup_fastq.py correctly !"
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
			
			if [ $WORKING_ANSWER_REMOVE_PCR_DUPLICATES = 'YES' ]
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

				#docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/root -w /root genomicpariscentre/cutadapt bash -c "cutadapt -u $INDEX_LENGTH -o $INDEX_TRIM_OUTPUT $INDEX_TRIM_INPUT" > $LOGFILE && cat $LOGFILE
				docker run --rm --volumes-from ribopro -w /home genomicpariscentre/cutadapt bash -c "cutadapt -u $INDEX_LENGTH -o $INDEX_TRIM_OUTPUT $INDEX_TRIM_INPUT" > $LOGFILE && cat $LOGFILE
				chown $USER_IDS $INDEX_TRIM_OUTPUT
				echo chown $USER_IDS $INDEX_TRIM_OUTPUT

				chown $USER_IDS $LOGFILE
				echo chown $USER_IDS $LOGFILE

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
# $2 : ADAPTER SEQUENCE LENGTH

Index_Adapter_trimming_report()
	{
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}
		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
		then
			DIR_INDEX_TRIM_FASTQC="$1_TrimIndex_report"
			INDEX_TRIM_INPUT="$1_TrimIndex.fastq"

			fastqc_quality_control $DIR_INDEX_TRIM_FASTQC $INDEX_TRIM_INPUT

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
 #                       THREEPRIME_TRIM_OUTPUT="$1_ThreePrime_Trim.fastq"
  #                      LOGFILE="$1_ThreePrimeTrim.log"
		else
#			BASENAME=$(basename $1 .f*q)

                        if [ $WORKING_ANSWER_REMOVE_PCR_DUPLICATES = 'YES' ]
                        then
                                THREEPRIME_TRIM_INPUT="$1_rmPCR.fastq"
                        else
                                THREEPRIME_TRIM_INPUT="$1_rmIQF.fastq"
                        fi

                        THREEPRIME_TRIM_OUTPUT="$1_ThreePrime_Trim.fastq"
			LOGFILE="$1_ThreePrimeTrim.log"
		fi

		if [ -s $THREEPRIME_TRIM_OUTPUT ] && [ -s $LOGFILE ]
		then
			return
		else
			echo "3' trimming :"

			#docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/root -w /root genomicpariscentre/cutadapt bash -c "cutadapt -a $2 -o $THREEPRIME_TRIM_OUTPUT $THREEPRIME_TRIM_INPUT > $LOGFILE && cat $LOGFILE"
			docker run --rm --volumes-from ribopro -w /home genomicpariscentre/cutadapt bash -c "cutadapt -a $2 -o $THREEPRIME_TRIM_OUTPUT $THREEPRIME_TRIM_INPUT > $LOGFILE && cat $LOGFILE"
			chown $USER_IDS $THREEPRIME_TRIM_OUTPUT
			echo chown $USER_IDS $THREEPRIME_TRIM_OUTPUT

			chown $USER_IDS $LOGFILE
			echo chown $USER_IDS $LOGFILE

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
		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

#		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
#		then
			DIR_THREEPRIME_TRIM_FASTQC="$1_ThreePrime_Trim_report"
                        THREEPRIME_TRIM_INPUT="$1_ThreePrime_Trim.fastq"
#		else
#			BASENAME=$(basename $1 .f*q)
 #                       DIR_THREEPRIME_TRIM_FASTQC="${BASENAME}_ThreePrime_Trim_report"
  #                      THREEPRIME_TRIM_INPUT="${BASENAME}_ThreePrime_Trim.fastq"
#		fi
		
		fastqc_quality_control $DIR_THREEPRIME_TRIM_FASTQC $THREEPRIME_TRIM_INPUT

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

                        #docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/root -w /root genomicpariscentre/cutadapt bash -c "cutadapt -m $MIN_READ_LENGTH -o $SIZE_SELECT_OUTPUT $THREEPRIME_TRIM_INPUT > $LOGFILE && cat $LOGFILE"
			docker run --rm --volumes-from ribopro -w /home genomicpariscentre/cutadapt bash -c "cutadapt -m $MIN_READ_LENGTH -o $SIZE_SELECT_OUTPUT $THREEPRIME_TRIM_INPUT > $LOGFILE && cat $LOGFILE"
			chown $USER_IDS $SIZE_SELECT_OUTPUT
			echo chown $USER_IDS $SIZE_SELECT_OUTPUT

			chown $USER_IDS $LOGFILE
			echo chown $USER_IDS $LOGFILE

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
#                WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

 #               if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
  #              then
			DIR_SIZE_SELECT_FASTQC="$1_Size_Selection_report"
                        SIZE_SELECT_INPUT="$1_SizeSelection.fastq"
   #             else
#			BASENAME=$(basename $1 .f*q)
 #                       DIR_SIZE_SELECT_FASTQC="${BASENAME}_Size_Selection_report"
  #                      SIZE_SELECT_INPUT="${BASENAME}_SizeSelection.fastq"
   #             fi

                fastqc_quality_control $DIR_SIZE_SELECT_FASTQC $SIZE_SELECT_INPUT
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

	#		rRNA_INDEX_BASENAME=$(echo $(basename ${PATH_TO_rRNA_INDEX}/*.1.ebwt | cut -f1 -d'.'))
			rRNA_INDEX_BASENAME=$(echo $(basename /rRNAindexdirectory/*.1.ebwt | cut -f1 -d'.'))

			if [ -s $UNMAPPED_RNA_FASTQ_FILE ] && [ -s $MAPPED_RNA_SAM_FILE ] && [ -s $LOGFILE_BOWTIE ]
			then
				return
			else
				echo "Starting of Bowtie1 :"

				#docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -v $PATH_TO_rRNA_INDEX:/root -w /home genomicpariscentre/bowtie1 bash -c "bowtie $BOWTIE_INPUT_UNMAPPED_OPTIONS $UNMAPPED_RNA_FASTQ_FILE /root/$rRNA_INDEX_BASENAME $INPUT_RNA_MAPPING $BOWTIE_OUTPUT_MAPPED_OPTION $MAPPED_RNA_SAM_FILE > /dev/null 2> $LOGFILE_BOWTIE && cat $LOGFILE_BOWTIE"

				#docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home -v $PATH_TO_rRNA_INDEX:/root genomicpariscentre/bowtie1 bash -c "bowtie -p $(nproc) $BOWTIE_OPTIONS $UNMAPPED_RNA_FASTQ_FILE /root/$rRNA_INDEX_BASENAME $INPUT_RNA_MAPPING $MAPPED_RNA_SAM_FILE 2> $LOGFILE_BOWTIE"

				echo docker run --rm --volumes-from ribopro -w /home genomicpariscentre/bowtie1 bash -c "bowtie -p $(nproc) $BOWTIE_OPTIONS $UNMAPPED_RNA_FASTQ_FILE /rRNAindexdirectory/$rRNA_INDEX_BASENAME $INPUT_RNA_MAPPING $MAPPED_RNA_SAM_FILE 2> $LOGFILE_BOWTIE"
				docker run --rm --volumes-from ribopro -w /home genomicpariscentre/bowtie1 bash -c "bowtie -p $(nproc) $BOWTIE_OPTIONS $UNMAPPED_RNA_FASTQ_FILE /rRNAindexdirectory/$rRNA_INDEX_BASENAME $INPUT_RNA_MAPPING $MAPPED_RNA_SAM_FILE 2> $LOGFILE_BOWTIE"

				chown $USER_IDS $UNMAPPED_RNA_FASTQ_FILE
				echo chown $USER_IDS $UNMAPPED_RNA_FASTQ_FILE

				chown $USER_IDS $MAPPED_RNA_SAM_FILE
				echo chown $USER_IDS $MAPPED_RNA_SAM_FILE

				chown $USER_IDS $LOGFILE_BOWTIE
				echo chown $USER_IDS $LOGFILE_BOWTIE

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
#                WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

 #               if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
  #              then
			DIR_UNMAPPED_RRNA_FASTQC="$1_no_rRNA_report"
                        UNMAPPED_RRNA_INPUT="$1_no_rRNA.fastq"
   #             else
#			BASENAME=$(basename $1 .f*q)
 #                       DIR_UNMAPPED_RRNA_FASTQC="${BASENAME}_no_rRNA_report"
  #                      UNMAPPED_RRNA_INPUT="${BASENAME}_no_rRNA.fastq"
   #             fi

                fastqc_quality_control $DIR_UNMAPPED_RRNA_FASTQC $UNMAPPED_RRNA_INPUT
        }

# We run the Python library matplotlib

mapped_to_R_RNA_distrib_length()
	{
#		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

#		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
#		then
			DISTR_LGT_PNG="$1_mapped_to_rRNA_read_length_distribution.png"
                        INPUT_SAM_MAPPED_RNA="$1_rRNA_mapped.sam"
#		else
#			BASENAME=$(basename $1 .f*q)
 #                       DISTR_LGT_PNG="${BASENAME}_mapped_to_rRNA_read_length_distribution.png"
  #                      INPUT_SAM_MAPPED_RNA="${BASENAME}_rRNA_mapped.sam"
#		fi

		if [ -s $DISTR_LGT_PNG ]
		then
			return
		else
			echo "Computing mapped to rRNA reads length distribution :"

#			grep -v '^@' $INPUT_SAM_MAPPED_RNA | awk '$2 != 4 {print $0}' | awk '{print length($10)}' | python $PYTHON_SCRIPTS_PATH$PYTHON_SCRIPT_READ_LENGTH_DISTRIBUTION -i $INPUT_SAM_MAPPED_RNA -o $DISTR_LGT_PNG
			grep -v '^@' $INPUT_SAM_MAPPED_RNA | awk '$2 != 4 {print $0}' | awk '{print length($10)}' | $PYTHON_SCRIPT_READ_LENGTH_DISTRIBUTION -i $INPUT_SAM_MAPPED_RNA -o $DISTR_LGT_PNG
			chown $USER_IDS $DISTR_LGT_PNG

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
			
				#docker run --rm -u $(id -u):$(id -g) -v $(pwd):/home -v $PATH_TO_GENOME_INDEX:/root -w /home genomicpariscentre/star:2.4.0k bash -c "STAR --runThreadN $(nproc) --genomeDir /root --readFilesIn $INPUT_ALIGN_GENOME --outFileNamePrefix $DIR_ALIGN_STAR"
				docker run --rm --volumes-from ribopro -w /home genomicpariscentre/star:2.4.0k bash -c "STAR --runThreadN $(nproc) --genomeDir /genomeindexdirectory --readFilesIn $INPUT_ALIGN_GENOME --outFileNamePrefix $DIR_ALIGN_STAR"
				chown -R $USER_IDS $DIR_ALIGN_STAR

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
#		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}
		WORKING_ANSWER_KEEP_MULTIREAD=${ANSWER_KEEP_MULTIREAD^^}
	
#		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
#		then
			SAM_INPUT="$1_align_star/Aligned.out.sam"
                        FILTERED_SAM_UNIQUE_OUTPUT="$1_align_filtered.sam"
                        FILTERED_SAM_MULTI_OUTPUT="$1_align_multi.sam"
                        LOGFILE="$1_align_filtering.log"
#		else
#			BASENAME=$(basename $1 .f*q)
 #                       SAM_INPUT="${BASENAME}_align_star/Aligned.out.sam"
  #                      FILTERED_SAM_UNIQUE_OUTPUT="${BASENAME}_align_filtered.sam"
   #                     FILTERED_SAM_MULTI_OUTPUT="${BASENAME}_align_multi.sam"
    #                    LOGFILE="${BASENAME}_align_filtering.log"
#		fi

		if [ -s $SAM_INPUT ]
		then
			if [ -s $FILTERED_SAM_UNIQUE_OUTPUT ]
			then
				return
			else
				echo "Starting of SAM file filtering :"

				if [ "$WORKING_ANSWER_KEEP_MULTIREAD" = YES ]
				then
#					grep -v '^@' $SAM_INPUT | awk '$2 != 4 {print $0}' | sort -k 1,1 | python $PYTHON_SCRIPTS_PATH$PYTHON_SCRIPT_SAM_FILTERING -i $SAM_INPUT -o $FILTERED_SAM_UNIQUE_OUTPUT -m $FILTERED_SAM_MULTI_OUTPUT > $LOGFILE && cat $LOGFILE
					grep -v '^@' $SAM_INPUT | awk '$2 != 4 {print $0}' | sort -k 1,1 | $PYTHON_SCRIPT_SAM_FILTERING -i $SAM_INPUT -o $FILTERED_SAM_UNIQUE_OUTPUT -m $FILTERED_SAM_MULTI_OUTPUT > $LOGFILE && cat $LOGFILE
					chown $USER_IDS $FILTERED_SAM_UNIQUE_OUTPUT
					chown $USER_IDS $FILTERED_SAM_MULTI_OUTPUT
					chown $USER_IDS $LOGFILE
				else
#					grep -v '^@' $SAM_INPUT | awk '$2 != 4 {print $0}' | sort -k 1,1 | python $PYTHON_SCRIPTS_PATH$PYTHON_SCRIPT_SAM_FILTERING -i $SAM_INPUT -o $FILTERED_SAM_UNIQUE_OUTPUT > $LOGFILE && cat $LOGFILE
					grep -v '^@' $SAM_INPUT | awk '$2 != 4 {print $0}' | sort -k 1,1 | $PYTHON_SCRIPT_SAM_FILTERING -i $SAM_INPUT -o $FILTERED_SAM_UNIQUE_OUTPUT > $LOGFILE && cat $LOGFILE
					chown $USER_IDS $FILTERED_SAM_UNIQUE_OUTPUT
					chown $USER_IDS $LOGFILE
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
#		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

#		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
#		then
			SAM_FILTERED_INPUT="$1_align_filtered.sam"
                        DISTR_LGT_PNG="$1_mapped_to_genome_read_length_distribution.png"
#		else
#			BASENAME=$(basename $1 .f*q)
 #                       SAM_FILTERED_INPUT="${BASENAME}_align_filtered.sam"
  #                      DISTR_LGT_PNG="${BASENAME}_mapped_to_genome_read_length_distribution.png"
#		fi

                if [ -s $DISTR_LGT_PNG ]
                then
                        return
                else
                        echo "Computing mapped to genome reads length distribution :"

#			grep -v '^@' $SAM_FILTERED_INPUT | awk '{print length($10)}' | python $PYTHON_SCRIPTS_PATH$PYTHON_SCRIPT_READ_LENGTH_DISTRIBUTION -i $SAM_FILTERED_INPUT -o $DISTR_LGT_PNG
			grep -v '^@' $SAM_FILTERED_INPUT | awk '{print length($10)}' | $PYTHON_SCRIPT_READ_LENGTH_DISTRIBUTION -i $SAM_FILTERED_INPUT -o $DISTR_LGT_PNG
			chown $USER_IDS $DISTR_LGT_PNG

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
#		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}

#		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
#		then
			FILTERED_BAM="$1_align_filtered.bam"
                        FILTERED_SAM="$1_align_filtered.sam"
#		else
#			BASENAME=$(basename $1 .f*q)
 #                       FILTERED_BAM="${BASENAME}_align_filtered.bam"
  #                      FILTERED_SAM="${BASENAME}_align_filtered.sam"
#		fi

		if [ -s $FILTERED_SAM ]
		then
			if [ -s $FILTERED_BAM ]
			then
				return
			else
				echo "Starting of Samtools"
			
#				docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home genomicpariscentre/samtools:0.1.19 bash -c "samtools view -Sb $FILTERED_SAM > $FILTERED_BAM"
				docker run --rm --volumes-from ribopro -w /home genomicpariscentre/samtools:0.1.19 bash -c "samtools view -Sb $FILTERED_SAM > $FILTERED_BAM"
				chown $USER_IDS $FILTERED_BAM

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
#		DIRNAME_ANNOTATIONS=$(dirname $PATH_TO_ANNOTATION_FILE)
		INPUT_ANNOTATION=$(basename $PATH_TO_ANNOTATION_FILE)

		ANNOTATION_PREFIX=${INPUT_ANNOTATION:0:-4}

		CDS_ANNOTATIONS="${ANNOTATION_PREFIX}_only_cds.gtf"
		LONGEST_TRANSCRIPTS="${ANNOTATION_PREFIX}_longest_transcripts.txt"

		CDS_LONGEST_TRANSCRIPTS_LIST="${ANNOTATION_PREFIX}_only_cds_longest_transcripts.txt"
		CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS="${ANNOTATION_PREFIX}_only_cds_longest_transcripts.gtf"

		if [ ! -s $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS ]
		then
#			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -v $DIRNAME_ANNOTATIONS:/root -w /home genomicpariscentre/gff3-ptools bash -c "gtf-filter --keep-comments -o $CDS_ANNOTATIONS \"field feature == CDS\" /root/$INPUT_ANNOTATION"
			docker run --rm --volumes-from ribopro -w /home genomicpariscentre/gff3-ptools bash -c "gtf-filter --keep-comments -o $CDS_ANNOTATIONS \"field feature == CDS\" /root/$INPUT_ANNOTATION"
			chown $USER_IDS $CDS_ANNOTATIONS

			#python $PYTHON_SCRIPTS_PATH$PYTHON_SCRIPT_LONGEST_TRANSCRIPT -i $PATH_TO_ANNOTATION_FILE -o $CDS_LONGEST_TRANSCRIPTS_LIST
			$PYTHON_SCRIPT_LONGEST_TRANSCRIPT -i "/root/${INPUT_ANNOTATION}" -o $CDS_LONGEST_TRANSCRIPTS_LIST
			chown $USER_IDS $CDS_LONGEST_TRANSCRIPTS_LIST

			grep -Ff $CDS_LONGEST_TRANSCRIPTS_LIST $CDS_ANNOTATIONS > $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS
			chown $USER_IDS $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS
		else
			return
		fi
	}

# We compute the number of reads in CDS (HTSeq-count)
htseq_count()
	{
#		WORKING_ANSWER_DEMULTIPLEXING=${ANSWER_DEMULTIPLEXING^^}
		WORKING_ANSWER_RNASEQ_COUNTING=${ANSWER_RNASEQ_COUNTING^^}

#		if [ $WORKING_ANSWER_DEMULTIPLEXING = YES ]
#		then
			FILTERED_BAM="$1_align_filtered.bam"
                        HTSEQCOUNT_FILE="$1_htseq.txt"
                        HTSEQCOUNT_FILE_ANADIF_BABEL="$1_RPcounts.txt"

#		else
#			BASENAME=$(basename $1 .f*q)
 #                       FILTERED_BAM="${BASENAME}_align_filtered.bam"
  #                      HTSEQCOUNT_FILE="${BASENAME}_htseq.txt"
   #                     HTSEQCOUNT_FILE_ANADIF_BABEL="${BASENAME}_RPcounts.txt"
#		fi

#		DIRNAME_ANNOTATIONS=$(dirname $PATH_TO_ANNOTATION_FILE)
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

#				docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR:/home -w /home genomicpariscentre/htseq bash -c "htseq-count --mode $MODE_FOR_MULTIPLE_FEATURES_READS --type $FEATURE_TYPE --idattr $IDATTR --stranded $STRANDED --format $FILETYPE $FILTERED_BAM $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS > $HTSEQCOUNT_FILE"

				docker run --rm --volumes-from ribopro -w /home genomicpariscentre/htseq bash -c "htseq-count --mode $MODE_FOR_MULTIPLE_FEATURES_READS --type $FEATURE_TYPE --idattr $IDATTR --stranded $STRANDED --format $FILETYPE $FILTERED_BAM $CDS_LONGEST_TRANSCRIPTS_ANNOTATIONS > $HTSEQCOUNT_FILE"
				chown $USER_IDS $HTSEQCOUNT_FILE

				mkdir -p DifferentialAnalysis
				chown -R $USER_IDS DifferentialAnalysis

				if [ $WORKING_ANSWER_RNASEQ_COUNTING = YES ]
				then
					grep -v __.* $HTSEQCOUNT_FILE > $HTSEQCOUNT_FILE_ANADIF_BABEL
					chown $USER_IDS $HTSEQCOUNT_FILE_ANADIF_BABEL

					mv $HTSEQCOUNT_FILE_ANADIF_BABEL DifferentialAnalysis
					mv $1_mRNAcounts.txt DifferentialAnalysis
				else

					mv $HTSEQCOUNT_FILE DifferentialAnalysis
				fi

				if [ -s target.txt ]
				then
					mv target.txt DifferentialAnalysis
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
			#SAMP=$(echo $1)

#			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR_ANADIFF:/home -v $R_SCRIPTS_PATH:/root/ -w /home genomicpariscentre/babel Rscript /root/$R_SCRIPT_BUILD_COUNTING_TABLE_RNASEQ $SAMP
			echo docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_BUILD_COUNTING_TABLE_RNASEQ}" ${SAMPLES[@]}
			docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_BUILD_COUNTING_TABLE_RNASEQ}" ${SAMPLES[@]}

#			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR_ANADIFF:/home -v $R_SCRIPTS_PATH:/root/ -w /home genomicpariscentre/babel Rscript /root/$R_SCRIPT_BUILD_COUNTING_TABLE_RP $SAMP
			echo docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_BUILD_COUNTING_TABLE_RP}" ${SAMPLES[@]}
			docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_BUILD_COUNTING_TABLE_RP}" ${SAMPLES[@]}
		else
			return
		fi
	}

anadif_babel()
	{
		WORKDIR_ANADIFF=$(readlink -f DifferentialAnalysis)
		WORKING_ANSWER_RNASEQ_COUNTING=${ANSWER_RNASEQ_COUNTING^^}

		# If user has RNA-seq counting, we use Babel R package
		if [ $WORKING_ANSWER_RNASEQ_COUNTING = YES ]
		then
			#WORKING_CONDITION_ARRAY=$(echo ${CONDITION_ARRAY[*]})

			COND=$1

#			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR_ANADIFF:/home -v $R_SCRIPTS_PATH:/root/ -w /home genomicpariscentre/babel Rscript /root/$R_SCRIPT_ANADIFF_BABEL $COND
			echo docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_BABEL}" ${CONDITION_ARRAY[@]}
			docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_BABEL}" ${CONDITION_ARRAY[@]}

#			docker run --rm -u $(id -u):$(id -g) -v $TMPDIR:/tmp -v $WORKDIR_ANADIFF:/home -v $R_SCRIPTS_PATH:/root/ -w /home genomicpariscentre/babel Rscript /root/$R_SCRIPT_PERMT_TEST_BABEL $COND
			echo docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_PERMT_TEST_BABEL}" ${CONDITION_ARRAY[@]}
			docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/babel Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_PERMT_TEST_BABEL}" ${CONDITION_ARRAY[@]}
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

			PARAM=($WORKDIR_ANADIFF $1 $2 target.txt $WORKDIR_ANADIFF $3)
			WORK_PARAM=$(echo ${PARAM[*]})
			PARAMETERS=$(echo $WORK_PARAM)

                        if [ $WORKING_DIFFERENTIAL_ANALYSIS_PACKAGE = DESEQ2 ]
	                then
				#docker run --rm -u $(id -u):$(id -g) -v $WORKDIR_ANADIFF:/home -v $R_SCRIPTS_PATH:/root/ -w /home genomicpariscentre/sartools Rscript /root/$R_SCRIPT_ANADIFF_SARTOOLS_DESEQ2 $PARAMETERS
#				docker run --rm -u $USER_IDS --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/sartools Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_SARTOOLS_DESEQ2}" $PARAMETERS

				docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/sartools Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_SARTOOLS_DESEQ2}" $PARAMETERS
				chown -R $USER_IDS DifferentialAnalysis
			else
#				docker run --rm -u $(id -u):$(id -g) -v $WORKDIR_ANADIFF:/home -v $R_SCRIPTS_PATH:/root/ -w /home genomicpariscentre/sartools Rscript /root/$R_SCRIPT_ANADIFF_SARTOOLS_EDGER $PARAMETERS
#				docker run --rm -u $USER_IDS --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/sartools Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_SARTOOLS_EDGER}" $PARAMETERS
				
				docker run --rm --volumes-from ribopro -w $WORKDIR_ANADIFF genomicpariscentre/sartools Rscript "${R_SCRIPTS_PATH}/${R_SCRIPT_ANADIFF_SARTOOLS_EDGER}" $PARAMETERS
                                chown -R $USER_IDS DifferentialAnalysis
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

#parallel align_To_R_RNA {.} ::: $WORKING_SAMPLE_ARRAY
align_To_R_RNA

wait

parallel Unmmaped_to_rRNA_report {.} ::: $WORKING_SAMPLE_ARRAY

wait

parallel mapped_to_R_RNA_distrib_length {.} ::: $WORKING_SAMPLE_ARRAY

wait

#parallel align_to_ref_genome ::: $WORKING_SAMPLE_ARRAY
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

#build_rnaseq_ribopro_counting_tables ${SAMPLE[@]}
#build_rnaseq_ribopro_counting_tables $WORKING_SAMPLE
build_rnaseq_ribopro_counting_tables

wait

anadif_babel $CONDITIONS

wait

anadif_sartools $PROJECT_NAME $AUTHOR $REFERENCE_CONDITION

FINALLOGFILE="${PROJECT_NAME}.final.report"

for file in $(ls -c *log); do stat -c '%y' $file >> $FINALLOGFILE; printf "\n" >> $FINALLOGFILE; cat $file >> $FINALLOGFILE; done
rm -rf $TMPDIR

