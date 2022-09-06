options(repos = "http://cran.rstudio.com/")

# print
print("hello world!")
# sequence
seq(1, 10)
# random numbers
rnorm(100, mean = 10, sd = 2)
# average 
mean(rnorm(100))
# sum
sum(rnorm(100))

my_random_sum <- sum(rnorm(100))

my_random_sum

install.packages("readxl")

library(readxl)

install.packages("dplyr")

# Enable universe(s) by massbays-tech
options(repos = c(
  massbaystech = "https://massbays-tech.r-universe.dev",
  CRAN = "https://cloud.r-project.org"))

# Install the package
install.packages("MassWateR")

dbl_var <- c(1, 2.5, 4.5)
int_var <- c(1L, 6L, 10L)
log_var <- c(TRUE, FALSE, T, F)
chr_var <- c("a", "b", "c")

class(dbl_var)
length(log_var)

ltrs <- c("a", "b", "c")
nums <- c(1, 2, 3)
logs <- c(T, F, T)
mydf <- data.frame(ltrs, nums, logs)
mydf

sitdat <- read_excel("data/ExampleSites.xlsx")

# get the dimensions
dim(sitdat)
# get the column names
names(sitdat)
# see the first six rows
head(sitdat)
# get the overall structure
str(sitdat)

View(sitdat)
