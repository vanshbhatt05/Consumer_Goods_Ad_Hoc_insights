SELECT segment,count(distinct product) as product_count FROM gdb0041.dim_product
group by segment
order by product_count desc