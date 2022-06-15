# target to make the file report
all: 05_final_report.html

googlebooks-eng-all-1gram-20120701-1.gz: # add filenames for data and/or code this output depends on here
	# add code to run script to download the 1grams data here

year_counts.tsv: # add filenames for data and/or code this output depends on here 
	# add code to run script to filter the 1grams data here

googlebooks-eng-all-totalcounts-20120701.txt: # add filenames for data and/or code this output depends on here
	# add code to run script to download the total counts data here

total_counts.csv: # add filenames for data and/or code this output depends on here
	# add code to run script to reformat the total counts data here

05_final_report.html: # add filenames for data and/or code this output depends on here
	Rscript -e "rmarkdown::render('05_final_report.Rmd')"
