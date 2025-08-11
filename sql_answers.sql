Request 1
SELECT distinct market from gdb0041.dim_customer
where customer='Atliq Exclusive' and region='APAC' order by market;

Request 2
with 2020_data as(
SELECT count(distinct product_code) as unique_product_2020
 FROM gdb0041.fact_sales_monthly
where fiscal_year=2020),

 2021_data as(
select count(distinct product_code) as unique_product_2021
from gdb0041.fact_sales_monthly
where fiscal_year=2021)

select *,round(((unique_product_2021-unique_product_2020)*100/unique_product_2020),2) as pert_chang
from 2020_data,2021_data;

Request 3
SELECT segment,count(distinct product) as product_count FROM gdb0041.dim_product
group by segment
order by product_count desc;

Request 4
with cte1 as (
select segment,count(distinct product_code) as product_code_2020
from dim_product p join fact_sales_monthly f using (product_code)
where fiscal_year=2020 group by segment),

 cte2 as (
select segment,count(distinct product_code) as product_code_2021
from dim_product p join fact_sales_monthly f using (product_code)
where fiscal_year=2021 group by segment)

select *,product_code_2021-product_code_2020 as difference
 from cte1 join cte2 using (segment) order by segment;

Request 5
SELECT m.product_code,p.product,m.manufacturing_cost
 FROM gdb0041.fact_manufacturing_cost m join dim_product p
 using(product_code) where manufacturing_cost=
 (select max(manufacturing_cost)from fact_manufacturing_cost )
 or manufacturing_cost=(select min(manufacturing_cost) from fact_manufacturing_cost)
 order by manufacturing_cost desc;
 
Request 6
SELECT customer_code,customer,avg(pre_invoice_discount_pct) as avg_discount_pert 
 FROM gdb0041.fact_pre_invoice_deductions f join dim_customer c
 using(customer_code) where fiscal_year=2021 and market="India"
 group by customer_code
 order by avg_discount_pert desc limit 5;
 
 Request 7
 with cte1 as (
select date, monthname(date) as Month ,sold_quantity,gross_price,fiscal_year
from fact_gross_price p
join fact_sales_monthly s using(fiscal_year,product_code) join
dim_customer using(customer_code) where customer="Atliq Exclusive"
)
select month,year(date) as year ,round(sum(gross_price*sold_quantity)/1000000,2) as gross_sales_mln
 from cte1 group by month,year 
 order by year;
 
  Request 8
 with cte1 as(
select date,quarter(date_add(date,interval 4 month)) as qtr ,sold_quantity
from fact_sales_monthly s where fiscal_year=2020)

select case when qtr=1 then "Q1"
when qtr=2 then "Q2"
when qtr=3 then "Q3"
else "Q4" end as Quarter,
sum(sold_quantity) as total_sold_quantity from cte1 
group by Quarter
order by Quarter;

Request 9
with cte1 as 
(select channel,sum(sold_quantity*gross_price) as gross_sales_
from fact_sales_monthly s join fact_gross_price g using(fiscal_year,product_code)
join dim_customer c using(customer_code) where fiscal_year=2021
group by channel)
select channel,
round(gross_sales_/1000000,2) as gross_sales_mln,
     round((gross_sales_/(select sum(gross_sales_) from cte1))*100,2)
as percentage from cte1
order by percentage desc;

Request 10
with cte1 as(
SELECT division,product_code,product,sum(sold_quantity) as total_sold_quantity,
rank() over(partition by division order by sum(sold_quantity)desc) as rank_order
 FROM gdb0041.dim_product p join fact_sales_monthly using(product_code)
 where fiscal_year=2021 group by division,product_code,product)
 
 select * from cte1 
 where rank_order<=3;



 
 
 
 
 
 
 
 
 
 
 


