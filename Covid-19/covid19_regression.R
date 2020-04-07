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

sk_2842 <- covid_data %>% 
  filter(Country.Region == 'Korea, South') %>% 
  select(28:42)
print(sk_2842)

us_values <- log(as.numeric(usa)) # us: day 48 onward
print(us_values)

sk_values <- log(as.numeric(sk)) # south korea: day 48 onward
print(sk_values)

sk_2842_values <- log(as.numeric(sk_2842)) # south korea: days 28 to 42
print(sk_2842)

x_us <- seq(length(us_values))
us_model <- lm(us_values ~ x_us)

x_sk <- seq(length(sk_values))
x_2842 <- seq(length(sk_2842))
sk_model <- lm(sk_values ~ x_sk)
sk_2842_model <- lm(sk_2842_values ~ x_2842)

summary(us_model)
summary(sk_model)
summary(sk_2842_model)

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
