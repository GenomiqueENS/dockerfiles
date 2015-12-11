#!/usr/bin/python
# -*- coding: utf-8 -*-

#
#
#

import argparse
import sys
import os
import math
import re
import time

#---------------------------------------------------------------------------------------
# Generate regex
# 
# 
#---------------------------------------------------------------------------------------
def generate_regex(adapt) :
	
	regex = "^"	# à modifier si l'adapt n'est pas au début
	print "WARNING : read must BEGIN with the adapter"
	for char in adapt :
		if char in ["A","T","C","G"] :
			regex += char
		elif char == "N" :
			regex += "\w"
		else : # à compléter si besoin particuliers
			regex += "."

	print "INFO : the tested regex will be : "+str(regex)
	return regex

#---------------------------------------------------------------------------------------
# Filter fastq file
# 
# 
#---------------------------------------------------------------------------------------
def search_and_write(inF, outF, regex):

	try:
		inFile = open(inF, 'r')

	except IOError:
		print "No such file or directory : " + inF
		sys.exit(1)

	outFile = open(outF, 'w')

	nbReads = 0
	nbKept = 0

	motif = re.compile(regex)

	while True :
		name = inFile.readline()
		if not name : 
			break
		nbReads += 1
		if nbReads%10000000 == 0 :
			print "COUNT : "+str(nbKept)+" reads kept ("+str(nbReads)+" total)."

		read = inFile.readline()
		strangeThirdLine = inFile.readline()
		qual = inFile.readline()

		if not read or not strangeThirdLine or not qual :
			print "WARNING : fastq file ended at an unexpected line. Please check your file !"
			break

		test = motif.search(read)


		if test :
			nbKept += 1
			outFile.write(name)
			outFile.write(read)
			outFile.write(strangeThirdLine)
			outFile.write(qual)


	
	inFile.close()
	outFile.close()

	perct = float(nbKept)/float(nbReads) * 100
	perct = "{0:.2f}".format(perct)
	print "TOTAL COUNT : "+str(nbKept)+" reads matched from "+str(nbReads)+" total ("+str(perct)+"%)."
	print "INFO : matching reads have been written to "+str(outF)+" in FASTQ format."


	return


#---------------------------------------------------------------------------------------
# Filter fastq file
# 
# 
#---------------------------------------------------------------------------------------
def search_and_count(inF, regex):
	try:
		inFile = open(inF, 'r')

	except IOError:
		print "No such file or directory : " + inF
		sys.exit(1)

	nbReads = 0
	nbKept = 0

	motif = re.compile(regex)

	while True :
		name = inFile.readline()
		if not name : 
			break
		nbReads += 1
		if nbReads%10000000 == 0 :
			print "COUNT : "+str(nbKept)+" reads kept ("+str(nbReads)+" scanned)."

		read = inFile.readline()
		strangeThirdLine = inFile.readline()
		qual = inFile.readline()

		if not read or not strangeThirdLine or not qual :
			print "WARNING : fastq file ended at an unexpected line. Please check your file !"
			break

		test = motif.search(read)
		if test :
			nbKept += 1
	
	inFile.close()
	perct = float(nbKept)/float(nbReads) * 100
	perct = "{0:.2f}".format(perct)
	print "TOTAL COUNT : "+str(nbKept)+" reads matched from "+str(nbReads)+" total ("+str(perct)+"%)."
	return

#################################################################################
# MAIN
#################################################################################

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("-i", "--input", required = True, metavar = "input_multiplexing.fastq", help = "Fastq file with multiplexed reads")
	parser.add_argument("-o", "--output", required = False, metavar = "output_demultiplexing.fastq", help = "Fastq file with demultiplexed reads")
	parser.add_argument("-a", "--adapter", required = True, metavar = "5' adapter sequence", help = "5' adapter sequence :  it has to be at the beginning of the read !")
	args = parser.parse_args()

	inFile = args.input
	outFile = args.output
	adapter = args.adapter

	if outFile != None:	
		regex = generate_regex(adapter)
		print "INFO : Starting scan of "+str(inFile)+" (expected format : FASTQ)."
		print "DATE OF STARTING : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
		search_and_write(inFile, outFile, regex)
		print "DATE OF THE END OF THE STEP : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
	else:
		print " "
		print "WARNING : No output specified - COUNT ONLY mode."

		regex = generate_regex(adapter)
		print "INFO : Starting scan of "+str(inFile)+" (expected format : FASTQ)."
		print "DATE OF STARTING : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
		search_and_count(inFile, regex)
		print "DATE OF THE END OF THE STEP : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
