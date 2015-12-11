#! /usr/bin/python

import time
import argparse
import sys

if __name__=='__main__':
	parser = argparse.ArgumentParser()      
        parser.add_argument("-i", "--input", required = True, metavar = "input.sam", help = "Unfiltered SAM file as input")
        parser.add_argument("-o", "--output", required = True, metavar = "output_filtered.sam", help = "Filtered SAM file as output")
	parser.add_argument("-m", "--multireads", required = False, metavar = "output_multireads.sam", help = "SAM file with multi-reads as output")
        args = parser.parse_args()

        inPutSam = args.input
        outPutSamUniq = args.output
	outPutMulti = args.multireads


	if outPutMulti != None:
		writeMulti = True
	else:
		writeMulti = False

	print "INFO : Starting scan of "+str(inPutSam)+" (expected format : SAM)."
	print "DATE OF THE STARTING : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))

	entree = sys.stdin
	
	entry_1 = ""
	id_1 = ""

	entry_2 = entree.readline()
	id_2 = entry_2.strip().split("\t")[0]
	
	nbLine = 1
	nbUniq = 0
	nbMulti = 0

	try:
		inPutSamFile = open(inPutSam,"r")

	except IOError:
		print "No such file or directory : " + inPutSam
		sys.exit(1)

	outUnique = open(outPutSamUniq,"w")
	if writeMulti:
		outMulti = open(outPutMulti,"w")

	for line in inPutSamFile:
		if line.startswith('@'):
			outUnique.write(line)

			if writeMulti:
				outMulti.write(line)

	inPutSamFile.close()

	while True:
		entry_3 = entree.readline()

		if entry_3 == '':
			if id_2 != id_1:
				outUnique.write(entry_2)
				nbUniq += 1
			else:
				if writeMulti:
					outMulti.write(entry_2)
				nbMulti += 1
                        break

		nbLine += 1

		if nbLine%1000000 == 0 :
			print "COUNT : "+str(nbLine)+" processed lines ("+str(nbUniq)+" uniquely mapped and "+str(nbMulti)+ " multi-mapped reads)."

		id_3 = entry_3.strip().split("\t")[0]

		if (id_2 != id_1) and (id_2 != id_3):
			outUnique.write(entry_2)
			nbUniq += 1
		else:
			if writeMulti:
				outMulti.write(entry_2)
			nbMulti += 1
		
		id_1 = id_2
		entry_1 = entry_2

		id_2 = id_3
		entry_2 = entry_3

	outUnique.close()
	if writeMulti:
		outMulti.close()

	## output some stats to stdout
	perct = float(nbUniq)/float(nbLine) * 100
	perct = "{0:.2f}".format(perct)
	print "TOTAL COUNT : "+str(nbUniq)+" uniquely mapped reads from "+str(nbLine)+" total ("+str(perct)+"%)."
	print "INFO : unique reads have been written to "+str(outPutSamUniq)+" in SAM format."

	if writeMulti:
		print "INFO : multi-reads have been written to "+str(outPutMulti)+" in SAM format."

	print "DATE OF THE END OF THE STEP : " + str(time.strftime("%Y-%m-%d %H:%M:%S"))
