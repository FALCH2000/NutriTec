--Store procedure para obtener todos los usuarios
CREATE PROCEDURE GetUsuarios 

AS
	BEGIN 
		SELECT * FROM Usuario
	RETURN
	END
GO

--Store procedure para obtener un usuario segun su codigo
CREATE PROCEDURE GetNuricionistaXcod (@NutriCod          VARCHAR(20))

AS
	BEGIN 
		SELECT * FROM Usuario
		WHERE @NutriCod = codigo_nutricionista
	RETURN
	END
GO

CREATE PROCEDURE GetUsuarios 

AS
	BEGIN 
		SELECT * FROM Usuario
	RETURN
	END
GO

--Store procedure que ingresa un nuevo usuario
CREATE PROCEDURE InsertUsuario (@nombre1 VARCHAR(20),
					@nombre2 VARCHAR(20),
					@apellido1 VARCHAR(20),
					@apellido2 VARCHAR(20),
					@cedula INTEGER,
					@fecha_de_nacimiento DATE,
					@edad INTEGER,
					@codigo_nutricionista VARCHAR(20),
					@pass VARCHAR(30),
					@email VARCHAR(40),
					@numero_tarjeta INTEGER,
					@tipo_cobro VARCHAR (50),
					@rol VARCHAR(50),
					@direccion VARCHAR (80),
					@foto VARCHAR(80))

AS
	BEGIN
        INSERT INTO Usuario(nombre1,
							nombre2,
							apellido1,
							apellido2,
							cedula,
							fecha_de_nacimiento,
							edad,
							codigo_nutricionista,
							pass,
							email,
							numero_tarjeta,
							tipo_cobro,
							rol,
							direccion,
							foto) 
        VALUES     (@nombre1,
					@nombre2,
					@apellido1,
					@apellido2,
					@cedula,
					@fecha_de_nacimiento,
					@edad,
					@codigo_nutricionista,
					@email,
					@pass,
					@numero_tarjeta,
					@tipo_cobro,
					@rol,
					@direccion,
					@foto)
        END
GO

--Store procedure que hace la validacion de un usuario que ingresa a la plataforma
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetValidarLogin] (@User VARCHAR(60), @pass VARCHAR(100), @Return int output)

AS
Declare @encontrado INT
    BEGIN 
        SELECT @encontrado = COUNT(*) FROM paciente
        WHERE @User = email AND @pass = pass
    END


if @encontrado = 1
    Begin
         set @Return = 1
     End
ELSE IF @encontrado = 0
    Begin
         set @Return = 0
    End