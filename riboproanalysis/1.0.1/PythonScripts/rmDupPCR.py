#!/usr/bin/python

import os
import sys
import argparse
import time

def computeSequenceQuality(qualityLine):
	qualityScore = 0

	for char in qualityLine:
		qualityScore += ord(char)

	return qualityScore

if __name__=='__main__':
	parser = argparse.ArgumentParser()	
	parser.add_argument("-i", "--input", required = True, metavar = "input.fastq", help = "Fastq with PCR duplicates as input")
	parser.add_argument("-o", "--output", required = True, metavar = "output.fastq", help = "Fastq without PCR duplicates as output")
	args = parser.parse_args()

	if os.path.exists(args.input):
		inPut = args.input
	else:
		print "No such file : " + args.input
		sys.exit(1)

	outPut = args.output

	s1 = None
	quality1 = None

	entree = sys.stdin

	nbReads = 0
	nbKept = 0

	o = open(outPut,"w")
	
	print "DATE OF THE STARTING : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))

	for line in entree:
		line = line.strip()
		s = line.split()
		s2 = s[0]
		readIdLine2 = s[1] + " " + s[2]
		thirdLine2 = s[4]
		qualityLine2 = s[3]
		quality2 = computeSequenceQuality(qualityLine2)

		nbReads += 1
	
			
		if len(s) != 5:
			sys.stderr.write("WARNING : fastq file ended at an unexpected line. Please check your file !")
			break

		if nbReads%1000000 == 0 :
			print "COUNT : " + str(nbReads) + " processed reads (" + str(nbKept)+" kept)."

		if s1 == s2:
			if quality2 > quality1:
				quality1 = quality2
                                readIdLine1 = readIdLine2
                                thirdLine1 = thirdLine2
                                qualityLine1 = qualityLine2
		else:
			if s1 != None:
				o.write(readIdLine1 + "\n")
				o.write(s1 + "\n")
				o.write(thirdLine1 + "\n")
				o.write(qualityLine1 + "\n")	

			s1 = s2
			quality1 = quality2
			readIdLine1 = readIdLine2
			thirdLine1 = thirdLine2
			qualityLine1 = qualityLine2

			nbKept += 1

	if s1:
		o.write(readIdLine1 + "\n")
		o.write(s1 + "\n")
		o.write(thirdLine1 + "\n")
		o.write(qualityLine1 + "\n")

	o.close()

	## output some stats to stdout
	try:
		perct = float(nbKept)/float(nbReads) * 100
		perct = "{0:.2f}".format(perct)
	except ZeroDivisionError:
		sys.stderr.write("Cannot read sequences !")
		sys.exit(1)

	print "TOTAL COUNT : "+str(nbKept)+" reads kept from "+str(nbReads)+" total ("+str(perct)+"%)."
	print "DATE OF THE END OF THE STEP : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
