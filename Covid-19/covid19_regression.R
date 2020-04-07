library(dplyr)
library(ggplot2)

url <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'
covid_data <- read.csv(url)
head(covid_data)

covid_data <- covid_data %>% 
  select(-Province.State, -Lat, -Long)
print(covid_data)
dim(covid_data)

usa <- covid_data %>% 
  filter(Country.Region == 'US')
usa <- usa %>%
  select(-Country.Region)
usa <- usa %>% 
  select(48:length(usa)) # us: day 48 onward
print(usa)

sk <- covid_data %>% 
  filter(Country.Region == 'Korea, South')
sk <- sk %>%
  select(-Country.Region)
sk <- sk %>% 
  select(48:length(sk)) # south korea: day 48 onward
print(sk)

sk_2842 <- covid_data %>% 
  filter(Country.Region == 'Korea, South')
sk_2842 <- sk_2842 %>%
  select(-Country.Region)
sk_2842 <- sk_2842 %>% 
  select(28:42) # south korea: days 28 to 42
print(sk_2842)

us_values <- log(as.numeric(usa)) 
print(us_values)

sk_values <- log(as.numeric(sk)) 
print(sk_values)

sk_2842_values <- log(as.numeric(sk_2842)) 
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

ggplot(NULL, aes(x = seq(length(us_values)), y = us_values)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  labs(x = 'days', y = 'number of cases', title = 'US Day 48 Onward') + 
  theme(plot.title = element_text(hjust = 0.5))

ggplot(NULL, aes(x = seq(length(sk_values)), y = sk_values)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  labs(x = 'days', y = 'number of cases', title = 'South Korea Day 48 Onward') + 
  theme(plot.title = element_text(hjust = 0.5))
