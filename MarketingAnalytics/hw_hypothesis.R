library(dplyr)
library(MASS)
##################################
# 1. 박물관과 지역문화재단의 유튜브 운영 비율은 같을까
df <- read.csv('F:/R/Marketing_Analytics/test1.csv')
df_count <- data.frame(df %>%
                         group_by(type) %>%
                         count(youtube))

prop.test(c(47, 33), c(47+107, 33+10))
##################################
# 2. 접근성이 높은 채널이 접근성이 낮은 채널보다 구독자 수가 많을까?
df <- read.csv('F:/R/Marketing_Analytics/test2.csv')

high_acc <- df[df$accessibility==2, ]$subscriber
low_acc <- df[df$accessibility==1, ]$subscriber

t.test(low_acc, high_acc, alt = 'less', var.equal = TRUE)
##################################
# 3. 유튜브 활용에 따른 구독자 수 차이가 존재할까?
df <- read.csv('F:/R/Marketing_Analytics/test3.csv')

aov.df <- aov(sqrt(df$subscriber) ~ df$ability)
aov.df
summary(aov.df)