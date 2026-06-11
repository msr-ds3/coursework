# target to make the file report
all: 05_final_report.html

googlebooks-eng-all-1gram-20120701-1.gz: 
	bash 01_download_1grams.sh

year_counts.tsv: googlebooks-eng-all-1gram-20120701-1.gz
	bash 02_filter_1grams.sh

googlebooks-eng-all-totalcounts-20120701.txt: 
	bash 03_download_totals.sh

total_counts.csv: googlebooks-eng-all-totalcounts-20120701.txt
	bash 04_reformat_totals.sh

05_final_report.html: year_counts.tsv total_counts.csv
	Rscript -e "rmarkdown::render('05_final_report.Rmd')"
