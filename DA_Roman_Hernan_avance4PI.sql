use FastFoodDB;

--¿Cómo puedo obtener una lista de todos los productos junto con sus categorías?
select * from Productos;
select * from Categorias;

select P.Nombre Poducto, C.Nombre Categoria
from Productos P
inner join Categorias C
	on (P.CategoriaID = C.CategoriaID);

--¿Cómo puedo saber a qué sucursal está asignado cada empleado?
select * from Empleados;
select * from Sucursales;

select E.Nombre Empleado, S.Nombre Sucursal
from Empleados E
left join Sucursales S
	on (E.SucursalID = S.SucursalID);

--¿Existen productos que no tienen una categoría asignada?
select * from Productos;
select * from Categorias;

select P.Nombre Poducto, C.Nombre Categoria
from Productos P
left join Categorias C
	on (P.CategoriaID = C.CategoriaID)
where C.CategoriaID is null;

/*¿Cómo puedo obtener un detalle completo de las órdenes, incluyendo cliente, empleado 
que tomó la orden, y el mensajero que la entregó?
*/
select O.OrdenID, C.Nombre Cliente, E.Nombre Empleado, M.Nombre Mensajero
from ordenes O
left join Clientes C 
	on (O.ClienteID = C.ClienteID)
left join Empleados E 
	on (O.EmpleadoID = E.EmpleadoID)
left join Mensajeros M 
	on (O.MensajeroID = M.MensajeroID);

--¿Cuántos productos de cada tipo se han vendido en cada sucursal?
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