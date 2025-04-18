create database CarRental
use CarRental

create table Categories
(
Id int primary key identity,
CategoryName varchar(200) not null,
DailyRate decimal(10,2) not null,
WeeklyRate decimal(10,2) not null,
MonthlyRate decimal(10,2) not null, 
WeekendRate decimal(10,2) not null
)
create table Cars
(
Id int primary key identity,
PlateNumber varchar(10) not null,
Manufacturer varchar(100) not null,
Model varchar(100) not null,
CarYear varchar(4) not null,
CategoryId int foreign key references Categories(Id) not null,
Doors varchar(100), 
Picture varbinary(max),
Condition varchar(200) not null,
Available bit not null
)
create table Employees
(
Id int primary key identity,
FirstName varchar(200) not null,
LastName varchar(200) not null,
Title varchar(200) not null,
Notes text
)

create table Customers 
(
Id int primary key identity,
DriverLicenceNumber varchar(10) not null,
FullName varchar(max) not null,
[Address] varchar(max) ,
City varchar(100),
ZIPCode varchar(5),
Notes text
)

create table RentalOrders
(Id int primary key identity,
EmployeeId int foreign key references Employees(Id) not null,
CustomerId int foreign key references Customers(Id) not null,
CarId int foreign key references Cars(Id) not null,
TankLevel decimal(5,2) not null,
KilometrageStart decimal(10,2) not null,
KilometrageEnd decimal(10,2) not null,
TotalKilometrage decimal(10,2) not null,
StartDate datetime2 not null,
EndDate datetime2 not null,
TotalDays int not null,
RateApplied varchar(20) not null,
TaxRate decimal(5,2) not null,
OrderStatus varchar(20) not null,
Notes text
)

insert into Categories
values
('Category1',5.50,12,50,14),
('Category2',4,10,45,10),
('Category3',6,14,60,20)

insert into Cars
values
('EH 1565 BM','Toyota','Silvia','2014',1,null,null,'Excelent',1),
('SK 6987 HB','Mitsubishi','Sushi','2021',2,null,null,'Great',0),
('UM 7788 KM','Honda','Civic','2020',3,null,null,'Good',1)

insert into Employees(FirstName,LastName,Title)
values
('Pesho','Georgiev','manager'),
('Gosho','Petrov','salesperson'),
('Mitko','Dimitrov','mechanic')

insert into Customers(DriverLicenceNumber,FullName)
values
('123456789','Bob Thebuilder'),
('987654321','Pesho Peshev'),
('059768423','Ivan Ivanov')

insert into RentalOrders(EmployeeId,CustomerId,CarId,TankLevel,KilometrageStart,KilometrageEnd,TotalKilometrage,StartDate,EndDate,TotalDays,RateApplied,TaxRate,OrderStatus)
values
(1,1,1,10.5,10000,10500,500,'2024-02-02','2024-02-12',10,'Weekly',2.30,'Delivered'),
(2,2,2,50,1000,1050,50,'2024-05-02','2024-05-05',3,'Weekend',3,'Delivering'),
(3,3,3,25.36,29000,29357,357,'2024-06-06','2024-07-06',30,'Monthly',5,'Returned')
