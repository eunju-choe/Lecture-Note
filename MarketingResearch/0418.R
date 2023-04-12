# 0418
# 반복문
for (i in 1:5) {
  print(i^2)
}

for(i in 1:3) {
  for (j in 1:2){
    print(i+j)
  }
}

x <- 1:9

if (length(x) <= 10) {
  x <- c(x, 10:10)
  print(x)
} else
{
  print(x[1])
}
