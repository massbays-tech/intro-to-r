print("Hello World!")

# Variables
var1 <- 34
var2 <- "some text"
var1
var2

# Vectors
vect1 <- c(5,4,7.4,8.3)
length(vect1)
mean(vect1)
sum(vect1)
mySum <- sum(vect1)
mySum

# Data frames
diameters <- vect1
fruits <- c("apple","orange","grapefruit","pineapple")
fruitDiams <- data.frame(fruits,diameters)
fruitDiams
View(fruitDiams)
sum(fruitDiams$diameters)
fruitDiams[3,2]

# Packages
install.packages("dplyr")
library(dplyr)
largeFruits <- filter(fruitDiams, fruitDiams$diameters > 6)
largeFruits

install.packages("readxl")
library(readxl)
sitedata <- read_excel("C:/Users/bweth/Desktop/MassWateR_Training/Training_sites.xlsx")
View(sitedata)
colnames(sitedata)

install.packages("MassWateR")
library(MassWateR)

# Graphing
plot(fruitDiams$diameters)
barplot(fruitDiams$diameters~fruitDiams$fruits)
barplot(fruitDiams$diameters~fruitDiams$fruits,
        xlab = "", ylab = "Diameter", main = "Fruit sizes", col = "yellow")

# GGPLOT
install.packages("ggplot2")
library(ggplot2)
ggplot(data = fruitDiams, mapping = aes(x=fruits,y=diameters)) +
  geom_col(color = "green", fill = "orange") +
  labs(title = "Fruit Sizes in GGPLOT", y = "Diameter (cm)") +
  geom_point(color = "gray", size = 40) + 
  geom_hline(yintercept = 2) +
  coord_cartesian(ylim = c(0,10)) +
  #coord_flip() +
  #theme_light()
  theme(axis.text.x = element_text(size = 16),
        axis.title.x = element_blank())
