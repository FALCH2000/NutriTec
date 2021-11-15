-- Tabla Usuario

CREATE TABLE Usuario (
    nombre1 varchar(20) not null,
    nombre2 varchar(20),
    apellido1 varchar(20) not null,
    apellido2 varchar(20) not null,
    cedula integer not null,
    fecha_de_nacimiento date not null,
    edad integer,
    codigo_nutricionista VARCHAR(20) not null,
    pass varchar(30) not null,
    email varchar(40) not null,
    numero_tarjeta integer not null,
    tipo_cobro varchar(50) not null,
    rol VARCHAR(50) not null,
    direccion VARCHAR(80),
    foto VARCHAR(80),

    PRIMARY KEY(codigo_nutricionista),
    UNIQUE(cedula, codigo_nutricionista, email)

);

-- Tabla Producto
CREATE TABLE Producto (
  codigo_de_barras varchar(50) not null,
  descripcion varchar(500) not null,
  tamano_porcion integer not null,
  energia integer not null,
  grasa integer not null,
  sodio integer not null,
  carbohidrato integer not null,
  proteina integer not null,
  calcio integer not null,
  estado varchar(50) not null,
  hierro integer not null,

  PRIMARY KEY(codigo_de_barras)
); 

-- Tabla Plan_Alimentacion

CREATE TABLE Plan_Alimentacion (
    nombre varchar(50) not null,
    desayuno varchar(120) NOt null,
    merienda_manana varchar(120) not null,
    almuerzo varchar(120) not null,
    cena VARCHAR(120) not null,
      merienda_tarde varchar(120) not null,
      nutricionista VARCHAR(20) not null,

    PRIMARY KEY(nombre),
    UNIQUE(nombre)

);

-- Tabla Consumo Diario

CREATE TABLE ConsumoDiario (
  fecha date,
  almuerzo Varchar(250),
  cena Varchar(250) ,
  desayuno Varchar(250) ,
  merienda_m Varchar(250) ,
  merienda_t Varchar(250),
  consumo_calorias integer,
  cedula_paciente integer,


    PRIMARY KEY(fecha,cedula_paciente)
); 


--Tabla paciente
CREATE TABLE paciente (
    nombre1 varchar(30) not null,
    nombre2 varchar(30),
    apellido1 varchar(30) not null,
    apellido2 varchar(30) not null,
    cedula integer not null,
    fecha_de_nacimiento date not null,
    peso float,
    estado VARCHAR(30),
    edad integer,
    pass varchar(30) not null,
    email varchar(40) not null,
    imc integer,
    pais VARCHAR(40),
    codigo_nutricionista VARCHAR(20),

    PRIMARY KEY(cedula),
    UNIQUE(cedula, email) 
);

-- Tabla Medida

CREATE TABLE Medida (
    fecha_ingreso DATE not null,
    cadera INTEGER,
      cintura INTEGER,
      cuello INTEGER,
    peso INTEGER NOT null,
    porcentaje_musculo INTEGER NOT null,
      porcentaje_grasa INTEGER NOT null,
      cedula_paciente INTEGER NOT null,

    PRIMARY KEY(fecha_ingreso,cedula_paciente)
);

CREATE TABLE Receta (
    nombre varchar(50) not null,
    calorias Integer,
    carbohidratos integer,
    grasa integer,
    sodio integer,
    proteina integer,
    hierro integer,
    tamano_porcion integer,
    calcio integer,
	cedula_paciente integer,

    PRIMARY KEY(nombre)
);

CREATE TABLE Producto_por_receta(
  codigo_barras VARCHAR(50),
  nombre_receta VARCHAR(50)
);

-- Tabla Plan por paciente

CREATE TABLE plan_por_paciente (
  cedula integer,
  nombre_plan Varchar(50),
  periodo_inicio date,
  periodo_fin date,



    PRIMARY KEY(cedula, nombre_plan)
); 


CREATE TABLE Producto_por_plan(
  codigo_barras VARCHAR(50),
  nombre_plan VARCHAR(50),
	PRIMARY KEY(codigo_barras,nombre_plan)
	
);

create table Vitamina (
  vitamina varchar(10),

  primary key(vitamina)
);

create table Vitaminas_por_producto (
  vitamina varchar(10),
  codigo_barras VARCHAR(50),

  primary key(vitamina,codigo_barras)
);

create table Vitaminas_por_receta (
    vitamina varchar(10),
      nombre_receta VARCHAR(50),

    primary key(vitamina,nombre_receta)
);

-- Tabla de los roles
CREATE TABLE Rol (
  Nombre varchar(50) not null,
  Descripcion Varchar(50) not null,

    PRIMARY KEY(Nombre),
); 

--Asignacion de llaves foraneas
ALTER TABLE Usuario
ADD CONSTRAINT usuario_rol FOREIGN KEY (rol)
REFERENCES Rol(Nombre);

ALTER TABLE Paciente
ADD CONSTRAINT NUTRICIONISTA_PACIENTE_FK FOREIGN KEY    (codigo_nutricionista)
REFERENCES Usuario(codigo_nutricionista); 

ALTER TABLE Medida
ADD CONSTRAINT PACIENTE_MEDIDA_FK FOREIGN KEY    (cedula_paciente)
REFERENCES Paciente(cedula); 

ALTER TABLE ConsumoDiario
ADD CONSTRAINT Paciente_ConsumoDiario_FK FOREIGN KEY    (cedula_paciente)
REFERENCES paciente(cedula);

ALTER TABLE Plan_Alimentacion
ADD CONSTRAINT Plan_Nutricionista_FK FOREIGN KEY    (nutricionista)
REFERENCES Usuario(codigo_nutricionista); 

ALTER TABLE Receta 
ADD CONSTRAINT Cedula_Paciente_FK FOREIGN KEY (cedula_paciente)
REFERENCES paciente(cedula);

ALTER TABLE plan_por_paciente 
ADD CONSTRAINT Cedula_PPP_FK FOREIGN KEY (cedula)
REFERENCES paciente(cedula);

ALTER TABLE plan_por_paciente 
ADD CONSTRAINT nombre_plan_PPP_FK FOREIGN KEY (nombre_plan)
REFERENCES plan_alimentacion(nombre);

ALTER TABLE vitaminas_por_producto
ADD CONSTRAINT Vitamina_PProduct_FK FOREIGN KEY (vitamina)
REFERENCES vitamina(vitamina);

ALTER TABLE vitaminas_por_producto
ADD CONSTRAINT Vitamina_Codigo_FK FOREIGN KEY (codigo_barras)
REFERENCES producto(codigo_de_barras);

ALTER TABLE vitaminas_por_receta
ADD CONSTRAINT Vitamina_PRece_FK FOREIGN KEY (vitamina)
REFERENCES vitamina(vitamina);

ALTER TABLE vitaminas_por_receta
ADD CONSTRAINT Vitamina_nombre_FK FOREIGN KEY (nombre_receta)
REFERENCES receta(nombre);

ALTER TABLE producto_por_receta
ADD CONSTRAINT Codigo_PRece_FK FOREIGN KEY (codigo_barras)
REFERENCES producto(codigo_de_barras);

ALTER TABLE producto_por_receta
ADD CONSTRAINT Codigo_nombre_FK FOREIGN KEY (nombre_receta)
REFERENCES receta(nombre);

ALTER TABLE producto_por_plan
ADD CONSTRAINT Codigo_PPlan_FK FOREIGN KEY (codigo_barras)
REFERENCES producto(codigo_de_barras);

ALTER TABLE producto_por_plan
ADD CONSTRAINT Plan_nombre_FK FOREIGN KEY (nombre_plan)
REFERENCES plan_alimentacion(nombre);