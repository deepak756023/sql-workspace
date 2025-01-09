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


