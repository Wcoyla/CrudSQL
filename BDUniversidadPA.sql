-- Procedimientos almacenados
-- Coyla
-- 8/agosto/2022

-- PA para TEscuela

use BDUniversidad
go

if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go
create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

EXEC spListarEscuela
go

if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go
create proc spAgregarEscuela
@CodEscuela char(3), 
@Escuela varchar(50),
@Facultad varchar(50)
as
begin
	-- CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		-- Escuela no puede ser duplicado
		if not exists (select Escuela from TEscuela where Escuela=@Escuela)
			begin
				insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
				select CodError =0, Mensaje ='Se inserto correctamente escuela'
			end
		else select CodError = 1, Mensaje = 'Error: Escuela duplicada'
	else select CodError = 1, Mensaje = 'Error: CodEscuela duplicado'

end
go

exec spAgregarEscuela 'E06','Minas','Ingenieria'
go
EXEC spListarEscuela
go
-- Actividad: Implementar Eliminar, Actualizar y Buscar
-- Elminar 

if OBJECT_ID ('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create procedure spEliminarEscuela
@CodEscuela char(3)
as
	delete from TEscuela where CodEscuela=@CodEscuela;
go

exec spEliminarEscuela 'E06'
go
EXEC spListarEscuela
go
-- Actualizar

if OBJECT_ID ('spActEscuela') is not null
	drop proc spActEscuela
go
create procedure spActEscuela
@CodEscuela char(3),
@Escuela varchar(50),
@Facultad varchar(50)
as
	update TEscuela set Escuela=@Escuela, 
						Facultad=@Facultad
						where CodEscuela=@CodEscuela
go
exec spAgregarEscuela 'E06','Minas','Ingenieria'
go
exec spActEscuela 'E06','Ing. Minas','Ingenieria'
go
EXEC spListarEscuela
go
-- Buscar
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create procedure spBuscarEscuela
@CodEscuela char(3)
as begin
select * from TEscuela where CodEscuela like @CodEscuela+'%'
end
go

EXEC spBuscarEscuela 'E01'
go

---------------------------Alumno----------------------------
if OBJECT_ID('spListarAlumno') is not null
	drop proc spListarAlumno
go
create proc spListarAlumno
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac ,FechaNac, CodEscuela from TAlumno
end
go

EXEC spListarAlumno
go

if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go
create proc spAgregarAlumno
@CodAlumno char(3), 
@Apellidos varchar(50),
@Nombres varchar(50),
@LugarNac varchar(50),
@FechaNac datetime,
@CodEscuela char(3)
as
begin
	-- CodEscuela no puede ser duplicado
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
			begin
				insert into TAlumno values(@CodAlumno,@Apellidos,@Nombres,@LugarNac,@FechaNac,@CodEscuela)
				select CodError =0, Mensaje ='Se inserto correctamente alumno'
			end
		else select CodError = 1, Mensaje = 'Error: CodAlumno repetido'

end
go

exec spAgregarAlumno'A03','Connie Amezcua','Paty','Otra casa','03/01/01','E01'
go

EXEC spListarAlumno
go

-- Actividad: Implementar Eliminar, Actualizar y Buscar
-- Elminar 

if OBJECT_ID ('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go
create procedure spEliminarAlumno
@CodAlumno char(3)
as
	delete from TAlumno where CodAlumno=@CodAlumno;
go

exec spEliminarAlumno'A03'
go
exec spListarAlumno
-- Actualizar

if OBJECT_ID ('spActAlumno') is not null
	drop proc spActAlumno
go
create procedure spActAlumno
@CodAlumno char(3), 
@Apellidos varchar(50),
@Nombres varchar(50),
@LugarNac varchar(50),
@FechaNac datetime,
@CodEscuela char(3)
as
	update TAlumno set  
						Apellidos=@Apellidos,
						Nombres=@Nombres,
						LugarNac=@LugarNac,
						FechaNac=@FechaNac,
						CodEscuela=@CodEscuela
						where CodAlumno=@CodAlumno
go
exec spAgregarAlumno'A03','Connie Amezcua','Paty','Otra casa','03/01/01','E01'
go

exec spActAlumno 'A03','Connie Amezcua','Paty','Cusco','2001-01-01','E01'
go
exec spListarAlumno
-- Buscar
if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go
create procedure spBuscarAlumno
@CodAlumno char(3)
as begin
select * from TAlumno where CodAlumno like @CodAlumno+'%'
end
go

EXEC spBuscarAlumno'A03'
go