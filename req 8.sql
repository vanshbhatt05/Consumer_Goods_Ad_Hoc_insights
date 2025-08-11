with cte1 as(
select date,quarter(date_add(date,interval 4 month)) as qtr ,sold_quantity
from fact_sales_monthly s where fiscal_year=2020)

select case when qtr=1 then "Q1"
when qtr=2 then "Q2"
when qtr=3 then "Q3"
else "Q4" end as Quarter,
sum(sold_quantity) as total_sold_quantity from cte1 
group by Quarter
order by Quarter