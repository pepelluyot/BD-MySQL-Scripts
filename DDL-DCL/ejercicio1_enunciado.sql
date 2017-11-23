/* creamos una base de datos */
create database dawb_17;

/* eliminamos una base de datos */
drop database dawb_17;

/* creamos una base de datos si no existe*/
create database if not exists dawb_17;

/* activamos la base de datos */
use dawb_17;

/* creamos una tabla llamada usuarios con dos campos, idUsuario, nombre */
create table usuarios (
	idUsuario int,
    nombre varchar(20)
);

/* eliminamos la tabla */
drop table usuarios;

/* creamos una tabla llamada usuarios (si no existe) con dos campos, idUsuario, nombre y PK nombre*/
create table if not exists usuarios (
	idUsuario int,
    nombre varchar(20) PRIMARY KEY
);
/* mostramos la estructura de la tabla */
describe usuarios;

/* eliminamos la tabla si existe usuarios*/
drop table if exists usuarios;

/* la creamos de nuevo y posteriormente añadimos una nueva columna llamada apellidos no nulo*/
create table if not exists usuarios (
	idUsuario int,
    nombre varchar(20) PRIMARY KEY
);
alter table usuarios
add column ( apellidos varchar(30) NOT NULL ); 

/* añadimos dos nuevos campos, dni y fecha nacimiento */
alter table dawb_17.usuarios
add (dni varchar(9), fecNacimiento date);

/* cambiamos el nombre a la tabla por usuario */
alter table usuarios rename usuario;
rename table usuarios to usuario;

/* eliminamos la clave principal */
alter table usuario
drop PRIMARY KEY;

/* añadimos una nueva PK con los campos nombre y apellidos */
alter table usuario
add PRIMARY KEY (nombre, apellidos);

/* eliminar la columna fecha de nacimiento */
alter table usuario drop column fecNacimiento;

/* añadir un nuevo campo llamado idUsuarioSupervisor de tipo texto no nulo */
alter table usuario
add (idUsuarioSupervisor varchar(20) NOT NULL);
/* cambiar el nombre de la columna idUsuarioSupervisor por idUsuarioJefe (con el mismo tipo de datos que idUsuario y que permita nulos) */
alter table usuario 
change column idUsuarioSupervisor idUsuarioJefe int NULL;

/* cambiar la clave primaria al campo idUsuario en una única sentencia con "drop" y "add" */
alter table usuario
drop primary key,
add primary key (idUsuario);

/* poner el campo idUsuarioJefe como clave foránea de idUsuario */
alter table usuario
add constraint usuario_idus_idusj_FK
foreign key (idUsuarioJefe) references usuario(idUsuario);



create table asignatura(
	idAsignatura int PRIMARY KEY,
    nombre varchar(10),
    idUsuario int,
    foreign key (idUsuario) references usuario (idUsuario)
);



/* modifica el tamaño del campo apellidos */

/* hacer que la clave sea autoincremental (hay que borrar previamente la Fk, cambiar el autoincremento y volver a crear la FK)*/
    
/* introduce algunos valores a mano en la tabla */

/* elimina los datos de la tabla pero no la estructura*/

/* elimina la tabla usuario */

/* elimina la base de datos */
