--          Day1

-- 1757. Recyclable and Low Fat Products
SELECT p.product_id
FROM products p
WHERE p.low_fats = 'Y' AND p.recyclable = 'Y';

-- https://leetcode.com/problems/find-customer-referee
select c.name
from Customer c
where c.referee_id != 2 OR c.referee_id IS NULL;

-- https://leetcode.com/problems/big-countries
select w.name,
       w.population,
       w.area
from World w
where w.area >= 3000000 OR w.population >= 25000000;

-- https://leetcode.com/problems/article-views-i
select distinct author_id as id
from Views
where author_id = viewer_id
order by author_id ASC;

-- https://leetcode.com/problems/invalid-tweets
select tweet_id
from Tweets
where length(content) > 15;

-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier
select e2.unique_id,
       e1.name
from Employees e1
left join EmployeeUNI e2
on e1.id = e2.id;

-- https://chat.google.com/dm/t5WyRkAAAAE/nA-zQtxZ5Mg/nA-zQtxZ5Mg?cls=10
select p.product_name,
       s.year,
       s.price
from Sales s
join Product p
on s.product_id = p.product_id;

-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions

select v.customer_id,
       count(v.customer_id) as count_no_trans
from Visits v

left join Transactions t
on v.visit_id = t.visit_id
where v.visit_id not in (select visit_id from Transactions)
group by v.customer_id;


