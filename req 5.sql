SELECT m.product_code,p.product,m.manufacturing_cost
 FROM gdb0041.fact_manufacturing_cost m join dim_product p
 using(product_code) where manufacturing_cost=
 (select max(manufacturing_cost)from fact_manufacturing_cost )
 or manufacturing_cost=(select min(manufacturing_cost) from fact_manufacturing_cost)
 order by manufacturing_cost desc;
 