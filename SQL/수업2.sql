use shop;

create table SampleMath
(m  numeric (10,3),
 n  integer,
 p  integer);

insert into SampleMath(m, n, p) values (500, 0, NULL);
insert into SampleMath(m, n, p) values (-180, 0, NULL);
insert into SampleMath(m, n, p) values (NULL, NULL, NULL);
insert into SampleMath(m, n, p) values (NULL, 7, 3);
insert into SampleMath(m, n, p) values (NULL, 5, 2);
insert into SampleMath(m, n, p) values (NULL, 4, NULL);
insert into SampleMath(m, n, p) values (8, NULL, 3);
insert into SampleMath(m, n, p) values (2.27, 1, NULL);
insert into SampleMath(m, n, p) values (5.555,2, NULL);
insert into SampleMath(m, n, p) values (NULL, 1, NULL);
insert into SampleMath(m, n, p) values (8.76, NULL, NULL);

select m, abs(m) as abs_m
from SampleMath;

select n, p, mod(n, p) as mod_col
from SampleMath;
#나머지 구하기

select m, n, round(m, n) as round_col
from SampleMath;
#반올림 구하기 m의 소수 n번째자리까지 반올림하기

create table SampleStr
(str1  varchar(40),
 str2  varchar(40),
 str3  varchar(40));

insert into SampleStr (str1, str2, str3) values ('가나다', '라마', NULL);
insert into SampleStr (str1, str2, str3) values ('abc', 'def', NULL);
insert into SampleStr (str1, str2, str3) values ('김', '철수', '입니다');
insert into SampleStr (str1, str2, str3) values ('aaa', NULL, NULL);
insert into SampleStr (str1, str2, str3) values (NULL, '가가가', NULL);
insert into SampleStr (str1, str2, str3) values ('@!#$%', NULL,	NULL);
insert into SampleStr (str1, str2, str3) values ('ABC',	NULL, NULL);
insert into SampleStr (str1, str2, str3) values ('aBC',	NULL, NULL);
insert into SampleStr (str1, str2, str3) values ('abc철수', 'abc', 'ABC');
insert into SampleStr (str1, str2, str3) values ('abcdefabc','abc', 'ABC');
insert into SampleStr (str1, str2, str3) values ('아이우', '이','우');

select str1, str2, concat(str1, str2) as str_concat
from SampleStr;

select str1, lower(str1) as low_str
from SampleStr;

select str1, str2, str3,
	replace(str1, str2, str3) as rep_str
from SampleStr;

select current_date, current_time, current_timestamp;

select
    extract(year from current_timestamp) as year,
    extract(month from current_timestamp) as month,
    extract(day	from current_timestamp) as day,
    extract(hour from current_timestamp) as hour,
    extract(minute from current_timestamp) as minute,
    extract(second from current_timestamp) as second;

create table SampleLike
(strcol varchar(6) not null,
primary key (strcol));

insert into SampleLike (strcol) values ('abcddd');
insert into SampleLike (strcol) values ('dddabc');
insert into SampleLike (strcol) values ('abdddc');
insert into SampleLike (strcol) values ('abcdd');
insert into SampleLike (strcol) values ('ddabc');
insert into SampleLike (strcol) values ('abddc');
#검색법
select *
from samplelike
where strcol like 'ddd%';

select *
from SampleLike
where strcol like '%ddd%';

select *
from SampleLike
where strcol like '%ddd';

select *
from goods
where sell_price between 100 and 1000;

select *
from goods
where buy_price is not null;

select *
from goods
where buy_price in (320, 500, 5000);

select *
from goods
where buy_price not in (320, 500, 5000);

select goods_name, sell_price,
	case when sell_price >=  6000 then '고가'    
		 when sell_price >= 3000 and sell_price < 6000 then '중가'
         when sell_price < 3000 then '저가'
		 else null
end as price_classify
from goods;

CREATE TABLE StoreGoods
(store_id CHAR(4) NOT NULL,
 store_name VARCHAR(200) NOT NULL,
 goods_id CHAR(4) NOT NULL,
 num INTEGER NOT NULL,
 PRIMARY KEY (store_id, goods_id));

insert into StoreGoods (store_id, store_name, goods_id, num) values ('000A', '서울',	'0001',	30);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000A', '서울',	'0002',	50);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000A', '서울',	'0003',	15);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000B', '대전',	'0002',	30);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000B',' 대전',	'0003',	120);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000B', '대전',	'0004',	20);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000B', '대전',	'0006',	10);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000B', '대전',	'0007',	40);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000C', '부산',	'0003',	20);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000C', '부산',	'0004',	50);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000C', '부산',	'0006',	90);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000C', '부산',	'0007',	70);
insert into StoreGoods (store_id, store_name, goods_id, num) values ('000D', '대구',	'0001',	100);

select * from goods;
select * from StoreGoods;

select * from StoreGoods as a
inner join goods as b
on a.goods_id = b.goods_id;

select distinct(goods_id) from StoreGoods;
select distinct(goods_id) from Goods;

select store.store_id, store.store_name, goods.goods_id,
	goods.goods_name, goods.sell_price
from StoreGoods as store 
left outer join Goods as goods
	on store.goods_id = goods.goods_id;
    
#left outer join과 right outer join의 결과가 다름 left join을 걸면 from에서 호출한 테이블이 마스터 테이블이 되고 이를 기준으로 합쳐진다

select goods_name, goods_classify, sell_price,
	rank() over (partition by goods_classify order by sell_price desc) as ranking
from Goods;
#오름차순 단축키는 desc

select * from(
select goods_name, goods_classify, sell_price,
	rank() over (partition by goods_classify order by sell_price desc) as ranking
from Goods
) as a
where a.ranking =1;
#서브쿼리를 이용해서 출력. 서브쿼리는 처리한 결과를 임시테이블로 저장하는 역할을함. 원래는 그냥 보는 용도.

select goods_name, goods_classify, sell_price,
	rank() over (order by sell_price) as ranking,
    dense_rank() over (order by sell_price) as ranking,
    row_number() over (order by sell_price) as ranking
from Goods;

select goods_id, goods_name, sell_price,
	sum(sell_price) over() as current_sum
from Goods;

select goods_id, goods_name, sell_price,
	sum(sell_price) over(order by goods_id) as current_sum
from Goods;

select goods_id, goods_name, sell_price,
	avg(sell_price) over(order by goods_id) as current_avg
from Goods;	

select goods_id, goods_classify, goods_name, sell_price,
	sum(sell_price) over(partition by goods_classify order by goods_id) as current_sum
from Goods;

select goods_id, goods_classify, goods_name, sell_price,
	avg(sell_price) over(order by goods_id rows 2 preceding) as moving_avg
from Goods;

select goods_id, goods_classify, goods_name, sell_price,
	avg(sell_price) over(order by goods_id rows between current row and 2 following) as moving_avg
from Goods;