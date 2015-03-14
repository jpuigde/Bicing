
system.time({
require(RJSONIO)
require(RCurl)

raw_data <- fromJSON(getURL("http://api.citybik.es/bicing.json"))
new_data <- do.call("rbind",raw_data)

if (file.exists("data/row_bicing.csv")) {
  write.table(new_data,"data/row_bicing.csv",sep=";",row.names=FALSE,append = TRUE,col.names=FALSE)
}else {
  write.table(new_data,"data/row_bicing.csv",sep=";",row.names=FALSE)
}
})