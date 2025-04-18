create database Hotel

use Hotel

create table Employees
(
Id int primary key identity,
FirstName varchar(100) not null,
LastName varchar(100) not null,
Title varchar(200) not null,
Notes text
)

create table Customers 
(
AccountNumber varchar(20) primary key not null,
FirstName varchar(100) not null,
LastName varchar(100) not null,
PhoneNumber varchar(10) not null,
EmergencyName varchar(100) not null,
EmergencyNumber varchar(10) not null,
Notes text
)

create table RoomStatus
(
RoomStatus bit not null,
Notes text
) 

create table RoomTypes
(
RoomType varchar(20) not null,
Notes text
)

create table BedTypes
(
BedType varchar(20) not null,
Note text
)

create table Rooms
(
RoomNumber int primary key not null,
RoomType varchar(20) not null,
BedType varchar(20) not null,
Rate decimal(5,2) not null,
RoomStatus bit not null,
Notes text
)

create table Payments (
Id int primary key not null,
EmployeeId int foreign key (EmployeeId) references Employees(Id) not null,
PaymentDate datetime2 not null,
AccountNumber varchar(10) not null,
FirstDateOccupied datetime2 not null,
LastDateOccupied datetime2 not null,
TotalDays int not null, 
AmountCharged decimal(5,2) not null,
TaxRate decimal(5,2) not null,
TaxAmount decimal(5,2) not null,
PaymentTotal decimal(5,2) not null ,
Notes text
)

create table Occupancies 
(
Id int primary key identity not null,
EmployeeId int foreign key (EmployeeId) references Employees(Id) not null, 
DateOccupied datetime2 not null,
AccountNumber varchar(10) not null,
RoomNumber int not null,
RateApplied decimal(5,2),
PhoneCharge decimal(5,2), 
Notes text
)


insert into Employees(FirstName,LastName,Title) 
values
('Ivan','Ivanov','Manager'),
('Petur','Petrov','Cleaner'),
('Mitko','Dimitrov','Receptionist')

insert into Customers(AccountNumber,FirstName,LastName,PhoneNumber,EmergencyName,EmergencyNumber) 
values
('25161165','Ivan','Ivanov','039845212','Pesho','0555698444'),
('36994156','Petur','Petrov','026999955','Gosho','0477778955'),
('99877899','Mitko','Dimitrov','06949484','Tosho','055588866')

insert into RoomStatus(RoomStatus)
values (0),(1),(1)

insert into RoomTypes(RoomType) values ('Appartment'),('Single'),('Family')

insert into BedTypes(BedType) values('Twin'),('Queen'),('King')

insert into Rooms(RoomNumber,RoomType,BedType,Rate,RoomStatus)
values
(101,'Appartment','King',100,0),
(102,'Single','Queen',50,1),
(103,'Family','King',150,1)

insert into Payments(Id,EmployeeId,PaymentDate,AccountNumber,FirstDateOccupied,LastDateOccupied,TotalDays,AmountCharged,TaxRate,TaxAmount,PaymentTotal)
values (123466,1,'2024-06-05','11333366','2024-05-26','2024-06-05',10,100,5.3,5.6,150),
(6665558,1,'2024-05-05','99988877','2024-04-26','2024-05-05',9,200,9.6,5.6,269),
(887744,1,'2024-07-05','3344885','2024-06-26','2024-07-07',11,500,4.5,5.6,100)

insert into Occupancies(EmployeeId,DateOccupied,AccountNumber,RoomNumber)
values(2,'2024-05-06','123456',102),(1,'2024-12-06','998875',101),(3,'2024-10-16','8874533',103)