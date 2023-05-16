create database shop;
use shop;
create table goods
(
goods_id char(4) not null, #char : 4자리고정
goods_name varchar(100) not null, #varchar : 0~100자리
goods_classify varchar(32) not null,
sell_price integer,
buy_price integer,
register_date date, #상관없으면 비워둠
primary key (goods_id) #메인이되는 키 설정
);
insert into goods values ('0001', '티셔츠', '의류', 1000, 500, '2020-09-20');
insert into goods values ('0002', '펀칭기', '사무용품', 500, 320, '2020-09-11');
insert into goods values ('0003', '와이셔츠', '의류', 4000, 2800, NULL);
insert into goods values ('0004', '식칼', '주방용품', 3000, 2800, '2020-09-20');
insert into goods values ('0005', '압력솥', '주방용품', 6800, 5000, '2020-01-15');
insert into goods values ('0006', '포크', '주방용품', 500, NULL, '2020-09-20');
insert into goods values ('0007', '도마', '주방용품', 880, 790, '2020-04-28');
insert into goods values ('0008', '볼펜', '사무용품', 100, NULL, '2020-11-11');

select goods_id, goods_name, buy_price
from goods;

select goods_id as id,
	goods_name as name,
	buy_price as price
from goods;

select '상품' as category,
    38 as num,
    '2022-01-01' as date,
    goods_id,
    goods_name,
    sell_price,
    buy_price,
    sell_price - buy_price as profit
from goods;

select distinct goods_classify
from goods;

select *
from goods
where goods_classify = '의류';

select *, sell_price - buy_price as profit
from goods
where sell_price - buy_price >= 500;

select *
from goods
where sell_price >= 1000;

select goods_name, goods_classify, register_date
from goods
where register_date < '2020-09-27';

select goods_name, goods_classify, sell_price
from goods
where goods_classify = '주방용품'
and sell_price >= 3000;

select count(*)
from goods;

select sum(sell_price)
from goods;

select count(distinct goods_classify) 
from goods;

select goods_classify, count(*)
from goods
group by goods_classify;

select buy_price, count(*)
from goods
group by buy_price;

select goods_classify, avg(sell_price)
from goods
group by goods_classify
having avg(sell_price) >= 2500;

select goods_classify, buy_price, count(*)
from goods
where goods_classify = '의류'
group by buy_price;

select goods_classify, avg(sell_price)
from goods
group by goods_classify
having avg(sell_price) >= 2500;

select *
from goods
order by register_date, sell_price;

select *
from goods
order by sell_price, buy_price;

create view GoodSum (goods_classify, cnt_goods)
as
select goods_classify, count(*)
from goods
group by goods_classify; 

select * from GoodSum;

select goods_classify, cnt_goods
from (
 select goods_classify, count(*) as cnt_goods
 from goods
 group by goods_classify
) as GoodsSum;

select *
from goods
where sell_price > (select avg(sell_price) from goods);