##Importing data
succ= read.csv(file.choose(), header = TRUE)
##Collecting observations
dim(succ)
attach(succ)
##Computing summary
summary(succ)
succ[1:5, ]
mean(Age)
##Subsetting data
fem= succ[Sex =="Female", ]
fem[1:5, ]
mean(Age[Sex=="Female"])
mean(Age[Sex=="Male"])
Age[1:10]
##Practicing Logic
fem1= succ[Sex=="Female" & Age<30, ]
fem1[1:5]
fem2=Age<30
fem2[1:10]
fem3= Sex=="Female" & Age<30
fem3[1:10]

##Binding new column
newsucc= cbind(succ, fem3)
newsucc[1:5, ]

##Learning Apply

##Learning tApply
tapply(X=Farmer_Experience, INDEX = Sex, FUN = mean, na.rm=T)
tapply(Farmer_Experience, Sex, mean)
##saving in an object t
t= tapply(Farmer_Experience, Sex, mean)
t

##Making Histogram
hist(Farmer_Experience)
hist(Age)

hist(Farmer_Experience, freq = FALSE)
hist(Age, prob=T)
hist(Age, prob=T, ylim = c(0, 0.035))
hist(Age, prob=T, ylim = c(0, 0.040), breaks=9, main = "Age of Farmers" , las= 1)
line(density(Age))
lines(density(Age))
lines(mean(Age))
lines(density(Age), col=2, lwd=3)
?hist

##Using Scatterplot ##Studying r/p between two variables
summary(Age)
summary(Farmer_Experience)
cor(Age, Farmer_Experience)
plot(Age, Farmer_Experience)
plot(Age, Farmer_Experience, main="Scatter Plot", las=1, xlim=c(0, 70), ylim = c(0, 45))
plot(Age, Farmer_Experience, main="Scatter Plot", las=1, xlim=c(0, 70), ylim = c(0, 45), pch=10, col= "purple")
abline(lm(Farmer_Experience~Age), col=2)

##Funny
q()
