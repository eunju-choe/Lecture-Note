####################
# 10주차 강의
####################
library(readxl)
library(dplyr)
####################
# 엑셀 파일 불러오기
finedust <- read_excel('data/finedust.xlsx')
str(finedust)
head(finedust)
tail(finedust)

# 새로운 데이터셋 만들기
dust1 <- finedust %>% filter(area == '성북구' |
                      area == '중구')
str(dust1)

# 결측치 확인
sum(is.na(dust1))
####################
# 두 집단 간 평균 비교 : t.test()
t.test(data = dust1, finedust ~ area, var.equal = T)

# 정규성 검증 : shapiro.test
shapiro.test(dust1$finedust[dust1$area == '성북구'])
shapiro.test(dust1$finedust[dust1$area == '중구'])

# 정규분포가 아니라고 가정 : wilcox.test
wilcox.test(data = dust1, finedust ~ area)

# 등분산성 검증 : var.test
var.test(data = dust1, finedust ~ area)
####################
# 세 집단 간 평균 비교 : ANOVA
data(iris)
str(iris)

out <- aov(data = iris, Sepal.Width ~ Species)
summary(out)

# 사후 검정
TukeyHSD(out)

# 정규성 검증
shapiro.test(iris$Sepal.Width[iris$Species == 'setosa'])
shapiro.test(iris$Sepal.Width[iris$Species == 'versicolor'])
shapiro.test(iris$Sepal.Width[iris$Species == 'virginica'])

# 등분산성 확인
bartlett.test(data = iris, Sepal.Width ~ Species)

# 정규성 확인이 안되었다고 가정 : kruskal
kruskal.test(data = iris, Sepal.Width ~ Species)

# 등분산성이 아님 : oneway.test (Welch's test)
oneway.test(data = iris, Sepal.Width ~ Species, var.equal = F)