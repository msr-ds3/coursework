import argparse
import namespaceCV

def parseArgs():
	'''
	Summary:
		Parses all command line arguments.
	'''
	# Parse command line arguments
	parser = argparse.ArgumentParser()
	parser.add_argument("-img", type=str, nargs='?', help="specify an image deal with")
	parser.add_argument("-bw", type=bool, nargs='?', help="specify if a computed histogram should be black and white")
	parser.add_argument("-pick", type=bool, nargs='?', help="flag to select classes for classification (default is hedgehog vs. accordion)")
	args = parser.parse_args()

	if args.img:
		# If an image name was passed in, set the global image variable in the namespace to the image name.
		namespaceCV.IMG = namespaceCV.IMG_DIR + args.img + ".jpg"
		print namespaceCV.IMG
	if args.bw:
		namespace.BW = True
	if args.pick:
		namespaceCV.DEFAULTCLASS = False