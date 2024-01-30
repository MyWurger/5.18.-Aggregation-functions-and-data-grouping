-- Задача 1. Найти количество товаров, в названии которых есть слово CORE

select count(*) as res
from products
where lower(product_name) like '%core%';


-- Задача 2. Вывести количество заказов, которые клиент 46 оформил в течение каждого года.

select to_char(order_date, 'YYYY') as year, count(*)
from orders
where customer_id = 46
group by year
order by year;


-- Задача 3. Вывести количество заказов, оформленных за каждый месяц 2019 го-да.

select to_char(order_date, 'MM-YYYY') as month_year, count(*)
from orders
where to_char(order_date, 'YYYY')= '2019' 
group by month_year
order by month_year


-- Задача 4. Определить номера товаров, по которым было совершено меньше 10 продаж. Продажа - это строка в таблице Order_items.

select item_id , count(*)
from order_items
group by item_id
having count(*)<10
order by count(*)


-- Задача 5. Для заказов вывести номера товаров в заказе, их количество, общую стоимость каждого товара и всего заказа. Вывести эти данные только для зака-зов, у которых order_id <30.

select order_id, item_id, sum(quantity) as quantity , sum(quantity * unit_price) as items_cost
from order_items
where order_id < 30
GROUP BY ROLLUP (order_id, item_id)
order by order_id


-- Задача 6. Вывести количество заказов, оформленных в течение каждого года и количество заказов, которые оформил каждый клиент. Вывести только те строки, в которых количество заказов >4.

select extract(year from order_date) as years, customer_id, count(*)
from orders
group by grouping sets (years, customer_id)
having count(*)>4
order by years, customer_id;


-- Задача 7. Для каждого отдела вывести суммарную зарплату сотрудников, за весь период их работы.

SELECT department_id, count(employee_id) as num-bers_of_employees,
SUM(salary*extract(month from AGE(current_date, hire_date))::integer + salary*12* extract(year from AGE(current_date, hire_date))::integer)  AS To-tal_Salary_of_department
FROM Employees
where salary is not null
GROUP BY department_id
having department_id is not null
order by department_id;