--Insert de roles
INSERT INTO Rol(Nombre,Descripcion) 
VALUES('Administrador', 'Administra la aplicacion');

INSERT INTO Rol(Nombre,Descripcion) 
VALUES('Nutricionista', 'Usa la aplicacion como servicio');

--Insert de usuarios
INSERT INTO Usuario(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, edad, codigo_nutricionista, pass, email, numero_tarjeta, tipo_cobro, rol, direccion, foto) 
VALUES('Paula', 'Maria', 'Alpizar', 'Herrera', 307760989, '09/08/1990', 22, 'N0001', 'cQNeHA1/qFXFuuRm/xlBSA==', 'pau.a@gmail.com', 222333444, 
       'Semanal', 'Administrador', 'Santo Domingo Heredia', 'url');
       
INSERT INTO Usuario(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, edad, codigo_nutricionista, pass, email, numero_tarjeta, tipo_cobro, rol, direccion, foto) 
VALUES('Armando', 'Jose', 'Araya', 'Delgado', 109870654, '02/12/1987', 26, 'N0002', 'z1BLC2S7vE1A38oz6lgCMA==', 'arman.a@gmail.com', 111222333, 
       'Anual', 'Nutricionista', 'San Pedro San Jose', 'url');

INSERT INTO Usuario(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, edad, codigo_nutricionista, pass, email, numero_tarjeta, tipo_cobro, rol, direccion, foto) 
VALUES('Silvia', 'Teresa', 'Leiva', 'Matarrita', 209760222, '07/05/1989', 32, 'N0003', '41hx9j5G8+SyyoumqBNOcw==', 'silvia.leiva@gmail.com', 555666777, 
       'Mensual', 'Nutricionista', 'Santa Rosa Turrialba', 'url');
       
INSERT INTO Usuario(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, edad, codigo_nutricionista, pass, email, numero_tarjeta, tipo_cobro, rol, direccion, foto) 
VALUES('Oscar', 'Enrique', 'Fallas', 'Chacon', 305230111, '08/10/1990', 22, 'N0004', 'e3a5i7b6F0ndjocE/hvqXA==', 'enri.fallas@gmail.com', 999111222, 
       'Semanal', 'Nutricionista', 'Santo Domingo Heredia', 'url');

INSERT INTO Usuario(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, edad, codigo_nutricionista, pass, email, numero_tarjeta, tipo_cobro, rol, direccion, foto) 
VALUES('Roberto', 'Ramiro', 'Benavides', 'Arguello', 405670980, '11/04/1985', 24, 'N0005', 'z2XX346UitdVxKXXdfidDg==', 'roberto.ramiro@gmail.com', 333666999, 
       'Semanal', 'Nutricionista', 'El Coyol Alajuela', 'url');

--Insert productos
INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('CVA02092000', 'Queso Turrialba Dos Pinos', 65, 87, 12, 8, 34, 15, 9, 'en espera', 89);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('ABC24121997', 'Yogurt Griego Dos Pinos', 6, 7, 23, 38, 3, 5, 19, 'en espera', 76);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('FLC22244555', 'Brownie cero azucar', 67, 12, 24, 18, 45, 16, 8, 'en espera', 80);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('NBA12345678', 'Galleta Maria', 12, 24, 56, 16, 15, 16, 18, 'en espera', 60);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('EMC65423499', 'Jugo de Naranja 100', 22, 56, 47, 18, 52, 61, 82, 'en espera', 80);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('VDC12567777', 'Arroz Integral', 79, 14, 42, 13, 53, 6, 82, 'aprobado', 18);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('PCH02121965', 'Quinoa', 73, 12, 41, 11, 35, 66, 8, 'aprobado', 78);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('PMN6018415', 'Frijoles', 74, 122, 41, 13, 55, 61, 82, 'aprobado', 65);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('NWN6789041', 'Papaya', 10, 12, 2, 12, 15, 16, 82, 'aprobado', 90);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('AFG1165478', 'Banano', 16, 34, 1, 6, 12, 88, 23,'aprobado', 12);

INSERT INTO producto(codigo_de_barras, descripcion, tamano_porcion, energia, grasa, sodio, carbohidrato, proteina, calcio, estado, hierro) 
VALUES('DAC22451236', 'Aceite de Oliva', 7, 24, 18, 16, 5, 6, 8, 'aprobado', 8);

--Insert de vitaminas
INSERT INTO Vitamina (vitamina)
VALUES ('A');
INSERT INTO Vitamina (vitamina)
VALUES ('C');
INSERT INTO Vitamina (vitamina)
VALUES ('D');
INSERT INTO Vitamina (vitamina)
VALUES ('E');
INSERT INTO Vitamina (vitamina)
VALUES ('K');
INSERT INTO Vitamina (vitamina)
VALUES ('B1');
INSERT INTO Vitamina (vitamina)
VALUES ('B2');
INSERT INTO Vitamina (vitamina)
VALUES ('B3');
INSERT INTO Vitamina (vitamina)
VALUES ('B6');
INSERT INTO Vitamina (vitamina)
VALUES ('B12');
INSERT INTO Vitamina (vitamina)
VALUES ('B9');
INSERT INTO Vitamina (vitamina)
VALUES ('B5');

---Insert de los pacientes
INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Mario', 'Neta', 'Del', 'Socorro', 303360333, '01/10/1980', 83, 'activo',41, 'shWuQPiPNB0=', 'mario@gmail.com', 41,'Holanda', 'N0001');
       
INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Baso', 'Quebrado', 'Del', 'Cordero', 104411333, '08/01/1995', 59, 'activo',26, '5kV09FqsF/4=', 'bquebra@gmail.com', 26,'Nicaragua', 'N0002');


INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Carita', 'Feliz', 'Monestel', 'Chicarron', 505511555, '11/18/2000', 64, 'activo',21, 'r0zK9ekqKMQ=', 'cfeliz@gmail.com', 21,'Chile', 'N0003');


INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Tatiana', 'Gabriela', 'Montes', 'Colorados', 102221223, '05/20/1997', 55, 'activo',19, 'kK7E6PzXL1s=', 'gabi.m@gmail.com', 24,'Argentina', 'N0004');


INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Coquito', 'Dulce', 'Sanchez', 'Leiva', 105555393, '03/03/1993', 69, 'activo',28, 'fKlrzGfNM/0=', 'coquit@gmail.com', 23,'Bolivia', 'N0005');
  

INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Eso', 'Tilin', 'Leiva', 'Lopez', 302220983, '09/03/1980', 73, 'activo',41, 'yYJ1vpvGjik=', 'tilin@gmail.com', 41,'Paraguay', 'N0001');
       
INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Pancito', 'Dulce', 'Ulloa', 'Arguedas', 102222345, '05/08/1995', 49, 'activo',26, 'IwPO/IXYQlU=', 'pandulce@gmail.com', 26,'Panama', 'N0002');


INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Agua', 'Salada', 'Rivera', 'Solis', 409911234, '01/30/2000', 60, 'activo',21, 'tnVZB5tyX88=', 'aguas@gmail.com', 21,'Uruguay', 'N0003');


INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Plato', 'Lavado', 'Montero', 'Campos', 102341234, '05/31/1997', 65, 'activo',25, '4SPqXJr06x8=', 'plt.lav@gmail.com', 24,'Mexico', 'N0004');


INSERT INTO paciente(nombre1, nombre2, apellido1, apellido2, cedula, fecha_de_nacimiento, peso, estado, edad, pass, email, imc, pais, codigo_nutricionista) 
VALUES('Tres', 'Leches', 'Salvador', 'Arias', 105432783, '07/07/1993', 79, 'activo',24, '6wh0mvMN/R0=', 'tres.leches@gmail.com', 23,'Colombia', 'N0005');

--Insert de las medidas
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 90, 60, 30, 65, 20, 40, 303360333);
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 80, 70, 40, 55, 34, 37, 104411333);
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 86, 74, 36, 70, 34, 20, 505511555);
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 74, 52, 33, 80, 30, 25, 102221223);
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 54, 32, 43, 67, 33, 18, 105555393);
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 59, 62, 43, 43, 24, 27, 102222345);
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 62, 32, 24, 60, 32, 26, 409911234);
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 83, 67, 35, 54, 26, 29, 102341234);
INSERT INTO Medida(fecha_ingreso, cadera, cintura, cuello, peso, porcentaje_musculo, porcentaje_grasa, cedula_paciente) 
VALUES(getdate(), 72, 55, 31, 73, 27, 24, 105432783);


--Insert de los planes 
INSERT INTO plan_alimentacion(nombre, desayuno,merienda_manana, almuerzo, cena, merienda_tarde, nutricionista) 
VALUES('Aumento Masa Muscular', '2 proteinas, 2 carbohidratos, 1 fruta, 1 grasa',
       '1 carbohidratos, 1 fruta', '2 proteinas, 2 carbohidratos, 2 vegetales, 1 fruta, 1 grasa',
      '2 proteinas, 2 carbohidratos, 1 vegetal, 1 grasa', '1 fruta, 1 carbohidrato', 'N0002');

INSERT INTO plan_alimentacion(nombre, desayuno,merienda_manana, almuerzo, cena, merienda_tarde, nutricionista) 
VALUES('Disminucion Grasa', '1 proteinas, 3 carbohidratos, 2 fruta, 1 grasa',
       '3 carbohidrato,  fruta', '2 proteinas, 2 carbohidratos, 2 vegetales, 1 fruta, 1 grasa',
      '2 proteinas, 3 carbohidratos, 1 vegetal, 1 grasa', '2 fruta, 1 carbohidrato', 'N0002');

INSERT INTO plan_alimentacion(nombre, desayuno,merienda_manana, almuerzo, cena, merienda_tarde, nutricionista) 
VALUES('Deportista Alto Rendimiento', '3 proteinas, 4 carbohidratos, 2 fruta, 1 grasa',
       '1 carbohidratos, 2 fruta', '3 proteinas, 3 carbohidratos, 2 vegetales, 1 fruta, 2 grasa',
      '2 proteinas, 2 carbohidratos, 1 vegetal, 1 grasa', '1 fruta, 2 carbohidratos', 'N0003');

INSERT INTO plan_alimentacion(nombre, desayuno,merienda_manana, almuerzo, cena, merienda_tarde, nutricionista) 
VALUES('Diabetico 1', '3 proteinas, 4 carbohidratos, 2 fruta, 1 grasa',
       '2 carbohidratos', '3 proteinas, 3 carbohidratos, 2 vegetales 2 grasa',
      '3 proteinas, 2 carbohidratos, 4 vegetal, 1 grasa', '1 fruta, 2 carbohidratos', 'N0004');

INSERT INTO plan_alimentacion(nombre, desayuno,merienda_manana, almuerzo, cena, merienda_tarde, nutricionista) 
VALUES('Lactancia', '3 proteinas, 4 carbohidratos, 2 fruta, 1 grasa',
       '2 carbohidratos, 2 fruta', '3 proteinas, 3 carbohidratos, 2 vegetales, 1 fruta, 2 grasa',
      '2 proteinas, 2 carbohidratos, 1 vegetal, 1 grasa', '2 fruta, 2 carbohidratos', 'N0005');

--Insert de recetas
INSERT INTO Receta(nombre, calorias, carbohidratos, grasa, sodio, proteina, hierro, tamano_porcion, calcio,cedula_paciente) 
VALUES('Gallo Pinto', 314, 36, 15, 1, 8, 5, 300, 13,303360333);

INSERT INTO Receta(nombre, calorias, carbohidratos, grasa, sodio, proteina, hierro, tamano_porcion, calcio,cedula_paciente) 
VALUES('Postre De Frutas', 214, 26, 13, 2, 3, 4, 200, 10,102221223);

INSERT INTO Receta(nombre, calorias, carbohidratos, grasa, sodio, proteina, hierro, tamano_porcion, calcio,cedula_paciente) 
VALUES('Yogurt gustoso', 114, 22, 11, 4, 2, 6, 250, 7,303360333);

--Insert productos por recetas
INSERT INTO Producto_por_receta(codigo_barras, nombre_receta) 
VALUES('VDC12567777','Gallo Pinto');
INSERT INTO Producto_por_receta(codigo_barras, nombre_receta) 
VALUES('PMN6018415','Gallo Pinto');
INSERT INTO Producto_por_receta(codigo_barras, nombre_receta) 
VALUES('DAC22451236','Gallo Pinto');
INSERT INTO Producto_por_receta(codigo_barras, nombre_receta) 
VALUES('ABC24121997','Postre De Frutas');
INSERT INTO Producto_por_receta(codigo_barras, nombre_receta) 
VALUES('AFG1165478','Postre De Frutas');
INSERT INTO Producto_por_receta(codigo_barras, nombre_receta) 
VALUES('ABC24121997','Yogurt gustoso');
INSERT INTO Producto_por_receta(codigo_barras, nombre_receta) 
VALUES('NBA12345678','Yogurt gustoso');

--Insert de cada plan por paciente
INSERT INTO plan_por_paciente(cedula, nombre_plan, periodo_inicio, periodo_fin)
VALUES(303360333, 'Aumento Masa Muscular', '02-13-2020', '12-03-2021');
INSERT INTO plan_por_paciente(cedula, nombre_plan, periodo_inicio, periodo_fin)
VALUES(104411333, 'Disminucion Grasa', '02-03-2021', '06-24-2022');
INSERT INTO plan_por_paciente(cedula, nombre_plan, periodo_inicio, periodo_fin)
VALUES(102341234, 'Lactancia', '06-25-2021', '07-24-2023');
INSERT INTO plan_por_paciente(cedula, nombre_plan, periodo_inicio, periodo_fin)
VALUES(105432783, 'Diabetico 1', '02-25-2021', '11-21-2024');
INSERT INTO plan_por_paciente(cedula, nombre_plan, periodo_inicio, periodo_fin)
VALUES(102222345, 'Deportista Alto Rendimiento', '01-05-2020', '12-21-2021');
INSERT INTO plan_por_paciente(cedula, nombre_plan, periodo_inicio, periodo_fin)
VALUES(302220983, 'Aumento Masa Muscular', '03-06-2021', '04-01-2022');


--Insert de las vitaminas por cada producto
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('A','CVA02092000');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('D','CVA02092000');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('A','ABC24121997');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('D','ABC24121997');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B1','FLC22244555');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B2','FLC22244555');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B3','FLC22244555');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B2','NBA12345678');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B3','NBA12345678');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('A','EMC65423499');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('C','EMC65423499');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B6','EMC65423499');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B1','VDC12567777');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B2','VDC12567777');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B3','VDC12567777');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B1','PCH02121965');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B6','PCH02121965');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B1','NWN6789041');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B2','NWN6789041');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B3','NWN6789041');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('A','NWN6789041');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('C','NWN6789041');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B1','AFG1165478');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B2','AFG1165478');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B9','AFG1165478');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('E','AFG1165478');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('A','AFG1165478');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('C','AFG1165478');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('A','DAC22451236');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('D','DAC22451236');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('E','DAC22451236');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('K','DAC22451236');

INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B1','PMN6018415');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B2','PMN6018415');
INSERT INTO vitaminas_por_producto(vitamina,codigo_barras)
VALUES ('B3','PMN6018415');


--Insert vitaminas por receta
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('B1', 'Gallo Pinto');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('B2', 'Gallo Pinto');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('B3', 'Gallo Pinto');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('A', 'Gallo Pinto');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('D', 'Gallo Pinto');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('E', 'Gallo Pinto');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('K', 'Gallo Pinto');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('A', 'Postre De Frutas');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('D', 'Postre De Frutas');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('B1', 'Postre De Frutas');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('B2', 'Postre De Frutas');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('B9', 'Postre De Frutas');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('E', 'Postre De Frutas');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('C', 'Postre De Frutas');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('A', 'Yogurt gustoso');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('D', 'Yogurt gustoso');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('B2', 'Yogurt gustoso');
INSERT INTO Vitaminas_por_receta(vitamina, nombre_receta)
VALUES('B3', 'Yogurt gustoso');

--Inser de los productos de los planes
insert into producto_por_plan (codigo_barras, nombre_plan)
VALUES ('DAC22451236','Aumento Masa Muscular');

insert into producto_por_plan (codigo_barras, nombre_plan)
VALUES ('ABC24121997','Deportista Alto Rendimiento');

insert into producto_por_plan (codigo_barras, nombre_plan)
VALUES ('EMC65423499','Disminucion Grasa');

insert into producto_por_plan (codigo_barras, nombre_plan)
VALUES ('PMN6018415','Diabetico 1');

insert into producto_por_plan (codigo_barras, nombre_plan)
VALUES ('FLC22244555','Deportista Alto Rendimiento');

insert into producto_por_plan (codigo_barras, nombre_plan)
VALUES ('NWN6789041','Lactancia');

insert into producto_por_plan (codigo_barras, nombre_plan)
VALUES ('AFG1165478','Disminucion Grasa');

--Insert de los consumos diarios
INSERT INTO ConsumoDiario(fecha, almuerzo, cena, desayuno, merienda_m, merienda_t, consumo_calorias, cedula_paciente)
VALUES('04-12-2021', '2 proteinas, 2 carbohidratos, 1 fruta, 1 grasa', '2 proteinas, 2 carbohidratos, 2 vegetales, 1 fruta, 1 grasa', '2 proteinas, 2 carbohidratos, 1 vegetal, 1 grasa', '1 fruta, 1 carbohidrato', '2 proteinas, 2 carbohidratos, 1 fruta, 1 grasa', 250, 303360333);

INSERT INTO ConsumoDiario(fecha, almuerzo, cena, desayuno, merienda_m, merienda_t, consumo_calorias, cedula_paciente)
VALUES('10-13-2021', '3 carbohidrato,  fruta', '2 proteinas, 2 carbohidratos, 2 vegetales, 1 fruta, 1 grasa',  '2 proteinas, 3 carbohidratos, 1 vegetal, 1 grasa', '2 fruta, 1 carbohidrato', '2 proteinas, 2 carbohidratos, 2 vegetales, 1 fruta, 1 grasa',300, 104411333);

INSERT INTO ConsumoDiario(fecha, almuerzo, cena, desayuno, merienda_m, merienda_t, consumo_calorias, cedula_paciente)
VALUES('10-13-2021', '3 proteinas, 4 carbohidratos, 2 fruta, 1 grasa', '1 carbohidratos, 2 fruta', '3 proteinas, 3 carbohidratos, 2 vegetales, 1 fruta, 2 grasa', '2 proteinas, 2 carbohidratos, 1 vegetal, 1 grasa', '1 fruta, 2 carbohidratos',240, 102222345); 