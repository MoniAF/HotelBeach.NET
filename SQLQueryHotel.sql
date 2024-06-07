USE master
GO

CREATE DATABASE HotelBeachDB
GO

USE HotelBeachDB
GO

IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Reservaciones')
DROP TABLE [Reservaciones]
GO

CREATE TABLE [Reservaciones](
Id int primary key not null,
CedulaCliente varchar(25) not null,
IdPaquete int not null,
TipoPago varchar(25) not null,
FechaReserva Date not null,
Duracion int not null,
Subtotal decimal(12,2) not null,
Impuesto decimal(12,2) not null,
Descuento decimal(12,2) not null,
MontoTotal decimal(12,2) not null,
Adelanto decimal(12,2) not null,
MontoMensualidad decimal(12,2) not null,
Estado char not null)
GO

SELECT * FROM Reservaciones
GO

IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Empleados')
DROP TABLE [Empleados]
GO

CREATE TABLE [Empleados](
ID int not null primary key identity,
NombreCompleto varchar(150) not null,
Email varchar(50) not null,
Password varchar(20) not null,
TipoUsuario int not null,
FechaRegistro datetime not null default getdate(),
Estado char not null)
GO

SELECT * FROM Empleados
GO

INSERT INTO Empleados (NombreCompleto, Email, Password, TipoUsuario, Estado)
VALUES ('Lana García', 'sahotelbeach@outlook.com', 'Ucr2024*', 1, 'A')
GO

IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Paquetes')
DROP TABLE [Paquetes]
GO

CREATE TABLE [Paquetes](
ID int not null primary key identity,
NombrePaquete varchar(150) not null,
Precio decimal(12,2) not null,
PorcentajePrima decimal(12,2) not null,
LimiteMeses int not null,
FechaRegistro datetime not null default getdate(),
Estado char not null)
GO

SELECT * FROM Paquetes
GO

INSERT INTO Paquetes (NombrePaquete, Precio, PorcentajePrima, LimiteMeses, Estado)
VALUES ('Todo incluido', 450, 45, 24, 'A')
GO

INSERT INTO Paquetes (NombrePaquete, Precio, PorcentajePrima, LimiteMeses, Estado)
VALUES ('Alimentación', 275, 35, 18, 'A')
GO

INSERT INTO Paquetes (NombrePaquete, Precio, PorcentajePrima, LimiteMeses, Estado)
VALUES ('Hospedaje', 210, 15, 12, 'A')
GO

IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Clientes')
DROP TABLE [Clientes]
GO

CREATE TABLE [Clientes](
Cedula varchar(25) not null primary key,
TipoCedula varchar(20) not null,
NombreCompleto varchar(150) not null,
Telefono varchar(15) not null,
Direccion varchar(150) not null,
Email varchar(150) not null,
Password varchar(20) not null,
TipoUsuario int not null,
Restablecer int not null,
FechaRegistro datetime not null default getdate(),
Estado char not null)
GO

SELECT * FROM Clientes
GO

ALTER TABLE Reservaciones ADD
CONSTRAINT [FK_Reservaciones_Clientes] FOREIGN KEY (CedulaCliente)
REFERENCES [Clientes](Cedula)
GO

ALTER TABLE Reservaciones ADD
CONSTRAINT [FK_Reservaciones_Paquetes] FOREIGN KEY (IdPaquete)
REFERENCES [Paquetes](ID)
GO

IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Cheques')
DROP TABLE [Cheques]
GO

CREATE TABLE [Cheques](
IdCheque int primary key not null,
NumeroCheque int not null,
NombreBanco varchar(100) not null,
IdReservacion int not null)
GO

SELECT * FROM Cheques
go

ALTER TABLE Cheques ADD
CONSTRAINT [FK_Cheques_Reservaciones] FOREIGN KEY (IdReservacion)
REFERENCES [Reservaciones](Id)
go

ALTER TABLE Cheques
DROP CONSTRAINT [FK_Cheques_Reservaciones]
GO

ALTER TABLE Reservaciones
DROP CONSTRAINT [FK_Reservaciones_Paquetes]
GO

ALTER TABLE Reservaciones
DROP CONSTRAINT [FK_Reservaciones_Clientes]
GO

CREATE TABLE [Reservaciones_Auditoria](
Accion varchar(25) not null,
FechaCambio datetime not null default getdate(),
Id int not null,
CedulaCliente varchar(25) not null,
IdPaquete int not null,
TipoPago varchar(25) not null,
FechaReserva Date not null,
Duracion int not null,
Subtotal decimal(12,2) not null,
Impuesto decimal(12,2) not null,
Descuento decimal(12,2) not null,
MontoTotal decimal(12,2) not null,
Adelanto decimal(12,2) not null,
MontoMensualidad decimal(12,2) not null,
Estado char not null)
GO

SELECT * FROM Reservaciones_Auditoria
GO

CREATE TABLE [Empleados_Auditoria](
Accion varchar(25) not null,
FechaCambio datetime not null default getdate(),
ID int not null,
NombreCompleto varchar(150) not null,
Email varchar(50) not null,
Password varchar(20) not null,
TipoUsuario int not null,
FechaRegistro datetime not null,
Estado char not null)
GO

SELECT * FROM Empleados_Auditoria
GO

CREATE TABLE [Paquetes_Auditoria](
Accion varchar(25) not null,
FechaCambio datetime not null default getdate(),
ID int not null,
NombrePaquete varchar(150) not null,
Precio decimal(12,2) not null,
PorcentajePrima decimal(12,2) not null,
LimiteMeses int not null,
FechaRegistro datetime not null,
Estado char not null)
GO

SELECT * FROM Paquetes_Auditoria
GO

CREATE TABLE [Clientes_Auditoria](
Accion varchar(25) not null,
FechaCambio datetime not null default getdate(),
Cedula varchar(25) not null,
TipoCedula varchar(20) not null,
NombreCompleto varchar(150) not null,
Telefono varchar(15) not null,
Direccion varchar(150) not null,
Email varchar(150) not null,
Password varchar(20) not null,
TipoUsuario int not null,
Restablecer int not null,
FechaRegistro datetime not null,
Estado char not null)
GO

SELECT * FROM Clientes_Auditoria
GO


