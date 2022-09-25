create table payment_bk1 as
select*
from payment

alter table payment_bk1
add column refund money;

update payment_bk1
set refund = amount;

update payment_bk1
set refund = amount*.95
where amount > 5;

create view is_refunded AS
select*, case when amount >5 then 'Refund'else 'No_refund' end as Refund_status
from payment_bk1;


select first_name|| ' '|| last_name as fullname, cu.customer_id, cu.address_id, a.address, a.city_id, postal_code, city, ci.country_id, country
from customer as cu
left join address a 
ON cu.address_id = a.address_id
left join city ci
on ci.city_id = a.city_id
left join country
on country.country_id = ci.country_id;

create table customer_contact AS
SELECT first_name|| ' '|| last_name as fullname, cu.customer_id, cu.address_id, a.address, a.city_id, postal_code, city, ci.country_id, country
from customer as cu
left join address a 
ON cu.address_id = a.address_id
left join city ci
on ci.city_id = a.city_id
left join country
on country.country_id = ci.country_id;


CREATe TABLE Ten_most_valuable_customers as
select  first_name|| ' '|| last_name as fullname, cu.customer_id, amount
from customer as cu
left join payment p
on p.customer_id = cu.customer_id;

alter table ten_most_valuable_customers
alter column amount type money using amount::text::money

select 
customer_id, fullname,
sum (amount) as total
from ten_most_valuable_customers
group by customer_id, fullname
ORDER BY total DESC
LIMIT 10;








