# Moneyball Project
library(ggplot2)
library(ggthemes)
library(dplyr)
library(plotly)
library(scales)
# Load the Batting Data
batting <- read.csv("C:\\Github\\moneyball_project\\batting.csv")
head(batting)

# Check the struture of the data
str(batting)

# check AB(At Bats)
head(batting$AB)
# check X2B(Double)
head(batting$X2B)

##### Feature Engineering
# Batting Average
batting$BA <- batting$H / batting$AB
tail(batting$BA)
# On Base Percentage(H+BB+HBP/AB+BB+HBP+SF)
batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB+batting$BB+batting$HBP+batting$SF)
# Slugging Percentage((1B)+(2*2B)+(3*3B) + 4HR)/AB)
# Create a X1B column to calculate Slugging Percentage
batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR
# Slugging Percentage
batting$SLG <- (batting$X1B+batting$X2B*2+batting$X3B*3+batting$HR*4)/batting$AB

# Check the structure again
str(batting)

####### Merging Salary Data with Batting Data
# Load Salary Data
salary <- read.csv("C:\\Github\\moneyball_project\\Salaries.csv")
summary(salary)

# Mismatch in years between Salary and Batting Data
# Remove data before 1985 from batting data.
batting <- subset(batting, yearID >= 1985)
summary(batting)


# Merge the batting data with salary data
combo <- merge(batting, salary, by = c("yearID", "playerID"))
summary(combo)


######### Analyzing the Lost Players
# Notice how to use %in% to filter the rows
lost_players <- subset(combo,playerID %in% c('giambja01','damonjo01','saenzol01'))
lost_players <- lost_players %>% subset(yearID == 2001, select = c(playerID,H,X2B,X3B,HR,OBP,SLG,BA,AB)) %>% arrange(playerID)

# lost players in 2001 in the offseason. Need data from 2001

print(lost_players)


######### Replacement Players
# All the players' data in 2001
replacement <- combo %>% subset(yearID == 2001, select = c(playerID, salary, AB, OBP))
print(replacement)


# Find 3 players to replace lost_players
# 1. total combined salary less than 15m dollars
# 2. Combined AB >= AB of lost_players
# 3. Mean OBP >= mean OBP of lost_players

mean_OBP <- mean(lost_players$OBP) # 0.3638
total_AB <- sum(lost_players$AB) # 1469 / 3 = 489
limit_salary <- 15000000 


# Heuristic Approach
# Filter out players with high salary, unreasonable scores, around 489 AB

replacement <- replacement %>% subset(salary < 8000000 & OBP > 0 & OBP < 0.5 & AB < 500 & AB > 450) %>% arrange(desc(OBP))
str(replacement)

ggplot(replacement, aes(x=OBP, y=salary)) + geom_point(size=2)
head(arrange(replacement, desc(OBP)), 10)
# Let's say we are selecting the first 3 players in the list
#playerID  salary  AB       OBP
#1  martied01 5500000 470 0.4234079
#2  catalfr01  850000 463 0.3913894
#3  gracema01 3000000 476 0.3858696

# Plot the scatter plot with marked points for selected players
selected <- ggplot(replacement, aes(x=OBP, y=salary, color=AB)) + geom_point(size=2, aes(fill=AB)) + 
  geom_point(data = replacement[1:3,], aes(x=OBP, y=salary), size = 3, color = 'red') +
  ggtitle(label = "Money Ball Project: Three Candidates") +
  scale_y_continuous(name = "Salary (in Millions)", limit = c(0, 8000000), breaks = seq(0, 8000000, 2000000), labels = function(x){paste(x/1000000,'M')})+
  scale_x_continuous(name= "On Base Percentage(OBP)", limit = c(0.2, 0.5), breaks = seq(0.2, 0.5, 0.05))

## Using ggplotly to be interactive
ggplotly(selected)
