create database LibraryDb
create table Genres
(
Id int primary key identity,
[Name] nvarchar(30) not null
)

create table Contacts
(
Id int primary key identity,
Email nvarchar(100),
PhoneNumber nvarchar(20),
PostAddress nvarchar(200),
Website nvarchar(50)
)

create table Authors
(
Id int primary key identity,
[Name] nvarchar(100) not null,
ContactId int foreign key references Contacts(Id) not null
)

create table Libraries
(
Id  int primary key identity,
[Name] nvarchar(50) not null,
ContactId int foreign key references Contacts(Id) not null
)

create table Books
(
Id int primary key identity,
Title nvarchar(100) not null,
YearPublished int not null,
ISBN nvarchar(13) unique not null,
AuthorId int foreign key references Authors(Id) not null,
GenreId int foreign key references Genres(Id) not null
)

create table LibrariesBooks
(
LibraryId int foreign key references Libraries(Id),
BookId int foreign key references Books(Id),
constraint PK_Library_Book primary key(LibraryId,BookId)
)

--02
insert into Contacts
	values
	(null,null,null,null),
	(null,null,null,null),
	('stephen.king@example.com'	,'+4445556666',	'15 Fiction Ave, Bangor, ME',	'www.stephenking.com'),
	('suzanne.collins@example.com',	'+7778889999',	'10 Mockingbird Ln, NY, NY',	'www.suzannecollins.com')

insert into Authors
	values
	('George Orwell',	21),
	('Aldous Huxley',	22),
	('Stephen King',	23),
	('Suzanne Collins',	24)

insert into Books
	values
	('1984',	1949,	'9780451524935',	16,	2),
	('Animal Farm',	1945,	'9780451526342',		16,	2),
	('Brave New World',	1932,	'9780060850524',	17,	2),
	('The Doors of Perception',	1954,	'9780060850531',	17,	2),
	('The Shining',	1977,	'9780307743657',	18,	9),
	('It',	1986,	'9781501142970',	18,	9),
	('The Hunger Games',	2008,	'9780439023481',	19,	7),
	('Catching Fire',	2009,	'9780439023498',	19,	7),
	('Mockingjay',	2010,	'9780439023511',19,	7)

insert into LibrariesBooks
	values
	(1,	36),
	(1,	37),
	(2,	38),
	(2,	39),
	(3,	40),
	(3,	41),
	(4,	42),
	(4, 43),
	(5,	44)


--03
begin
declare @AuthorsWithoutWeb table(WebsiteNames varchar(200),Id int)
insert into @AuthorsWithoutWeb(WebsiteNames,id)
select 
'www.'+lower(TRIM(SUBSTRING([Name],1,CHARINDEX(' ',[Name])))+TRIM(SUBSTRING([Name],CHARINDEX(' ',[Name]),LEN([Name]))))+'.com',Authors.ContactId
from Authors
join Contacts on Contacts.Id=Authors.ContactId
where Website is null

update Contacts 
set Website=(select WebsiteNames from @AuthorsWithoutWeb as aw where Contacts.Id=aw.Id)
where Contacts.Id=(select Id from @AuthorsWithoutWeb as aw where Contacts.Id=aw.Id)
end

update Contacts
set Website=null
where Id between 9 and 15
--04
begin

declare @AuthorId int
set @AuthorId=(select Id from Authors where [Name]='Alex Michaelides')

declare @BookId int
set @BookId=(select Id from Books where AuthorId=@AuthorId)

delete from LibrariesBooks
where BookId=@BookId

delete from Books
where AuthorId=@AuthorId

delete from Authors
where [Name]='Alex Michaelides' 
end

--05
select Title as [Book Title],ISBN,YearPublished as YearReleased  from Books
order by YearPublished desc,Title

--06

select Books.Id,Title,ISBN,Genres.[Name] from Books 
join Genres on Genres.Id=Books.GenreId
where Genres.[Name]='Biography' or  Genres.[Name]='Historical Fiction'
order by Genres.[Name],Title

--07
begin
declare @RemoveWhereGenre table (libraryName varchar(100))
insert into @RemoveWhereGenre (libraryName)
select Libraries.[Name]from Libraries
join Contacts on Contacts.Id=Libraries.ContactId
join LibrariesBooks on LibrariesBooks.LibraryId=Libraries.Id
join Books on Books.Id=LibrariesBooks.BookId
join Genres on Books.GenreId=Genres.Id
where Genres.[Name]='Mystery'

select Libraries.[Name],Email from Libraries
join Contacts on Contacts.Id=Libraries.ContactId
join LibrariesBooks on LibrariesBooks.LibraryId=Libraries.Id
join Books on Books.Id=LibrariesBooks.BookId
join Genres on Books.GenreId=Genres.Id
where Libraries.[Name] not in (select * from @RemoveWhereGenre)
group by Libraries.[Name],Email
order by Libraries.[Name]
end
--08
select top 3 
Title,YearPublished,Genres.[Name]
from Books
join Genres on Books.GenreId=Genres.Id
where YearPublished>2000 and Title like '%a%'
or YearPublished<1950 and Genres.[Name] like '%Fantasy%'
order by Title asc,YearPublished desc

--09
select [Name],Email,PostAddress from Authors
join Contacts on Authors.ContactId=Contacts.Id
where PostAddress like '%UK%'
order by Authors.[Name] asc

--10
select Authors.[Name],Title,Libraries.[Name],Contacts.PostAddress from Authors
join Books on Books.AuthorId=Authors.Id
join LibrariesBooks on Books.Id=LibrariesBooks.BookId
join Libraries on Libraries.Id=LibrariesBooks.LibraryId
join Contacts on Libraries.ContactId=Contacts.Id
join Genres on Books.GenreId=Genres.Id
where PostAddress like '%Denver%' and Genres.[Name]='Fiction'
order by Title

--11
create function udf_AuthorsWithBooks(@name nvarchar(100))
returns int
as
begin
declare @booksCounting int
set @booksCounting= (select COUNT(Books.Id) from Books join Authors on Authors.Id=Books.AuthorId where Authors.[Name]=@name)
return @booksCounting
end

--12
create procedure usp_SearchByGenre(@genreName varchar(50)) 
as
begin 
select Title,YearPublished,ISBN,Authors.[Name],Genres.[Name] from Books
join Authors on Authors.Id=Books.AuthorId
join Genres on Genres.Id=Books.GenreId
where Genres.[Name]=@genreName
order by Title
end

EXEC usp_SearchByGenre 'Fantasy'