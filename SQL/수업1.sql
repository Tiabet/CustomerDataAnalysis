use shop;

	create view GoodSum (goods_classify, cnt_goods)
	as
	select goods_classify, count(*)
	from goods
	group by goods_classify;
    
select goods_classify, cnt_goods
from (
 select goods_classify, count(*) as cnt_goods
 from goods
 group by goods_classify
) as GoodsSum;

select *
from goods
where sell_price > (select avg(sell_price) from goods);

select *,
	(select avg(sell_price) from goods) as avg_price
from goods;

select goods_classify, avg(sell_price)
from goods
group by goods_classify
having avg(sell_price) > (select avg(sell_price) from goods);

select goods_classify
from goods
group by goods_classify