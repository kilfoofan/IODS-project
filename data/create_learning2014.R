setwd("C:/koulu/mooc/intro to open data/IODS-project/")
# access the dplyr library
library(dplyr)
library(knitr)

#access the data
daatta <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(daatta)
str(daatta)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(daatta, one_of(deep_questions))
daatta$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(daatta, one_of(surface_questions))
daatta$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(daatta, one_of(strategic_questions))
daatta$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
anadata <- select(daatta, one_of(keep_columns))
anadata <- anadata %>%  filter(Points !=0)

#write the data to a csv-file
str(anadata)
head(anadata)
write.csv(file = "./data/learning2014.csv", x = anadata) #comma separated!
