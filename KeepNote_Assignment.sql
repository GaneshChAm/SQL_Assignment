Create Database KeepNote
Use KeepNote

-----------User Records Table------------
Create Table UserRecords
(
UserRecord_id int Primary Key,
UserRecord_Name varchar(20),
UserRecord_Date varchar(10),
UserRecord_Password varchar(20),
UserRecord_Mobile varchar(10)
)
Insert into UserRecords Values
(112233,'Maya','2019-01-02','Maya1214',8012345679),
(112244,'Nair','2019-01-11','Welcome',9023778467)

-----------Note Records Table------------
Create Table NoteRecords
(
Note_Id int primary key,
Note_Title varchar(100),
Note_Content varchar(100),
Note_Status varchar(20),
Note_Date varchar(10),
NoteUser_Id int references UserRecords(UserRecord_id)
)
Insert into NoteRecords Values
(1,'Today Tasks','1.Check emails and reply to them. 2.Start the pro...','InProgress','2019-01-21',112233),
(2,'Training to plan','1.Application related. 2.Technical related','Yet to Start','2019-01-31',112244),
(3,'Things to have today','1.Fruits. 2.More Water','In Progress','2019-01-25',112244)


-----------Category Records Table-------------
Create Table CategoryRecords
(
Category_id int primary key,
Category_name varchar(10),
Category_descr varchar(30),
Category_date varchar(10),
Category_creator int references UserRecords(UserRecord_id)
)
Insert into CategoryRecords Values
(1,'Official','Office related notes','2019-01-21',112233),
(2,'Diet','Health related notes','2019-01-24',112244)


-----------Remainder Records Table------------
Create Table RemainderRecords
(
Remainder_id int primary key,
Remainder_name varchar(20),
Remainder_descr varchar(100),
Remainder_type varchar(50),
Remainder_date varchar(10),
Remainder_creator int references UserRecords(UserRecord_id)
)
Insert into RemainderRecords Values
(1,'KT remainder','Session on technical queries','Office Remainders','2019-02-12',112233),
(2,'Personal remainder','Pick children','Personal Remainders','2019-02-14',112244)


----------NoteCategory Table------------
Create Table NoteCategory
(
NoteCategory_id int primary key,
Note_id int references NoteRecords(Note_Id),
Category_id int references CategoryRecords(Category_id)
)
Insert into NoteCategory values
(1,1,1),(2,2,1),(3,3,2)


----------NoteRemainder Table------------
Create Table NoteRemainder
(
NoteRemainder_id int Primary Key,
Note_id int references NoteRecords(Note_Id),
Remainder_id int references RemainderRecords(Remainder_id)
)
Insert into NoteRemainder values
(1,3,2),(2,2,1)
------------------------------------------

Select * from UserRecords
Select * from NoteRecords
Select * from CategoryRecords
Select * from RemainderRecords
Select * from NoteCategory
Select * from NoteRemainder

/*
Write the queries to carry out the below listed operations:
1.Fetch the row from User table with Id=112233 and Password=’Maya1214’.
2.Fetch all the rows from Note table with note_creation_date=’01/31/2019’.
3.Fetch all the Categories created after ‘01/22/2019’.
4.Fetch all category details which belongs to note with note id=1.
5.Fetch all the Notes from the Note table with userId=112244.
6.Fetch all the Notes from the Note table for category_id=1.
7.Fetch all the reminder details for note id=2.
8.Write a query to change the note_status to ‘Completed’ with note Id=3.
9.Write a query to set a reminder of type ‘Personal Reminders’ for Note with note id=1. [Find reminder id based upon reminder_type]
10.Write a query to remove all reminders from Note with note_id=2.
*/

--1.Fetch the row from User table with Id=112233 and Password=’Maya1214’.
Select * from UserRecords
Select * from UserRecords where UserRecord_id=112233 and UserRecord_Password='Maya1214'

--2.Fetch all the rows from Note table with note_creation_date=’01/31/2019’.
Select * from NoteRecords
Select * from NoteRecords where Note_Date='2019-01-31'

--3.Fetch all the Categories created after ‘01/22/2019’.
Select * from CategoryRecords
Select * from CategoryRecords where Category_date>'2019-01-22'

--4.Fetch all category details which belongs to note with note id=1.
Select * from CategoryRecords
Select * from CategoryRecords where Category_id=1

--5.Fetch all the Notes from the Note table with userId=112244.
Select * from NoteRecords
Select * from NoteRecords where NoteUser_Id=112244

--6.Fetch all the Notes from the Note table for category_id=1.
Select * from NoteRecords
Select * from CategoryRecords
Select Category_creator from CategoryRecords where Category_id=1
Select * from NoteRecords where NoteUser_Id= (Select Category_creator from CategoryRecords where Category_id=1)

--7.Fetch all the reminder details for note id=2.
Select * from RemainderRecords
Select * from NoteRecords
Select NoteUser_Id from NoteRecords where Note_Id=2
Select * from RemainderRecords where Remainder_creator=(Select NoteUser_Id from NoteRecords where Note_Id=2)

--8.Write a query to change the note_status to ‘Completed’ with note Id=3.
Select * from NoteRecords
Update NoteRecords Set Note_Status='Completed' Where Note_Id=3

--9.Write a query to set a reminder of type ‘Personal Reminders’ for Note with note id=1. [Find reminder id based upon reminder_type]
Select * from RemainderRecords
Select * from NoteRecords
Select NoteUser_Id from NoteRecords where Note_Id=1
Update RemainderRecords Set Remainder_type='Personal Reminders' Where Remainder_creator=(Select NoteUser_Id from NoteRecords where Note_Id=1)

--10.Write a query to remove all reminders from Note with note_id=2.
Select * from RemainderRecords
Select * from NoteRecords
Select NoteUser_Id from NoteRecords where Note_Id=2
Delete from RemainderRecords Where Remainder_creator=(Select NoteUser_Id from NoteRecords where Note_Id=2)

Delete from NoteRemainder where note_id = 2
Select * from NoteRemainder