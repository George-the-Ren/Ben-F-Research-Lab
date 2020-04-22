library(dplyr)
library(ggplot2)

# cases.raw <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'
deaths.raw <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv'

cases <- read.csv(cases.raw)
head(cases)

deaths <- read.csv(deaths.raw)
head(deaths)

cases <- cases %>% 
  select(-Province.State, -Lat, -Long)
print(cases)

deaths <- deaths %>% 
  select(-Province.State, -Lat, -Long)
print(deaths)

subset <- deaths %>% 
  filter(Country.Region == 'US' |
         Country.Region == 'Korea, South' |
         Country.Region == 'Spain' |
         Country.Region == 'Italy')
print(subset)

subset <- subset %>% 
  select(-Country.Region)
print(subset)

subset <- t(subset)
colnames(subset) <- c('italy', 'south.korea', 'spain', 'usa')
subset <- as.data.frame(subset)
print(subset)
colnames(subset)

# USA
usa <- subset['usa']
usa <- usa %>% 
  filter(usa > 0)
print(usa)
usa <- log(as.numeric(unlist(usa)))
print(usa)

x <- seq(length(usa))
y <- usa

model1 <- lm(y ~ poly(x, 2, raw=TRUE)) # second degree polynomial
model2 <- lm(y ~ poly(x, 3, raw=TRUE)) # third degree polynomial
model3 <- lm(y ~ poly(x, 4, raw=TRUE)) # fourth degree polynomial
  
ggplot(NULL, aes(x = x)) +
  geom_point(aes(y = y)) +
  geom_line(y = predict(model1, data.frame(x=x)), 
            color = 'red') +
  geom_line(y = predict(model2, data.frame(x=x)), 
            color = 'blue') +
  geom_line(y = predict(model3, data.frame(x=x)), 
            color = 'green') +
  labs(x = 'Days Since First Case', 
       y = 'Number of Cases (log)', 
       title = 'US COVID-19 Deaths') + 
  theme(plot.title = element_text(hjust = 0.5))

# ITALY
italy <- subset['italy']
italy <- italy %>% 
  filter(italy > 0)
print(italy)
italy <- log(as.numeric(unlist(italy)))
print(italy)

x <- seq(length(italy))
y <- italy

model1 <- lm(y ~ poly(x, 2, raw=TRUE)) # second degree polynomial
model2 <- lm(y ~ poly(x, 3, raw=TRUE)) # third degree polynomial
model3 <- lm(y ~ poly(x, 4, raw=TRUE)) # fourth degree polynomial

ggplot(NULL, aes(x = x)) +
  geom_point(aes(y = y)) +
  geom_line(y = predict(model1, data.frame(x=x)), 
            color = 'red') +
  geom_line(y = predict(model2, data.frame(x=x)), 
            color = 'blue') +
  geom_line(y = predict(model3, data.frame(x=x)), 
            color = 'green') +
  labs(x = 'Days Since First Case', 
       y = 'Number of Cases (log)', 
       title = 'Italy COVID-19 Deaths') + 
  theme(plot.title = element_text(hjust = 0.5))

# SOUTH KOREA
sk <- subset['south.korea']
sk <- sk %>% 
  filter(sk > 0)
print(sk)
sk <- log(as.numeric(unlist(sk)))
print(sk)

x <- seq(length(sk))
y <- sk

model1 <- lm(y ~ poly(x, 2, raw=TRUE)) # second degree polynomial
model2 <- lm(y ~ poly(x, 3, raw=TRUE)) # third degree polynomial
model3 <- lm(y ~ poly(x, 4, raw=TRUE)) # fourth degree polynomial

ggplot(NULL, aes(x = x)) +
  geom_point(aes(y = y)) +
  geom_line(y = predict(model1, data.frame(x=x)), 
            color = 'red') +
  geom_line(y = predict(model2, data.frame(x=x)), 
            color = 'blue') +
  geom_line(y = predict(model3, data.frame(x=x)), 
            color = 'green') +
  labs(x = 'Days Since First Case', 
       y = 'Number of Cases (log)', 
       title = 'South Korea COVID-19 Deaths') + 
  theme(plot.title = element_text(hjust = 0.5))

# SPAIN
spain <- subset['spain']
spain <- spain %>% 
  filter(spain > 0)
print(spain)
spain <- log(as.numeric(unlist(spain)))
print(spain)

x <- seq(length(spain))
y <- spain

model1 <- lm(y ~ poly(x, 2, raw=TRUE)) # second degree polynomial
model2 <- lm(y ~ poly(x, 3, raw=TRUE)) # third degree polynomial
model3 <- lm(y ~ poly(x, 4, raw=TRUE)) # fourth degree polynomial

ggplot(NULL, aes(x = x), color = colors) +
  geom_point(aes(y = y)) +
  geom_line(y = predict(model1, data.frame(x=x)), 
            color = 'red') +
  geom_line(y = predict(model2, data.frame(x=x)), 
            color = 'blue') +
  geom_line(y = predict(model3, data.frame(x=x)), 
            color = 'green') +
  labs(x = 'Days Since First Case', 
       y = 'Number of Cases (log)', 
       title = 'Spain COVID-19 Deaths') + 
  theme(plot.title = element_text(hjust = 0.5), 
        legend.position=c(0.9, 0.9), 
        legend.justification = c('right', 'bottom'))
