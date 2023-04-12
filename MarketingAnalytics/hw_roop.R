# for -> while
i = 1
x = c()
while (i <= 10) {
  x[i] <- rnorm(1)
  print(paste(i, '번째 x[i] : ', x[i]))
  i = i + 1
}
print(x)

# while -> for
# method 1
for (i in seq(1, 10, 2)) {
  print(i)
}

# method 2
for (i in 1:10) {
  if (i %% 2 == 1){
    print(i)
  }
}
