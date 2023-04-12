### 경영대학 교수님의 연락처 파일 만들기 ###
# 전공별 url 요소 저장
num <- c(14313, 14314, 14315, 14316,
         14317, 14318, 14319, 52294)

# 변수 선언 : 수집 결과 저장
names <- c()
tels <- c()
emails <- c()

# 반복문 생성
for (i in 1:length(num)) {
  URL <- paste('https://biz.pusan.ac.kr/biz/', num[i], '/subview.do', sep = '')
  res <- GET(url = URL)
  contents <- res %>% 
    read_html() %>% 
    html_nodes(css = 'form:nth-child(2) > ul > li')
  
  ## 이름 추출
  name <- contents %>% 
    html_node(css = 'div.artclTitle > a') %>% 
    html_text(trim = TRUE)
  
  ## 전화번호 추출
  tel <- contents %>% 
    html_node(css = 'dl:nth-child(3) > dd') %>% 
    html_text(trim = TRUE)
  
  email <- contents %>% 
    html_node(css = 'dl:nth-child(4) > dd') %>% 
    html_text(trim = TRUE)
  
  names <- c(names, name)
  tels <- c(tels, tel)
  emails <- c(emails, email)
}

df <- data.frame('이름' = names, '전화번호' = tels, '이메일' = emails)
write.csv(df, 'result.csv')