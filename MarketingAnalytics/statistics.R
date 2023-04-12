# Simulation Example for CLT - 1
n = 10
p = .25
smean = numeric(0)

for (i in 1:10000) {
    # 이항분포의 난수 생성(성공확률이 p일 때, 100번 중 n번 성공할 확률)
    S = rbinom(100, n, p)
    smean[i] = (mean(S) - n*p)/sqrt(n*p*(1-p))
}

hist(smean, prob = T)
hist(S, prob = T)

# Simulation Example for CLT - 2
smean = numeric(0)
lamda = 1
n = 30
for (i in 1:10000) {
    # generate random data
    S = rexp(n, lamda)
    smean[i] = (mean(S) - (1/lamda))/(1/lamda)/sqrt(n)
}
hist(smean, prob = T)
hist(S, prob = T)

# Analysis of Variance (ANOVA)
data(InsectSprays)
aov.spray <- aov(sqrt(InsectSprays$count) ~ InsectSprays$spray)
aov.spray
summary(aov.spray)

# Linear Regression
x = c(18, 23, 25, 35, 65, 54, 34, 56, 72, 19, 23, 42, 18, 39, 37)
y = c(202, 186, 187, 180, 156, 169, 174, 172, 153, 199, 193, 174, 198, 183, 178)
plot(x, y)
abline(lm(y ~ x))

lm.result = lm(y ~ x)
summary(lm.result)
