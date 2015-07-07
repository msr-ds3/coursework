# dataset: http://times.cs.uiuc.edu/~wang296/Data/

# set working directory to the path of this script
dataFolder = "data"
filenames = list.files(dataFolder,full.names = T)
text = sapply(filenames, GetText)
text = unlist(text)
ratings = sapply(filenames, GetRatings)
ratings = unlist(ratings)
data = data.frame(Text = text, Rating = ratings, row.names=NULL, stringsAsFactors = F)
data$Label = NA
data[data$Rating > 3, "Label"] = 'P'
data[data$Rating == 1 | data$Rating==2, "Label"] = 'N'

subset = c(
  sample(which(data$Rating==4), size = 2500, replace = F),
  sample(which(data$Rating==5), size = 2500, replace = F),
  sample(which(data$Rating==1), size = 2500, replace = F),
  sample(which(data$Rating==2), size = 2500, replace = F)
)
data = data[subset, ]

library(RWeka)
tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 2))

dtm = GetDTM(data$Text, tokenizer= tokenizer)

dim(dtm)
dtm = removeSparseTerms(dtm, 0.995)
dim(dtm)


write.csv(
  data.frame(i=dtm$i, j=dtm$j, v=dtm$v),
             "c:\\temp\\ta_dtm_sparse.csv", row.names=F)

write.csv(
  data.frame(Vocab=Terms(dtm)),"c:\\temp\\vocab.csv", row.names=F)


write.csv(
  data.frame(Label=data$Label),"c:\\temp\\labels.csv", row.names=F)


# write dense document-term matrix
#write.csv(  data.frame(data$Label, (as.matrix(dtm)), "c:\\temp\\ta_dtm.csv", row.names=F))

# write sparse document-term matrix

