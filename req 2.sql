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


