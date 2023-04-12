#### 네이버 쇼핑에서 상품 목록 가져오기 ####

library(tidyverse)
library(httr)
library(rvest)

# 검색어 설정하기
searchword <- '무접점 키보드'
res <- GET(url = 'https://search.shopping.naver.com/search/all',
           query = list(query = searchword))

print(x = res)

# 상품 정보를 담고 있는 HTML 추출하기
##__next > div > div.style_container__1YjHN > div.style_inner__18zZX > div.style_content_wrap__1PzEo > div.style_content__2T20F > ul > div > div:nth-child(42) > li > div > div.basicList_info_area__17Xyo
contents <- res %>% 
  read_html() %>% 
  html_nodes(css = 'div.basicList_info_area__17Xyo')

print(contents)

# 상품명 추출하기
# #__next > div > div.style_container__1YjHN > div.style_inner__18zZX > div.style_content_wrap__1PzEo > div.style_content__2T20F > ul > div > div:nth-child(1) > li > div > div.basicList_info_area__17Xyo > div.basicList_title__3P9Q7 > a
title <- contents %>% 
  html_node(css = '.basicList_title__3P9Q7') %>% 
  html_text(trim = TRUE)

# 링크 추출하기
link <- contents %>%
  html_node(css = '.basicList_title__3P9Q7 > a') %>% 
  html_attr(name = 'href') 
head(link)
