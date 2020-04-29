library(dplyr)
library(ggplot2)

cat('\014') 
graphics.off()

#deaths.raw <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv'
deaths <- read.csv('time_series_covid19_deaths_global.csv')
head(deaths)

# DATA SUBSETTING AND PREPROCESSING
deaths <- deaths %>% 
  select(-Province.State, -Lat, -Long)
deaths

subset <- deaths %>% 
  filter(Country.Region == 'US')
subset <- subset %>% 
  select(-Country.Region)
subset

subset <- t(subset)
subset <- as.data.frame(subset)
colnames(subset) <- c('usa_deaths')
subset

subset <- subset %>% 
  filter(usa_deaths > 0)

subset$day <- seq(length(subset$usa_deaths))
subset
x <- subset$day

# NORMAL DATA PLOT
ggplot(NULL, aes(x = x)) +
  geom_point(aes(y = subset$usa_deaths), size = 2, color = 'darkgreen') +
  labs(x = 'Days', 
       y = 'Number of Deaths', 
       title = 'USA COVID-19 Deaths') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(0, max(subset$day)+5, by = 5))

subset$usa_deaths <- log(subset$usa_deaths)
subset

# LOG PLOT
ggplot(NULL, aes(x = x)) +
  geom_point(aes(y = subset$usa_deaths), size = 2) +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'USA COVID-19 Deaths') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(0, max(subset$day)+5, by = 5)) + 
  scale_y_continuous(breaks = seq(0, max(subset$usa_deaths)+1, by = 1))

# BREAK DATA INTO 2 SUBSETS
subset1 <- subset %>% 
  filter(day >= 15 & day <= 30)
subset1

subset2 <- subset %>% 
  filter(day >= 45 & day <= 59)
subset2

ggplot(NULL, aes(x = subset1$day)) +
  geom_point(aes(y = subset1$usa_deaths), size = 2, color = 'blue') +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'USA COVID-19 Deaths From Days 15 to 30') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(0, max(subset1$day), by = 1))

ggplot(NULL, aes(x = subset2$day)) +
  geom_point(aes(y = subset2$usa_deaths), size = 2, color = 'red') +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'USA COVID-19 Deaths From Days 45 to 59') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(0, max(subset2$day), by = 1))

# ADD GROUPING VARIABLE, CONCAT, AND VISUALIZE SUBSETS
subset1$group <- replicate(length(subset1$day), 0)
subset1

subset2$group <- replicate(length(subset2$day), 1)
subset2

subset1 
subset2

glm_df <- rbind(subset1, subset2)
glm_df

ggplot(NULL, aes(x = glm_df$day)) +
  geom_point(aes(y = glm_df$usa_deaths), size = 2, color = 'darkblue') +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'USA COVID-19 Deaths (linear)') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(min(glm_df$day), max(glm_df$day), by = 2)) + 
  scale_y_continuous(breaks = seq(min(glm_df$usa_deaths), max(glm_df$usa_deaths)+1, by = 1))

# CREATE GLM
model <- lm(glm_df$usa_deaths ~ glm_df$day + as.factor(glm_df$group))
summary(model)

# MODELS FOR EACH SUBSET
model1 <- lm(subset1$usa_deaths ~ subset1$day)
model2 <- lm(subset2$usa_deaths ~ subset2$day)

summary(model1)
summary(model2)

# MODEL 1 (SUBSET 1)
ggplot(NULL, aes(x = subset1$day)) +
  geom_point(aes(y = subset1$usa_deaths), size = 2, color = 'darkblue') +
  geom_line(aes(y = predict(model1, data.frame(x = subset1$day)))) +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'Regression Results for Days 15 to 30') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(min(subset1$day), max(subset1$day), by = 1))

# MODEL 2 (SUBSET 2)
ggplot(NULL, aes(x = subset2$day)) +
  geom_point(aes(y = subset2$usa_deaths), size = 2, color = 'red') +
  geom_line(aes(y = predict(model2, data.frame(x = subset2$day)))) +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'Regression Results for Days 45 to 59') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(min(subset2$day), max(subset2$day), by = 1))
