# 라이브러리 불러오기
library(dplyr)

##### 문제 1 #####
# ba_001.csv 불러와 df에 저장 - 저장 폴더 : BA_R092/data
df <- read.csv('/home/choe43324/BA_R092/data/ba_001.csv')

# 1) vs 변수를 factor형으로 변환
# factor 함수를 이용해 factor형으로 변환
# levels 인자를 이용해 레벨 지정
df$vs <- factor(df$vs, levels = c('V', 'S'))

# 2) am 변수를 factor형으로 변환
# factor 함수를 이용해 factor형으로 변환
# levels 인자를 이용해 레벨 지정
df$am <- factor(df$am, levels = c('automatic', 'manual'))

# 3) mpg_liter 변수 생성
# mutate 함수를 통해 파생 변수 생성
df <- df %>% mutate(mpg_liter = mpg * 3.785)

# 4) disp_liter 변수 생성
# mutate 함수를 통해 파생 변수 생성
df <- df %>% mutate(disp_liter = disp * 0.001)

# 5) ex1 생성
# 제외할 컬럼을 벡터로 지정
temp <- c(2, 4)
# -를 이용해 컬럼을 제외하고 ex1에 저장
ex1 <- df[, -temp]


##### 문제 2 #####
# 1) mpg_liter 하위 3개 출력
# arrange를 이용하여 mpg_liter를 오름차순 정렬
# select를 이용하여 car_name과 mpg_liter 추출
# result 변수에 저장
result <- ex1 %>% 
  arrange(mpg_liter) %>% 
  select(car_name, mpg_liter)
# result에서 3개만 출력하여 결과 확인
head(result, 3)

# 2) hp 이상치
# boxplot을 이용하여 이상치 존재 여부 확인
# 그래프를 통해 이상치가 존재함을 확인 가능
boxplot(ex1$hp)
# 이상치 정보를 out_num에 저장
out_num <- boxplot(ex1$hp)
# 인덱싱을 이용해 이상치 확인
ex1[ex1$hp %in% out_num$out, ]

# 3) cyl별 평균 차체 무게
# group_by로 cyl 그룹화
# summarise로 평균 차체 무게 계산 
ex1 %>%
  group_by(cyl) %>% 
  summarise(wt_mean = mean(wt))


##### 문제 3 #####
# 1) ex1_high_wt 생성
# filter를 이용해 연비가 평균 이상인 레코드 추출
# mean 함수를 이용해 연비의 평균 계산
# select를 이용해 출력할 변수 지정
# ex1_high_wt에 저장
ex1_high_wt <- ex1 %>% 
  filter(mpg_liter >= mean(mpg_liter)) %>% 
  select(car_name, mpg_liter, cyl, wt, qsec)

# 2) 분산 계산 - 소수 이하 두 자릿수까지 출력
# var 함수로 분산 계산
# round 함수로 반올림
round(var(ex1_high_wt$mpg_liter), 2)
round(var(ex1_high_wt$wt), 2)

# 3) ex2.csv 저장
# write.csv로 데이터프레임 저장
# 저장 경로는 BA_R092/data
write.csv(ex1_high_wt, '/home/choe43324/BA_R092/data/ex2.csv')
