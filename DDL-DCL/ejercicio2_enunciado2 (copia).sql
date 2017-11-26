/* crea una nueva base de datos (si no existe) llamada daw_ejemplo2 */
-- como root
create schema if not exists daw_ejemplo2;

/* crea un usuario llamado alumno en la máquina local */
-- como root
create user alumno@localhost identified by '1234'; 

/* concede los privilegios de crear tablas, modificar y eliminar, para un usuario local */
-- como root
grant create, alter, drop on daw_ejemplo2.* to alumno@localhost;

/*============================================================
nos autenticamos (creando una nueva conexión) 
con el nuevo usuario y creamos las siguientes tablas 
=============================================================*/
-- como alumno
use daw_ejemplo2;
create table persona (
	idPersona int auto_increment PRIMARY KEY ,
    nombre varchar(20) NOT NULL,
    apellidos varchar(30) NOT NULL,
    fecNacimiento date
    -- ,PRIMARY KEY (idPersona)
    
    );
    
/* crea una nueva tabla juegos */
-- como alumno
create table juego (
	idJuego int auto_increment PRIMARY KEY ,
    nombre varchar(20) NOT NULL,
    fecNacimiento date,
    idComprador int,
    foreign key (idComprador) references persona(idPersona)
    );
    
/* para crear la tabla anterior hay que añador el privilegio REFERENCES sobre el usuario "usuario" */
-- añadimos como root:
grant references on daw_ejemplo2.* to alumno@localhost;

-- como alumno comprobamos que ya podemos crear la tabla


/* crear un nuevo usuario llamado alumno2@localhost con el usuario alumno@localhost */
-- como alumno
create user alumno2@localhost identified by '1234';


/* otorgar desde root los privilegios de CREATE USER y modificar los que tenia with grant options */
-- como root

-- como alumno


/* eliminar permisos*/
-- como root
revoke references, alter on daw_ejemplo2.* from alumno@localhost;

/* ===================================================
realizamos lo siguiente como root 

===================================================*/
/*cambiamos la clave de alumno y cuando entre de nuevo pide cambiarla*/
-- como root
alter user alumno@locahost identified by '1234';
 alter user 'alumno'@'localhost' identified with mysql_native_password by '1234' password expire;
/*cambiamos el nombre al usuario de alumno a dawuser*/
-- como root
 rename user alumno@localhost to pepe@localhost;
/* Eliminamos el usuario alumno2 */
-- como root
drop user pepe@localhost;
/* poner todos los permisos de la base de datos daw_ejemplo2 al usuario dawuser */
-- como root
-- grant all on *.* to usuario1@'%', usuario2@localhost;

/* creamos a la vez un usuario orotgándole todos los permisos sobre nuestra bd */
-- como root
grant all  on *.* to juan@'%' identified by 'passwd' with grant option;
drop user juan@'%';
/************************************
creación de indices

crearemos las siguientes sentencias con un usuario con permisos en nuestra bd
********************************/
/* comprobar que ambas tablas creadas tienen un índice creado */
/* crear un nuevo indice en la tabla personal, por apellidos, nombre*/
create index persona_ap_no_idx on persona ( apellidos, nombre);
alter table persona  add index ( apellidos DESC, nombre ASC);
/* se puede crear indices ordenando por ejemplo: */


/* cambiar la tabla personal y añadir un nuevo campo dni que sea único (clave alternativa) */
alter table daw_ejemplo2.persona  
add ( dni char(9) UNIQUE NOT NULL );

/* comprobar visualmente desde la tabla que se genera un nuevo indice */

/* diferencias entre create unique index y create index */

/* eliminar un indice */
alter table persona
drop index persona_ap_no_idx;
/* creacion de vistas */

create view juegos_persona as
SELECT persona.nombre, persona.apellidos, juego.nombre 'NombreJuego', juego.fecCompra
FROM persona, juego
WHERE persona.idPersona = juego.idComprador;


/* eliminar vistas */
drop view juegos_persona;