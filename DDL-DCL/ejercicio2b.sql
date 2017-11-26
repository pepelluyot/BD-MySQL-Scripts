/* crea una nueva base de datos (si no existe) llamada daw_ejemplo2 */
-- como root
create database if not exists daw_ejemplo2;

/* crea un usuario llamado alumno en la máquina local */
-- como root
create user alumno@localhost identified by '1234';

/* concede los privilegios de crear tablas, modificar y eliminar, para un usuario local */
-- como root
Grant create, drop, alter on daw_ejemplo2.* to alumno@localhost;

/*============================================================
nos autenticamos (creando una nueva conexión) 
con el nuevo usuario y creamos las siguientes tablas 
=============================================================*/
-- como alumno
use daw_ejemplo2;
create table personal (
	idPersonal int auto_increment PRIMARY KEY,
    nombre varchar(20) NOT NULL,
    apellidos varchar(30) NOT NULL,
    fecNacimiento date
        -- ,PRIMARY KEY (idPersonal) --podríamos poner la primary key aquí abajo
);
    
/* crea una nueva tabla juegos */
-- como alumno
create table juego (
	idJuego int primary key,
    nombre varchar(20) NOT NULL,
    descripcion varchar(40),
    fecCompra date,
    idComprador int,
    FOREIGN KEY (idComprador) REFERENCES personal(idPersonal) -- nos dará un error pues no tenemos permisos
);
/* para crear la tabla anterior hay que añador el privilegio REFERENCES sobre el usuario "usuario" */
-- añadimos como root:
grant references on daw_ejemplo2.* to alumno@localhost;

-- como alumno comprobamos que ya podemos crear la tabla
create table juego (
	idJuego int primary key,
    nombre varchar(20) NOT NULL,
    descripcion varchar(40),
    fecCompra date,
    idComprador int,
    FOREIGN KEY (idComprador) REFERENCES personal(idPersonal) -- nos dará un error pues no tenemos permisos
);

/* crear un nuevo usuario llamado alumno2@localhost con el usuario alumno@localhost */
-- como alumno
create user alumno2@localhost identified by '1234'; -- no se puede, necesitas el privilegio de CREATE USER

/* otorgar desde root los privilegios de CREATE USER y modificar los que tenia with grant options */
-- como root
grant create user on daw_ejemplo2.* to alumno@localhost;
-- como alumno
create user alumno2@localhost identified by '1234'; 

/* eliminar permisos*/
-- como root
revoke create user on daw_ejemplo2.* from alumno@localhost;
revoke create on daw_ejemplo2.* from alumno@localhost;
/* ===================================================
realizamos lo siguiente como root 

===================================================*/
/*cambiamos la clave de alumno y cuando entre de nuevo pide cambiarla*/
-- como root
alter user alumno@localhost identified by '1111' ;-- PASSWORD expire; -- aunque nos marque como rojo, es correcto

/*cambiamos el nombre al usuario de alumno a dawuser*/
-- como root
rename user alumno@localhost to dawuser@localhost;

/* Eliminamos el usuario alumno2 */
-- como root
drop user alumno2@localhost;

/* poner todos los permisos de la base de datos daw_ejemplo2 al usuario dawuser */
-- como root
-- grant all on *.* to usuario1@'%', usuario2@localhost;
grant all on daw_ejemplo2.* to dawuser@localhost with grant option; -- además permite a este usuario otorgar permisos a otros

/* creamos a la vez un usuario orotgándole todos los permisos sobre nuestra bd */
-- como root
grant all on daw_ejemplo2.* to pepe1@localhost identified by '1234' with grant option;

/************************************
creación de indices

crearemos las siguientes sentencias con un usuario con permisos en nuestra bd
********************************/
/* comprobar que ambas tablas creadas tienen un índice creado */
/* crear un nuevo indice en la tabla personal, por apellidos, nombre*/
create index apellido_nombre_idx on personal (apellidos, nombre); 
alter table persona  add index ( apellidos DESC, nombre ASC);
/* se puede crear indices ordenando por ejemplo: */
create index apellido_nombre2_idx on personal (apellidos DESC, nombre ASC); 


/* cambiar la tabla personal y añadir un nuevo campo dni que sea único (clave alternativa) */
ALTER TABLE daw_ejemplo2.personal
ADD ( dni VARCHAR(9) NOT NULL UNIQUE );

/* comprobar visualmente desde la tabla que se genera un nuevo indice */

/* diferencias entre create unique index y create index */

/* eliminar un indice */
alter table personal drop index personal_nom_apell_ind;

/* creacion de vistas */
create view personal_juego as
select nombreJuego, nombre 'Nombre Persona', apellidos 'Apellidos Persona'
from personal, juego
where personal.idPersona=juego.idPropietario;

/* eliminar vistas */
drop view personal_juego;

