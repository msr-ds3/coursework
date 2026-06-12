# target to make the file report
all: 05_final_report.html

googlebooks-eng-all-1gram-20120701-1.gz: 
	# run script to download the 1grams data 
	./01_download_1grams.sh
	
year_counts.tsv: 
	# run script to filter the 1grams data 
	./02_filter_1grams.sh

googlebooks-eng-all-totalcounts-20120701.txt:
	# run script to download the total counts data 
	./03_download_totals.sh

total_counts.csv: 
	# run script to reformat the total counts data 
	./04_reform_totals.sh

05_final_report.html: # add filenames for data and/or code this output depends on here
	Rscript -e "rmarkdown::render('05_final_report.Rmd')"

05_final_report.pdf: # add filenames for data and/or code this output depends on here
	Rscript -e "rmarkdown::render('05_final_report.Rmd', output_format = 'pdf_document')"