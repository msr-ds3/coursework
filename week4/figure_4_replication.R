library(tidyverse)

# Import immigrant crime trend data
crime <- read_csv("immigrant_crime.csv")
crime$Month <- as.Date(paste0(crime$Month, "-01"), format = "%Y-%m-%d")
crime <- crime |> 
  filter(Trend != 0)
crime <- crime |> 
  mutate(President = case_when(
    between(Month, as.Date("2001-01-01"), as.Date("2009-12-31")) ~ "Bush",
    between(Month, as.Date("2009-1-1"), as.Date("2017-1-19")) ~ "Obama",
    TRUE ~ "Trump"
  ))

# Crime Trends Graph by Presidential Term
crime |> 
  ggplot(aes(x = Month, y = Trend, color = President)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(
    x = "",
    y = "Google Trends"
  ) +
  ggtitle("Crime Trends")

# Import immigrant reporting trend data
reporting <- read_csv("immigrant_reporting.csv")
reporting$Month <- as.Date(paste0(reporting$Month, "-01"), format = "%Y-%m-%d")
reporting <- reporting |> 
  filter(Trend != 0)
reporting <- reporting |> 
  mutate(President = case_when(
    between(Month, as.Date("2001-01-01"), as.Date("2009-12-31")) ~ "Bush",
    between(Month, as.Date("2009-1-1"), as.Date("2017-1-19")) ~ "Obama",
    TRUE ~ "Trump"
  ))

# Reporting Trends Graph by Presidential Term
reporting |> 
  ggplot(aes(x = Month, y = Trend, color = President)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(
    x = "",
    y = "Google Trends"
  ) +
  ggtitle("Reporting Trends")

# Import immigrant welfare trend data
welfare <- read_csv("immigrant_welfare.csv")
welfare$Month <- as.Date(paste0(welfare$Month, "-01"), format = "%Y-%m-%d")
welfare <- welfare |> 
  filter(Trend != 0)
welfare <- welfare |> 
  mutate(President = case_when(
    between(Month, as.Date("2001-01-01"), as.Date("2009-12-31")) ~ "Bush",
    between(Month, as.Date("2009-1-1"), as.Date("2017-1-19")) ~ "Obama",
    TRUE ~ "Trump"
  ))

# Welfare Trends Graph by Presidential Term
welfare |> 
  ggplot(aes(x = Month, y = Trend, color = President)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(
    x = "",
    y = "Google Trends"
  ) +
  ggtitle("Welfare Trends")