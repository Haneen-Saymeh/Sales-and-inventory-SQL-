

---table 1 sales
select *
from Sales 

---table 2 products
select *
from Products

---table 3 inventory
select * 
from Inventory


---Showing product names
select ProductName, count(distinct(ProductName)) 
from Products
group by ProductName


-----total cost for each product type and total count of product type
select ProductName, ProductCost, sum(ProductCost) over (partition by ProductName) as TotalProductCost
, count(ProductName) over (Partition by ProductName) as ProductCount
from Products
order by 1


------exploring suppliers and their count
select Supplier, count(Supplier) as supplierscount
from Products 
group by  Supplier
order by 2 desc


-----which suppliers and products with prouct cost more than 10
select Supplier,ProductCost, ProductName, count(Supplier)
from Products 
where ProductCost > 10
group by  Supplier, ProductCost, ProductName


-- unit revenue (unit price* total sold) 
select Year, ProductId, (UnitPrice * TotalSold) as UnitRevenue
from Sales
order by UnitRevenue desc


-------Subqueries (total sold for each product id vs average sold)
select ProductId, TotalSold, (select cast (avg(TotalSold) as int) from Sales) as AvgSold
from Sales 


----Total sold units per year
select Year, sum(totalSold) as TotalSoldYearly 
from Sales
group by Year 
order by 2 desc



--join Sales and Products tables
select *
from Sales 
join Products 
on Sales.ProductId = Products.ProductId


--calulate unit profit(price-cost) for each unit
select Year, ProductName, UnitPrice - ProductCost as UnitProfit
from Sales 
join Products 
on Sales.ProductId = Products.ProductId
order by 3 desc



---Total revenue  (price*quanitiy sold - cost *quantity sold) 
Select ProductName, Year, Cast((UnitPrice*TotalSold) - (ProductCost*TotalSold) as int) as TotalRevenue
from Sales 
join Products 
on Sales.ProductId = Products.ProductId 
order by 3 desc



--most sold products (by names)
Select ProductName, sum(TotalSold) as ProductTotalSold
from Sales 
join Products 
on Sales.ProductId = Products.ProductId 
group by ProductName,TotalSold 
order by 2 desc



--- inventory quantity availabe 
select ProductId, StoreName, sum(QuantityAvailable) 
from Inventory 
group by  ProductId, StoreName
order by 3 desc



----joining three tables, sales, inventory and products 
select * 
from Sales 
join Products 
on Sales.ProductId = Products.ProductId
join inventory 
on Sales.ProductId = Inventory.ProductId



---Sales and inventory information related to Target
select TotalSold, ProductName, Address, count(ProductName) over (Partition by ProductName) as TotalProductCount
, sum (TotalSold) over (Partition by ProductName) as TotalSoldforProductType
from Sales 
join Products 
on Sales.ProductId = Products.ProductId
join inventory 
on Sales.ProductId = Inventory.ProductId
where StoreName = 'Target' 
order by 2



---total solds units at each store 
select StoreName, sum(TotalSold) as StoresTotalSold
from Sales 
join Products 
on Sales.ProductId = Products.ProductId
join inventory 
on Sales.ProductId = Inventory.ProductId
group by StoreName
order by 2 desc 



----quantity left at each store 
select StoreName, sum(QuantityAvailable) as TotalQuantityAvailabeAtStore
from Inventory 
group by StoreName
order by 2 desc 


----Inventroy information of stores with 'mart' letters in their names 
select ProductName,  Address, StoreName , max(QuantityAvailable) over (partition by StoreName) as MaxQuantityAvailabe
from Sales 
join Products 
on Sales.ProductId = Products.ProductId
join inventory 
on Sales.ProductId = Inventory.ProductId
where StoreName like '%mart'
order by 4 desc

 








