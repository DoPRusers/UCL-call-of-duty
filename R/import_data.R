import_data <- function(keyword){
  

  db <- "pubmed"
  query <- keyword
  baseUrl <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"
  URL <- paste(baseUrl, "esearch.fcgi?db=", db, "&term=", query,"&usehistory=y", sep="", collapse=NULL)
  search <- GET(URL)
  warn_for_status(search)
  searchContent <- content(search, "text")
  webEnv <- gsub(".*<WebEnv>|</WebEnv>.*", "", searchContent)
  key <- gsub(".*<QueryKey>|</QueryKey>.*", "", searchContent)
  URLSum <- paste(baseUrl, "esummary.fcgi?db=", db, "&query_key=", key, "&WebEnv=", webEnv, sep="", collapse=NULL)
  finalData <- GET(URLSum)
  finalDataContent <- content(finalData, "text")
  xmlfile <- xmlParse(finalDataContent)
  dates <- xmlToDataFrame( getNodeSet(xmlfile, '//eSummaryResult/DocSum/Item[1]'))
#   yearOnly <- sapply(dates, substring, 1,4)
#   occurences <- table(unlist(yearOnly))
#   toPlotOccur <- as.data.frame(occurences)
#   plot(toPlotOccur$Var1, toPlotOccur$Freq)
  write.table(dates, "data/raw_import.txt", sep = "\t", row.names = F)
  return(dates)
cat(paste("read in from: ", URL))
}
