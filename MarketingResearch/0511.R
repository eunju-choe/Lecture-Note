# 0511
data <- read.csv('lecture/MarketingResearch/sample data.csv')
head(data)
View(data)

# 기초통계 계산
summary(data[, 5])
bpref <- data[, 5]
max(bpref)
min(bpref)
var(bpref)
sd(bpref)
quantile(bpref)

# 히스토그램 그리기
T <- table(bpref)
barplot(T)
hist(bpref)
stem(bpref)
gender <- data[,16]
boxplot(bpref~gender) # 종속 ~ 독립
gender <- factor(gender)
plot(gender, bpref)

ggplot(data, aes(x=gender, y=bpref))+
  geom_point()
abline(lm(bpref~gender))

for (i in 1:5) {
  print(i^2)
}

for (i in 1:3){
  for (j in 1:2) {
    print(i+j)
  }
}

x = 1:9
if (length(x)<=10){
  x <- c(x, 10, 20)
  print(x)
} else {
  print(x[1])
}

for (i in c(-4, 5, 10, -6, -40, 30)){
  if(i>0) {
    print('warm')
  }
  else {
    print('not so warm')
  }
}
