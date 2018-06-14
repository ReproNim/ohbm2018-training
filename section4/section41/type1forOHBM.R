#title: "Basics, type 1 and power. OHBM 2018""
#author: "Celia Greenwood"
#date: "June 8, 2018"



## Read in the datafile
# this line needs correct location of dataset
datain <- read.csv("../../data/phenotypes.aug.csv", header=TRUE, as.is=TRUE)



## Explore

# Rename some variables for simplicity.  

# Look at a few histograms


par(mfrow = c(2,2), omi=rep(0,4), mar =  c(2,2,0.2,0.2), mgp = c(1,0,0))
hist(datain$MRI_cort_vol.ctx.lh.parahippocampal)
hist(datain$Age_At_IMGExam)
hist(datain$PHX_ANX_TOTAL)

MRI <- datain$MRI_cort_vol.ctx.lh.parahippocampal
AGE <- (datain$Age_At_IMGExam - mean(datain$Age_At_IMGExam,na.rm=TRUE))
MANUFACTURER <- datain$ManufacturersModelName
GENDER <- datain$Gender
HAND <- datain$FDH_23_Handedness_Prtcpnt
MYSTERY <- datain$MYSTERY

data.revised <- data.frame(MRI, MANUFACTURER, AGE, GENDER, MYSTERY, HAND)
N <- nrow(data.revised)


## Create a subsample and analyze it

#* Change N.small to different values.  
#* Compare results with your neighbour.


N.small <- 30

  
data.subsamp <- data.revised[sample(1:N, N.small),]
fit.g <- lm(MRI ~ GENDER, data = data.subsamp)
fit.m <- lm(MRI ~ MYSTERY, data = data.subsamp)

summary(fit.g)
summary(fit.m)


## Analyzing results for a series of subsamples

#(Make sure to complete the previous exercise first)

N.small <- 30
N.subsamps <- 35

qq.volcano.function <- function(N.small, N.subsamps, data.revised=data.revised,
                                nam1, nam2)  
{
  set.seed <- 1234
  results.p.gender <- array(NA, dim = length(N.subsamps)) 
  results.beta.gender <- array(NA, dim = length(N.subsamps)) 
  results.p.mystery <- array(NA, dim = length(N.subsamps)) 
  results.beta.mystery <- array(NA, dim = length(N.subsamps)) 

  for (j in (1:N.subsamps)) {
     data.subsamp <- data.revised[sample(1:N, N.small),]
     fit.g <- lm(MRI ~ GENDER, data = data.subsamp)
     fit.m <- lm(MRI ~ MYSTERY, data = data.subsamp)
     results.p.gender[j] <- summary(fit.g)$coefficients[2,4]
     results.beta.gender[j] <- summary(fit.g)$coefficients[2,1]
     results.p.mystery[j] <- summary(fit.m)$coefficients[2,4]
     results.beta.mystery[j] <- summary(fit.m)$coefficients[2,1]
  }

  #jpeg(paste("Figures/",nam1,".jpg",sep=""))
  exp.log10p <- sort(-log10(((1:N.subsamps) - 0.5)/N.subsamps))
  plot(exp.log10p, sort(-log10(results.p.gender)), pch=16, col='red',
      xlab='Expected log10 p', ylab='Observed log10 p')
  abline(0,1)
  points(exp.log10p, sort(-log10(results.p.mystery)), pch=15, col='blue')
  #dev.off()

 #jpeg(paste("Figures/",nam2,".jpg",sep=""))
 plot(c(min(results.beta.gender,results.beta.mystery),
        max(results.beta.gender,results.beta.mystery)),
       c(0,4), typ='n',xlab='BETA', ylab = '-log10 p' )

 points(results.beta.gender, -log10(results.p.gender), col='red', pch=16 )
 abline(v=0)
 points(results.beta.mystery, -log10(results.p.mystery), col='blue', pch=16)
 #dev.off()
}

qq.volcano.function(30, 35, data.revised, "qq30","volcano30")  
qq.volcano.function(100, 35, data.revised, "qq100","volcano100")
qq.volcano.function(250, 35, data.revised,"qq250","volcano250")

