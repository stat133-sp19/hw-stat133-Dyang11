#Title: Make Shots Charts Script
#Description: Creating shot chart visualizations for each player's shot attempts
#Inputs: Data frames of the players' shots
#Outputs: A picture overview of each player's shots over a NBA basketball court

#Loading necessary packages
library(jpeg)
library(grid)
library(ggplot2)
library(readr)
library(dplyr)

#court image (to be used as background of plot)
court_file <- "../images/nba-court.jpg"

#create raste object
court_image <- rasterGrob(readJPEG(court_file), height = unit(1, "npc"), width = unit(1,"npc"))

#importing data frames & deleting beyond half-court shots
shot_data <- read_csv("../data/shots-data.csv")
shot_data <- filter(shot_data, y < 420 )
klay <- shot_data[shot_data$name == "Klay Thompson",]
kevin <- shot_data[shot_data$name == "Kevin Durant",]
steph <- shot_data[shot_data$name == "Stephen Curry",]
andre <- shot_data[shot_data$name == "Andre Iguodala",]
draymond <- shot_data[shot_data$name == "Draymond Green",]


#creating shot charts
klay_shot_chart <- ggplot(data = klay) +annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag),size=1) + ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + theme_minimal() + 
  xlab("Horizontal distance from Basket (inches)") + ylab("Vertical distance from Basket (inches)")
steph_shot_chart <- ggplot(data = steph) +annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag),size=1) + ylim(-50, 420) + 
  ggtitle('Shot Chart: Stephen Curry (2016 season)') + theme_minimal() +
  xlab("Horizontal distance from Basket (inches)") + ylab("Vertical distance from Basket (inches)")
kevin_shot_chart <- ggplot(data = kevin) +annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag),size=1) + ylim(-50, 420) + 
  ggtitle('Shot Chart: Kevin Durant (2016 season)') + theme_minimal() +
  xlab("Horizontal distance from Basket (inches)") + ylab("Vertical distance from Basket (inches)")
draymond_shot_chart <- ggplot(data = draymond) +annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) + 
  ggtitle('Shot Chart: Draymond Green (2016 season)') + theme_minimal() +
  xlab("Horizontal distance from Basket (inches)") + ylab("Vertical distance from Basket (inches)")
andre_shot_chart <- ggplot(data = andre) +annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) + 
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') + theme_minimal() +
  xlab("Horizontal distance from Basket (inches)") + ylab("Vertical distance from Basket (inches)")

#exporting shot charts
pdf(file='../images/andre-iguodala-shot-chart.pdf', width = 6.5, height = 5)
andre_shot_chart
dev.off()
pdf(file='../images/klay-thompson-shot-chart.pdf', width = 6.5, height = 5)
klay_shot_chart
dev.off()
pdf(file='../images/stephen-curry-shot-chart.pdf', width = 6.5, height = 5)
steph_shot_chart
dev.off()
pdf(file='../images/kevin-durant-shot-chart.pdf', width = 6.5, height = 5)
kevin_shot_chart
dev.off()
pdf(file='../images/draymond-green-shot-chart.pdf', width = 6.5, height = 5)
draymond_shot_chart
dev.off()

#creating GSW shot chart
gsw_shot_chart <- ggplot(data = shot_data) +annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag),size= 0.8) + ylim(-50, 420) + theme_minimal() +  facet_wrap(~name) +
  labs(title = 'Shot Chart: GSW\'s Hampton Five (2016 season)', x = "Horizontal distance from Basket (inches)", y = "Vertical distance from Basket (inches)", color = "Shot Made?") +
  theme(legend.position = c(0.8,0.2),legend.background = element_rect(fill='lightgrey',size=0.5, linetype="solid"))

#saving GSW shot chart
pdf(file='../images/gsw-shot-charts.pdf', width = 8, height = 7)
gsw_shot_chart
dev.off()
png(filename='../images/gsw-shot-charts.png',width = 8, height = 7,units='in',res=500)
gsw_shot_chart
dev.off()
