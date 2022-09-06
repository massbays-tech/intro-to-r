
# Install the MassWateR package - only necessary for updates ------------

# Enable massbays-tech universe
options(repos = c(
  massbaystech = 'https://massbays-tech.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))
install.packages('MassWateR')



# Activate libraries every time -----------------------------------------

library(MassWateR)
library(dplyr)  #Needed for %>% in outlier review



# Load files --------------------------------------------------------------

respth <- "D:/Documents/1 ACASAK/MassWateR/Design/Example input files/BetaResults_9-2-22.xlsx"
dqoaccpth <- "D:/Documents/1 ACASAK/MassWateR/Design/Example input files/BetaDQOAccuracy_9-2-22.xlsx"
dqofrecompth <- "D:/Documents/1 ACASAK/MassWateR/Design/Example input files/BetaDQOFreqComp_9-2-22.xlsx"
sitespth <- "D:/Documents/1 ACASAK/MassWateR/Design/Example input files/BetaSites_9-2-22.xlsx"
resdat <- readMWRresults(respth)
dqoaccdat <- readMWRacc(dqoaccpth)
dqofrecomdat <- readMWRfrecom(dqofrecompth)
sitedat <- readMWRsites(sitespth)



# Review files ------------------------------------------------------------

str(resdat)
head(resdat)
View(resdat)
View(dqoaccdat)
View(paramsMWR)
View(thresholdMWR)



# Review - full report ----------------------------------------------------

qcMWRreview(res=resdat,acc=dqoaccdat,frecom=dqofrecomdat, 
            output_dir="D:/Documents/", 
            output_file = "QCReport", rawdata = FALSE)


# QC Review - individual reports ------------------------------------------

tabMWRfre(res=resdat,frecom=dqofrecomdat,type = "summary")
tabMWRfre(res=resdat,frecom=dqofrecomdat,type = "percent")
tabMWRacc(res=resdat,acc=dqoaccdat,accchk = "Field Duplicates",type = "individual")
tabMWRacc(res=resdat,acc=dqoaccdat,type = "summary",frecom = dqofrecomdat)
tabMWRacc(res=resdat,acc=dqoaccdat,type = "percent",frecom = dqofrecomdat)
tabMWRcom(res=resdat,frecom=dqofrecomdat)



# Analyze Outliers --------------------------------------------------------

anlzMWRoutlier(res=resdat,param="E.coli",acc=dqoaccdat,type="box",
               group="month")# labsize = 2)
               #dtrng = c("2021-06-01","2021-07-31"))
anlzMWRoutlier(res=resdat,param="Ammonia",acc=dqoaccdat,group="month",
               outliers = TRUE)# %>%
            #print(width=Inf)
anlzMWRoutlierall(res=resdat, acc=dqoaccdat, group = "month", format="word", 
                  output_dir = "D:/Documents", output_file = "my_outliers")
                  #fig_height = 3)



# Seasonal Analysis -------------------------------------------------------

anlzMWRseason(res=resdat,param="TP",acc=dqoaccdat,group="month",
              type="box", thresh="fresh")
anlzMWRseason(res=resdat,param="TP",acc=dqoaccdat,group="month",
              type="jitterbar", thresh="fresh")# site="ABT-077",
              #sit=sitedat, locgroup = "Sudbury")
              #resultatt = "Low")
              #dtrng = c("2021-06-01","2021-07-01"))

anlzMWRseason(res=resdat,param="TP",acc=dqoaccdat,group="month",
              type="box", thresh="fresh") +
  labs(x="Month", y="Total Phosphorus (mg/L)", 
       title="Total Phosphorus 2022") +
  geom_hline(yintercept = 0.15, color = "green", show.legend = TRUE)
  #theme_gray()
  #coord_cartesian(ylim = c(0.1,0.2))
  #facet_wrap(~`Monitoring Location ID`)
  #coord_flip()



# Time-series Analysis ----------------------------------------------------

anlzMWRdate(res=resdat, param="pH", acc=dqoaccdat, thresh="fresh",
            sit = sitedat, group="site", locgroup = "Sudbury")
anlzMWRdate(res=resdat, param="pH", acc=dqoaccdat, thresh="fresh",
            site=c("ABT-077","ABT-144","CND-009")) 
            #repel=TRUE, colleg = TRUE, threshcol="red")
            #sit = sitedat, group="locgroup")
            #locgroup = c("Assabet","Sudbury"))# confint=TRUE)



# By-site Analysis --------------------------------------------------------

anlzMWRsite(res=resdat,param="DO",acc=dqoaccdat,type="box",thresh="fresh", 
            sit=sitedat, locgroup = "Sudbury")
anlzMWRsite(res=resdat,param="E.coli",acc=dqoaccdat,type="jitterbar",
            thresh="fresh", site=c("ABT-077","ABT-162","CND-009"), 
            fill="pink")
            #resultatt = "Wet")
            #byresultatt = TRUE)



# Map Analysis ------------------------------------------------------------

anlzMWRmap(res=resdat, param="DO", acc=dqoaccdat, sit=sitedat)

anlzMWRmap(res=resdat, param="DO", acc=dqoaccdat, sit=sitedat, 
           maptype = NULL, addwater = "nhd", dLevel = "high",
           palcol = "Spectral", ptsize = 2, labsize = 2, latlon = FALSE, 
           site = c("HBS-016","HBS-098"))
           #northloc = "tr", scaleloc = "tl")
           #locgroup = c("Assabet"))
           #dtrng = c("2021-05-01","2021-07-31"))
anlzMWRmap(res=resdat, param="DO", acc=dqoaccdat, sit=sitedat, 
           palcol = "YlOrRd", buffdist = 0.2,
           locgroup = c("Assabet"), ptsize = 2.5, labsize = 2.5,
           maptype = "terrain-lines", addwater = "nhd", dLevel = "low")
           #maptype = "terrain-background", addwater = NULL)

