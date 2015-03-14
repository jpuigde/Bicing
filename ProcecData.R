library(data.table)

bici.df <- fread("data/row_bicing.csv",sep=";",header=TRUE)
bici.df <- unique(bici.df)
bici.df[,":="(timestamp=as.POSIXct(trunc(as.POSIXlt(gsub("T|Z" ," ",as.character(timestamp))),"mins")),
              lng=lng/1000000,
              lat=lat/1000000,
              Percent = ifelse(bikes==0,0, bikes/(bikes + free))
       )]
bici.df <- unique(bici.df)
bici.df$name <- iconv(bici.df$name,to="ASCII//TRANSLIT")

bici.df$freeBin <- cut(bici.df$free,breaks=c(-1,0,3,15,100))
bici.df$bikesBin <- cut(bici.df$bikes,breaks=c(-1,0,3,15,100))

bici.df$timeID <- as.numeric(factor(bici.df$timestamp))

write.table(bici.df,"data/bicing.csv",sep=";",row.names=FALSE)
