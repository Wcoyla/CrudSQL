-- Base de datos ejemplo
-- Coyla
-- 8/8/2022
use BDUniversidad
go

if DB_ID('BDUniversidad') is not null
	drop database BDUniversidad
go

create database BDUniversidad
GO

use BDUniversidad
go



-- CREAR TABLAS

IF OBJECT_ID('TEscuela') is not null
	drop table TEscuela
go
create table TEscuela
(
	CodEscuela char(3) primary key,
	Escuela varchar(50),
	Facultad varchar(50)
)
go

IF OBJECT_ID('TAlumno') is not null
	drop table TAlumno
go

create table TAlumno 
(
	CodAlumno char(5) primary key,
	Apellidos varchar(50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac datetime,
	CodEscuela char(3), 
	foreign key (CodEscuela) references TEscuela
)
go

-- insertar datos 
insert into TEscuela values('E01','Ing. Sistemas','Ingenieria')
insert into TEscuela values('E02','Ing. Civil','Ingenieria')
insert into TEscuela values('E03','Ing. Industrial','Ingenieria')
insert into TEscuela values('E04','Ing. Ambiental','Ingenieria')
insert into TEscuela values('E05','Arquitectura','Ingenieria')
go
select * from TEscuela

insert into TAlumno values('A01','Coyla Espirilla','Wildor','Mi casa','01/01/01','E01')
insert into TAlumno values('A02','Aguilar Ramirez','Agus','Su casa','02/01/01','E02')

select * from TAlumno