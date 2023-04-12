# 0413
library('MASS')

# 패키지에 포함된 데이터셋 목록 확인 (오류)
data()

# MASS 패키지에 포함된 CO2 데이터 불러오기
data(CO2)


View(CO2)
head(CO2)
tail(CO2)
str(CO2)
ls(CO2) # 데이터의 변수명 확인

# [행, 열]
a <- CO2[CO2$Type=='Quebec', ]
CO2[CO2$Type=='Mississippi', ]

# $ 없이 커맨드 실행하는 법
attach(CO2)
CO2[Type=='Quebec',]

mssp <- CO2[Type=='Mississippi',]
tail(mssp)

CO2[Type=='Quebec' & Treatment=='chilled', ]
CO2[Type=='Quebec' | Treatment=='chilled', ]

mean(Treatment) # Factor라서 안됨
class(Treatment)
levels(Treatment)
newT <- as.numeric(Treatment)
class(newT)
levels(newT)
mean(newT)
sort(newT) # 오름차순 정렬, decreasing=F가 default


A <- c(1, 0, 2, 3)
B <- c(0, 1, 1, 4)
A&B
A|B
A&&B
A||B
