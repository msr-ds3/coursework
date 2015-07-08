
GetText = function(f){
  lines = readLines(f)  
  m = regexpr(pattern = "(^<Content>)(.+)", text = lines)
  text = regmatches(x = lines, m)
  text = gsub("^<Content>","", text)
  return(text)
}

GetRatings = function(f){
  lines = readLines(f)
  m = regexpr(pattern = "(^<Overall>)(.+)", text = lines)
  ratings = regmatches(x = lines, m)
  ratings = as.numeric(gsub("^<Overall>","", ratings))
  return(ratings)
}

GetDTM = function(text, dictionary = NULL, tokenizer=NULL){
  library(tm)
  corpus = Corpus(VectorSource(text))  
  corpus = tm_map(corpus, removeWords, stopwords('english'))
  dtm = DocumentTermMatrix(corpus,
                           control=list(tokenize = tokenizer,
                                        removePunctuation = F,
                                        removeNumbers = T,
                                        weighting = weightBin,
                                        dictionary = dictionary))
}

Evaluate = function(pred, actual){
  cm = table(pred=pred, actual=actual)
  TN = cm[1,1]
  TP = cm[2,2]
  FP = cm[2,1]
  FN = cm[1,2]
  
  accuracy = (TP + TN) / (TP + TN + FP + FN)
  precision = TP / (TP + FP)
  recall = TP / (TP + FN)
  F1 = 2 * precision * recall / (precision + recall)
  print(paste("accuracy:", accuracy))
  print(paste("precision:", precision))
  print(paste("recall:", recall))
  print(paste("F1:", F1))
}


tokenize = function(s) {  
  w = unlist(strsplit(as.character(s) , " "))
  l = length(w) - 1 
  c(paste(w[1:l] , w[2:(l+1)], sep=" "), w)  
}


