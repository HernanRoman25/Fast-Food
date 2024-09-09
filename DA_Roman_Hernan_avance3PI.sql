USE FastFoodDB;

 --1 - ¿Cuál es el total de ventas (TotalCompra) a nivel global?
SELECT 
	SUM(TotalCompra) AS TotalVentas
FROM Ordenes;

--2 - ¿Cuál es el precio promedio de los productos dentro de cada categoría?
SELECT CategoriaID,
	CAST(avg(Precio) AS DECIMAL (10,2)) PrecioPromedio
FROM Productos
group by CategoriaID
ORDER BY PrecioPromedio desc;

--3 - ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?
select SucursalID,
	min (TotalCompra) as OrdenMinimo,
	max (TotalCompra) as OrdenMaximo
from Ordenes
group by SucursalID;

--4 - ¿Cuál es el mayor número de kilómetros recorridos para una entrega?
select 
	max (KilometrosRecorrer) as MayorNumeroKilometros
from Ordenes;

--5 - ¿Cuál es la cantidad promedio de productos por orden?
SELECT OrdenID,
	avg(Cantidad) AS PromedioCantidadProductos
FROM DetalleOrdenes
group by OrdenID;

--6 - ¿Cuál es el total de ventas por cada tipo de pago?
select TipoPagoID,
	sum(TotalCompra) as TotalVenta
from Ordenes
group by TipoPagoID
order by TotalVenta desc;

-- 7 - ¿Cuál sucursal tiene la venta promedio más alta?
select top 1 SucursalID, 
	cast(avg(TotalCompra) as decimal (10,2) ) PromedioVenta
from Ordenes
group by SucursalID
order by PromedioVenta desc;

--8 - ¿Cuáles son las sucursales que han generado ventas por orden por encima de $50?
select sucursalID,
	sum(TotalCompra) TotalVentas
from Ordenes
group by sucursalID
having sum(TotalCompra) >50
order by TotalVentas desc;

--9 - ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?
select 'Antes del 1 de julio de 2023' as Periodo,
	cast(AVG(TotalCompra) as decimal (10,2)) TotalVenta
from Ordenes
where  FechaOrdenTomada < '2023-07-01'
union
select 'Despues del 1 de julio de 2023' as Periodo,
	cast(AVG (TotalCompra) as decimal (10,2)) TotalVenta
from Ordenes
where  FechaOrdenTomada > '2023-07-01' ;

/* 10 - ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas, 
cuál es el valor promedio de estas ventas, y cuál ha sido la venta máxima alcanzada?
*/
select HorarioVenta,
	count(*) as CantidadVentas,
	cast(avg(TotalCompra) as decimal (10,2)) PromedioVentas,
	max(TotalCompra) VentaMaxima
from Ordenes
group by HorarioVenta
order by CantidadVentas desc;