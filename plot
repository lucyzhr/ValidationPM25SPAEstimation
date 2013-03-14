##################################################################################
##################################################################################
##################################################################################
###########################Relative Error Calculating#############################
###Attention:Date stands for the observation from today noon to tomorrow noon#####
###Eg:Date 2012-12-01's weighted average value was the average mean of the #######
###observationsfrom 2012-12-01 13:00 to 2012-12-02 12:00##########################
setwd("F:/Khaki/SPAValidation/Calc.SPA")
true <- read.csv("F:/Khaki/SPAValidation/RAW/WtAvg.csv")
stations <- c("atzx", "bbxq","cpq","ds","dxq","fthy","gc", "gy","lx","mtgq","nzg","tt","tzq","wl","wsxg","yg","yz","zwy")
length.all <- c(20,25,30,35,40,45,92)
keep <- c(1,2)
allError <- as.data.frame(matrix(rep(0,length(stations)*length(length.all)),ncol=length(length.all),nrow=length(stations)))
names(allError) <- length.all;row.names(allError) <- stations
for (station in stations) {
  I <- which(row.names(allError)==station)
  for (length in length.all) {
    J <- which(names(allError)==length)
    estimationPath <- paste(station,"_","w0blnk","_",length,"d_result.csv",sep="")
    estimation <- read.csv(estimationPath)
    mergeFile <- merge(true, estimation[,keep],by.x="Date",by.y="Date")
    rltvError <- abs(mergeFile[,3]-mergeFile[,2])/mergeFile[,2]
    avgRltvError <- mean(rltvError) 
    allError[I,J] <- avgRltvError 
  }
}
