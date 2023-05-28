dbl_var = c(1, 2.5, 4.5)
print(dbl_var)

int_var = c(1L, 6L, 5L)
print(int_var)

as.integer(dbl_var)
dbl_var

#끝점도포함
1:10

seq(1,21,2)

x = c(1, 1.35, 1.7, 2.053, 2.4, 2.758, 3.1, 3.45,
      3.8, 4.15, 4.5, 4.855, 5.2, 5.55, 5.9)

round(x)

round(x, digits = 2)
ceiling(x)
floor(x)

a = 'learning to create'
b = 'character strings'
paste(a, b)

paste('pi is', pi)
paste('I', 'love', 'R', sep = ',')
paste0('I', 'love', 'R')


library(stringr)
str_c('Learning', 'to', 'use', 'the', 'stringr', 'package', sep = ' ')

text = c('Learning', 'to', NA, 'use', 'the', NA, 'stringr', 'package')
str_length(text)

x = 'Learning to use the stringr package'
str_sub(x, start = 1, end = 15) #띄어쓰기 포함함
str_sub(x, start = -7, end = -1)

text = c('Text ', ' with', ' whitespace ', ' on', 'both ', 'sides ')
print(text)
str_trim(text, side = 'both')

str_pad('beer', width = 10, side = 'left')


name = '가나다라마마'
birth = '2139123'

library(glue)
glue('{name} 은 {birth}')


Sys.timezone() #동기화하는 작업
Sys.Date()
Sys.time()

y = c('07/01/2015', '08/01/2015', '09/01/2015')
as.Date(y, format = '%m/%d/%Y') #소문자y는 두자리

library(lubridate)
x = c('2021-07-01', '2021-08-01', '2021-09-01')
y = c('07/01/2015', '08/01/2015', '09/01/2015')
x=ymd(x)
y=mdy(y) #date로 치환해줌

year(x)
year(y)

yday(x[1])
yday(x[3])
wday(x[1])
mday(x[1])

x = ymd('2021-07-01', '2021-08-01', '2021-09-01')
x + years(1) - days(c(2, 9, 21))


seq(ymd('2015-01-01'), ymd('2021-01-01'), by ='year')
seq(ymd('2021-09-01'), ymd('2021-09-30'), by ='2 days')

vec_integer = 8:17
vec_integer
vec_char = c('a', 'b', 'c')
vec_char  
c(1, 2, 3, TRUE, FALSE)
c('a', 'b', 'c', TRUE, FALSE)
v1 = 8:17
c(v1, 18:22)
v1[c(2, 4, 6)]
v1[-c(2, 4, 6, 8)]
v1 < 12
v1[v1 < 12 | v1 > 15]


#리스트 : 벡터집합, 데이터타입이 달라도됨, 리스트가 들어와도 됨
l = list(1:3, 'a', c(TRUE, FALSE, TRUE), c(2.5, 4.2))
str(l)
l2 = list(1:3, list(letters[1:5], c(TRUE, FALSE, TRUE)))
str(l2)
l3 = list(1:3, 'a', c(TRUE, FALSE, TRUE))
l4 = append(l3, list(c(2.5, 4.2)))
print(l4)

l4[1]
l4[[1]]
l4[[3]][2]



df = data.frame (col1 = 1:3,
                 col2 = c ("this", "is", "text"),
                 col3 = c (TRUE, FALSE, TRUE),
                 col4 = c (2.5, 4.2, pi))
str(df)
print(df)

#벡터의 길이가 동일해야함
v1 = 1:3
v2 = c ("this", "is", "text")
v3 = c (TRUE, FALSE, TRUE)
data.frame(col1 = v1, col2 = v2, col3 = v3)

l = list (item1 = 1:3,
          item2 = c ("this", "is", "text"),
          item3 = c (2.5, 4.2, 5.1))
l
data.frame(l)

df
v4 = c ("A", "B", "C")
cbind(df, v4) #열붙이기

v5 = c (4, "R", F, 1.1)
rbind(df, v5) #행붙이기

df[2:3, ]
df[ , c('col2', 'col4')]

df[, "col2", drop = FALSE]

x = c(1:4, NA, 6:7, NA)
x
is.na(x)
is.numeric(x)
is.character(x)

df = data.frame (col1 = c (1:3, NA),
                 col2 = c ("this", NA,"is", "text"),
                 col3 = c (TRUE, FALSE, TRUE, TRUE),
                 col4 = c (2.5, 4.2, 3.2, NA),
                 stringsAsFactors = FALSE)
df
is.na(df)

na.omit(df)
x[is.na(x)] = mean(x, na.rm = TRUE) #na를 remove
x

#함수 만들어서 사용하기
PV =function(FV, r, n) {
  PV = FV / (1+r)^n
  return(round(PV, 2))
}
body(PV)
formals(PV)
environment(PV)
PV(FV = 1000, r = 0.08, n = 5)

#디폴트값 지정 가능
PV =function(FV = 1000, r = .08, n = 5) {
  PV = FV / (1 + r)^n
  return(round(PV, 2))
}

PV(1000, 0.08)

x = c(8, 3, -2, 5)
if (any(x < 0)) {
  print('x contains negative number')
}

y = c (8, 3, 2, 5)
if (any (y < 0)) {
  print ("y contains negative numbers")
} else {
  print ("y contains all positive numbers")
}

x = c (8, 3, 2, 5)
ifelse(any(x < 0), "x contains negative numbers", "x contains all positive numbers")

x = 7
if (x >= 10) {
  print ("x exceeds acceptable tolerance levels")
} else if(x >= 0 & x < 10) {
  print ("x is within acceptable tolerance levels")
} else {
  print ("x is negative")
}

for (i in 2016:2020) {
  output = paste("The year is", i) #paste로 합쳐줘야함
  print(output)
}
