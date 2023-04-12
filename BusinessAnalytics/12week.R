####################
# 11주차 강의
####################
data(sleep)
str(sleep)

# 대응표본 t-검정 : paired t-test
with(sleep, t.test(extra[group==1], extra[group==2], paired = T, alternative = 'less'))

# Shapiro test
with(sleep, shapiro.test(extra[group==1]))
with(sleep, shapiro.test(extra[group==2]))

####################
# 12주차 강의
####################
## mtcars dataset
data(mtcars)
str(mtcars)

mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$am <- as.factor(mtcars$am)

# 교차분석(카이제곱검정)
result <- table(mtcars$cyl, mtcars$am) # 빈도표
chisq.test(result)
fisher.test(result)

## education dataset
library(gmodels)

df <- read.csv('data/education.csv', header = T)
str(df)
head(df)

# 결측치 확인
sum(is.na(df$level))
sum(is.na(df$pass))

CrossTable(df$level, df$pass, chisq = T)

## 상관분석
library(ggplot2)
cor.test(mtcars$wt, mtcars$mpg)

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() + 
  geom_smooth(color = 'orange', size = 0.4) +
  labs(title = '자동차 무게와 연료의 효율성', x = '차체 무게', y = ' 연비')