with cte1 as 
(select channel,sum(sold_quantity*gross_price) as gross_sales_
from fact_sales_monthly s join fact_gross_price g using(fiscal_year,product_code)
join dim_customer c using(customer_code) where fiscal_year=2021
group by channel)
select channel,
round(gross_sales_/1000000,2) as gross_sales_mln,
     round((gross_sales_/(select sum(gross_sales_) from cte1))*100,2)
as percentage from cte1
order by percentage desc