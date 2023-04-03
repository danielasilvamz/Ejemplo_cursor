drop database if exists supermerc;
create database supermerc;
use supermerc;

create table tipo_productos(
	id int primary key auto_increment,
	nombre varchar(50) not null
);

create table proveedor(
	nit varchar(12) primary key,
    nombre varchar(70) not null,
    telefono varchar(12) not null,
    direccion varchar(60) not null
);

create table productos(
	id int primary key auto_increment,
    id_tipo_producto int not null,
    id_proveedor varchar(12) not null,
    nombre varchar(50) not null,
    precio_unitario int not null,
    foreign key (id_tipo_producto) references tipo_productos(id),
    foreign key (id_proveedor) references proveedor(nit)
);

create table inventario(
	id int primary key auto_increment,
    id_producto int not null,
    cantidad int,
    foreign key (id_producto) references productos(id)
);

create table clientes(
	cedula int primary key,
    nombres varchar(30) not null,
    apellidos varchar(30) not null,
    telefono varchar(12) not null
);

create table factura(
	num_factura int primary key auto_increment,
    id_cliente int not null,
    id_producto int not null,
    cantidad int not null,
    fecha_venta datetime,
    foreign key (id_cliente) references clientes(cedula),
    foreign key (id_producto) references productos(id)
);

create table compra(
	num_compra int primary key auto_increment,
    id_proveedor varchar(12) not null,
    id_producto int not null,
    cantidad int not null,
    fecha_compra datetime,
    foreign key (id_proveedor) references proveedor(nit),
    foreign key (id_producto) references productos(id)
);

insert into tipo_productos(nombre) values ('Lácteos');
insert into tipo_productos(nombre) values ('Panadería');
insert into tipo_productos(nombre) values ('Frutas y verduras');

insert into proveedor (nit, nombre, telefono, direccion) values ('8600259002', 'Alpina Productos Alimenticios S A Bic', '6014238600', 'CARRERA 4 7 99, SOPO, CUNDINAMARCA');
insert into proveedor (nit, nombre, telefono, direccion) values ('8300023660', 'Bimbo De Colombia S A', '6017452111', 'AUTOPISTA MEDELLIN KM 12 VEREDA LA PUNTA PREDIO EL TEJAR');
insert into proveedor (nit, nombre, telefono, direccion) values ('8000181285', 'Cooperativa De Trabajo Asociado Y Servicios Especiales En Corabastos', '6014537188', 'CARRERA 86 24 A 19 SUR');

insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (1, '8600259002', 'Queso tajado mozarella Alpina', 17950);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (1, '8600259002', 'Kumis Alpina', 8700);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (2, '8300023660', 'Pan tajado blanco Bimbo', 7490);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario)  values (2, '8300023660', 'Tostadas integrales Bimbo', 6970);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (3, '8000181285', 'Manzana roja', 2510);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (3, '8000181285', 'Banano', 590);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (1, '8600259002', 'Bon Yurt Zucaritas', 3760);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (1, '8600259002', 'Queso crema Alpina', 10950);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (2, '8300023660', 'Pan super perro Bimbo', 6610);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario)  values (2, '8300023660', 'Tortillas blancas medianas Bimbo', 11750);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (3, '8000181285', 'Pera', 1100);
insert into productos(id_tipo_producto, id_proveedor, nombre, precio_unitario) values (3, '8000181285', 'Pepino cohombro', 1760);

insert into inventario(id_producto, cantidad) values (1, 20);
insert into inventario(id_producto, cantidad) values (2, 20);
insert into inventario(id_producto, cantidad) values (3, 20);
insert into inventario(id_producto, cantidad) values (4, 20);
insert into inventario(id_producto, cantidad) values (5, 20);
insert into inventario(id_producto, cantidad) values (6, 20);
insert into inventario(id_producto, cantidad) values (7, 20);
insert into inventario(id_producto, cantidad) values (8, 20);
insert into inventario(id_producto, cantidad) values (9, 20);
insert into inventario(id_producto, cantidad) values (10, 20);
insert into inventario(id_producto, cantidad) values (11, 20);
insert into inventario(id_producto, cantidad) values (12, 20);
    
insert into clientes(cedula, nombres, apellidos, telefono) values (52790002, 'María Camila', 'Rodriguez Sánchez', 3124351376);
insert into clientes(cedula, nombres, apellidos, telefono) values (1020804780, 'Nicolas', 'Torres Méndez', 3056402442);
insert into clientes(cedula, nombres, apellidos, telefono) values (79460303, 'Juan Carlos', 'Arango Molina', 3208304567);
insert into clientes(cedula, nombres, apellidos, telefono) values (1019450790, 'Juliana', 'Gómez Pérez', 3124351376);

insert into factura(id_cliente, id_producto, cantidad, fecha_venta) values (52790002, 1, 6, now());
insert into factura(id_cliente, id_producto, cantidad, fecha_venta) values (1020804780, 3, 8, now());
insert into factura(id_cliente, id_producto, cantidad, fecha_venta) values (79460303, 1, 5, now());
insert into factura(id_cliente, id_producto, cantidad, fecha_venta) values (1019450790, 5, 12, now());

insert into compra(id_proveedor, id_producto, cantidad, fecha_compra) values ('8600259002', 1, 11, now());
insert into compra(id_proveedor, id_producto, cantidad, fecha_compra) values ('8300023660', 3, 8, now());
insert into compra(id_proveedor, id_producto, cantidad, fecha_compra) values ('8000181285', 5, 12, now());

-- drop procedure if exists lista_compras_proveedores;
delimiter //
create procedure lista_compras_proveedores (
	in nombre_prov varchar (70),
    inout listacompras varchar(2000)
)
begin
	declare finished integer default 0;
    declare productos varchar(50) default "";
    
    -- Declaración del cursor 
    declare curProductos
		cursor for
			select PD.nombre from proveedor PV inner join productos PD
            on PV.nit = PD.id_proveedor
            where PV.nombre like concat('%', nombre_prov, '%');
    -- Declaración del NOT FOUND handler        
	declare continue handler
		for not found set finished = 1;
	
    open CurProductos;
    
    myloop: LOOP
		fetch curProductos into productos;
        if finished = 1 then
			leave myloop;
		end if;
        -- Construcción de la lista de productos
        set listacompras = concat(productos, ', ', listacompras);
        end loop myloop;
        close CurProductos;
end 
//

set @listacompras = '';
call lista_compras_proveedores('Alpina',@listacompras);
select @listacompras;

set @listacompras = '';
call lista_compras_proveedores('Bimbo',@listacompras);
select @listacompras;

set @listacompras = '';
call lista_compras_proveedores('Corabastos',@listacompras);
select @listacompras;
