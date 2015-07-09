# Local libs
import namespaceCV
import utils

# Python libs
import cv2
import numpy as np
from matplotlib import pyplot as plt

# Sets namespaceCV.IMG to whatever image name was passed in
utils.parseArgs()

if namespaceCV.BW:
	# If black and white
	img = cv2.imread(namespaceCV.IMG,0)
	plt.hist(img.ravel(),256,[0,256]); plt.show()
else:
	# Color histogram
	img = cv2.imread(namespaceCV.IMG)
	color = ('b','g','r')
	for i,col in enumerate(color):
	    histr = cv2.calcHist([img],[i],None,[256],[0,256])
	    plt.plot(histr,color = col)
	    plt.xlim([0,256])
	plt.show()