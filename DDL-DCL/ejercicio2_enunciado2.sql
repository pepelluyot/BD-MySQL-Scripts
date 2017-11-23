/* crea una nueva base de datos (si no existe) llamada daw_ejemplo2 */
-- como root


/* crea un usuario llamado alumno en la máquina local */
-- como root


/* concede los privilegios de crear tablas, modificar y eliminar, para un usuario local */
-- como root


/*============================================================
nos autenticamos (creando una nueva conexión) 
con el nuevo usuario y creamos las siguientes tablas 
=============================================================*/
-- como alumno

    
/* crea una nueva tabla juegos */
-- como alumno

/* para crear la tabla anterior hay que añador el privilegio REFERENCES sobre el usuario "usuario" */
-- añadimos como root:


-- como alumno comprobamos que ya podemos crear la tabla


/* crear un nuevo usuario llamado alumno2@localhost con el usuario alumno@localhost */
-- como alumno


/* otorgar desde root los privilegios de CREATE USER y modificar los que tenia with grant options */
-- como root

-- como alumno


/* eliminar permisos*/
-- como root

/* ===================================================
realizamos lo siguiente como root 

===================================================*/
/*cambiamos la clave de alumno y cuando entre de nuevo pide cambiarla*/
-- como root

/*cambiamos el nombre al usuario de alumno a dawuser*/
-- como root

/* Eliminamos el usuario alumno2 */
-- como root

/* poner todos los permisos de la base de datos daw_ejemplo2 al usuario dawuser */
-- como root
-- grant all on *.* to usuario1@'%', usuario2@localhost;

/* creamos a la vez un usuario orotgándole todos los permisos sobre nuestra bd */
-- como root

/************************************
creación de indices

crearemos las siguientes sentencias con un usuario con permisos en nuestra bd
********************************/
/* comprobar que ambas tablas creadas tienen un índice creado */
/* crear un nuevo indice en la tabla personal, por apellidos, nombre*/

/* se puede crear indices ordenando por ejemplo: */


/* cambiar la tabla personal y añadir un nuevo campo dni que sea único (clave alternativa) */

/* comprobar visualmente desde la tabla que se genera un nuevo indice */

/* diferencias entre create unique index y create index */

/* eliminar un indice */

/* creacion de vistas */

/* eliminar vistas */
