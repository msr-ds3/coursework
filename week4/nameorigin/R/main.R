# get data
data_url = "https://raw.githubusercontent.com/enorvelle/NameDatabases/master/NamesDatabases/surnames"
country_codes = c("it", "pt", "pl", "cz", "fr", "de", "es")

library(RCurl)
GetSurnames = function(country_code, data_url){
  url = paste(data_url, country_code, sep ="/")
  url = paste(url, "txt", sep=".")
  surnames = getURL(url)
  surnames = strsplit(names2, split = "\n")
  surnames = unlist(names2)
  df = data.frame(Surname = surnames)
  df$Country = country_code
  return(df)
}

data = sapply(country_codes, GetSurnames, data_url = data_url, simplify = F)

data = do.call(rbind, data)

rownames(data) = NULL
table(data$Country)
data$Surname = as.character(data$Surname)
data = data[data$Surname != "", ]

subset = c(
  which(data$Country=="it"),
  which(data$Country=="fr"),  
  which(data$Country=="pt"),
  sample(which(data$Country=="de"), size = 5500, replace = F),
  sample(which(data$Country=="es"), size = 5500, replace = F)
)

data = data[subset, ]

GetFeatures = function(s){  
  s = tolower(s)
  chars = strsplit(s, split = "")
  chars = unlist(chars)
  chars = iconv(chars, to = "UTF8")
  utf_values = sapply(chars, utf8ToInt) # decimal unicode value
  l = length(chars)
  vowel_positions = which(chars %in% c("a","e","i","o","u","y"))
  mid_position = (l + 1) / 2
  letter_features=rep(0, 26)
  letter_features[which(letters %in% chars)] = 1
  names(letter_features)=letters
  
  features = c(
    mean_utf = mean(utf_values,na.rm = T),
    sd_utf = sd(utf_values),
    last_char = chars[l],
    last_2_chars = ifelse(l > 2, paste(chars[(l-1):l], collapse = ""), ""),
    vowel_proportion = length(vowel_positions) / l,
    mavd = mean(abs(vowel_positions - mid_position)),  # mean absolute vowel deviation          
    letter_features
  )    
  return(features)
}


features = sapply(data$Surname, GetFeatures)
data = data[,c("Surname", "Country")]
data = cbind(data, t(features), row.names=NULL, stringsAsFactors=F)
data$mean_utf = as.numeric(data$mean_utf)
data$sd_utf = as.numeric(data$sd_utf)
data$vowel_proportion = as.numeric(data$vowel_proportion)
data$mavd = as.numeric(data$mavd)

data = data[!is.na(data$sd_utf), ]
data = data[!is.na(data$mavd), ]

table(data$Country)

write.csv(data, "namesdata.csv", row.names=F)

# http://en.wikipedia.org/wiki/List_of_Unicode_characters
# basic latin: 97-122
# latin-1 223:255
#https://github.com/enorvelle/NameDatabases/tree/master/NamesDatabases/surnames

s = "bleikin"


