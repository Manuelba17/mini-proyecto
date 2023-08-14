drop table if exists ventas_x_producto;
drop table if exists ventas;
drop table if exists clientes;
drop table if exists productos;


 
 create table clientes (
	cliente_id serial PRIMARY KEY,
	nombre varchar(15) NOT NULL,
	apellidos varchar(15) NOT NULL,
	email varchar(30) NOT NULL UNIQUE,
	telefono varchar(30) NOT NULL UNIQUE,
	direccion varchar(30) NOT NULL,
	codigo_postal int NOT NULL,
	ciudad varchar(15) NOT NULL
); 

create table productos (
	sku varchar(30) PRIMARY KEY,
	nombre varchar(255) NOT NULL,
	descripcion text,
	precio float NOT NULL
 ); 
 
  create table ventas(
 	venta_id serial PRIMARY KEY,
	cliente_id int,
	FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)	 
 );
 
  create table ventas_x_producto(
	ventas_x_producto_id serial,
	sku varchar(30) NOT NULL,
	venta_id int NOT NULL,
	cantidad int NOT NULL,
	FOREIGN KEY (sku) references productos(sku),
	FOREIGN KEY (venta_id) references ventas(venta_id)
	
	
 );
 
-- ingresando datos en la tabla clientes

insert into clientes (nombre, apellidos, email, telefono, direccion, codigo_postal, ciudad) values ('Brina', 'Currington', 'bcurrington0@123-reg.co.uk', '+62 110 793 6254', '79 Oriole Pass', 8717, 'Cerme Kidul'),
 ('Anna-maria', 'Duffill', 'aduffill1@prweb.com', '+48 464 609 8212', '49 Veith Drive', 8089, 'México'),
 ('Kally', 'Willett', 'kwillett2@lycos.com', '+86 921 939 5119', '138 Park Meadow Alley', 1111, 'Cancún'),
 ('Warden', 'Ruck', 'wruck3@altervista.org', '+64 130 394 7875', '38972 Mariners Cove Hill', 4848, 'México'),
 ('Melamie', 'Jaques', 'mjaques4@mapquest.com', '+86 207 494 3167', '86 Nancy Trail', 5025, 'Monterrey'),
 ('Ware', 'McAlroy', 'wmcalroy5@wikispaces.com', '+54 808 850 3776', '8076 Lyons Terrace', 5900, 'Guadalajara'),
 ('Kelby', 'Calkin', 'kcalkin6@cisco.com', '+86 169 713 3786', '98 Fallview Trail', 2345, 'Guadalajara');
 
 -- ingresando datos en la tabla productos

insert into productos (sku, nombre, descripcion, precio) values (1, 'Ropinirole Hydrochloride', 'aenean fermentum donec ut mauris eget massa tempor convallis nulla', 78.6),
 (2, 'Natural Honey Lemon with Echinacea Cough Suppressant Throat Drops', 'varius nulla facilisi cras non velit nec nisi vulputate nonummy', 5),
 (3, 'Gabapentin', 'ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut', 68.4),
 (4, 'Citalopram Hydrobromide', 'gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi', 15.7),
 (5, 'Apis Bryonia Special Order', 'convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi', 3);
 
 -- ingresando datos en la tabla ventas
 
 insert into ventas (cliente_id) values (3),
(4),
(1),
(2),
(7);

 -- ingresando datos en la tabla ventas por producto 

insert into ventas_x_producto (sku, venta_id, cantidad) values (1, 1, 20),
(2, 1, 1),
(5, 2, 15),
(3, 2, 3),
(1, 2, 1),
(4, 2, 2),
(2, 2, 5),
(2, 2, 20),
(2, 5, 16),
(5, 3, 9),
(1, 4, 50);

-- ID de los clientes de la Ciudad de Monterrey

select cliente_id from clientes c
where c.ciudad = 'Monterrey'

-- ID y descripción de los productos que cuesten menos de 15 pesos

select sku, descripcion from productos
where precio < 15

-- ID y nombre de los clientes, cantidad vendida, y descripción del producto, en las ventas en las cuales se vendieron más de 10 unidades.

select cl.cliente_id, cl.nombre, vp.cantidad, pr.descripcion from ventas_x_producto vp
join ventas vt on vt.venta_id = vp.venta_id 
join clientes cl on cl.cliente_id = vt.cliente_id
join productos pr on pr.sku = vp.sku
where vp.cantidad > 10


-- ID y nombre de los clientes que no aparecen en la tabla de ventas (Clientes que no han comprado productos)

select cl.cliente_id, cl.nombre from clientes cl
LEFT join ventas vt on cl.cliente_id = vt.cliente_id  
where vt.cliente_id is null

-- ID de los productos que se han vendido a clientes de Monterrey y que también se han vendido a clientes de Cancún.

select pr.sku from productos pr
join ventas_x_producto vp on vp.sku = pr.sku
join ventas vt on vt.venta_id = vp.venta_id
join clientes cl on cl.cliente_id = vt.cliente_id
where cl.ciudad in ('Monterrey', 'Cancún')


 



 
 
 
 
