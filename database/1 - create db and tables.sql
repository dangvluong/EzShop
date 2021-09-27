USE master;
GO
--DROP DATABASE EShop;
GO

-------------------------CREATE DATABASE-------------------------
CREATE DATABASE EShop;
GO
USE EShop;
GO

-------------------------CREATE TABLES-------------------------
CREATE TABLE Product(
	ProductId SMALLINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	ProductName NVARCHAR(100) NOT NULL,
	Sku VARCHAR(32) NOT NULL,
	Price INT NOT NULL,
	PriceSaleOff INT,
	Material NVARCHAR(64),
	Description NVARCHAR(MAX),
	IsDeleted BIT DEFAULT 0
)
GO

CREATE TABLE Category(
	CategoryId SMALLINT NOT NULL PRIMARY KEY IDENTITY (1,1),
	CategoryName NVARCHAR(64) NOT NULL
)
GO

CREATE TABLE ProductInCategory(
	ProductId SMALLINT NOT NULL REFERENCES Product(ProductId),
	CategoryId SMALLINT NOT NULL REFERENCES Category(CategoryId),
	PRIMARY KEY(ProductId, CategoryId)
)
GO

CREATE TABLE Color(
	ColorId SMALLINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	ColorCode VARCHAR(20) NOT NULL,
	IconUrl VARCHAR(32),
	IsDeleted BIT DEFAULT 0
)
GO

CREATE TABLE ColorOfProduct(
	ProductId SMALLINT NOT NULL REFERENCES Product(ProductId),
	ColorId SMALLINT NOT NULL REFERENCES Color(ColorId),
	PRIMARY KEY (ProductId, ColorId)
)
GO

CREATE TABLE Size(
	SizeId SMALLINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	SizeCode VARCHAR(20) NOT NULL,
	IsDeleted BIT DEFAULT 0
)
GO

CREATE TABLE SizeOfProduct(
	ProductId SMALLINT NOT NULL REFERENCES Product(ProductId),
	SizeId SMALLINT NOT NULL REFERENCES Size(SizeId),
	PRIMARY KEY(ProductId, SizeId)
)
GO

CREATE TABLE Guide(
	GuideId SMALLINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	GuideDescription NVARCHAR(100) NOT NULL,
	IsDeleted BIT DEFAULT 0
)
GO

CREATE TABLE GuideOfProduct(
	ProductId SMALLINT NOT NULL REFERENCES Product(ProductId),
	GuideId SMALLINT NOT NULL REFERENCES Guide(GuideId),
	PRIMARY KEY(ProductId, GuideId)
)
GO

CREATE TABLE ImageOfProduct(
	ProductId SMALLINT NOT NULL REFERENCES Product(ProductId),
	ColorId SMALLINT NOT NULL REFERENCES Color(ColorId),
	ImageUrl VARCHAR(100) NOT NULL,
	PRIMARY KEY (ProductId, ColorId, ImageUrl)
)
GO

CREATE TABLE Province(
	ProvinceId SMALLINT NOT NULL PRIMARY KEY,
	ProvinceName NVARCHAR(32) NOT NULL
)
GO

CREATE TABLE District(
	DistrictId SMALLINT NOT NULL PRIMARY KEY,
	DistrictName NVARCHAR(32) NOT NULL,
	ProvinceId SMALLINT NOT NULL REFERENCES Province(ProvinceId)
)
GO

CREATE TABLE Ward(
	WardId SMALLINT NOT NULL PRIMARY KEY,
	WardName NVARCHAR(32) NOT NULL,	
	DistrictId SMALLINT NOT NULL REFERENCES District(DistrictId)
)
GO

CREATE TABLE Contact(
	ContactId SMALLINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	AddressHome NVARCHAR(100) NOT NULL,
	ProvinceId SMALLINT NOT NULL REFERENCES Province(ProvinceId),
	DistrictId SMALLINT NOT NULL REFERENCES District(DistrictId),
	WardId SMALLINT NOT NULL REFERENCES Ward(WardId),
	PhoneNumber VARCHAR(15) NOT NULL,
	FullName NVARCHAR(32) NOT NULL,
	IsDeleted BIT DEFAULT 0
)
GO

CREATE TABLE Member(
	MemberId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	Username VARCHAR(32) NOT NULL UNIQUE,
	Password VARBINARY(64) NOT NULL,
	Email VARCHAR(32) NOT NULL UNIQUE,
	Gender BIT NOT NULL,
	JoinDate DATETIME NOT NULL,
	DefaultContact SMALLINT DEFAULT NULL,
	IsBanned BIT DEFAULT 0,
	Token VARCHAR(32) 
)

CREATE TABLE Role(
	RoleId TINYINT NOT NULL PRIMARY KEY,
	RoleName VARCHAR(32) NOT NULL
)
GO

CREATE TABLE MemberInRole(
	MemberId UNIQUEIDENTIFIER NOT NULL REFERENCES Member(MemberId),
	RoleId TINYINT NOT NULL REFERENCES Role(RoleId),
	IsDeleted BIT DEFAULT 0,
	PRIMARY KEY(MemberId, RoleId)
)
GO

CREATE TABLE ContactOfMember(
	MemberId UNIQUEIDENTIFIER NOT NULL REFERENCES Member(MemberId),
	ContactId SMALLINT NOT NULL REFERENCES Contact(ContactId),	
	PRIMARY KEY(MemberId,ContactId)
)
GO

CREATE TABLE InventoryQuantity(
	ProductId SMALLINT NOT NULL REFERENCES Product(ProductId),
	ColorId SMALLINT NOT NULL REFERENCES Color(ColorId),
	SizeId SMALLINT NOT NULL REFERENCES Size(SizeId),
	Quantity SMALLINT NOT NULL,
	PRIMARY KEY (ProductId, ColorId, SizeId)
) 
GO

CREATE TABLE Cart(
	CartId UNIQUEIDENTIFIER NOT NULL,
	ProductId SMALLINT NOT NULL REFERENCES Product(ProductId),
	ColorId SMALLINT NOT NULL REFERENCES Color(ColorId),
	SizeId SMALLINT NOT NULL REFERENCES Size(SizeId),
	Quantity SMALLINT NOT NULL,
	Price INT NOT NULL,
	PRIMARY KEY(CartId, ProductId, ColorId, SizeId)
)
GO

CREATE TABLE InvoiceStatus(
	StatusId TINYINT NOT NULL PRIMARY KEY,
	StatusName VARCHAR(32) NOT NULL
)
GO

CREATE TABLE Invoice(
	InvoiceId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	MemberId UNIQUEIDENTIFIER NOT NULL REFERENCES Member(MemberId),
	ContactId SMALLINT NOT NULL REFERENCES Contact(ContactId),
	StatusId TINYINT NOT NULL REFERENCES InvoiceStatus(StatusId),
	DateCreated DATETIME NOT NULL,
	ShipCost INT NOT NULL
)
GO

CREATE TABLE InvoiceDetail(
	InvoiceId UNIQUEIDENTIFIER NOT NULL REFERENCES Invoice(InvoiceId),
	ProductId SMALLINT NOT NULL REFERENCES Product(ProductId),
	ColorId SMALLINT NOT NULL REFERENCES Color(ColorId),
	SizeId SMALLINT NOT NULL REFERENCES Size(SizeId),
	Quantity SMALLINT NOT NULL,
	Price INT NOT NULL,
	PRIMARY KEY(InvoiceId, ProductId, ColorId, SizeId)
)
GO

