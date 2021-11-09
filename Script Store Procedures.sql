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

--Store procedure para eliminar usuarios
CREATE PROCEDURE DeleteUsuario(@Codigo VARCHAR(20))
AS
	BEGIN
		DELETE FROM Usuario
		WHERE @Codigo = codigo_nutricionista
	END
GO

--Store procedure de validacion con Rol 
CREATE PROCEDURE GetValidarLoginRol (@User VARCHAR(60), @pass VARCHAR(100), @rol VARCHAR(100), @Return int output)

AS
Declare @encontrado INT
    BEGIN 
        SELECT @encontrado = COUNT(*) FROM Usuario
        WHERE @User = email AND @pass = pass AND @rol = rol
    END


if @encontrado = 1
    Begin
         set @Return = 1
     End
ELSE IF @encontrado = 0
    Begin
         set @Return = 0
    End

--Store procedure para obtener todos los planes creados por un nutricionista
CREATE PROCEDURE GetPlanesDeNutri(@Codigo VARCHAR(20))
AS
	BEGIN
		SELECT * FROM Plan_Alimentacion
		WHERE nutricionista = @Codigo
	END
GO

--Store procedure para obtener un plan con su nombre
CREATE PROCEDURE GetPlan(@nombre VARCHAR(50))
AS
	BEGIN
		SELECT * FROM Plan_Alimentacion
		WHERE nombre = @nombre
	END
GO

-- obtiene los nombres de las recetas que tiene un usuario
CREATE PROCEDURE GetNombreRecetasPaciente (@Email VARCHAR(60))

AS
Declare @cedula INT
    BEGIN 
        SELECT @cedula=cedula FROM paciente
        WHERE @Email = email
    END

    BEGIN
        SELECT nombre FROM Receta
        WHERE @cedula = cedula_paciente
    END

-- Obtiene los productos de un plan 
CREATE PROCEDURE GetProductosPlan (@Email VARCHAR(60))

AS
Declare @cedula INT, @nombrePlan VARCHAR(100)
    BEGIN 
        SELECT @cedula=cedula FROM paciente
        WHERE @Email = email
    END

    BEGIN
        SELECT @nombrePlan = nombre_plan FROM plan_por_paciente
        WHERE @cedula = cedula
    END

    BEGIN
        SELECT descripcion FROM Producto
        WHERE codigo_de_barras IN(SELECT codigo_barras FROM Producto_por_plan
        WHERE @nombrePlan = nombre_plan)
    END

--Obtiene los productos de una receta
CREATE PROCEDURE GetProductoPorReceta (@NombreReceta VARCHAR(60))

AS

    BEGIN 
        SELECT descripcion FROM producto WHERE codigo_de_barras IN(SELECT codigo_barras FROM Producto_por_receta
        WHERE @NombreReceta = nombre_receta)
    END

--Store procedure para actualizar un plan con su nombre
CREATE PROCEDURE UpdatePlan(@nombre VARCHAR(50),
							@desayuno VARCHAR(120),
							@merienda_manana VARCHAR(120),
							@almuerzo VARCHAR(120),
							@cena VARCHAR(120),
							@merienda_tarde VARCHAR(120),
							@nutricionista VARCHAR(20))
AS
	BEGIN
		UPDATE Plan_Alimentacion
		SET desayuno = @desayuno,
			merienda_manana = @merienda_manana,
			almuerzo = @almuerzo,
			cena = @cena,
			merienda_tarde = @merienda_tarde,
			nutricionista = @nutricionista
		WHERE nombre = @nombre
	END
GO

-----------------------------------------------------------------------------------
--Store procedure para eliminar un plan con su nombre
CREATE PROCEDURE DeletePlan(@nombre VARCHAR(50))
AS
	BEGIN
		DELETE FROM Producto_por_plan
		WHERE @nombre = nombre_plan
		DELETE FROM plan_por_paciente
		WHERE @nombre = nombre_plan
		DELETE FROM Plan_Alimentacion
		WHERE @nombre = nombre
	
		
	END
GO
-----------------------------------------------------------------------------------
--Store procedure para obtener las medidas de un usuario
CREATE PROCEDURE GetMedidasXCedula(@cedula_paciente INT)
AS
	BEGIN
		SELECT * FROM Medida
		WHERE cedula_paciente = @cedula_paciente
		
	END
GO


--Store procedure para ingresar las medidas de un usuario
CREATE PROCEDURE InsertMedidas(@fecha DATE,
							@cadera INT,
							@cintura INT,
							@cuello INT,
							@peso INT,
							@musculo INT,
							@grasa INT,
							@cedula_paciente INT)
AS
	BEGIN
		INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
		VALUES(@fecha,@cadera,@cintura,@cuello,@peso,@musculo,@grasa,@cedula_paciente);
		
	END
GO

--Store procedure para ingresar un nuevo consumo diario
CREATE PROCEDURE InsertConsumo(@fecha DATE,
							@almuerzo VARCHAR(250),
							@cena VARCHAR(250),
							@desayuno VARCHAR(250),
							@merienda_manana VARCHAR(250),
							@merienda_tarde VARCHAR(250),
							@consumo_calorias INT,
							@cedula_paciente INT)
AS
	BEGIN
		INSERT INTO ConsumoDiario(fecha, almuerzo, cena, desayuno, merienda_m, merienda_t, consumo_calorias, cedula_paciente)
		VALUES(@fecha,@almuerzo,@cena,@desayuno,@merienda_manana,@merienda_tarde,@consumo_calorias,@cedula_paciente);
		
	END
GO


--Agrega una nueva receta
CREATE PROCEDURE AgregarReceta (@Email VARCHAR(100), @NombreReceta VARCHAR(50), @TamanoPorcion INT, @Producto VARCHAR(100))

AS
 Declare @cedula INT, @Contador INT, @Codigo VARCHAR(50), @ValorEnReceta INT, @ValoreEnProd INT, @Suma INT
 	BEGIN 
 		SELECT @Contador = COUNT(*) FROM Receta 
        WHERE @NombreReceta = nombre
        
        END
 if @Contador = 0
    BEGIN 
        SELECT @cedula = cedula FROM paciente 
        WHERE @Email = email
    
    	INSERT Receta (nombre, tamano_porcion, cedula_paciente)
        VALUES(@NombreReceta, @TamanoPorcion, @cedula)
    END
ELSE If @Contador = 1

	BEGIN
    	SELECT @Codigo = codigo_de_barras FROM Producto
        WHERE @Producto = descripcion
    
    	INSERT INTO Producto_por_receta(codigo_barras, nombre_receta)
        VALUES(@Codigo, @NombreReceta)
   
    	SELECT @ValoreEnProd = energia FROM producto
        WHERE @Producto = descripcion
   
    	SELECT @ValorEnReceta = calorias FROM Receta
        WHERE @NombreReceta = nombre
    END
    
    if @ValorEnReceta IS NOT null
        BEGIN
            SET @Suma = @ValoreEnProd + @ValorEnReceta

        	UPDATE Receta SET calorias = @Suma WHERE  @NombreReceta = nombre
		END
    ELSE IF @ValorEnReceta IS null
    	BEGIN
        	UPDATE Receta SET calorias = @ValoreEnProd  WHERE  @NombreReceta = nombre
		END
        
    BEGIN
    	SELECT @ValoreEnProd = carbohidrato FROM producto
        WHERE @Producto = descripcion
    
    	SELECT @ValorEnReceta = carbohidratos FROM Receta
        WHERE @NombreReceta = nombre
    END
    
    if @ValorEnReceta IS NOT null
        BEGIN
            SET @Suma = @ValoreEnProd + @ValorEnReceta

        	UPDATE Receta SET carbohidratos = @Suma WHERE  @NombreReceta = nombre
		END
    ELSE IF @ValorEnReceta IS null
    	BEGIN
        	UPDATE Receta SET carbohidratos = @ValoreEnProd  WHERE  @NombreReceta = nombre
		END
        
        
    BEGIN
    	SELECT @ValoreEnProd = grasa FROM producto
        WHERE @Producto = descripcion
    
    	SELECT @ValorEnReceta = grasa FROM Receta
        WHERE @NombreReceta = nombre
    END
    
    if @ValorEnReceta IS NOT null
        BEGIN
            SET @Suma = @ValoreEnProd + @ValorEnReceta

        	UPDATE Receta SET grasa = @Suma WHERE  @NombreReceta = nombre
		END
    ELSE IF @ValorEnReceta IS null
    	BEGIN
        	UPDATE Receta SET grasa = @ValoreEnProd  WHERE  @NombreReceta = nombre
		END
   	
    
    BEGIN
    	SELECT @ValoreEnProd = sodio FROM producto
        WHERE @Producto = descripcion
    
    	SELECT @ValorEnReceta = sodio FROM Receta
        WHERE @NombreReceta = nombre
    END
    
    if @ValorEnReceta IS NOT null
        BEGIN
            SET @Suma = @ValoreEnProd + @ValorEnReceta

        	UPDATE Receta SET sodio = @Suma WHERE  @NombreReceta = nombre
		END
    ELSE IF @ValorEnReceta IS null
    	BEGIN
        	UPDATE Receta SET sodio = @ValoreEnProd  WHERE  @NombreReceta = nombre
		END
       
       
    BEGIN
    	SELECT @ValoreEnProd = proteina FROM producto
        WHERE @Producto = descripcion
    
    	SELECT @ValorEnReceta = proteina FROM Receta
        WHERE @NombreReceta = nombre
    END
    
    if @ValorEnReceta IS NOT null
        BEGIN
            SET @Suma = @ValoreEnProd + @ValorEnReceta

        	UPDATE Receta SET proteina = @Suma WHERE  @NombreReceta = nombre
		END
    ELSE IF @ValorEnReceta IS null
    	BEGIN
        	UPDATE Receta SET proteina = @ValoreEnProd  WHERE  @NombreReceta = nombre
		END
        
        
    BEGIN
    	SELECT @ValoreEnProd = hierro FROM producto
        WHERE @Producto = descripcion
  
    	SELECT @ValorEnReceta = hierro FROM Receta
        WHERE @NombreReceta = nombre
    END
    
    if @ValorEnReceta IS NOT null
        BEGIN
            SET @Suma = @ValoreEnProd + @ValorEnReceta

        	UPDATE Receta SET hierro = @Suma WHERE  @NombreReceta = nombre
		END
    ELSE IF @ValorEnReceta IS null
    	BEGIN
        	UPDATE Receta SET hierro = @ValoreEnProd  WHERE  @NombreReceta = nombre
		END
        
    BEGIN
    	SELECT @ValoreEnProd = calcio FROM producto
        WHERE @Producto = descripcion
    
    	SELECT @ValorEnReceta = calcio FROM Receta
        WHERE @NombreReceta = nombre
    END
    
    if @ValorEnReceta IS NOT null
        BEGIN
            SET @Suma = @ValoreEnProd + @ValorEnReceta

        	UPDATE Receta SET calcio = @Suma WHERE  @NombreReceta = nombre
		END
    ELSE IF @ValorEnReceta IS null
    	BEGIN
        	UPDATE Receta SET calcio = @ValoreEnProd  WHERE  @NombreReceta = nombre
		END


--Store procedure para obtener el listado de los productos existentes
CREATE PROCEDURE GetProductos
AS
	BEGIN
		SELECT * FROM Producto
	END
GO

--Store procedure para obtener un solo producto
CREATE PROCEDURE GetProducto(@codigo VARCHAR(50))
AS
	BEGIN
		SELECT * FROM Producto
		WHERE codigo_de_barras = @codigo
	END
GO

--Store procedure ingresar un nuevo producto
CREATE PROCEDURE InsertProducto(@codigo_de_barras VARCHAR(50),
								@descripcion VARCHAR(500),
								@tamano_porcion INT,
								@energia INT,
								@grasa INT,
								@sodio INT,
								@carbohidrato INT,
								@proteina INT,
								@calcio INT,
								@estado VARCHAR(50),
								@hierro INT)
AS
	BEGIN
		INSERT INTO producto(codigo_de_barras, descripcion, tamaño_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
		VALUES(@codigo_de_barras,@descripcion,@tamano_porcion,@energia,@grasa,@sodio,@carbohidrato,@proteina,@calcio,@estado,@hierro)
	END
GO

--Store procedure para cambiar el estado de un producto
CREATE PROCEDURE AprovacionProducto(@codigo VARCHAR(50),
									@estado VARCHAR(50))
AS
	BEGIN
		UPDATE Producto
		SET estado = @estado
		WHERE codigo_de_barras = @codigo
	END
GO

---Borrar un producto de una receta
CREATE PROCEDURE BorrarProdReceta (@NombreReceta VARCHAR(50), @ProductoBorrado VARCHAR(100))

AS
 Declare @codigo VARCHAR(50), @ValorEnReceta INT, @ValoreEnProd INT, @Resta INT
     BEGIN 
        SELECT @codigo = codigo_de_barras FROM Producto WHERE @ProductoBorrado = descripcion
         DELETE FROM Producto_por_receta Where @NombreReceta = nombre_receta AND @codigo = codigo_barras
        
        SELECT @ValoreEnProd = energia FROM producto
        WHERE @ProductoBorrado = descripcion
   
        SELECT @ValorEnReceta = calorias FROM Receta
        WHERE @NombreReceta = nombre
        
        SET @Resta = @ValorEnReceta - @ValoreEnProd

        UPDATE Receta SET calorias = @Resta WHERE  @NombreReceta = nombre
        
        SELECT @ValoreEnProd = carbohidrato FROM producto
        WHERE @ProductoBorrado = descripcion
    
        SELECT @ValorEnReceta = carbohidratos FROM Receta
        WHERE @NombreReceta = nombre
        
        SET @Resta = @ValorEnReceta - @ValoreEnProd

        UPDATE Receta SET carbohidratos = @Resta WHERE  @NombreReceta = nombre
        
        SELECT @ValoreEnProd = grasa FROM producto
        WHERE @ProductoBorrado = descripcion
    
        SELECT @ValorEnReceta = grasa FROM Receta
        WHERE @NombreReceta = nombre
        
        SET @Resta = @ValorEnReceta - @ValoreEnProd

        UPDATE Receta SET grasa = @Resta WHERE  @NombreReceta = nombre
        
        SELECT @ValoreEnProd = sodio FROM producto
        WHERE @ProductoBorrado = descripcion
    
        SELECT @ValorEnReceta = sodio FROM Receta
        WHERE @NombreReceta = nombre
        
        SET @Resta = @ValorEnReceta - @ValoreEnProd

        UPDATE Receta SET sodio = @Resta WHERE  @NombreReceta = nombre
        
        SELECT @ValoreEnProd = proteina FROM producto
        WHERE @ProductoBorrado = descripcion
    
        SELECT @ValorEnReceta = proteina FROM Receta
        WHERE @NombreReceta = nombre
        
        SET @Resta = @ValorEnReceta - @ValoreEnProd

        UPDATE Receta SET proteina = @Resta WHERE  @NombreReceta = nombre
        
        SELECT @ValoreEnProd = hierro FROM producto
        WHERE @ProductoBorrado = descripcion
  
        SELECT @ValorEnReceta = hierro FROM Receta
        WHERE @NombreReceta = nombre
        
        SET @Resta = @ValorEnReceta - @ValoreEnProd

        UPDATE Receta SET hierro = @Resta WHERE  @NombreReceta = nombre
        
        SELECT @ValoreEnProd = calcio FROM producto
        WHERE @ProductoBorrado = descripcion
    
        SELECT @ValorEnReceta = calcio FROM Receta
        WHERE @NombreReceta = nombre
        
        SET @Resta = @ValorEnReceta - @ValoreEnProd

        UPDATE Receta SET calcio = @Resta WHERE  @NombreReceta = nombre
    END

