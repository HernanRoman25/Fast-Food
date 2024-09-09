use FastFoodDB;

--�C�mo puedo obtener una lista de todos los productos junto con sus categor�as?
select * from Productos;
select * from Categorias;

select P.Nombre Poducto, C.Nombre Categoria
from Productos P
inner join Categorias C
	on (P.CategoriaID = C.CategoriaID);

--�C�mo puedo saber a qu� sucursal est� asignado cada empleado?
select * from Empleados;
select * from Sucursales;

select E.Nombre Empleado, S.Nombre Sucursal
from Empleados E
left join Sucursales S
	on (E.SucursalID = S.SucursalID);

--�Existen productos que no tienen una categor�a asignada?
select * from Productos;
select * from Categorias;

select P.Nombre Poducto, C.Nombre Categoria
from Productos P
left join Categorias C
	on (P.CategoriaID = C.CategoriaID)
where C.CategoriaID is null;

/*�C�mo puedo obtener un detalle completo de las �rdenes, incluyendo cliente, empleado 
que tom� la orden, y el mensajero que la entreg�?
*/
select O.OrdenID, C.Nombre Cliente, E.Nombre Empleado, M.Nombre Mensajero
from ordenes O
left join Clientes C 
	on (O.ClienteID = C.ClienteID)
left join Empleados E 
	on (O.EmpleadoID = E.EmpleadoID)
left join Mensajeros M 
	on (O.MensajeroID = M.MensajeroID);

--�Cu�ntos productos de cada tipo se han vendido en cada sucursal?
select * from Ordenes;
select * from DetalleOrdenes;
select * from Sucursales;
select * from Productos;

select S.Nombre Sucursal, P.Nombre Producto, sum(DO.Cantidad) ProductosVendidos
from Ordenes O
inner join DetalleOrdenes DO
	on (O.OrdenID= DO.OrdenID)
inner join Productos P
	on (DO.ProductoID = P.ProductoID)
inner join Sucursales S
	on (O.SucursalID = S.SucursalID)
group by S.Nombre, P.Nombre
order by ProductosVendidos desc;