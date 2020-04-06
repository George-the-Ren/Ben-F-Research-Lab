library(tidyverse)
url = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'
covid_data <- read.csv(url)
head(covid_data)
usa <- covid_data %>% 
  filter(Country.Region == 'US')
usa <- usa[, 5:length(usa)]
print(usa)
sk <- covid_data %>% 
  filter(Country.Region == 'Korea, South')
sk <- sk[, 5:length(sk)]
print(sk)
us_values <- as.numeric(usa)
us_values <- log(us_values[48:length(us_values)])
print(us_values)
sk_values <- as.numeric(sk)
sk_values <- log(sk_values[48:length(sk_values)])
print(sk_values)
x <- seq(length(us_values))
print(x)
us_model <- lm(us_values ~ x)
sk_model <- lm(sk_values ~ x)
summary(us_model)
summary(sk_model)
