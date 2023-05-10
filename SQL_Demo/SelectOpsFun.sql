Use Northwind
Select * from Customers
Select CustomerId, ContactName, City, Country from Customers

Select * from Customers where CustomerID='BERGS'
Select * from Customers where City='London'

Select CustomerId, ContactName, City, Country from Customers where ContactTitle='Owner'

Select * from Products where UnitPrice>35

Select * from Customers where City='London' or City='Madrid'

Select * from Customers where Country='Brazil' and City='Sao Paulo'

Select * from Customers where Region is not null

Select * from Customers where not Region is null

Select * from Customers where not Country='Mexico'

Select ProductID, ProductName, QuantityPerUnit, UnitPrice, UnitsInStock, UnitPrice*UnitsInStock as Amount, (UnitPrice*UnitsInStock)*10/100
as Discount from Products

Select * from Products where ProductID not between 11 and 20

Select * from Customers where City='London' or City='Madrid' or City='Paris' or City='Berlin'

Select * from Customers where City in ('London', 'Madrid', 'Paris', 'Berlin')

Select * from Customers where ContactName like 'A%'

Select * from Customers where ContactName like 'A_____________'

Select * from Customers where ContactName like '[^ASJ]%'

Select * from Customers where ContactName like 'A%S'

Select top 10 * from Customers

Select * from Customers Order By ContactName Desc

Select * from Customers

Select * from Customers Order By CustomerID offset 10 rows fetch next 5 rows only

Select distinct ContactTitle from Customers
-------------------------------------------------------------------------------------

Select * from Products
---AGGREAGATE FUNCTIONS - SUM,AVG,COUNT,MIN,MAX....---
Select SUM (UnitPrice) from Products
Select AVG (UnitPrice) from Products
Select COUNT (UnitPrice) from Products
Select COUNT(*) from Products
Select MIN (UnitPrice) from Products
Select MAX (UnitPrice) from Products

---STRING FUNCTIONS - CHAR(for getting a charcater based on ASCII value),LEFT(),LEN(),REVERSE()....---
Select CHAR(66)
Select LEFT('RICHARD',4)
Select LEN('Welcome')
Select REVERSE('Good Morning')

Select * from Customers
Select LEFT (ContactName,4) from Customers
Select REVERSE (ContactName) from Customers

----DATE FUNCTIONS - GETDATE,DATEADD,DAY,MONTH,YEAR,DATEDIFF....---
Select GETDATE()

Select DATEADD(mm,3,'2023-05-09')
Select DATEADD(dd,3,'2023-05-09')
Select DATEADD(yyyy,3,'2023-05-09')

Select DAY('2023-05-09')
Select MONTH('2023-05-09')
Select YEAR('2023-05-09')

Select * from Orders
Select OrderDate,DATEADD(dd,3,OrderDate) as DeliveryDate from Orders

Select DATEDIFF (dd,'2023-01-09','2023-05-09')

---MATH FUNCTIONS - POWER,ROUND,CEILING,FLOOR....---
Select POWER(2,3)
Select ROUND(3.1122,1)
Select ROUND(3.9999,1)
Select CEILING(4.1)
Select FLOOR(4.9)

----GROUP BY CLAUSE---
Select SupplierID, SUM(UnitsInStock) as TotalStock from Products group by SupplierID
---HAVING CLAUSE - Used Instead of Where in Group By Clause ---
Select SupplierID, SUM(UnitsInStock) as TotalStock from Products group by SupplierID having SupplierID=10

---JOINS OPERATIONs---
/* TYPES OS JOINS-
1.INNER JOIN-joins tables based on a condition.
2.OUTER JOIN 
			-LEFT OUTER JOIN-Get all Data from Left and only matching from Right.
			-RIGHT OUTER JOIN-Get all Data from Right and only matching from Left.
			-FULL OUTER JOIN-All data from both sides.
3.SELF JOIN-Within a table joins.(Single Table)
*/
Select * from Customers
Select * from Orders
---INNER JOIN
Select Customers.CustomerID,ContactName,ContactTitle,Country,OrderID,OrderDate,ShippedDate,ShipName from Customers inner join Orders
on Customers.CustomerID=Orders.CustomerID	
---LEFT OUTER JOIN
Select Customers.CustomerID,ContactName,ContactTitle,Country,OrderID,OrderDate,ShippedDate,ShipName from Customers Left outer join Orders
on Customers.CustomerID=Orders.CustomerID
---RIGHT OUTER JOIN
Select Customers.CustomerID,ContactName,ContactTitle,Country,OrderID,OrderDate,ShippedDate,ShipName from Customers Right outer join Orders
on Customers.CustomerID=Orders.CustomerID
---FULL OUTER JOIN
Select Customers.CustomerID,ContactName,ContactTitle,Country,OrderID,OrderDate,ShippedDate,ShipName from Customers full outer join Orders
on Customers.CustomerID=Orders.CustomerID
---SELF JOIN
Create Table Emp
(
EmpId varchar(10),
EmpName varchar(20),
MgrId varchar(10)
)
Insert into Emp values
('E001','John','M002'),('E002','James','M003'),('E003','Steve','M001'),('M001','Peter','NULL'),('M002','Maria','NULL'),('M003','Bob','NULL')
Select * from Emp
Select Emp.EmpName, Emp2.EmpName as ReportsTo from Emp inner join Emp as Emp2 on Emp.MgrId = Emp2.EmpId

--------------------SubQuerires-----------------
Create Table Students
(
RollNo int,
StudentName varchar(20),
Marks int
)
Insert into Students Values
(1,'John',78),(2,'James',82),(3,'Steve',80),(4,'Peter',91),(5,'Maria',95),(6,'Vishal',65),(7,'Rohit',92),(8,'Vijay',89),(9,'Ajay',85),(10,'Rohit',91)

Select * from Students

Select StudentName from Students where Marks = (Select Max(Marks) from Students)

Select * from Students where Marks = (Select Max(Marks) from Students where Marks<(Select Max(Marks) from Students))

Select * from Students order by Marks Desc

Select * from Students order by Marks Desc offset 1 row fetch next 1 row only


---VIEWS
Select * from Products
Select ProductId, ProductName, UnitPrice, UnitsInStock from Products
--Creating View
Create View ProductView
as
Select ProductId, ProductName, UnitPrice, UnitsInStock from Products
Select * from ProductView
--Altering View
Alter View ProductView
as
Select ProductId, ProductName, UnitPrice, UnitsInStock, UnitPrice*UnitsInStock as Amount, (UnitPrice*UnitsInStock)*10/100 as Discount from Products
Select * from ProductView

----Functions----
/*User Defined Functions(UDF)
	1.Scaler:-Accepts Single Parameter and returns a single data value
	2.Table-valued:-Accepts Multiple Parameters and Returns a Table as Output
*/
-- Scalar function returns single value
Create Function Cube(@num int)
returns int
as
begin
	RETURN POWER(@num, 3)
end
Select dbo.Cube(11)

-- Table Valued Function (Inline)
Create Function GetCustomer(@city varchar(10))
returns table
as
return (Select * from Customers where City=@city)
Select * from GetCustomer('Paris')

-- Stored Procedures-Execution is fast due to pre compiled query.
Create Proc ShowCustomers
as
Select * from Customers
Exec ShowCustomers
-----
Create Procedure SearchCustomer
@customerid varchar(5)
as
Select * from Customers where CustomerID=@customerid
Exec SearchCustomer 'BERGS'
-----
Select * from Students

Create Proc AddNewStudent
@rollno int,
@name varchar(10),
@marks int
as
insert into Students values(@rollno, @name, @marks)
Exec AddNewStudent 12, 'Jessabel', 98

Alter Proc AddNewStudent
@rollno int,
@name varchar(10),
@marks int
as
begin
if(@marks>100)
begin
	print 'Marks cannot be greater than 100'
	rollback tran
end
else
	begin
		insert into Students values(@rollno, @name, @marks)
	end
end

Exec AddNewStudent 13, 'Mahi', 100