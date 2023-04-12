####################
# 13주차 강의
####################
library(lm.beta)

df <- read.csv('data/CollegeScorecard.csv')
str(df)
head(df)
sum(is.na(df))
summary(df)

# 팩터로 형 변환
df$City <- as.factor(df$City)

# 다중회귀분석
result1 <- lm(Earnings ~ Cost+Grad+Debt+City, data = df)
summary(result1)

# 표준화 회귀계수
lm.beta(result1)
