#!/usr/bin/python
# -*- coding: utf-8 -*-

import matplotlib
matplotlib.use('Agg')
import argparse
import matplotlib.pyplot as plt
import sys
import os

if __name__=='__main__':
	parser = argparse.ArgumentParser()      
        parser.add_argument("-i", "--input", required = True, metavar = "input.sam", help = "Alignment on SAM format as input")
        parser.add_argument("-o", "--output", required = True, metavar = "output.png", help = "Read length distribution picture as output")
        args = parser.parse_args()

	if os.path.exists(args.input):
	        inPut = args.input
	else:
		print "No such file : " + args.input
		sys.exit(1)

        graphOutputName = args.output

	reads_lgts = []
	entree = sys.stdin

        for line in entree:
                reads_lgts.append(int(line.strip()))

        plt.hist(reads_lgts, histtype='bar', facecolor='b')

	title = 'Reads length distribution from ' + inPut

	plt.title(title)
	plt.xlabel('Length')
	plt.ylabel('Number of reads')
	plt.grid(True)
        plt.savefig(graphOutputName)
