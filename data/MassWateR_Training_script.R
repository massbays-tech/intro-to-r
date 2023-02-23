
# Install the MassWateR package - only necessary for updates ------------

install.packages('MassWateR')



# Activate libraries every time -----------------------------------------

library(MassWateR)



# Load files --------------------------------------------------------------

setwd("C:/Users/bweth/Desktop/MassWateR_Training")
respth <- "Training_Results.xlsx"
accpth <- "Training_DQOAccuracy.xlsx"
frecompth <- "Training_DQOFreqComp.xlsx"
sitpth <- "Training_Sites.xlsx"
wqxpth <- "Training_WQXMeta.xlsx"
readMWRresultsview(respth = respth, output_dir = getwd(), output_file = "resultscheck.csv")
resdat <- readMWRresults(respth)
accdat <- readMWRacc(accpth)
frecomdat <- readMWRfrecom(frecompth)
sitdat <- readMWRsites(sitpth)
wqxdat <- readMWRwqx(wqxpth)
fsetls <- list(res=resdat,acc=accdat,frecom=frecomdat,sit=sitdat,wqx=wqxdat)



# Review files ------------------------------------------------------------

str(resdat)
head(resdat)
View(resdat)
View(accdat)
View(paramsMWR)
View(thresholdMWR)



# Analyze Outliers --------------------------------------------------------

anlzMWRoutlier(fset=fsetls,param="TP",type="box",group="month",)
                #labsize = 2, dtrng = c("2022-06-01","2022-07-31"))
anlzMWRoutlier(fset=fsetls,param="Ammonia",group="month",outliers = TRUE)
AmmoniaOutliers <- anlzMWRoutlier(fset=fsetls,param="Ammonia",
                                  group="month", outliers = TRUE)
View(AmmoniaOutliers)

anlzMWRoutlierall(fset=fsetls, group = "month", type = "box", format="word",
                  output_dir = "Reports", output_file = "my_outliers")
                  #fig_height = 3)



# QC Review - full report ----------------------------------------------------

tabMWRfre(fset=fsetls, type = "summary")
tabMWRfre(fset=fsetls, type = "percent")#, pass_col = "blue",fail_col = "orange")
tabMWRacc(fset=fsetls, type = "summary")
tabMWRacc(fset=fsetls, type = "percent")
tabMWRacc(fset=fsetls, type = "individual", accchk = "Field Duplicates")
tabMWRcom(fset=fsetls)


qcMWRreview(fset = fsetls, output_dir=getwd(), output_file = "QCReport", 
            rawdata = TRUE)



# WQX Output --------------------------------------------------------------
tabMWRwqx(fset = fsetls, output_dir=getwd(), output_file = "MyWQXOutput.xlsx")



# Seasonal Analysis -------------------------------------------------------

anlzMWRseason(fset = fsetls,param="TP",group="month",
              type="box", thresh="fresh")
anlzMWRseason(fset = fsetls,param="TP",group="month",
              type="jitterbar", thresh="fresh")
              #confint = TRUE)
              #site="ABT-077")
              #locgroup = "Tributaries")
              #resultatt = "WET")
              #dtrng = c("2022-05-01","2022-06-30"))

library(ggplot2)  #needed for additional ggplot functionality
anlzMWRseason(fset = fsetls,param="DO",group="month",
              type="box", thresh="fresh") +
  labs(x="Month", y="Dissolved Oxygen (mg/L)", 
       title="Dissolved Oxygen 2022")
  #geom_hline(yintercept = 3.0, color = "green")
  #theme_gray()
  #coord_cartesian(ylim = c(5,9))
  #coord_flip()



# Time-series Analysis ----------------------------------------------------

anlzMWRdate(fset = fsetls, param="pH", thresh="fresh",
            locgroup = "Assabet", group="site")
anlzMWRdate(fset = fsetls, param="pH", thresh="fresh",
            site=c("ABT-077","ABT-144","ABT-312")) 
            #repel=TRUE, colleg = TRUE, threshcol="red", ptsize = 3)
            #group="locgroup", confint=TRUE)



# By-site Analysis --------------------------------------------------------

anlzMWRsite(fset = fsetls,param="DO",type="box",thresh="fresh", 
            locgroup = "Assabet")
anlzMWRsite(fset = fsetls,param="E.coli",type="jitterbar",
            thresh="fresh", site=c("ABT-077","ABT-162"), 
            fill="pink")
            #byresultatt = TRUE)
            #resultatt = "WET")



# Map Analysis ------------------------------------------------------------

anlzMWRmap(fset = fsetls, param="DO")

anlzMWRmap(fset = fsetls, param="DO", addwater = "high")
           #palcol = "Spectral", ptsize = 2, labsize = 2, latlon = FALSE) 
           #site = c("ABT-026","ABT-077"))
           #maptype = "terrain-lines")
           #northloc = "tr", scaleloc = "tl")
           #locgroup = "Tributaries")
           #dtrng = c("2022-05-01","2022-07-31"))
anlzMWRmap(fset = fsetls, param="pH", 
           palcol = "YlOrRd", buffdist = 5,
           maptype = "terrain-background", addwater = NULL)

ggsave("BetaMap.png", plot = last_plot(), device = "png", 
       width = 6.5, height = 7, units = "in")
