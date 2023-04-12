####################
# 4주차 강의
####################
# 팩터
## (변수) #####
inflation <-  c(2.34, 2.74, 0.27, 2.31)
realgdp <- c(2778, 2775, 2785, 2847)
unemp <- c(5.1, 5.3, 5.6, 5.2)
recess = factor(c('No', 'No', 'No', 'No'),
                levels = c('Yes', 'No'))
year <- c(2007, 2008, 2009, 2010)
################
df <- data.frame(inflation, realgdp, unemp, recess,
                 row.names = year)

# str : 변수의 구조 확인
str(df)

# 데이터프레임 다루기
data('iris')
str(iris)
head(iris)
tail(iris)
View(iris)
levels(iris$Species) # 팩터의 레벨 확인

# 인덱싱
iris[4, 5]
iris[-3, ]
iris[, 5]
iris[(iris$Sepal.Width >= 2.5) & (iris$Species == 'setosa'), ]
# 벡터 인덱싱
a <- c(1, 2, 3, 4, 5, 6)
a[3]


# subset()
df_iris3 <- subset(iris,
                   (iris$Sepal.Width >= 2.5) & (iris$Species == 'versicolor'),
                   select =  c(Sepal.Length, Petal.Length))

# rbind
## (변수) #####
df_iris4 <- subset(iris,
                   (iris$Sepal.Width >= 2.5) & (iris$Species == 'setosa'),
                   select =  c(Sepal.Length, Petal.Length))
################
cb_iris <- rbind(df_iris3, df_iris4)

# cbind
## (변수) #####
cb_df_iris3 <- subset(iris,
                   (iris$Sepal.Width >= 3.5) & (iris$Species == 'setosa'),
                   select =  c(Sepal.Length, Petal.Length))

cb_df_iris4 <- subset(iris,
                      (iris$Sepal.Width >= 3.5) & (iris$Species == 'setosa'),
                      select =  c(Sepal.Width, Petal.Width, Species))
################
cb_iris_c <- cbind(cb_df_iris3, cb_df_iris4)