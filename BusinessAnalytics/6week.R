####################
# 6주차 강의
####################
library(dplyr)
####################
# 외부파일 불러오기
df <- read.csv('/home/choe43324/BA_R092/data/resident_daily_201701.csv', sep = '|')
str(df)
head(df)
tail(df)

# 결측치 확인
is.na(df)
sum(is.na(df))     # df 내 전체 결측치 개수
colSums(is.na(df))     # 컬럼 별 결측치 개수
summary(df)

# na.rm 함수 인자 사용
sum(c(1, 2, 3, NA))
sum(c(1, 2, 3, NA), na.rm = T)

# 결측치 대체
p_mean <- mean(df$POP, na.rm = T)
df$POP <- ifelse(is.na(df$POP), p_mean, df$POP)
table(is.na(df$POP))     # 테이블로 결과 확인 가능

# 결측치 제거
df1 <- df %>% filter(!is.na(df$AGE))

# 모든 결측치 제거
df1 <- na.omit(df)

# 문자형을 팩터형으로 변경
df1$GENDER <- factor(df1$GENDER, levels = c('m', 'w'))

# csv로 저장하기
write.csv(df1, '/home/choe43324/BA_R092/data/new_201701.csv', row.names = F)