# dataset: http://times.cs.uiuc.edu/~wang296/Data/
#http://times.cs.uiuc.edu/~wang296/Data/LARA/TripAdvisor/Review_Texts.zip


dataFolder = "c:/temp/tadata"
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
tokenizer = function(x) NGramTokenizer(x, Weka_control(min = 1, max = 2))
#OR:
tokenizer = function(s) {  
  w = unlist(strsplit(as.character(s) , " "))
  l = length(w) - 1 
  c(paste(w[1:l] , w[2:(l+1)], sep=" "), w)  
}



dtm = GetDTM(data$Text, tokenizer= tokenizer)

dim(dtm)
dtm = removeSparseTerms(dtm, 0.995)
dim(dtm)



# (optional) write files
write.csv(
  data.frame(i=dtm$i, j=dtm$j, v=dtm$v),
             "c:\\temp\\ta_dtm_sparse.csv", row.names=F)

write.csv(
  data.frame(Vocab=Terms(dtm)),"c:\\temp\\vocab.csv", row.names=F)


write.csv(
  data.frame(Label=data$Label),"c:\\temp\\labels.csv", row.names=F)









