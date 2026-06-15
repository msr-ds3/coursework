# target to make the file report
all: 05_final_report.html

googlebooks-eng-all-1gram-20120701-1.gz: 01_download_1grams.sh.R
	# run script to download the 1grams data 
	Rscript 01_download_1grams.sh.R
	
year_counts.tsv: 02_filter_1grams.sh
	# run script to filter the 1grams data 
	Rscript 02_filter_1grams.sh.R

googlebooks-eng-all-totalcounts-20120701.txt: 03_download_totals.sh.R
	# run script to download the total counts data 
	Rscript 03_download_totals.sh.R

total_counts.csv: 04_reform_totals.sh.R
	# run script to reformat the total counts data 
	04_reform_totals.sh.R

05_final_report.html: # add filenames for data and/or code this output depends on here
	Rscript -e "rmarkdown::render('05_final_report.Rmd')"

05_final_report.pdf: # add filenames for data and/or code this output depends on here
	Rscript -e "rmarkdown::render('05_final_report.Rmd', output_format = 'pdf_document')"