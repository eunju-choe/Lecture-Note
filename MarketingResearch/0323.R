### 0323 ###
# scalar 
a <- c(1)

# vector
x <- c(5.2, 1.7, 6.3)
Colors <- c('red', 'green', 'red')

y <- 1:5
z <- seq(1, 1.4, by=0.1)
y+z

length(y) # 길이
mean(y+z) # 평균

# vector 응용
mydata <- c(2, 3.5, -0.2)

mydata[mydata>0]
mydata>0

mydata[-c(1,3)]

sort(x)
rev(x)

# matrix
matrix(1:9, nrow=3)
matrix(1:9, byrow=T)

# matrix 응용
mat <- matrix(1:12, 4, byrow=F)
dim(mat)
mat[1, 2]
mat[,2]
mat[1,] 
mat[c(1,3), ]
mat[,c(1,3)]
mat[-1, ]

# array
a1 <- array(1:24, dim=c(2,3,4))
a1
array(1:3, c(2,4))

#dataframe
d1 <- 1:4
d2 <- c('a', 'b', 'c', 'd')
df <- data.frame(d1, d2)

name <- c('A', 'B', 'C')
gender <- c('F', 'M', 'F')
score <- c(90, 80, 100)
df <- data.frame(name, gender, score)
df