##### 1. Right Triangle #####
for (i in 1:5) {
  for (j in 1:i) {
    cat('*')
  }
  cat('\n')
}

##### 2. Isosceles Triangle #####
n = 5
row = 1

while (row <= n) {
  space = 1
  while (space <= n - row) {
    cat(' ')
    space = space + 1
  }
  
  col1 = 1
  while (col1 <= row) {
    cat('*')
    col1 = col1 + 1
  }
  
  col2 = row - 1
  while (col2 >= 1) {
    cat('*')
    col2 = col2 - 1
  }
  
  cat('\n')
  row = row + 1
}

##### 3. Inversed Isosceles Triangle #####
n = 5
row = 1

while (row <= n) {
  space = 1
  while (space <= row - 1) {
    cat(' ')
    space = space + 1
  }
  
  col1 = 0
  while (col1 <= n - row) {
    cat('*')
    col1 = col1 + 1
  }
  
  col2 = n - row
  while (col2 > 0) {
    cat('*')
    col2 = col2 - 1
  }
  
  cat('\n')
  row = row + 1
}

##### 4. Diamond #####
fn_dia <-  function(n){
  row = 1
  while (row <= n) {
    space = 1
    while (space <= n- row){
      cat(' ')
      space = space + 1
    }
  
    col1 = 1
    while (col1 <= row){
      cat('*')
      col1 = col1 + 1
    }
    
    col2 = row - 1
    while (col2 >= 1){
      cat('*')
      col2 = col2 - 1
    }
    
    cat('\n')
    row = row + 1
  }
  
  n = n - 1
  row = 1
  while (row <= n) {
    space = 1
    while (space <= row) {
      cat(' ')
      space = space + 1
    }
    
    col1 = 0
    while (col1 <= n - row) {
      cat('*')
      col1 = col1 + 1
    }
    
    col2 = n - row
    while (col2 > 0) {
      cat('*')
      col2 = col2 - 1
    }
    
    cat('\n')
    row = row + 1
  }
}
fn_dia(5)

##### 5. Function - pyramid2 #####
pyramid2 <- function(x, type){
  if (type == 0) {
    row = 1
    
    while (row <= x) {
      space = 1
      while (space <= x - row) {
        cat(' ')
        space = space + 1
      }
      
      col1 = 1
      while (col1 <= row) {
        cat('*')
        col1 = col1 + 1
      }
      
      col2 = row - 1
      while (col2 >= 1) {
        cat('*')
        col2 = col2 - 1
      }
      
      cat('\n')
      row = row + 1
    }
  }
  
  if (type == 1) {
    row = 1
    
    while (row <= x) {
      space = 1
      while (space <= row - 1) {
        cat(' ')
        space = space + 1
      }
      
      col1 = 0
      while (col1 <= x - row) {
        cat('*')
        col1 = col1 + 1
      }
      
      col2 = x - row
      while (col2 > 0) {
        cat('*')
        col2 = col2 - 1
      }
      
      cat('\n')
      row = row + 1
    }
  }
  
  if (type == 2) {
    fn_dia(x)
  }
}

pyramid2(7, 0)
pyramid2(7, 1)
pyramid2(7, 2)
