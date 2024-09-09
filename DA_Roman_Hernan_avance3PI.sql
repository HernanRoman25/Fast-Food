USE FastFoodDB;

 --1 - �Cu�l es el total de ventas (TotalCompra) a nivel global?
SELECT 
	SUM(TotalCompra) AS TotalVentas
FROM Ordenes;

--2 - �Cu�l es el precio promedio de los productos dentro de cada categor�a?
SELECT CategoriaID,
	CAST(avg(Precio) AS DECIMAL (10,2)) PrecioPromedio
FROM Productos
group by CategoriaID
ORDER BY PrecioPromedio desc;

--3 - �Cu�l es el valor de la orden m�nima y m�xima por cada sucursal?
select SucursalID,
	min (TotalCompra) as OrdenMinimo,
	max (TotalCompra) as OrdenMaximo
from Ordenes
group by SucursalID;

--4 - �Cu�l es el mayor n�mero de kil�metros recorridos para una entrega?
select 
	max (KilometrosRecorrer) as MayorNumeroKilometros
from Ordenes;

--5 - �Cu�l es la cantidad promedio de productos por orden?
SELECT OrdenID,
	avg(Cantidad) AS PromedioCantidadProductos
FROM DetalleOrdenes
group by OrdenID;

--6 - �Cu�l es el total de ventas por cada tipo de pago?
select TipoPagoID,
	sum(TotalCompra) as TotalVenta
from Ordenes
group by TipoPagoID
order by TotalVenta desc;

-- 7 - �Cu�l sucursal tiene la venta promedio m�s alta?
select top 1 SucursalID, 
	cast(avg(TotalCompra) as decimal (10,2) ) PromedioVenta
from Ordenes
group by SucursalID
order by PromedioVenta desc;

--8 - �Cu�les son las sucursales que han generado ventas por orden por encima de $50?
select sucursalID,
	sum(TotalCompra) TotalVentas
from Ordenes
group by sucursalID
having sum(TotalCompra) >50
order by TotalVentas desc;

--9 - �C�mo se comparan las ventas promedio antes y despu�s del 1 de julio de 2023?
select 'Antes del 1 de julio de 2023' as Periodo,
	cast(AVG(TotalCompra) as decimal (10,2)) TotalVenta
from Ordenes
where  FechaOrdenTomada < '2023-07-01'
union
select 'Despues del 1 de julio de 2023' as Periodo,
	cast(AVG (TotalCompra) as decimal (10,2)) TotalVenta
from Ordenes
where  FechaOrdenTomada > '2023-07-01' ;

/* 10 - �Durante qu� horario del d�a (ma�ana, tarde, noche) se registra la mayor cantidad de ventas, 
cu�l es el valor promedio de estas ventas, y cu�l ha sido la venta m�xima alcanzada?
*/
select HorarioVenta,
	count(*) as CantidadVentas,
	cast(avg(TotalCompra) as decimal (10,2)) PromedioVentas,
	max(TotalCompra) VentaMaxima
from Ordenes
group by HorarioVenta
order by CantidadVentas desc;