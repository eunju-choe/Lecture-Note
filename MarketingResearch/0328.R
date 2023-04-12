# Factor
vector <- c('M', 'L', 'H')
factor <- factor(vector,
                 order=T,
                 level=c('L', 'M', 'H'))
factor

grade <- factor(c('A', 'B', 'C', 'D', 'F'),
                order=T,
                levels=c('F', 'D', 'C', 'B', 'A'))
