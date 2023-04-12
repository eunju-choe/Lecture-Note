# 파일 합치기
setwd('/home/choe43324/BA_R092')
file_list <- list.files()

df_1 <- NULL
for (i in 1:length(file_list)) {
  file <- read.csv(file_list[i], sep = '|', header = TRUE)
  df_1 <- rbind(df_1, file)
}

str(df_1)
head(df_1)
tail(df_1)
sum(is.na(df_1))