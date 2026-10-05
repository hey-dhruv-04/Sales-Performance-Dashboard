use AdventureWorks2022 
go
--- Question 1 : How did total sales revenue change year by year?

select year(OrderDate) as Year, sum(TotalDue) as total_rev from Sales.SalesOrderHeader group by Year(orderDate) order by total_rev desc;

---2013 generated the highest total revenue of approx. 48.97 million.
---Revenue increased from 2011 to 2013, but declined significantly in 2014

---Question 2 : Which year had the highest number of orders?

Select Year(OrderDate) as Year, count(SalesOrderID) as No_of_Orders from Sales.SalesOrderHeader Group by Year(OrderDate) order by No_of_Orders desc;

--- 2013 recorded the highest number of orders with 14182 orders.
--- Order vloume increased substantially from  2011 through 2013.
--- followed by a decline in 2014.

---Question 3 : What was the average order value for each year?

Select Year(OrderDate) as Year, avg(TotalDue) as Avg_rev from Sales.SalesOrderHeader group by Year(OrderDate) order by Avg_rev desc;

-- Average order value was highest in 2012 at approximately 9,623.
-- Average order value declined substantially in 2013 and declined further in 2014.
-- Therefore, although 2013 had the highest order volume and total revenue,
-- the average value of each order was considerably lower

--Question 4 : Which customers generated the highest total revenue?

Select Top 10 CustomerID, sum(TotalDue) as total_rev from Sales.SalesOrderHeader group by CustomerID order by total_rev desc

-- Customer 29818 generated the highest total revenue at approximately 989,184.
-- The top 10 customers each generated more than 820,000 in total revenue.

--Question 5 : Which customers placed the highest number of orders?

Select Top 10 CustomerID, count(SalesOrderID) as No_of_orders from Sales.SalesOrderHeader group by CustomerID order by No_of_orders desc

-- Customers 11091 and 11176 placed the highest number of orders, with 28 orders each.
-- The remaining customers in the top 10 placed 27 orders each.

--Question 6 : Which 10 products generated the highest total sales revenue?

Select Top 10 ProductID, sum(LineTotal) as total_sales_rev from Sales.SalesOrderDetail group by ProductID order by total_sales_rev desc

-- Product 782 generated the highest total sales revenue at approximately 4.40 million.
-- Product 783 was the second-highest at approximately 4.01 million.
-- The top 10 products generated between approximately 1.85 million and 4.40 million in sales revenue.

--Question 7 : What are the names of the top 10 products by total sales revenue?

Select Top 10 p.ProductID , p.Name, sum(LineTotal) as total_sales_rev  from Sales.SalesOrderDetail S inner join Production.Product P on S.ProductID = P.ProductID
group by p.ProductID,p.Name order by total_sales_rev desc

-- Mountain-200 Black, 38 generated the highest total sales revenue at approximately 4.40 million.
-- The top 6 products by revenue are Mountain-200 variants,
-- while Road-250 and Road-150 variants also appear in the top 10.

--Question 8 : Which 10 products had the highest total quantity sold?

Select Top 10 p.ProductID, p.name, sum(OrderQty) as Total_quatity_sold  from Sales.SalesOrderDetail S inner join Production.Product P on S.ProductID = P.ProductID
group by p.ProductID,p.Name order by Total_quatity_sold desc

-- AWC Logo Cap had the highest total quantity sold, with 8,311 units.
-- Water Bottle - 30 oz. ranked second with 6,815 units.
-- Several sports accessories and apparel products appear among the top 10 products by quantity sold.

--Question 9 : How many customers have never placed an order?

Select count(c.CustomerID) as order_not_placed from Sales.Customer c left join Sales.SalesOrderHeader  s on s.CustomerID = c.CustomerID
where s.SalesOrderID is null 

-- 701 customers have never placed an order.
-- This group may represent an opportunity for targeted marketing
-- and customer acquisition-to-activation efforts.

--Question 10 : Which sales territories generated the highest total revenue?

Select Top 10 T.name, sum(s.TotalDue) as Total_sales from Sales.SalesOrderHeader s inner join Sales.SalesTerritory t on s.TerritoryID = t.TerritoryID
group by T.Name order by Total_sales Desc

-- Southwest generated the highest total revenue at 27,150,594.5893,
-- followed by Canada and Northwest.
-- Germany had the lowest revenue among the top 10 territories at 5,479,819.5755.

--Question 11 : Which sales territories have the highest number of orders?

Select Top 10 T.name, count(s.SalesOrderID) as Total_Orders from Sales.SalesOrderHeader s inner join Sales.SalesTerritory t on s.TerritoryID = t.TerritoryID
group by T.Name order by Total_Orders Desc

-- Australia recorded the highest order volume with 6,843 orders,
-- followed by Southwest with 6,224 orders.
-- Australia leads in order volume, while northwest generated the highest total revenue.

--Question 12 : Which salespersons generated the highest total revenue?

Select Top 10 s.SalesPersonID, sum(s.TotalDue) as Total_rev  from Sales.SalesOrderHeader s inner join Sales.SalesPerson p on s.SalesPersonID = p.BusinessEntityID
group by s.SalesPersonID order by Total_rev desc

-- Salesperson 276 generated the highest total revenue at 11,695,019.0605,
-- followed by Salesperson 277 at 11,342,385.8968.
-- The top 3 salespersons each generated over 10 million in revenue,
-- indicating that a substantial share of sales came from these leading performers.

--Question 13 : Which salespersons have the highest number of orders?

Select Top 10 s.SalesPersonID, count(s.SalesOrderID) as Total_order  from Sales.SalesOrderHeader s inner join Sales.SalesPerson p on s.SalesPersonID = p.BusinessEntityID
group by s.SalesPersonID order by Total_order desc

-- Salesperson 277 handled the highest number of orders (473),
-- followed by Salesperson 275 (450) and Salesperson 279 (429).
-- Salesperson 277 leads in order volume, while Salesperson 276
-- generated the highest total revenue in Q12.

--Question 14 : What is the monthly sales revenue trend?

Select  YEAR(OrderDate) as Year_rev,MONTH(OrderDate) as Month_rev, sum(TotalDue) as total_rev  from Sales.SalesOrderHeader
group by year(OrderDate),MONTH(OrderDate) order by Year_rev asc,Month_rev asc

-- Monthly sales revenue fluctuated throughout the observed period.
-- March 2014 recorded the highest monthly revenue at 8,097,036.3137.
-- June 2014 revenue was significantly lower at 54,151.4785;
-- however, 2014 data is available only through June, so the year
-- should not be treated as a complete annual period.

--Question 15 : What is the average revenue per order for each sales territory?

Select t.Name, AVG(s.TotalDue) as  avg_rev from Sales.SalesOrderHeader s inner join Sales.SalesTerritory t on s.TerritoryID = t.TerritoryID
group by t.Name order by avg_rev desc

-- Central recorded the highest average order revenue at 23,151.4266,
-- followed by Northeast at 22,216.5046.
-- Australia had the lowest average order revenue at 1,726.4907.
-- Central, Northeast, and Southeast have substantially higher
-- average order values than the other territories.

--Question 16 : Which product categories generated the highest total revenue?

Select PR.Name, sum(s.LineTotal) as total_rev   from Sales.SalesOrderDetail s inner join Production.Product p on s.ProductID = p.ProductID 
inner join Production.ProductSubcategory pc on pc.ProductSubcategoryID = p.ProductSubcategoryID inner join Production.ProductCategory PR on PR.ProductCategoryID = pc.ProductCategoryID
group by PR.Name order by total_rev desc

-- Bikes generated the highest revenue at 94,651,172.704731,
-- substantially exceeding all other product categories.
-- Components ranked second with 11,802,593.286430 in revenue.
-- Bikes are the dominant revenue-generating product category.

--Question 17 : What is the total revenue generated across all sales?

Select sum(totalDue) as Total_rev from Sales.SalesOrderHeader

--Question 18 : How many unique orders were placed across all sales?

Select count(SalesOrderID) as total_orders from Sales.SalesOrderHeader

--Question 19 : What is the average revenue generated per order?

Select sum(TotalDue)/count(SalesOrderID) as avg_per_order  from Sales.SalesOrderHeader

--Question 20 : How many unique customers have placed at least one order?

Select count( Distinct customerID) as Unique_custmoers from Sales.SalesOrderHeader

--Question 21 : How did total revenue change from year to year?

Select year(OrderDate) as year, sum(TotalDue) as total_rev from Sales.SalesOrderHeader group by YEAR(OrderDate) order by year

-- Revenue increased from 14,155,699.525 in 2011 to a peak of
-- 48,965,887.9632 in 2013, before declining to 22,419,498.3157 in 2014.

--Question 22 : How did the number of orders change from year to year?

Select YEAR(OrderDate) as Year, count(SalesOrderID) as total_order from Sales.SalesOrderHeader group by year(OrderDate) order by Year





