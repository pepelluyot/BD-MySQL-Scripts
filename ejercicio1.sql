/* creamos una base de datos */
create database dawb_2017;

/* eliminamos una base de datos */
drop database dawb_2017;

/* creamos una base de datos si no existe*/
create database if not exists dawb_2017;

/* activamos la base de datos */
use dawb_2017;

/* creamos una tabla llamada usuarios con dos campos, idUsuario, nombre */
create table usuarios (
	idUsuario int,
    nombre varchar(30)
);

/* eliminamos la tabla */
drop table usuarios;

/* creamos una tabla llamada usuarios (si no existe) con dos campos, idUsuario, nombre y PK nombre*/
create table if not exists usuarios (
	idUsuario int,
    nombre varchar(30) PRIMARY KEY,
    check (idUsuario between 2 and 10) -- esta condición aunque no da error, no está implementada en MySQL
);

/* mostramos la estructura de la tabla */
describe usuarios;

/* eliminamos la tabla si existe usuarios*/
drop table if exists usuarios;

/* la creamos de nuevo y posteriormente añadimos una nueva columna llamada apellidos no nulo*/
create table if not exists usuarios (
	idUsuario int,
    nombre varchar(30) PRIMARY KEY,
    check (idUsuario between 2 and 10) -- esta condición aunque no da error, no está implementada en MySQL
);
alter table usuarios add column (apellidos varchar(30) NOT NULL);

/* añadimos dos nuevos campos, dni y fecha nacimiento */
alter table usuarios add column (dni varchar(9) NOT NULL, fecNacimiento date);

/* cambiamos el nombre a la tabla por usuario */
alter table usuarios rename usuario;
rename table usuarios to usuario; -- otra forma de hacerlo

/* eliminamos la clave principal */
alter table usuario drop PRIMARY KEY;

/* añadimos una nueva PK con los campos nombre y apellidos */
alter table usuario add PRIMARY KEY (nombre, apellidos);

/* eliminar la columna fecha de nacimiento */
alter table usuario drop fecNacimiento;

/* añadir un nuevo campo llamado idUsuarioSupervisor de tipo texto no nulo */
alter table usuario add idUsuarioSupervisor varchar(20) NOT NULL;

/* cambiar el nombre de la columna idUsuarioSupervisor por idUsuarioJefe (con el mismo tipo de datos que idUsuario y que permita nulos) */
alter table usuario change column idUsuarioSupervisor idUsuarioJefe int NULL;

/* cambiar la clave primaria al campo idUsuario en una única sentencia con "drop" y "add" */
alter table usuario drop PRIMARY KEY, add PRIMARY KEY (idUsuario);

/* poner el campo idUsuarioJefe como clave foránea de idUsuario */
alter table usuario add constraint usuariojefe_FK foreign key (idUsuarioJefe) references usuario(idUsuario);

/* modifica el tamaño del campo apellidos */
alter table usuario modify apellidos varchar(45) NULL;

/* hacer que la clave sea autoincremental (hay que borrar previamente la Fk, cambiar el autoincremento y volver a crear la FK)*/
alter table usuario 
	drop FOREIGN KEY usuariojefe_FK, -- podemos hacer varias instrucciones sobre la misma tabla
	modify idUsuario int auto_increment, -- separandolas por comas
    add constraint usuariojefe_2_FK foreign key (idUsuarioJefe) references usuario(idUsuario);
    
/* introduce algunos valores a mano en la tabla */
-- puedes meter valores dando click sobre la tabla (menú izquierda) y sobre el icono del grid

/* elimina los datos de la tabla pero no la estructura*/
truncate usuario;

/* elimina la tabla usuario */
drop table usuario;

/* elimina la base de datos */
drop database dawb_2017;