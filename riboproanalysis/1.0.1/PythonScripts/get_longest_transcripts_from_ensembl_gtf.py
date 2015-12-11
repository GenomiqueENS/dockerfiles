#! /usr/bin/python
#-*- coding: utf-8 -*-

import time
import argparse
import sys

def read_gtf(gtf):
	"""This function read a gtf file and return a dictionary
	with genes_id as keys
	and tuples containing transcript_id and length for all transcripts of each gene"""
	
	# Dict initialisation
	transcripts = {}
	
	try:	
		# Read the gtf
		f = open(gtf, "r")

	except IOError:
		print "No such file or directory : " + gtf
		sys.exit(1)
		
	for line in f:
		if line.startswith("#") == False:
			line = line.split('\t')
			if line[2] == "transcript":
			
				length = abs(int(line[3]) - int(line[4]))
			
				attributes  = line[8].split(';')
				
				l_attributes = [info.strip() for info in attributes]

				for info in l_attributes:
					if info.find("gene_id") != -1:
						info_gene_id = info
					elif info.find("transcript_id") != -1:
						info_transcript_id = info
				
				gene_id = info_gene_id[9:-1]
				transcript_id = info_transcript_id[15:-1]
			
				if gene_id not in transcripts.keys():
					transcripts[gene_id] = (transcript_id, length)
				else:
					if length > transcripts[gene_id][1]:
						transcripts[gene_id] = (transcript_id, length)
	return transcripts


def get_longest_transcripts_per_gene(output,transcripts_dict):
	"""Write all  transcripts id corresponding to the longest
	transcript for each gene in a file"""

	with open(output, "w") as f:
		for k, v in transcripts_dict.items():
			f.write(str(v[0]) + "\n")
	
if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("-i", "--input", required = True, metavar = "input annotations", help = "Gtf file to filter")
	parser.add_argument("-o", "--output", required = True, metavar = "longest transcripts file")
	args = parser.parse_args()
	input_annotations = args.input
	output_transcripts_id_list = args.output
	
	print "DATE OF THE STARTING : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
	transcripts_dict = read_gtf(input_annotations)

	get_longest_transcripts_per_gene(output_transcripts_id_list, transcripts_dict)
	print "DATE OF THE END OF THE STEP : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))

