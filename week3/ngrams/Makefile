# target to make the file report
all: 05_final_report.html

googlebooks-eng-all-1gram-20120701-1.gz: 01_download_1grams.sh
	bash 01_download_1grams.sh

year_counts.tsv: 02_filter_1grams.sh googlebooks-eng-all-1gram-20120701-1.gz
	bash 02_filter_1grams.sh

googlebooks-eng-all-totalcounts-20120701.txt: 03_download_totals.sh
	bash 03_download_totals.sh

total_counts.csv:  04_reformat_totals.sh googlebooks-eng-all-totalcounts-20120701.txt
	bash 04_reformat_totals.sh

05_final_report.html: 05_final_report.Rmd year_counts.tsv total_counts.csv michel_fig_3a.png ngramViewer.png
	Rscript -e "rmarkdown::render('05_final_report.Rmd')"

