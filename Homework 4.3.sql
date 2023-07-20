--Q1 1. List all customers who live in Texas (use JOINs)

select customer.first_name, customer.last_name, district
from customer 
full join address 
on customer.address_id = address.address_id 
where district = 'Texas';

-- Q2 2. Get all payments above $6.99 with the Customer's Full Name
select customer.first_name, customer.last_name, amount
from customer 
full join payment 
on customer.customer_id  = payment.customer_id 
where amount > 6.99;

--Q3 Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name 
from customer 
where customer_id  in (
	select customer_id 
	from payment
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc
);

--Q4 List all customers that live in Nepal (use the city table)
select customer.first_name, customer.last_name, country
from customer 
full join address 
on customer.address_id = address.address_id 
full join city 
on address.city_id = city.city_id 
full join country
on city.country_id = country.country_id 
where country = 'Nepal';

--Q5 Which staff member had the most transactions?
select staff.first_name, staff.last_name, count(amount) as transactions
from staff 
full join payment
on staff.staff_id = payment.staff_id 
group by staff.staff_id 
order by transactions desc
limit 1;

--Q6 How many movies of each rating are there?
select rating, count(rating) as num_of_films
from film 
group by rating
order by num_of_films desc

--Q7 Show all customers who have made [only-added for clarity?] a single payment above $6.99 (Use Subqueries)
select customer.first_name, customer.last_name, count(amount) as num
from customer
full join payment 
on customer.customer_id = payment.customer_id 
where payment.customer_id in (
	select customer_id
	from payment 
	where amount > 6.99
) 
group by customer.first_name, customer.last_name 
order by num asc
-- Note for above and would love feedback, the above will give an ordered list of all customers who 
--had any order 6.99 or above by count of purchases...technically it gives the single purchases as the top
-- of the table entries (as there will be no entries at 0 or neg integers)...How do I get it to only show 
--the entries with only a single 6.99+ purchase? I keep getting errors with placement of additional which 
--statements and I can't nest the count(amount) or it tells me that 'num does not exist' at other frames 
-- of looking at the data 

--Q8 How many free rentals did our stores give away?
select store.store_id, count(amount) as freebie
from payment 
full join staff 
on payment.staff_id = staff.staff_id 
full join store
on staff.store_id = store.store_id 
where amount = 0
group by store.store_id 
order by freebie desc






















