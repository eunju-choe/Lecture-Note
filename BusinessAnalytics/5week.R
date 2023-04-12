####################
# 5주차 강의
####################
# [참고] 순열
a <- c(2007, 2008, 2009, 2010)
b <- c(2007:2010)

####################
# dplyr 실습
library(dplyr)

# 데이터 추출 - select
iris1 <- iris %>% 
  filter(Sepal.Width >= 2.5 & Species == 'versicolor') %>% 
  select(Sepal.Length, Sepal.Width)

# 데이터 정렬 - arrange
iris %>% arrange(desc(Sepal.Length), Petal.Length)

# 파생변수 생성 - mutate
iris_sum <- iris %>% mutate(Length_sum = Sepal.Length + Petal.Length,
                            Width_sum= Sepal.Width + Petal.Width)

# 행/열 삭제
iris_sum <- iris_sum[, -5]

iris_sum <- iris_sum[-(1:5), ]

iris_sum <- subset(iris_sum, select = -Width_sum)

# 컬럼명 변경
iris_sum <- rename(iris_sum, Length = Length_sum)

# group_by / summarise
iris %>% 
  group_by(Species) %>% 
  summarise(PLen_max = max(Petal.Length),
            PLen_min = min(Petal.Length),
            PLen_mean = mean(Petal.Length), 
            n())
####################

## 실습하기
library(dplyr)
data(iris)
# 1. Petal.Length를 기준으로 올림차순 정렬
iris %>% 
  arrange(Petal.Length)

# 2. Sepal.Length를 기준으로 내림차순 정렬
iris %>%
  arrange(desc(Sepal.Length))

# 3. Species를 기준으로 그룹화 하여 Petal.Length의 합계, 평균, 최댓값, 최솟값 구하기
iris %>% 
  group_by(Species) %>% 
  summarise(PLen_sum = sum(Petal.Length),
            PLen_mean = mean(Petal.Length),
            PLen_max = max(Petal.Length),
            PLen_min = min(Petal.Length))

# 4. Species별 PL 평균과 PW 최댓값을 산출한 뒤 변수로 지정, 출력
df <- iris %>% 
  group_by(Species) %>% 
  summarise(PLen_mean = mean(Petal.Length),
            Pwid_max = max(Petal.Width))

mean_petal.length <- df$PLen_mean
max_petal.width <- df$Pwid_max

print(mean_petal.length)
print(max_petal.width)
