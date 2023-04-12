data <- c(rep(0, 100), rep (50, 100), rep(100, 100))
pop_mean <- mean(data)
hist(data, xlim = c(0, 100), 
     main = paste('population (mean =', as.character(pop_mean), ')'))

par(mfrow = c(2, 2))

sm <- sapply(1:10000, function(i) mean(sample(data, 2, replace = F)))
sample_mean <- round(mean(sm), 2)
hist(sm, xlim = c(0, 100), 
     main = paste('sample size = 2 (mean =', as.character(sample_mean), ')'))

sm <- sapply(1:10000, function(i) mean(sample(data, 5, replace = F)))
sample_mean <- round(mean(sm), 2)
hist(sm, xlim = c(0, 100), 
     main = paste('sample size = 5 (mean =', as.character(sample_mean), ')'))

sm <- sapply(1:10000, function(i) mean(sample(data, 10, replace = F)))
sample_mean <- round(mean(sm), 2)
hist(sm, xlim = c(0, 100), 
     main = paste('sample size = 10 (mean =', as.character(sample_mean), ')'))

sm <- sapply(1:10000, function(i) mean(sample(data, 30, replace = F)))
sample_mean <- round(mean(sm), 2)
hist(sm, xlim = c(0, 100), 
     main = paste('sample size = 30 (mean =', as.character(sample_mean), ')'))

## 다시 ##
n <- 100
x <- 3
smean <- numeric(0)

for (i in 1:10000) {
  S = rpois(n, x)
  smean[i] <- (mean(S) - x) / (sqrt(x/n))
}

hist(smean, prob = T)
hist(S, prob = T)
