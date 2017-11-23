/* crea una nueva base de datos (si no existe) llamada daw_ejemplo2 */
-- como root
create database if not exists daw_ejemplo2;

/* crea un usuario llamado alumno en la máquina local */
-- como root
create user alumno@localhost identified by '1234';

/* concede los privilegios de crear tablas y alterar */
-- como root
Grant create, drop, alter on daw_ejemplo2.* to alumno@localhost;

/* nos autenticamos con el nuevo usuario y creamos las siguientes tablas */
-- como alumno
use daw_ejemplo2;
create table personal (
	idPersonal int auto_increment PRIMARY KEY,
    nombre varchar(20) NOT NULL,
    apellidos varchar(30) NOT NULL,
    fecNacimiento date,
    INDEX  (apellidos ASC, nombre ASC)
    -- ,PRIMARY KEY (idPersonal)
);
    
/* crea una nueva tabla juegos */
-- como alumno
create table juego (
	idJuego int primary key,
    nombre varchar(20) NOT NULL,
    descripcion varchar(40),
    fecCompra date,
    idComprador int,
    FOREIGN KEY (idComprador) REFERENCES personal(idPersonal)
);
/* para crear la tabla anterior hay que añador el privilegio REFERENCES sobre el usuario "usuario" */
-- añadimos como root:
grant references on daw_ejemplo2.* to alumno@localhost;

/* crear un nuevo usuario llamado alumno2@localhost con el usuario alumno@localhost */

/* otorgar desde root los privilegios de CREATE USER y modificar los que tenia with grant options */

/* eliminar permisos*/
-- como root
revoke create on daw_ejemplo2.* from alumno@localhost;
/* ===================================================
realizamos lo siguiente como root 

===================================================*/
/*cambiamos la clave de alumno y cuando entre de nuevo pide cambiarla*/
alter user alumno@localhost identified by '1111' ;-- PASSWORD expire;

/*cambiamos el nombre al usuario de alumno a dawuser*/
rename user alumno@localhost to dawuser@localhost;
/* Eliminamos el usuario alumno2 */
drop user alumno2@localhost;

/* poner todos los permisos de la base de datos daw_ejemplo2 al usuario dawuser */
grant all on *.* to usuario1@'%', usuario2@localhost;

/************************************
creación de indices
********************************/
/* comprobar que ambas tablas creadas tienen un índice creado */
/* crear un nuevo indice en la tabla personal, por apellidos, nombre*/
create index apellido_nombre_idx on personal (apellidos ASC, nombre ASC); -- DESC
/* se puede crear indices ordenando por ejemplo: */

/* cambiar la tabla personal y añadir un nuevo campo dni que sea único (clave alternativa) */
ALTER TABLE `daw_ejemplo2`.`personal` 
ADD ( `dni` VARCHAR(9) NOT NULL UNIQUE );

/* comprobar que se genera un nuevo indice */

/* diferencias entre create unique index y create index */

/* eliminar un indice */
alter table personal drop index  apellido_nombre_idx;
/* creacion de vistas */

/* EJEMPLO COMPLETO*/