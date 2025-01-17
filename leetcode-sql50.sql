--                                                                                Basic Select                                                                            --

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


--                                                                                   Basic Joins                                                                     --

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

-- https://leetcode.com/problems/average-time-of-process-per-machine/description
select a.machine_id, round(avg(b.timestamp - a.timestamp), 3) as processing_time 
from activity a join activity b
on a.machine_id = b.machine_id and a.process_id = b.process_id and a.activity_type = 'start' and b.activity_type = 'end'
group by 1;

-- https://leetcode.com/problems/employee-bonus/description
select e.name,
       b.bonus
from employee e
left join Bonus b
on e.empId = b.empId
where b.bonus < 1000 or b.bonus is NULL;

-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description
select NAME
from employee 
where id IN (
      select managerId
      from employee
      group by managerId
      having count(*) >= 5

      );
      
--                                                                       Basic Aggregate Functions                                                                           --


-- https://leetcode.com/problems/not-boring-movies
select  c.*
from Cinema c
where c.id % 2 != 0 and c.description != 'boring'
order by c.rating DESC;

-- https://leetcode.com/problems/average-selling-price
select p.product_id , if(round(sum(p.price * u.units)/sum(u.units),2) is NULL , 0, round(sum(p.price * u.units)/sum(u.units),2) ) as average_price
from Prices p 
left join UnitsSold u 
  on p.product_id=u.product_id  
 and purchase_date between start_date and end_date 
 group by product_id;
 
 -- https://leetcode.com/problems/project-employees-i
 select p.project_id,
       round(avg(e.experience_years), 2) as average_years
from Project p
join Employee e
on p.employee_id = e.employee_id
group by p.project_id;

-- https://leetcode.com/problems/percentage-of-users-attended-a-contest
select r.contest_id,
       round((count(r.user_id)/ (select count(*)
                          from Users) ) * 100, 2) as percentage
from Register r
group by r.contest_id
order by percentage desc, r.contest_id;

-- https://leetcode.com/problems/queries-quality-and-percentage
select query_name,
       round(sum(rating / position) / count(rating), 2) as quality,
       round(sum(rating < 3) / count(rating) * 100, 2) as  poor_query_percentage
       
from Queries
group by query_name;

-- https://leetcode.com/problems/monthly-transactions-i
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month
    , country
    , COUNT(*) AS trans_count
    , SUM(state = 'approved') AS approved_count
    , SUM(amount) AS trans_total_amount
    , SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM Transactions
GROUP BY month, country;

-- https://leetcode.com/problems/immediate-food-delivery-ii
SELECT (ROUND (sum(IF (order_date=customer_pref_delivery_date, 1, 0)) / count(*) , 4) * 100) as immediate_percentage
FROM Delivery
WHERE (customer_id,order_date) in (select customer_id,min(order_date)  
                                   from delivery 
                                   group by customer_id);

--                                                                           Sorting and Grouping                                                                           --

-- https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher
select distinct teacher_id,
       count(distinct subject_id) as cnt
from Teacher
group by teacher_id;

-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i
select activity_date as day,
       COUNT(distinct user_id) as active_users 
       
from activity
group by activity_date
having activity_date between '2019-06-28' and '2019-07-28';

-- https://leetcode.com/problems/product-sales-analysis-iii
SELECT product_id, 
       year as first_year, 
       quantity,
       price
FROM Sales
WHERE (product_id,year) in (
                       SELECT product_id,MIN(year)
                       FROM Sales
                       GROUP BY product_id
                    );
                    
-- https://leetcode.com/problems/classes-more-than-5-students
select class
from Courses
group by class
having count(student) >= 5;

-- https://leetcode.com/problems/find-followers-count
select user_id,
       count(*) as followers_count
from Followers
group by user_id
order by user_id;

-- https://leetcode.com/problems/biggest-single-number
select
    case when count(num)=1 then num 
    else null 
    end as num
from MyNumbers
group by num
order by num desc 
limit 1;

-- https://leetcode.com/problems/customers-who-bought-all-products
select customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select count(distinct product_key)
                            from Product );
                            
--                                                                      Advanced Select and Joins                                                               --

-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee
select e1.employee_id,
       e1.name,
       count(e2.employee_id) as reports_count,
       round(avg(e2.age)) as average_age
       
from Employees e1
join Employees e2
on e1.employee_id = e2.reports_to
group by e1.employee_id, e1.name
order by employee_id;

-- https://leetcode.com/problems/primary-department-for-each-employee
select employee_id,department_id 
from Employee 
where primary_flag = 'Y' or employee_id not in(select employee_id
                                               from Employee
                                               where primary_flag = 'Y');
                                               
--       https://leetcode.com/problems/triangle-judgement
select *,
   case
    when x+y > z and x+z > y and y+z > x then 'Yes'
    else 'No'
    end as triangle
from Triangle ;

-- https://leetcode.com/problems/product-price-at-a-given-date


 















