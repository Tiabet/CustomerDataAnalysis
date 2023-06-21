library(httr)
library(rvest)
library(stringr)

url = 'https://movie.daum.net/ranking/reservation'
movie = GET(url)

print(movie)

movie_html = read_html(movie)

print(movie_html)

movie_div = movie_html %>%
  html_nodes('div.kakao_wrap') %>%
  html_nodes('main.kakao_content') %>%
  html_nodes('div.box_ranking') %>%
  html_nodes('ol.list_movieranking')

movie_name = movie_div %>%
  html_nodes('div.item_poster') %>%
  html_nodes('div.thumb_cont') %>%
  html_nodes('strong.tit_item') %>%
  html_text()

name <- gsub("\\s+|\\n+", "", movie_name)

movie_grade_and_pop = movie_div %>%
  html_nodes('div.item_poster') %>%
  html_nodes('div.thumb_cont') %>%
  html_nodes('span.txt_append') %>%
  html_text()

movie_grade_and_pop <- gsub("\\s+|\\n+", "", movie_grade_and_pop)

ratings <- str_extract(movie_grade_and_pop, "평점\\d+\\.\\d+")
reservation_rates <- str_extract(movie_grade_and_pop, "예매율\\d+\\.\\d+%")

ratings <- gsub("평점|", "", ratings)
reservation_rates <- gsub("예매율|", "", reservation_rates)

movie_day = movie_div %>%
  html_nodes('div.item_poster') %>%
  html_nodes('div.thumb_cont') %>%
  html_nodes('span.txt_info') %>%
  html_text()

open_day <- gsub("\n+|\t+|\\s+|개봉", "", movie_day)

df = data.frame("제목" = name, "평점" = ratings, "예매율" = reservation_rates, "개봉" = open_day)

df
