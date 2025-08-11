with cte1 as(
SELECT division,product_code,product,sum(sold_quantity) as total_sold_quantity,
rank() over(partition by division order by sum(sold_quantity)desc) as rank_order
 FROM gdb0041.dim_product p join fact_sales_monthly using(product_code)
 where fiscal_year=2021 group by division,product_code,product)
 
 select * from cte1 
 where rank_order<=3
 