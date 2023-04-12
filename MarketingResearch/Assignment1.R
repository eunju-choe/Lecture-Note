# Calculate any two numbers
# addition
2 + 4
# subtraction
2 - 4
# multiplication
2 * 4
# division
2 / 4


# Assign the value 5 to the variable 'my_apples'
my_apples <- 5
# Assign the value 6 to the variable 'my_oranges'
my_oranges <- 6
# Create the variable 'my_fruit' by adding those two variables
my_fruit <- my_apples + my_oranges
# Print the variable 'my_fruit'
print(my_fruit)


# Create two vectors
A_vector <- c(1, 2, 3)
B_vector <- c(4, 5, 6)
# Take the sum of A_vector and B_vector
A_vector + B_vector


# Create a 2X2 data frame using 1 numeric vector and 1 character vector
name <- c('민수', '철수')
score <- c(90, 95)
df <- data.frame(name, score)
print(df)


# Construct a matrix with 3 rows that contain the numbers 1 up to 9
mat <- matrix(1:9, 3, 3)
print(mat)
# Get the 2nd and 3rd elements of the first row of the matrix
mat[1, c(2,3)]


# Create 'speed_vector'
speed_vector <- c('medium', 'slow', 'fast')
# Convert 'speed_vector' to factor vector
speed_factor <- factor(speed_vector, levels = c('slow', 'medium', 'fast'))
# Print the factor vector
print(speed_factor)
