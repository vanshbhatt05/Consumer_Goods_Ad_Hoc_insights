with cte1 as (
select date, monthname(date) as Month ,sold_quantity,gross_price,fiscal_year
from fact_gross_price p
join fact_sales_monthly s using(fiscal_year,product_code) join
dim_customer using(customer_code) where customer="Atliq Exclusive"
)
select month,year(date) as year ,round(sum(gross_price*sold_quantity)/1000000,2) as gross_sales_mln
 from cte1 group by month,year 
 order by year;
