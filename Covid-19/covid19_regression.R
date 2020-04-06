library(tidyverse)
url = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'
covid_data <- read.csv(url)
head(covid_data)
usa <- covid_data %>% 
  filter(Country.Region == 'US')
print(usa)
sk <- covid_data %>% 
  filter(Country.Region == 'Korea, South')
print(sk)
us_values = c(6.86589107,  7.1553963 ,  7.41637848,  7.68662133,  7.91095738,
              8.16023249,  8.44074402,  8.76732915,  8.95969715,  9.52347087,
              9.85744361, 10.14600227, 10.4125917 , 10.68846158, 10.89191288,
              11.09404071, 11.33661779, 11.52935968, 11.70748846, 11.85570633,
              11.99415955, 12.14511172, 12.2707924 , 12.40267918, 12.52665502,
              12.640611  , 12.72805184)
sk_values = c(8.92439013, 8.95609308, 8.97068627, 8.98456837, 8.99788945,
              9.00724452, 9.01627007, 9.02641753, 9.03753341, 9.05543941,
              9.06554579, 9.08239336, 9.10063711, 9.10063711, 9.10908254,
              9.12008738, 9.13140538, 9.14120463, 9.1567286 , 9.16774597,
              9.17585244, 9.18870807, 9.19897604, 9.20793749, 9.21652123,
              9.22581994, 9.23376389)
x <- seq(length(us_values))
print(x)
us_model <- lm(log1p(us_values) ~ x)
sk_model <- lm(log1p(sk_values) ~ x)
summary(us_model)
summary(sk_model)
