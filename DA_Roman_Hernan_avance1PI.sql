--Paso 1: Creación de la Base de Datos

-- CREAR UNA CARPETA EN C:
CREATE DATABASE FastFoodDB -- si no lo declaras siempre se crea en esta direccion C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA
ON 
( NAME = 'FastFoodDB_Data',
  FILENAME = 'C:\FastFoodDB\FastFoodDB_Data.mdf', -- Creamos la carpeta de forma manual antes de correr
  SIZE = 50MB,
  MAXSIZE = 1GB,
  FILEGROWTH = 5MB )
LOG ON
( NAME = 'Carrera_BD_Log',
  FILENAME = 'C:\FastFoodDB\FastFoodDB_Log.ldf',
  SIZE = 25MB,
  MAXSIZE = 256MB,
  FILEGROWTH = 5MB );

--Usar la Base de Datos
USE FastFoodDB;

--Ver datos de la base de datos
SELECT name, database_id, create_date 
FROM sys.databases 
WHERE name = 'FastFoodDB';

-- Tabla categorías
CREATE TABLE Categorias (
	CategoriaID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL);

-- Tabla Productos
CREATE TABLE Productos (
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	CategoriaID INT,
	Precio DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID));

-- Sucursales
CREATE TABLE Sucursales (
    SucursalID INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(100) );

-- Empleados
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Posicion VARCHAR(100) NOT NULL,
    Departamento VARCHAR(100) NOT NULL,
    SucursalID INT,
    Rol VARCHAR(50) NOT NULL, -- Vendedor, Mensajero, etc.
    FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID));

-- Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(100) NOT NULL);

-- Origen Orden
CREATE TABLE OrigenesOrden (
    OrigenID INT PRIMARY KEY IDENTITY,
    Descripcion VARCHAR(100) NOT NULL);

-- Tipos Pago
CREATE TABLE TiposPago (
    TipoPagoID INT PRIMARY KEY IDENTITY,
    Descripcion VARCHAR(100) NOT NULL);

-- Mensajeros
CREATE TABLE Mensajeros (
    MensajeroID INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    EsExterno BIT NOT NULL);

-- Ordenes
CREATE TABLE Ordenes (
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT,
	EmpleadoID INT, -- Empleado que toma la orden
	SucursalID INT,
	MensajeroID INT, -- Puede ser externo o un empleado
	TipoPagoID INT,
	OrigenID INT, -- En linea, presencial, Servicarro, teléfono
	HorarioVenta VARCHAR(50) NOT NULL, -- Mañana,tarde y noche
	TotalCompra DECIMAL(10,2) NOT NULL,
	KilometrosRecorrer DECIMAL(10,2), -- En caso de que sea domicilio
	FechaDespacho DATETIME, -- En caso de que sea domicilio (Hora y fecha se entrega al repartidor)
	FechaEntrega DATETIME, -- En caso de que sea domicilio (Hora y fecha entrega al cliente)
	FechaOrdenTomada DATETIME NOT NULL, -- (Hora y fecha toma de orden)
	FechaOrdenLista DATETIME NOT NULL, -- (Hora y fecha de salir de cocina)
	FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
	FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID),
	FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID),
	FOREIGN KEY (MensajeroID) REFERENCES Mensajeros(MensajeroID),
	FOREIGN KEY (TipoPagoID) REFERENCES TiposPago(TipoPagoID),
	FOREIGN KEY (OrigenID) REFERENCES OrigenesOrden(OrigenID));

-- Tabla Detalles Orden
CREATE TABLE DetalleOrdenes (
	OrdenID INT,
	ProductoID INT,
	Cantidad INT,
	Precio DECIMAL(10,2),
	PRIMARY KEY (OrdenID,ProductoID),
	FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID),
	FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID));