## 1. mtcars ##
## am에 따른 mpg의 차이
#######################
data(mtcars)
str(mtcars)
#######################
# 팩터형으로 변환
mtcars$am <- as.factor(mtcars$am)

# 정규성 검증
shapiro.test(mtcars$mpg[mtcars$am == 0])
shapiro.test(mtcars$mpg[mtcars$am == 1])

# 등분산성 검증
var.test(data = mtcars, mpg ~ am)

# 두 집단 간 평균 비교
t.test(data = mtcars, mpg ~ am, var.equal = T)

## 2. diet ##
## Diet에 따른 loss.wt의 차이
#######################
library(dplyr)
diet_df <- read.csv('data/2. diet.csv')
str(diet_df)
#######################
# 파생변수(loss.wt) 생성
diet_df <- diet_df %>% 
  mutate(loss.wt = pre.weight - weight6weeks)

# 팩터형으로 변환
diet_df$Diet <- as.factor(diet_df$Diet)

# 정규성 검증
shapiro.test(diet_df$loss.wt[diet_df$Diet == 1])
shapiro.test(diet_df$loss.wt[diet_df$Diet == 2])
shapiro.test(diet_df$loss.wt[diet_df$Diet == 3])

# 등분산성 검증
bartlett.test(data = diet_df, loss.wt ~ Diet)

# 세 집단 간 평균 비교 : ANOVA
out <- aov(data = diet_df, loss.wt ~ Diet)
summary(out)

# 사후 검정
TukeyHSD(out)

# 3)
diet_df$Diet[which.max(diet_df$loss.wt)]
diet_df %>% arrange(loss.wt)

diet_df %>% group_by(Diet) %>% 
  summarise(max(loss.wt))

## 3. pairTest2 ##
## 시험점수 차이
#######################
library(readxl)
test_df <- read_xlsx('data/3. pair.test2.xlsx')
str(test_df)
#######################
# 정규성 검증
shapiro.test(test_df$preScore)
shapiro.test(test_df$postScore)

# 대응표본 t-검정
t.test(test_df$preScore, test_df$postScore, paired = T)

# wilcox.text
wilcox.test(test_df$preScore, test_df$postScore, paired = T)
