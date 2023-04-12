# 1. 데이터 불러오기
## 필요한 라이브러리
library(psych)

## 데이터 불러오기
data <- read.csv('response.csv')

## 20대의 설문 결과만 사용
data <- data[data$age < 30, ]
attach(data)


# 2. 신뢰도 분석
## 경험 가치
alpha(data[, c('value1', 'value2', 'value3')])
## 과정 품질
alpha(data[, c('process_order1', 'process_order2', 'process_order3', 'process_order4',
               'process_info1', 'process_info2', 'process_info3', 'process_info4')])
## 결과 품질
alpha(data[, c('outcome1', 'outcome2', 'outcome3', 'outcome4', 'outcome5')])
## 서비스 환경 품질
alpha(data[, c('environment1', 'environment2', 'environment3', 'environment4')])
## 만족도
alpha(data[, c('satisfaction1', 'satisfaction2', 'satisfaction3', 'satisfaction4')])
## 지속 사용 의도
alpha(data[, c('continuous1', 'continuous2', 'continuous3')])

# 2.1. 변수 정의
## 경험 가치
value <- (value1 + value2 + value3)/3
## 과정 품질
process <- (process_order1 + process_order2 + process_order3 + process_order4 +
              process_info1 + process_info2 + process_info3 + process_info4)/8
## 결과 품질
outcome <- (outcome1 + outcome2 + outcome3 + outcome4 + outcome5)/5
## 환경 품질
environment <- (environment1 + environment2 + environment3 + environment4)/4
## 만족도
satisfaction <- (satisfaction1 + satisfaction2 + satisfaction3 + satisfaction4)/4
## 지속 사용 의도
continuous <- (continuous1 + continuous2 + continuous3)/3


# 3. 가설 검증
# 3.1. 키오스크의 과정 품질은 경험 가치에 정의 영향을 미칠 것이다.
verf1 <- lm(value ~ process)
summary(verf1)

# 3.2. 키오스크의 결과 품질은 경험 가치에 정의 영향을 미칠 것이다.
verf2 <- lm(value ~ outcome)
summary(verf2)

# 3.3. 키오스크의 환경 품질은 경험 가치에 정의 영향을 미칠 것이다.
verf3 <- lm(value ~ environment)
summary(verf3)

# 3.4. 키오스크의 품질 특성은 경험 가치에 유의한 영향을 미칠 것이다.
verf4 <- lm(value ~ process + outcome + environment)
summary(verf)

# 3.5. 키오스크 이용에 대한 경험가치는 만족에 정의 영향을 미칠 것이다.
verf5 <- lm(satisfaction ~ value)
summary(verf5)

# 3.6. 키오스크에 대한 만족은 지속 사용에 정의 영향을 미칠 것이다.
verf6 <- lm(continuous ~ satisfaction)
summary(verf6)