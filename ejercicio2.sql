/* crea una nueva base de datos (si no existe) llamada daw_ejemplo2 */
create database if not exists daw_ejemplo2;
/* crea un usuario llamado alumno en la máquina local */
create user alumno@localhost identified by '1234';
/* concede los privilegios de crear tablas y alterar */
grant create, alter, drop on daw_ejemplo2.* to alumno@localhost;

/* nos autenticamos con el nuevo usuario y creamos las siguientes tablas */
use daw_ejemplo2;
create table personal (
	idPersona int auto_increment PRIMARY KEY,
    nombre varchar(20) NOT NULL,
    apellidos varchar(30) NOT NULL,
    fecNacimiento date);
    
/* crea una nueva tabla juegos */
create table juego (
	nombreJuego char(20) PRIMARY KEY,
    descripcion varchar(50),
    fecCompra date,
    idPropietario int NULL,
    constraint juego_idp_fk foreign key (idPropietario) references personal (idPersona)
    );
/* para crear la tabla anterior hay que añador el privilegio REFERENCES sobre el usuario "usuario" */
grant references on daw_ejemplo2.* to alumno@localhost;

/* crear un nuevo usuario llamado alumno2@localhost con el usuario alumno@localhost */
create user alumno2@localhost identified by '1234'; -- no se puede, necesitas el privilegio de CREATE USER
/* otorgar desde root los privilegios de CREATE USER y modificar los que tenia with grant options */
grant create user on daw_ejemplo2.* to alumno@localhost;

/* eliminar permisos*/
revoke create user on daw_ejemplo2.* from alumno@localhost;
/* ===================================================
realizamos lo siguiente como root 

===================================================*/
/*cambiamos la clave de alumno y cuando entre de nuevo pide cambiarla*/
alter user alumno@localhost identified by '1111' PASSWORD EXPIRE;

/*cambiamos el nombre al usuario de alumno a dawuser*/
rename user alumno@localhost to dawuser@localhost;

/* Eliminamos el usuario alumno2 */
drop user alumno2@localhost;

/* poner todos los permisos de la base de datos daw_ejemplo2 al usuario dawuser */
grant all on daw_ejemplo2.* to dawuser@localhost with grant option;

grant all on daw_ejemplo2.* to pepe1@localhost identified by '1234' with grant option;

/************************************
creación de indices
********************************/
/* comprobar que ambas tablas creadas tienen un índice creado */
/* crear un nuevo indice en la tabla personal, por apellidos, nombre*/
create index personal_nom_apell_ind on personal (apellidos, nombre);
/* se puede crear indices ordenando por ejemplo: */
ALTER TABLE `daw_ejemplo2`.`personal` 
DROP INDEX `personal_nom_apell_ind` ,
ADD INDEX `personal_nom_apell_ind` (`apellidos` DESC, `nombre` ASC);

/* cambiar la tabla personal y añadir un nuevo campo dni que sea único (clave alternativa) */
alter table personal add (dni varchar(9) UNIQUE);
/* comprobar que se genera un nuevo indice */

/* diferencias entre create unique index y create index */

/* eliminar un indice */
alter table personal drop index personal_nom_apell_ind;

/* creacion de vistas */
create view personal_juego as
select nombreJuego, nombre 'Nombre Persona', apellidos 'Apellidos Persona'
from personal, juego
where personal.idPersona=juego.idPropietario;

drop view personal_juego;

/* EJEMPLO COMPLETO*/
