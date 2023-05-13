library(DBI)
library(RMySQL)

#connect with MySQL
con = dbConnect(
  drv = MySQL(),
  user = 'root',
  password = 'kjhyun0221', # 위에서 설정한 root 비밀번호  host = '127.0.0.1',
  dbname = 'shop' # 사용하고자 하는 스키마
)
dbListTables(con)

goods = dbGetQuery(con, 'select * from goods;')

dbGetQuery(con, 'select goods_classify, count(*) as cnt
           from goods
           group by goods_classify
           order by cnt desc;')


dbSendQuery(con,
            "CREATE TABLE economics(
  date Date PRIMARY KEY,
  pce double,
  pop double,
  psavert double,
  uempmed double,
  unemploy double
)"
)

dbSendQuery(con,
            "SET GLOBAL local_infile = TRUE;"
)

economics = ggplot2::economics
economics = data.frame(economics)

dbDisconnect(con)
