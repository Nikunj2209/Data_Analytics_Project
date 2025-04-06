

Select count(*) from walmart;

Drop table walmart;

------Number of Transaction done on each payment method.------


Select 
payment_method,
count(*)
From Walmart
Group By payment_method

-----Number of Disintict branch---
Select count(Distinct branch) from walmart


----------------Answer Solution -----------------------------------------
--------Find different payment method and number of  transaction and number of quantity sold---------
Select * from walmart;	

Select 
	payment_method,
	Count(*) as number_of_payment,
	Sum(quantity) as no_qty_sold
    from walmart
group by payment_method;

---2.Identify the higehest-rated category in each branch, displaying the branch , category
--- Average Rating
Select *
	from
(Select 
	branch ,category, avg(rating) as average_rating ,
	Rank() Over (Partition by branch order by Avg(rating) Desc) as rank
	from walmart 
	group by branch , category 
	order by branch,3 desc)
	where rank=1

---Q3. Identifiy the busiest day of the each branch based on the number of transactions.

Select	*
from
(Select 
branch,
TO_CHAR(TO_DATE(date,'DD/MM/YY'),'Day') as day_name,
Count(*) as no_transactions,
Rank() Over(Partition By branch  Order by Count(*) Desc) as rank 	
from walmart
Group By 1,2)
where rank =1

--- Q4.Calculate the total quantity of item sold per payment method. List payment_method and total_quantity.

Select 
	payment_method,
	Sum(quantity) as no_qty_sold
    from walmart
group by payment_method;


--Q5 . Determine the average , minimum and maximum rating of category for each city.
--List the city, average_rating, min_rating, and max_rating. 

Select 
	city, category, 
	MIN(rating) as min_rating ,
	Max(rating) as max_rating ,
	Avg(rating) as avg_rating
	from walmart
group by city,  category

--Q6.Calculate the profit for each category by considering total_profit
--as(unit_price*qauntity*profit_margin). List  category and total_profit, ordered from highest to lowest profit.

Select 
category,
Sum(total) as total_revenue,
Sum(total * profit_margin) as profit 
from walmart
Group By 1

--Q7. Determine the most comman payment method for each branch. Display Branch and the preferred_payment_method.
With cte
AS
(Select 
	branch,
	payment_method,
	Count(*) as Total_trans,
	Rank() Over(Partition By Branch Order by Count(*)Desc) as rank
From walmart
Group By 1,2
)
Select *
from cte
where rank =1

--Q8. Categorize sales into 3 group Morning , Afternoon , Evening.
--Find out each of the shift and the number of invoices.

Select
	branch,
Case
  When Extract(Hour From(time::time))<12 Then 'Morning'
  When Extract(Hour From(time::time)) Between 12 and 17 Then 'Afternoon'
  Else 'Evening'
 END day_time,
 Count(*)	
From walmart
Group By 1,2
Order by 1, 3 desc	

--9. Identify 5 branch with highest decrease ratio in revevenue compare to last year(current year 2023 and last year 2022).
	
Select * from walmart

--revenue== last_revenue-current_revenue/last_revenue*100
	
With revenue_2022
As
(
 Select 
 branch,
 Sum(total) as revenue
 from walmart
 where Extract(Year from To_Date(date, 'DD/MM/YY'))=2022	
 Group by 1
),
revenue_2023
As	
(
Select 
	branch,
	Sum(total) as revenue
	from walmart
	where Extract(Year from To_Date(date, 'DD/MM/YY'))=2023
	Group by 1
)
Select 
	ls.branch,
	ls.revenue as last_year_revenue,
	cs.revenue as cr_year_revenue,
	Round(
	(ls.revenue-cs.revenue)::numeric/
	ls.revenue::numeric*100 ,
	2) as revenue_decrease_ratio
From revenue_2022 as ls 
Join 
revenue_2023 as cs 
On ls.branch = cs.branch
where 
ls.revenue>cs.revenue
Order by 4 desc
Limit 5

