--Creating a Database
Create Database TestDB
--Using a Database
Use TestDB
--Creating a Table
Create Table Customers
(
--Creating a Primary Key
CustomerId int primary key, 
CustomerName varchar(20),
Email varchar(20),
City varchar(10),
Age int
)
--Deleting a Table
--Drop Table Customers

Create Table Orders
(
OrderId int primary key,
OrderDate datetime,
Amount int,
--Creating a Foreign Key.
CustomerId int references Customers(CustomerId)
)

Create Table Products
(
ProductId int,
ProductName varchar(50),
Brand varchar(20),
Quantity int,
Price int
)
-- Adding new column in products table
Alter Table Products add ProductDescription varchar(50)
-- Removing column from products table
Alter Table Products drop column ProductDescription

---- Constraints
-- Check Constraint to restrict the value of Quantity column
Alter Table Products add constraint check_qty check(Quantity>0)
-- Removing check constraint from products table
Alter Table Products drop constraint check_qty

-- Adding primary key in existing table
Alter Table Products alter column ProductId int not null
Alter Table Products add constraint pk1 primary key(ProductId)

-- Dropping foriegn key from Orders table
Alter Table Orders drop constraint [FK__Orders__Customer__5629CD9C]
-- Adding foriegn key on Orders table using alter statement
Alter Table Orders add constraint fk1 foreign key(CustomerId) references Customers(CustomerId)

----------------------------SQL Parts----------------------
--1.DDL-Data Definition Language - Create,Alter,Drop.
--2.DML-Data Manipulation Language - Insert,Update,Delete.
--3.DCL-Data Control Language - Grant,Revoke.
--4.DQL-Data Query Language - select.
-----------------------------------------------------------
--------DML Statements--------
--Insert 
Insert into Customers Values (1,'john','john@gmail.com','NewDelhi',25)
Insert into Customers (CustomerId,Email,Age,City,CustomerName) Values (2,'James@gmail.com',26,'Kolkata','James')
--Paritial Insertion
Insert into Customers  (CustomerId,CustomerName,Email,Age) Values (3,'Peter','Peter@gmail.com',27)
--Inserting Multiple rows
insert into Customers Values (4,'Maria','Maria@gmail.com','Chennai',28),(5,'Steve','Steve@gmail.com','Mumbai',29)

--Update 
Update Customers set City='Pune' Where CustomerId=3
Update Customers set CustomerName='John',Email='John@gmail.com' Where CustomerId=1

--Delete
Delete from Customers Where CustomerId=3

--To Retrive data Select is used and * for the all Columns.
Select * from Customers
------------------------------------------------------------------