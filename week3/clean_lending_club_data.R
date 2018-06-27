#this scipt takes the raw Lending Club data and creates lending_club_cleaned.csv data
#we eliminated observations with missing value for `loan_status`,
#created good loan/bad loan indicator named `good`,
#calculated average `fico`, consolidated small or similar purpose categories,
#created a new variable `income` which includes income if either the source of income or income itself is verified.

library(dplyr)
# https://www.lendingclub.com/info/download-data.action
# https://resources.lendingclub.com/LCDataDictionary.xlsx

loan <- read.csv("https://www.dropbox.com/s/vljs4z2r4wixful/LoanStats3a_securev1.csv?raw=1", skip=1)
#loan <- read.csv("LoanStats3a_securev1.csv", skip=1)
loan <- filter(loan, loan_status!="")
loan$good <- ifelse(loan$loan_status=="Current" | 
                      loan$loan_status=="Fully Paid" |
                      loan$loan_status=="Does not meet the credit policy.  Status:Fully Paid","good","bad")
loan$good <- as.factor(loan$good)
loan$fico <- (loan$fico_range_high+loan$fico_range_low)/2

#consolidate some of the purpose categories
#create a character vector with level 'labels' where 'renewable energy' is replaced with 'other'
loan$test <- ifelse(loan$purpose=="renewable_energy" | loan$purpose=="moving", 
                    "other", as.character(loan$purpose))
loan$test <- ifelse(loan$purpose=="house", "home_improvement", loan$test)
loan$test <- ifelse(loan$purpose=="vacation", "vacation_wedding", loan$test)
loan$test <- ifelse(loan$purpose=="wedding", "vacation_wedding", loan$test)
loan$test <- ifelse(loan$purpose=="credit_card", "debt_consolidation", loan$test)
loan$test <- ifelse(loan$purpose=="car", "major_purchase", loan$test)
#turn the character vector back into a factor
loan$purpose <- as.factor(loan$test)
table(loan$purpose)
levels(loan$purpose)
loan$income <- ifelse(loan$is_inc_v=="Not Verified", NA, loan$annual_inc)

table(loan$is_inc_v)
write.csv(select(loan, good, purpose, fico, dti, loan_amnt, income), 
          "lending_club_cleaned.csv",
          row.names = FALSE)
