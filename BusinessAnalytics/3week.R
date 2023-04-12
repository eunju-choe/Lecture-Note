####################
# 3주차 강의
####################
# 벡터
# 예약어는 변수명으로 사용 불가
a <- c(1, 2, 3, 4, 5, 6)
b <- c('hello', 'hi')
c <- c(TRUE, FALSE, TRUE)
####################
# 행렬
x <- matrix(a, nrow = 2, ncol = 3)
# 행을 우선 입력
x_row <- matrix(a, nrow = 2, byrow = T)
####################
# 변수에 데이터 저장하기
var1 <- 'aaa'         # 문자형 데이터 
var2 <- 111           # 숫자형 데이터
var3 <- Sys.Date()    # 날짜형 데이터
var4 <- c('a', 'b', 'c') # 여러 건의 데이터

# 변수에 연속적인 값 저장하기
# 문자는 연속적으로 할당 불가
seq <- 1:5

# 변수 제거
rm(var1)
####################
# 데이터프레임
inflation <-  c(2.34, 2.74, 0.27, 2.31)
realgdp <- c(2778, 2775, 2785, 2847)
unemp <- c(5.1, 5.3, 5.6, 5.2)
recess = c('No', 'No', 'No', 'No')
df <- data.frame(inflation, realgdp, unemp, recess)

# rowname 추가 : 변수명이기 때문에 큰 따옴표 사용 안함
year <- c(2007, 2008, 2009, 2010)
df <- data.frame(inflation, realgdp, unemp, recess,
                 row.names = year)
####################
# 연산자 실습
4 == 6
3 != 8
8 %% 5
(3<5) | (4>5)
!(3>4)
3^2
3 ** 2 != 9