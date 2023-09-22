all: 05_final_report.html

googlebooks-eng-all-1gram-20120701-1.gz: 01_download_1grams.sh
	bash 01_download_1grams.sh

year_counts.tsv: googlebooks-eng-all-1gram-20120701-1.gz 02_filter_1grams.sh
	bash 02_filter_1grams.sh

googlebooks-eng-all-totalcounts-20120701.txt: 03_download_totals.sh
	bash 03_download_totals.sh

total_counts.csv: googlebooks-eng-all-totalcounts-20120701.txt 04_reformat_totals.sh
	bash 04_reformat_totals.sh

05_final_report.html: year_counts.tsv total_counts.csv 05_final_report.Rmd
	Rscript -e "rmarkdown::render('05_final_report.Rmd')"
