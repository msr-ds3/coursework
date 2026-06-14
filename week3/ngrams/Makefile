# target to make the file report
all: 05_final_report.pdf

googlebooks-eng-all-1gram-20120701-1.gz: # add filenames for data and/or code this output depends on here
	# add code to run script to download the 1grams data here
	curl -L http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-1gram-20120701-1.gz -o "googlebooks-eng-all-1gram-20120701-1.gz"

year_counts.tsv: # add filenames for data and/or code this output depends on here 
	# add code to run script to filter the 1grams data here
	zcat googlebooks-eng-all-1gram-20120701-1.gz | awk '$1 ~/^(18|19|20)[0-9]{2}$/' > year_counts.tsv


googlebooks-eng-all-totalcounts-20120701.txt: # add filenames for data and/or code this output depends on here
	# add code to run script to download the total counts data here
	curl -L http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-totalcounts-20120701.txt -o "googlebooks-eng-all-totalcounts-20120701.txt"

total_counts.csv: # add filenames for data and/or code this output depends on here
	# add code to run script to reformat the total counts data here
	bash 04_reformat_totals.sh

05_final_report.pdf: # add filenames for data and/or code this output depends on here
	Rscript -e "rmarkdown::render('05_final_report.Rmd', output_format='pdf_document', clean=FALSE)"

