exercises
####define a regular expression for zip codes.
[0-9]{5})-[0-9]{4})?


####define a regular expression for US phone numbers.
^+1\([0-9]{3}\) [0-9]{3} [0-9]{4}

####define a regular expression for email addresses from US universities.
\w(\w|.)*\w@[a-zA-Z0-9_\-\.].


1....list the subject lines for all messages in the package.

for D in 'find . -type d';do  echo $D; egrep -i ".**." $D/* |wc -l; done
grep '^Subject:' 20_newsgroups/*/*
2....count the number of mentions of “baseball” per newsgroup.
egrep -c '.*baseball*.' 20_newsgroups/*/* 
3....count the number of mentions of “hockey” per newsgroup.
egrep -c '.*hockey*.' 20_newsgroups/*/* 

