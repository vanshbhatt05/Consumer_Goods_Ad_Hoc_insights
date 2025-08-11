with cte1 as (
select segment,count(distinct product_code) as product_code_2020
from dim_product p join fact_sales_monthly f using (product_code)
where fiscal_year=2020 group by segment),

 cte2 as (
select segment,count(distinct product_code) as product_code_2021
from dim_product p join fact_sales_monthly f using (product_code)
where fiscal_year=2021 group by segment)

select *,product_code_2021-product_code_2020 as difference
 from cte1 join cte2 using (segment) order by segment
