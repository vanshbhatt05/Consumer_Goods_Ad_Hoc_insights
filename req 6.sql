SELECT customer_code,customer,avg(pre_invoice_discount_pct) as avg_discount_pert 
 FROM gdb0041.fact_pre_invoice_deductions f join dim_customer c
 using(customer_code) where fiscal_year=2021 and market="India"
 group by customer_code
 order by avg_discount_pert desc limit 5;