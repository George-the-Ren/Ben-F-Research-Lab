library(dplyr)
library(ggplot2)

cat('\014') 
graphics.off()

# LOAD IN DATA
deaths.raw <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv'
deaths <- read.csv(deaths.raw)
head(deaths)

# DATA SUBSETTING AND PREPROCESSING
deaths <- deaths %>% 
  select(-Province.State, -Lat, -Long)

subset <- deaths %>% 
  filter(Country.Region == 'US')
subset <- subset %>% 
  select(-Country.Region)
subset

subset <- t(subset)
subset <- as.data.frame(subset)
colnames(subset) <- c('usa_deaths')
subset$usa_deaths <- log(subset$usa_deaths)

subset <- subset %>% 
  filter(usa_deaths >= 0)

subset$days <- seq(length(subset$usa_deaths)) # add days column
subset$date <- seq(as.Date('2020/02/29'), by = 'days', length.out = length(subset$days)) # add date column

subset <- subset %>% 
  filter(days <= 57)
subset

# LOG PLOT
ggplot(NULL, aes(x = x)) +
  geom_point(aes(y = subset$usa_deaths), size = 2) +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'USA COVID-19 Deaths') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(0, max(subset$days)+5, by = 5)) + 
  scale_y_continuous(breaks = seq(0, max(subset$usa_deaths), by = 1))

# BREAK DATA INTO SUBSETS, ADD GROUPING VARIABLE, CONCAT, AND VISUALIZE SUBSETS
subset1 <- subset %>% 
  filter(days >= 15 & days <= 30)

subset2 <- subset %>% 
  filter(days >= 40 & days <= 57)

subset1$group <- replicate(length(subset1$days), 0)

subset2$group <- replicate(length(subset2$days), 1)

glm_df <- rbind(subset1, subset2)
glm_df

ggplot(NULL, aes(x = glm_df$days)) +
  geom_point(aes(y = glm_df$usa_deaths), size = 2, color = 'red') +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'USA COVID-19 Deaths (Linear Subsets)') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(min(glm_df$days), max(glm_df$days), by = 2)) + 
  scale_y_continuous(breaks = seq(min(glm_df$usa_deaths), max(glm_df$usa_deaths)+1, by = 1))

# CREATE GLM
days <- glm_df$days
deaths <- glm_df$usa_deaths
group <- glm_df$group

model <- lm(deaths ~ days + as.factor(group) + as.factor(group)*days)
summary(model)

# MODELS FOR EACH SUBSET
model1 <- lm(subset1$usa_deaths ~ subset1$days)
model2 <- lm(subset2$usa_deaths ~ subset2$days)

#summary(model1)
#summary(model2)

# MODEL 1 (SUBSET 1)
# ggplot(NULL, aes(x = subset1$days)) +
#   geom_point(aes(y = subset1$usa_deaths), size = 2, color = 'darkblue') +
#   geom_line(aes(y = predict(model1, data.frame(x = subset1$days)))) +
#   labs(x = 'Days', 
#        y = 'Number of Deaths (log)', 
#        title = 'Regression Results for Days 15 to 30') + 
#   theme(plot.title = element_text(hjust = 0.5)) + 
#   scale_x_continuous(breaks = seq(min(subset1$days), max(subset1$days), by = 1))

# MODEL 2 (SUBSET 2)
# ggplot(NULL, aes(x = subset2$days)) +
#   geom_point(aes(y = subset2$usa_deaths), size = 2, color = 'red') +
#   geom_line(aes(y = predict(model2, data.frame(x = subset2$days)))) +
#   labs(x = 'Days', 
#        y = 'Number of Deaths (log)', 
#        title = 'Regression Results for Days 40 to 57') + 
#   theme(plot.title = element_text(hjust = 0.5)) + 
#   scale_x_continuous(breaks = seq(min(subset2$days), max(subset2$days), by = 1))

# SELECT DATA FROM DAY 57 ONWARDS

deaths <- read.csv(deaths.raw)

deaths <- deaths %>% 
  select(-Province.State, -Lat, -Long)

new_data <- deaths %>% 
  filter(Country.Region == 'US')
new_data <- new_data %>% 
  select(-Country.Region)

new_data <- t(new_data)
new_data <- as.data.frame(new_data)
colnames(new_data) <- c('usa_deaths')
new_data$usa_deaths <- log(new_data$usa_deaths)
new_data <- new_data %>% 
  filter(usa_deaths >= 0)

new_data$days <- seq(length(new_data$usa_deaths)) # add days column
new_data$date <- seq(as.Date('2020/02/29'), by = 'days', length.out = length(new_data$days)) # add date column
new_data$group <- replicate(length(new_data$days), 1)

new_data <- new_data %>% 
  filter(days > 57)

new_df <- rbind(glm_df, new_data)
new_df

# NEW DATA PLOT
ggplot(NULL, aes(x = new_df$days)) +
  geom_point(aes(y = new_df$usa_deaths), size = 2, color = 'blue') +
  labs(x = 'Days', 
       y = 'Number of Deaths (log)', 
       title = 'USA COVID-19 Deaths (Linear Subsets) With Days 57 Onward') + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(min(new_df$days), max(new_df$days), by = 2)) + 
  scale_y_continuous(breaks = seq(min(new_df$usa_deaths), max(new_df$usa_deaths)+1, by = 1))

# CREATE GLM WITH NEW DATA
days <- new_df$days
deaths <- new_df$usa_deaths
group <- new_df$group

model <- lm(deaths ~ days + as.factor(group) + as.factor(group)*days)
summary(model)
