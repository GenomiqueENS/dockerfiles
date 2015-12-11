#!/usr/bin/python

import sys
import argparse
import time

if __name__=='__main__':
	parser = argparse.ArgumentParser()      
        parser.add_argument("-i", "--input", required = True, metavar = "input.fastq", help = "Fastq with bad passing filter quality")
        parser.add_argument("-o", "--output", required = True, metavar = "output.fastq", help = "Fastq without bad passing filter quality")
        args = parser.parse_args()
        FQ = args.input
        Out = args.output
	
	try:
		fileFQ = open(FQ,"r")
	except IOError:
		print "No such file or directory " + FQ
		sys.exit(1)

	fileOut = open(Out,"w")

	nbKept = 0
	nbReads = 0

	print "DATE OF STARTING : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
	while 1:
		line1 = fileFQ.readline()
		line1 = line1.strip()
		if line1 == "":
			break
		line2 = fileFQ.readline()
		line2 = line2.strip()
		line3 = fileFQ.readline()
		line3 = line3.strip()
		line4 = fileFQ.readline()
		line4 = line4.strip()
		result = line1.split(":")[-3]
		if result == "N":
			fileOut.write(line1 + "\n" + line2 + "\n" + line3 + "\n" + line4 + "\n")
			nbKept += 1
		nbReads += 1

	fileFQ.close()
	fileOut.close()

	## output some stats to stdout
	perct = float(nbKept)/float(nbReads) * 100
	perct = "{0:.2f}".format(perct)
	print "TOTAL COUNT : "+str(nbKept)+" reads kept from "+str(nbReads)+" total ("+str(perct)+"%)."
	print "INFO : reads have been written to "+str(Out)+" in FASTQ format."
	print "DATE OF THE END OF THE STEP : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
