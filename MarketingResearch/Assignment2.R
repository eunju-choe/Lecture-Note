## MASS 패키지의 CO2 데이터로 실습한 내용을 housing 데이터로 따라하기

# 라이브러리 불러오기
library('MASS')
# MASS 패키지에 포함된 housing 데이터 불러오기
data(housing)


# 1. attach/detach 활용하기
# attach 후 슬라이싱
attach(housing)
housing[Type=='Terrace', ]
# detach 후슬라이싱
detach(housing)
housing[housing$Type=='Terrace', ]

# 2. Factor 변수 중 하나를 선택하고 수준 확인하기
attach(housing)
levels(Sat)


# 3. 두가지 조건을 모두 만족하는 값 도출
housing[Type=='Terrace' & Infl=='Low', ]


# 4. 두가지 조건 중 하나라도 만족하는 값 도출
housing[Type=='Terrace' | Infl=='High', ]



## 강의교재의 실습 데이터(sample data.csv) 시각화하기

# 데이터불러오기
df <- read.csv('lecture/MarketingResearch/sample data.csv')

# 5. 최솟값, 최댓값, 중위수, 분산 확인하기
min(df$age) # 최솟값
max(df$age) # 최댓값
median(df$age) # 중위수
var(df$age) # 분산


# 6. 히스토그램 그리기
brand_aware <- df[, 'brandaware']
hist(brand_aware)


# 7. 상자도표 그리기
boxplot(df$brandaware~df$city)

