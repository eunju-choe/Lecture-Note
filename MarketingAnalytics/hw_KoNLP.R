library(KoNLP)
library(readr)
library(wordcloud2)

# 한국인의 감천문화마을 리뷰 데이터 불러오기
df <- read.csv('test.csv') 
text <- df$내용 # 내용 부분만 추출

text <- gsub("[a-z]", " ", text) # 영어를 공란으로 치환
text <- gsub('[0-9]', ' ', text) # 숫자를 공란으로 치환
text <- gsub(' +', ' ', text) # 여러 공란을 한 개의 공란으로 치환
text <- gsub('\"', ' ', text) # 줄바꿈 표시 제거

# 명사와 형용사 추출
noun <- extractNoun(text)
noun <- unlist(noun) # 리스트를 벡터로 변경경

# 한 글자 제거
noun <- noun[nchar(noun) > 1] # 길이가 1인 문자 제외

## 제외할 특정 단어를 정의후 제외
excluNouns <- c('들이', '부산', '감천', '문화', '마을', '하게', '하기',
                '정도', '모습', '해서', '곳곳')
noun <- noun[!noun %in% excluNouns]

# 빈도수를 기준으로 내림차순 정렬
wordT <- sort(table(noun), decreasing = T)[1:50]
wordT

# 워드클라우드 출력
wordcloud2(wordT, size = 1, shape = 'diamond',
           color = 'random-dark')
