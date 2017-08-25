# Input release location
release.loc <- c(634686,3926036,0)
# Input receptors' locations (transposed)
receptor.n <- 9
receptor.loc <- matrix(c(634617,3926150,0,
                         634602,3926283,0,
                         634695,3926282,0,
                         634622,3926383,0,
                         634623,3926495,0,
                         634781,3926490,0,
                         634603,3926632,0,
                         634651,3926912,0,
                         634785,3926905,0), nrow = 3, ncol = receptor.n)
# Input location mapping info
init.loc <- c(634614.5,3925939.8,0)
target.loc <- c(500,550,0)

# Calc translate vector, with vertical modification
transVec <- target.loc - init.loc + c(0,0,0.2)

# Translate and modify the vertical distance
releaseLocation <- release.loc + transVec
receptorLocation <- t(receptor.loc + transVec)

# read head, tail and repeatPart
head <- readLines('sourcesProperties-head')
tail <- readLines('sourcesProperties-tail')
repeatPart <- readLines('sourcesProperties-repeatPart')

# write
write(head, 'sourcesProperties')

## write T for release
repeatTemp <- repeatPart
repeatTemp <- gsub('fieldSource', 'TSource', repeatTemp)
locStr <- paste0('(', paste(releaseLocation, collapse = " "), ')')
repeatTemp <- gsub('sourceLocation', locStr, repeatTemp)
repeatTemp <- gsub('fieldName', 'T', repeatTemp)
write(repeatTemp, 'sourcesProperties', append = TRUE)

## write Tr* for receptors
for (i in 1:receptor.n){
        repeatTemp <- repeatPart
        TrName <- paste0("Tr", sprintf("%02d", i))
        repeatTemp <- gsub('fieldSource', paste0(TrName,'Source'), repeatTemp)
        locStr <- paste0('(', paste(receptorLocation[i,], collapse = " "), ')')
        repeatTemp <- gsub('sourceLocation', locStr, repeatTemp)
        repeatTemp <- gsub('fieldName', TrName, repeatTemp)
        write(repeatTemp, 'sourcesProperties', append = TRUE)
}

## write tail
write(tail, 'sourcesProperties', append = TRUE)