library(dplyr)
library(ggplot2)
url = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'
covid_data <- read.csv(url)
head(covid_data)

usa <- covid_data %>% 
  filter(Country.Region == 'US') %>%
  select(48:length(covid_data))
print(usa)

sk <- covid_data %>% 
  filter(Country.Region == 'Korea, South') %>% 
  select(48:length(covid_data))
print(sk)

us_values <- log(as.numeric(usa))
print(us_values)
sk_values <- log(as.numeric(sk))
print(sk_values)

x <- seq(length(us_values))
print(x)

us_model <- lm(us_values ~ x)
sk_model <- lm(sk_values ~ x)
summary(us_model)
summary(sk_model)

ggplot(NULL, aes(x = x, y = us_values)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  labs(x = 'days', y = 'number of cases', title = 'US') + 
  theme(plot.title = element_text(hjust = 0.5))

ggplot(NULL, aes(x = x, y = sk_values)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  labs(x = 'days', y = 'number of cases', title = 'South Korea') + 
  theme(plot.title = element_text(hjust = 0.5))
