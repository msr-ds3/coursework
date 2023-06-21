# target to make the file report
all: 05_final_report.html

googlebooks-eng-all-1gram-20120701-1.gz: 01_download_1grams.sh
	# add code to run script to download the 1grams data here
	bash 01_download_1grams.sh

year_counts.tsv: googlebooks-eng-all-1gram-20120701-1.gz 02_filter_1grams.sh
	# add code to run script to filter the 1grams data here
	bash 02_filter_1grams.sh
	
googlebooks-eng-all-totalcounts-20120701.txt: 03_download_totals.sh
	# add code to run script to download the total counts data here
	bash 03_download_totals.sh

total_counts.csv: googlebooks-eng-all-totalcounts-20120701.txt 04_reformat_totals.sh
	# add code to run script to reformat the total counts data here
	bash 04_reformat_totals.sh
	
05_final_report.html: # add filenames for data and/or code this output depends on here
	Rscript -e "rmarkdown::render('05_final_report.Rmd')"
