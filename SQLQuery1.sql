CREATE TABLE Minions
(
 Id int primary key not null,
 [Name] varchar(50),
 Age int
)
USE Minions
GO
CREATE TABLE Towns
(
 Id int primary key not null,
 [Name] varchar(50)
)
alter table Minions
add TownId int

select * from Minions
select * from Towns

alter table Minions
add constraint fk_townId foreign key(TownId) REFERENCES Towns(Id)

INSERT INTO Towns
			VALUES
			(1,'Sofia'),
			(2,'Plovdiv'),
			(3,'Varna')

INSERT INTO Minions
			VALUES
			(1,'Kevin',22,1),
			(2,'Bob',15,3),
			(3,'Steward',null,2)


TRUNCATE TABLE Minions

DROP TABLE Minions
DROP TABLE Towns


CREATE TABLE People
(
 Id INT PRIMARY KEY	IDENTITY ,
 [Name] NVARCHAR(200) NOT NULL,
 Picture VARBINARY(MAX),
 Height	DECIMAL(3,2),
 [Weight] DECIMAL(5,2),
 Gender CHAR(1) NOT NULL,
	CHECK (Gender in('m','f')),
 Birthdate DATETIME2 NOT NULL,
 Biography VARCHAR(max)
)

INSERT INTO People([Name],Gender,Birthdate)
		VALUES
		('Pesho','m','2000-06-13'),
		('Maria','f','2005-08-17'),
		('Mitko','m','2001-02-19'),
		('Gosho','m','2002-12-25'),
		('Nikol','f','2005-07-02')

SELECT * FROM People
CREATE TABLE Users
(
 Id BIGINT PRIMARY KEY IDENTITY,
 Username VARCHAR(30) NOT NULL,
 [Password]	VARCHAR(26) NOT NULL,
 ProfilePicture VARBINARY(MAX),
 LastLoginTime DATETIME2,
 IsDeleted BIT
)
INSERT INTO Users(Username,[Password])
			VALUES
			('ananasko','51584616515'),
			('macinkalol','695415586525'),
			('woofwoof','33256699'),
			('azsummeow123','55555555'),
			('korechi69','25644494949')

ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC079D4E5B37

ALTER TABLE Users
ADD CONSTRAINT PK_ID_Username PRIMARY KEY(Id,Username)

ALTER TABLE Users
ADD CONSTRAINT CHK_PassLenght CHECK(LEN([Password])>=5)

ALTER TABLE Users
ADD CONSTRAINT DF_TIME DEFAULT GETDATE() FOR LastLoginTime

ALTER TABLE Users
DROP CONSTRAINT PK_ID_Username

ALTER TABLE Users
ADD CONSTRAINT PK_ID PRIMARY KEY(Id)

ALTER TABLE Users
ADD CONSTRAINT CHK_USERNAME CHECK(LEN(Username)>=3)

CREATE DATABASE Movies
USE Movies
DROP DATABASE Minions

CREATE TABLE Directors
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
DirectorName VARCHAR(50) NOT NULL,
Notes TEXT
)
CREATE TABLE Genres
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
GenresName VARCHAR(50) NOT NULL,
Notes TEXT
)
CREATE TABLE Categories
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
CategoryName VARCHAR(50) NOT NULL,
Notes TEXT
)
CREATE TABLE Movies
(
Id INT PRIMARY KEY IDENTITY NOT NULL,
Title VARCHAR(200) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL ,
CopyrightYear DATETIME2 NOT NULL,
[Length] INT,
GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
Rating INT,
NOTES TEXT
)


INSERT INTO Directors(DirectorName)
 VALUES
 ('Moni'),
 ('Toshko'),
 ('Goshko'),
 ('Ivancho'),
 ('Mitko')

 INSERT INTO Genres(GenresName)
 VALUES
 ('Romance'),
 ('Horror'),
 ('Fantasy'),
 ('Sci-fi'),
 ('Historical')
  

INSERT INTO Categories(CategoryName)
 VALUES
 ('Category1'),
 ('Category2'),
 ('Category3'),
 ('Category4'),
 ('Category5')

 INSERT INTO Movies(Title,DirectorId,CopyrightYear,GenreId,CategoryId)
 VALUES
 ('Title1',2,'2019-12-06',1,5),
 ('Title2',2,'2005-05-06',3,4),
 ('Title3',1,'2015-09-09',4,3),
 ('Title4',4,'2016-03-03',2,2),
 ('Title5',5,'2001-01-01',5,1)