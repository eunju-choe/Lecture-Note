####################
# 7주차 강의
####################
# 제어문 실습 - if
num <- 3
if (num > 5) {
  print('True')
  print('Hello')
} else {
  print('False')
  print('world')
}

# 제어문 실습 - ifelse
x <- c(1:10)
ifelse(x %% 2 == 0, 'even', 'odd')

# 반복문 실습 - for
x <- 1:10
for (i in x) {
  print(i)
}

# 반복문 실습 - while
i <- 1
while (i <= 10) {
  print(i)
  i <- i +1
}

i <- 0
while (i <= 9) {
  i <- i +1
  if (i %% 2 != 0) {
    next      # pass 같은 거
  }
  print(i)
}

# 사용자 정의 함수 실습
fun <- function(num1, num2) {
  result1 <- num1 + num2
  result2 <- num1 * num2
  
  total <- result1 + result2
  
  return(c(total, result1, result2))
}

fun(3, 4)

# 기초통계분석
data(iris)
summary(iris)

library(descr)
data("mtcars")
str(mtcars)

mt<- within(mtcars, {
  vs <- factor(vs, labels = c("V", "S"))
  am <- factor(am, labels = c("automatic", "manual"))
  cyl  <- ordered(cyl)
  gear <- ordered(gear)
  carb <- ordered(carb)
})

str(mt)
head(mt)
tail(mt)  
sum(is.na(mt))  

# 컬럼으로 변환
mt %>% tibble::rownames_to_column('car_name')

# 빈도분석
freq(mt$cyl, plot = F)

# 산점도
plot(mtcars$mpg, mtcars$wt, main = '산점도',
     xlab = '연비', ylab = '차체무게')

# 히스토그램
hist(mt$mpg)

# 박스 플롯
boxplot(iris$Sepal.Width)

# 이상치 처리
out_num <- boxplot(iris$Sepal.Width)
iris[iris$Sepal.Width %in% out_num$out, ]