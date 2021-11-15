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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AgregarReceta] (@Email VARCHAR(100), @NombreReceta VARCHAR(50), @TamanoPorcion INT, @Producto VARCHAR(100))

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

		SELECT @Codigo = codigo_de_barras FROM Producto
        WHERE @Producto = descripcion
    
    	INSERT INTO Producto_por_receta(codigo_barras, nombre_receta)
        VALUES(@Codigo, @NombreReceta)

		SELECT @ValoreEnProd = energia FROM producto
        WHERE @Producto = descripcion

		UPDATE Receta SET calorias = @ValoreEnProd  WHERE  @NombreReceta = nombre

		SELECT @ValoreEnProd = carbohidrato FROM producto
        WHERE @Producto = descripcion

		UPDATE Receta SET carbohidratos = @ValoreEnProd  WHERE  @NombreReceta = nombre

		SELECT @ValoreEnProd = grasa FROM producto
        WHERE @Producto = descripcion

		UPDATE Receta SET grasa = @ValoreEnProd  WHERE  @NombreReceta = nombre

		SELECT @ValoreEnProd = sodio FROM producto
        WHERE @Producto = descripcion

		UPDATE Receta SET sodio = @ValoreEnProd  WHERE  @NombreReceta = nombre

		SELECT @ValoreEnProd = proteina FROM producto
        WHERE @Producto = descripcion

		UPDATE Receta SET proteina = @ValoreEnProd  WHERE  @NombreReceta = nombre

		SELECT @ValoreEnProd = hierro FROM producto
        WHERE @Producto = descripcion

		UPDATE Receta SET hierro = @ValoreEnProd  WHERE  @NombreReceta = nombre

		SELECT @ValoreEnProd = calcio FROM producto
        WHERE @Producto = descripcion

		UPDATE Receta SET calcio = @ValoreEnProd  WHERE  @NombreReceta = nombre



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


-----Ingresa un nuevo producto
CREATE PROCEDURE InsertPlan(@nombre VARCHAR(50),
							@desayuno VARCHAR(120),
							@merienda_manana VARCHAR(120),
							@almuerzo VARCHAR(120),
							@cena VARCHAR(120),
							@merienda_tarde VARCHAR(120),
							@nutricionista VARCHAR(20))
AS
BEGIN
	INSERT INTO Plan_Alimentacion(nombre,desayuno,merienda_manana,almuerzo,cena,merienda_tarde,nutricionista)
	VALUES(@nombre,@desayuno,@merienda_manana,@almuerzo,@cena,@merienda_tarde,@nutricionista)
END
GO


--Obtener los productos segun su estado
CREATE PROCEDURE GetProductosXEstado(@estado VARCHAR(50))
AS
	BEGIN
		IF @estado = 'aprobado'
		BEGIN
			SELECT * FROM dbo.ProductosAprobados
		END
		ELSE IF @estado = 'en espera'
		BEGIN
			SELECT * FROM dbo.ProductosEnEspera
		END
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
		INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
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


--Este metodo sirve para agregar los productos nuevos que se agreguen a una receta
CREATE PROCEDURE AgregarProdRecetaNuevo (@NombreReceta VARCHAR(50), @Producto VARCHAR(100), @Porcion INT)

AS
 Declare @Codigo VARCHAR(50), @ValorEnReceta INT, @ValoreEnProd INT, @Suma INT
 	BEGIN
    	UPDATE Receta SET tamano_porcion = @Porcion WHERE  @NombreReceta = nombre
   		
    	SELECT @Codigo = codigo_de_barras FROM Producto
        WHERE @Producto = descripcion
    
    	INSERT INTO Producto_por_receta(codigo_barras, nombre_receta)
        VALUES(@Codigo, @NombreReceta)
        
        INSERT into Vitaminas_por_receta(vitamina , nombre_receta)
        SELECT vitamina, @NombreReceta FROM Vitaminas_por_producto WHERE @Codigo = codigo_barras
        
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


--Store procedure para borrar la receta
CREATE PROCEDURE BorrarReceta (@Email VARCHAR(100), @NombreReceta VARCHAR(50))

AS
 Declare @cedula INT
     BEGIN 

        SELECT @cedula = cedula FROM paciente 
        WHERE @Email = email

        DELETE FROM Producto_por_receta WHERE @NombreReceta = nombre_receta

        DELETE FROM Vitaminas_por_receta WHERE @NombreReceta = nombre_receta

        DELETE FROM Receta Where @cedula = cedula_paciente AND @NombreReceta = nombre

    END

--Ingresa un nuevo consumo diario o lo actualiza
CREATE PROCEDURE RegistroDiario (@Email VARCHAR(50), @Producto VARCHAR(250), @Horario VARCHAR(250))

AS
Declare @contador INT, @Fecha datetime, @cedula int, @caloriasProducto int, @contador2 int, @CaloriasTotal int, @CaloriasExistentes int, @ProductosAgregados VARCHAR(250), @ProductosFinal VARCHAR(250)
    BEGIN 
        
        set @Fecha = Getdate()
        
        SELECT @cedula = cedula FROM paciente
        WHERE @Email = email
        
        SELECT @contador = COUNT(*) FROM ConsumoDiario 
        WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
        
        SELECT @contador2 = COUNT(*) FROM Producto
        WHERE @Producto = descripcion
        
        
    
    END
    
    if @contador2 = 1
        BEGIN
            SELECT @caloriasProducto = energia FROM producto
            WHERE @Producto = descripcion
        END
    ELSE
        BEGIN
            SELECT @caloriasProducto = calorias FROM Receta
            WHERE @Producto = nombre
        END
    
   if @contador = 0
        BEGIN
            if @Horario = 'Desayuno'
        
                BEGIN
                    INSERT INTO ConsumoDiario(fecha, desayuno, consumo_calorias, cedula_paciente)
                    VALUES(Getdate(), @Producto, @caloriasProducto, @cedula)
                   END
        
            ELSE if @Horario = 'MeriendaM'
        
                BEGIN
                    INSERT INTO ConsumoDiario(fecha, merienda_m, consumo_calorias, cedula_paciente)
                    VALUES(Getdate(), @Producto, @caloriasProducto, @cedula)
                   END
            
               ELSE if @Horario = 'MeriendaT'
        
                BEGIN
                    INSERT INTO ConsumoDiario(fecha, merienda_t, consumo_calorias, cedula_paciente)
                    VALUES(Getdate(), @Producto, @caloriasProducto, @cedula)
                   END
            
            ELSE if @Horario = 'Almuerzo'
        
                BEGIN
                    INSERT INTO ConsumoDiario(fecha, almuerzo, consumo_calorias, cedula_paciente)
                    VALUES(Getdate(), @Producto, @caloriasProducto, @cedula)
                   END
            ELSE if @Horario = 'Cena'
        
                BEGIN
                    INSERT INTO ConsumoDiario(fecha, cena, consumo_calorias, cedula_paciente)
                    VALUES(Getdate(), @Producto, @caloriasProducto, @cedula)
                   END
           END 

    
    ELSE 
        BEGIN
 
            if @Horario = 'Desayuno'
        
                BEGIN
                    SELECT @ProductosAgregados = desayuno, @CaloriasExistentes = consumo_calorias FROM ConsumoDiario
                    WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
            
                    if @ProductosAgregados is NULL
                        BEGIN
                            SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
                            UPDATE ConsumoDiario set desayuno = @Producto, consumo_calorias = @CaloriasTotal
                            WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                        END
                    ELSE 
                        BEGIN
                            SET @ProductosFinal = @Producto + ', ' + @ProductosAgregados
                            SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
                            UPDATE ConsumoDiario set desayuno = @ProductosFinal, consumo_calorias = @CaloriasTotal
                            WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                           END
                END
            ELSE if @Horario = 'MeriendaM'
        
                BEGIN
                    SELECT @ProductosAgregados = merienda_m, @CaloriasExistentes = consumo_calorias FROM ConsumoDiario
                    WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                	
                    if @ProductosAgregados is NULL
                        BEGIN
                        	SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
             
                    		UPDATE ConsumoDiario set merienda_m = @Producto, consumo_calorias = @CaloriasTotal
                    		WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
      
                        END
                        
                    ELSE 
                    	BEGIN
                            SET @ProductosFinal = @Producto + ', ' + @ProductosAgregados
                            SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes

                            UPDATE ConsumoDiario set merienda_m = @ProductosFinal, consumo_calorias = @CaloriasTotal
                            WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                        END
            END
               ELSE if @Horario = 'MeriendaT'
        
                BEGIN
                    SELECT @ProductosAgregados = merienda_t, @CaloriasExistentes = consumo_calorias FROM ConsumoDiario
                    WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                
                    if @ProductosAgregados is NULL
                    	BEGIN
							SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
                
                    		UPDATE ConsumoDiario set merienda_t = @Producto, consumo_calorias = @CaloriasTotal
                    		WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
              			END
              		ELSE
                    	BEGIN
                    		SET @ProductosFinal = @Producto + ', ' + @ProductosAgregados
                    		SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
                
                    		UPDATE ConsumoDiario set merienda_t = @ProductosFinal, consumo_calorias = @CaloriasTotal
                    		WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                   		END
            	END
            ELSE if @Horario = 'Almuerzo'
        
                BEGIN
                    SELECT @ProductosAgregados = almuerzo, @CaloriasExistentes = consumo_calorias FROM ConsumoDiario
                    WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                                   
                    if @ProductosAgregados is NULL
                    	BEGIN
                    		SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
                
                    		UPDATE ConsumoDiario set almuerzo = @Producto, consumo_calorias = @CaloriasTotal
                    		WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
               			END
					ELSE
                    BEGIN
                    	SET @ProductosFinal = @Producto + ', ' + @ProductosAgregados
                    	SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
                
                    	UPDATE ConsumoDiario set almuerzo = @ProductosFinal, consumo_calorias = @CaloriasTotal
                    	WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                   END
             	END
            ELSE if @Horario = 'Cena'
        
                BEGIN
                    SELECT @ProductosAgregados = cena, @CaloriasExistentes = consumo_calorias FROM ConsumoDiario
                    WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
                
                    if @ProductosAgregados is NULL
                    	BEGIN
                    		SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
                    		UPDATE ConsumoDiario set cena = @Producto, consumo_calorias = @CaloriasTotal
                    		WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
           				END
                        
                    ELSE

                    	SET @ProductosFinal = @Producto + ', ' + @ProductosAgregados
                    	SET @CaloriasTotal = @caloriasProducto + @CaloriasExistentes
                    	UPDATE ConsumoDiario set cena = @ProductosFinal, consumo_calorias = @CaloriasTotal
                    	WHERE DAY(fecha)=DAY(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND MONTH(fecha)=MONTH(getdate()) AND @cedula = cedula_paciente
               	END      
        END


-----Obtiene los nombres de las recetas de un paciente
CREATE PROCEDURE GetRecetasPaciente (@Email VARCHAR(50))

AS
Declare @cedula INT, @nombrePlan VARCHAR(100), @Resultado1 VARCHAR(100), @Resultado2 VARCHAR(100)
    BEGIN 
		SELECT R.nombre FROM Paciente AS p JOIN Receta AS R ON cedula = cedula_paciente 
		WHERE @Email = email

    END

----Obtiene los prooductos definidos en el plan de un paciente
CREATE PROCEDURE GetProductosDePaciente (@Email VARCHAR(50))

AS
Declare @cedula INT, @nombrePlan VARCHAR(100), @Resultado1 VARCHAR(100), @Resultado2 VARCHAR(100)
    BEGIN 
		SELECT descripcion FROM PdtsPacientes
		WHERE @Email = email

    END


---- Obtiene una lista de los pacientes que no tienen un nutrisionista asosiado
CREATE PROCEDURE PacienteSinNutri
AS
BEGIN
	select * from paciente
	where codigo_nutricionista IS NULL
END
GO

----Asigna un plan a un paciente
CREATE PROCEDURE AsignarPlanAPaciente(@cedula INT ,@nombre_plan VARCHAR(50),@inicio date,@fin date)

AS
BEGIN
	INSERT INTO plan_por_paciente(cedula, nombre_plan, periodo_inicio, periodo_fin)
	VALUES(@cedula  ,@nombre_plan ,@inicio ,@fin );
END


----- conseguir productos por el nombre
CREATE PROCEDURE GetProductosPlanPorNombre (@Email VARCHAR(60), @nombre VARCHAR(60))

AS
Declare @nombrePlan VARCHAR(100)


    BEGIN
        SELECT @nombrePlan = nombre_plan FROM email_plan_pacientes
        WHERE @Email = email
    END

    BEGIN
        SELECT descripcion FROM Producto
        WHERE codigo_de_barras IN(SELECT codigo_barras FROM Producto_por_plan
        WHERE @nombrePlan = nombre_plan) AND @nombre = descripcion
    END
-------------conseguir productos por codigo
CREATE PROCEDURE GetProductosPlanPorCodigo (@Email VARCHAR(60), @codigo VARCHAR(60))

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
        WHERE @nombrePlan = nombre_plan) AND codigo_de_barras = @codigo
    END


----Obtener el nombre de una receta por nombre de usuario
CREATE PROCEDURE GetNombreRecetasPorNombre (@Email VARCHAR(60), @Nombre)

AS
Declare @cedula INT
BEGIN 
    SELECT @cedula=cedula FROM paciente
    WHERE @Email = email
END

BEGIN
    SELECT nombre FROM Receta
    WHERE @cedula = cedula_paciente AND @Nombre = nombre
END

-----Obtiene un nutricionista por el email
CREATE PROCEDURE GetNutriXEmail(@email VARCHAR(40))

AS
BEGIN
	select * from Usuario
	WHERE @email = email
END

----- Asigna un nutricionista a un paciente
CREATE PROCEDURE AsignarNutriAPaciente(@cedula_paciente INT,@codigo_nutri VARCHAR(20))
AS
BEGIN
	UPDATE paciente
	SET codigo_nutricionista = @codigo_nutri
	WHERE cedula = @cedula_paciente

END
GO



------ Desasignar un nutricionista de un paciente
CREATE PROCEDURE DesligarNutricionista(@cedula_paciente INT)
AS
BEGIN
	UPDATE paciente
	SET codigo_nutricionista = @codigo_nutri
	WHERE cedula = @cedula_paciente

END
GO


--------Obtener los pacientes de un nutricionista
CREATE PROCEDURE GetPacientesDeUnNutri(@nutri VARCHAR(20))
AS
BEGIN
	SELECT * FROM paciente
	WHERE codigo_nutricionista = @nutri

END
GO

------Obtiene los consumos diarios de un paciente
CREATE PROCEDURE GetConsumosPaciente(@cedula INT)
AS
BEGIN
	SELECT * FROM ConsumoDiario
	WHERE cedula_paciente = @cedula

END
GO


----Obtiene un paciente x email
CREATE PROCEDURE GetPacienteXEmail(@email VARCHAR(40))

AS
BEGIN
	select * from paciente
	WHERE @email = email
END


----Obtiene la procion de la receta
CREATE PROCEDURE GetPorcionReceta (@Email VARCHAR(60), @Nombre VARCHAR(100))
AS
Declare @cedula INT
    BEGIN 
        SELECT @cedula=cedula FROM paciente
        WHERE @Email = email
    END

    BEGIN
        SELECT tamano_porcion FROM Receta
        WHERE @cedula = cedula_paciente AND @Nombre = nombre
    END


----Se agrea un producto a un plan
CREATE PROCEDURE AgregarProductoPlan (@NombrePlan VARCHAR(50), @Producto VARCHAR(100))

AS
 Declare @Codigo VARCHAR(50)
     BEGIN

        SELECT @Codigo = codigo_de_barras FROM Producto
        WHERE @Producto = descripcion

        INSERT INTO Producto_por_plan(codigo_barras, nombre_plan)
        VALUES(@Codigo, @NombrePlan)



    END


------Crea el reporte de cobro
CREATE PROCEDURE ReporteCobro
AS
BEGIN
	DECLARE @monto_total int, @descuento int, @monto_cobrar int, @contador int
	DECLARE	@tabla table(tipoc VARCHAR(50),codigo_nut VARCHAR(50), email VARCHAR(50),nombre1 VARCHAR(50),nombre2 VARCHAR(50), numerotarjeta int,
			apellido1 VARCHAR(50),apellido2 VARCHAR(50),cantidad_pacientes int,monto_total int,descuento int,monto_cobrar float)

	DECLARE	@tabla2 table(tipoc VARCHAR(50),codigo_nut VARCHAR(50), email VARCHAR(50),nombre1 VARCHAR(50),nombre2 VARCHAR(50),
			apellido1 VARCHAR(50),apellido2 VARCHAR(50), numerotarjeta int,cantidad_pacientes int,monto_total int,descuento int,monto_cobrar float)
	
	INSERT INTO @tabla (tipoc ,codigo_nut , email ,nombre1,nombre2,
				apellido1 ,apellido2,numerotarjeta ,cantidad_pacientes) SELECT * from tablaCobro

	INSERT INTO @tabla2 (tipoc ,codigo_nut , email ,nombre1,nombre2,
				apellido1 ,apellido2,numerotarjeta ,cantidad_pacientes) SELECT * from tablaCobro

	SELECT @contador = COUNT(*) FROM @tabla

	WHILE @contador > 0
	BEGIN

		DECLARE @tipocobro VARCHAR(50) = (SELECT top(1) tipoc FROM @tabla ORDER BY codigo_nut)
		DECLARE @nutricionista VARCHAR(50) = (SELECT top(1) codigo_nut FROM @tabla ORDER BY codigo_nut)
		DECLARE @cant_pacientes int = (SELECT top(1) cantidad_pacientes FROM @tabla ORDER BY codigo_nut)

		IF @tipocobro = 'Semanal'
		BEGIN
			UPDATE @tabla2
			SET monto_total = @cant_pacientes,
				descuento = 0,
				monto_cobrar = @cant_pacientes - @cant_pacientes*0
			WHERE @nutricionista = codigo_nut
		END

		IF @tipocobro = 'Mensual'
		BEGIN
			UPDATE @tabla2
			SET monto_total = @cant_pacientes,
				descuento = 5,
				monto_cobrar = @cant_pacientes - @cant_pacientes*0.05
			WHERE @nutricionista = codigo_nut
		END

		IF @tipocobro = 'Anual'
		BEGIN
			UPDATE @tabla2
			SET monto_total = @cant_pacientes,
				descuento = 10,
				monto_cobrar = @cant_pacientes - @cant_pacientes*0.1
			WHERE @nutricionista = codigo_nut
		END

		delete @tabla where @nutricionista = codigo_nut
		SET @contador = (SELECT COUNT(*) FROM @tabla)
	END

	SELECT * from @tabla2
	
END




---------------------------Vistas----------------------------------------------------------------------------------------------------------------

--------Productos aprovados-----------
CREATE VIEW ProductosAprobados
AS
SELECT * FROM Producto
WHERE estado = 'aprobado'

--------Productos en espera-----------
CREATE VIEW ProductosEnEspera
AS
SELECT * FROM Producto
WHERE estado = 'en espera'

--------Une los planes con el email-----------
CREATE VIEW email_plan_pacientes

AS
        SELECT plan_por_paciente.nombre_plan,paciente.email
        FROM paciente
        INNER JOIN plan_por_paciente ON paciente.cedula=plan_por_paciente.cedula 

------Obtiene los productos y los emails de pacientes------------
CREATE VIEW PdtsPacientes
AS
SELECT email,descripcion FROM Paciente AS p JOIN plan_por_paciente AS ppp ON ppp.cedula = p.cedula JOIN Plan_Alimentacion AS PA ON PA.nombre = ppp.nombre_plan
		JOIN Producto_por_plan AS pdtopp ON pdtopp.nombre_plan = PA.nombre JOIN Producto ON codigo_barras = codigo_de_barras


----Obtiene un contedo de los nutricionistas y la cantidad de paciente
CREATE VIEW tablaCobro
AS
	SELECT tipo_cobro, us.codigo_nutricionista,us.email,us.nombre1,us.nombre2,us.apellido1,us.apellido2,numero_tarjeta ,
			COUNT(*) as cantidad_pacientes
	FROM paciente as p join usuario as us on p.codigo_nutricionista = us.codigo_nutricionista

	WHERE rol = 'nutricionista'

	GROUP BY tipo_cobro,us.codigo_nutricionista, us.email,us.nombre1,us.nombre2,us.apellido1,us.apellido2,numero_tarjeta

select * from tablaCobro


--------------------TRIGGERS--------------------------------------------------------------------------------------------------------------

---------Impide el borrado de una tabla-----------------------------------
CREATE TRIGGER TR_DropTable ON DATABASE
For DROP_TABLE
AS
PRINT 'Desactive el trigger TR_DropTable para poder eliminar una tabla'
ROLLBACK

--------Impide que se ingrese un producto con cantidades menores a 0------
CREATE TRIGGER TR_validarCantidades
ON Producto
for insert
AS
	if(select tamano_porcion from inserted)<=0
	BEGIN
		ROLLBACK TRANSACTION
		PRINT'El tamano de la porcion no puede ser menor a 0'
	END
	if(select energia from inserted)<=0
	BEGIN
		ROLLBACK TRANSACTION
		PRINT'La energia no puede ser menor a 0'
	END
	if(select grasa from inserted)<=0
	BEGIN
		ROLLBACK TRANSACTION
		PRINT'La cantidad de grasa no puede ser menor a 0'
	END
	if(select sodio from inserted)<=0
	BEGIN
		ROLLBACK TRANSACTION
		PRINT'La cantidad de sodio no puede ser menor a 0'
	END
	if(select carbohidrato from inserted)<=0
	BEGIN
		ROLLBACK TRANSACTION
		PRINT'La cantidad de carbohidratos no puede ser menor a 0'
	END
	if(select proteina from inserted)<=0
	BEGIN
		ROLLBACK TRANSACTION
		PRINT'La cantidad de proteina no puede ser menor a 0'
	END
	if(select calcio from inserted)<=0
	BEGIN
		ROLLBACK TRANSACTION
		PRINT'La cantidad de calcio no puede ser menor a 0'
	END
	if(select hierro from inserted)<=0
	BEGIN
		ROLLBACK TRANSACTION
		PRINT'La cantidad de hierro no puede ser menor a 0'
	END