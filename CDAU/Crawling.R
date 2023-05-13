library(httr)
library(rvest)

url = 'https://quotes.toscrape.com/'
quote = GET(url)

print(quote)

quote_html = read_html(quote)

print(quote_html)

quote_div = quote_html %>%
  html_nodes('div.quote') %>%
  html_nodes('span.text')

print(quote_div)

quote_div %>% html_text()

quote_text = quote_div %>%
  html_text()

print(quote_text)

quote_who = quote_html %>%
  html_nodes('div.quote') %>%
  html_nodes('span') %>%
  html_nodes('small.author') %>%
  html_text()

print(quote_who)

quote_link = quote_html %>%
  html_nodes('div.quote') %>%
  html_nodes('span') %>%
  html_nodes('a') %>%
  html_attr('href')

print(quote_link)

quote_link = paste0('https://quotes.toscrape.com', quote_link)

quote_link

quote_df = data.frame(
  'quote' = quote_text,
  'author' = quote_who,
  'link' = quote_link
)

quote_df

url = 'http://www.yes24.com/Product/Goods/117293655'

data = GET(url)

data_sales = data %>%
  read_html() %>%
  html_nodes(xpath = '//*[@id="yDetailTopWrap"]/div[2]/div[1]/span[3]/span[3]')

print(data_sales)

library(stringr)

data_sales %>%
  html_text() %>%
  #str_flatten() %>%
  readr::parse_number()

library(rvest)
library(httr)

url = 'https://en.wikipedia.org/wiki/List_of_UFC_champions'
data_ufc = GET(url)

champion_list = data_ufc %>%
  read_html() %>%
  html_table()

champion_list[[1]]


library(httr)
library(rvest)

url = 'https://www.dhlottery.co.kr/gameResult.do?method=byWin'

data_lotto = POST(
  url, 
  body = list(
    drwNo = "1009",
    dwrNoList = "1009"
  )
)

data_lotto_html = data_lotto %>% read_html()

data_lotto_html %>%
  html_nodes('div.num.win') %>%
  html_text()

# 1
data_lotto_html %>%
  html_nodes('.num.win') %>%
  html_text() %>%
  str_extract_all('(\\d)+') %>%
  unlist()
