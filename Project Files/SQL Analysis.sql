select * from df_orders

--Find Top 10 Highest revenue generating products

select top 10 product_id , sum(sale_pricee) as revenue from df_orders group by product_id order by revenue desc 


-- Top 5 highest selling products in each region

with cte as (
select region,product_id,sum(sale_pricee) as sales
from df_orders
group by region,product_id)
select * from (
select *
, row_number() over(partition by region order by sales desc) as rn
from cte) A
where rn<=5 ;

-- Month Over Month Growth comparison for 2022 and 2023 sales






with cte1 as (
select DATEPART(month,order_date) as sale_month ,datepart(year,order_date) as sale_year ,sum(sale_pricee) as total_sales from df_orders 
where datepart(year,order_date) in ('2022','2023')  group by DATEPART(month,order_date),datepart(year,order_date) 
),
 
cte2 as (
	select *,lead(total_sales,1) over(partition by sale_month order by sale_year) as next_year  from cte1 
)
select sale_month , sale_year, round((next_year - total_sales)/total_sales,3) as growth from cte2 where sale_year=2022


-- For each category ,highest sale month

with cte as (
select category,format(order_date,'yyyyMM') as order_year_month
, sum(sale_pricee) as sales 
from df_orders
group by category,format(order_date,'yyyyMM')
--order by category,format(order_date,'yyyyMM')
)
select * from (
select *,
row_number() over(partition by category order by sales desc) as rn
from cte
) a
where rn=1
