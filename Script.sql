--Se crea tabla tipo usuario
CREATE TABLE tipo_usuario (
	id_tipo_usuario VARCHAR ( 20 ) PRIMARY KEY,
	nombre VARCHAR ( 20 ) NOT NULL
);

--Se crea tabla tipo documento
CREATE TABLE tipo_documento(
	id_tipo_documento VARCHAR ( 20 ) PRIMARY KEY,
	nombre VARCHAR ( 15 ) NOT NULL
);

--Se crea tabla ubicación
CREATE TABLE ubicación(
	id_ubicación VARCHAR ( 20 ) PRIMARY KEY,
	dirección VARCHAR ( 30 ) NOT NULL,
	barrio VARCHAR ( 30 ) NOT NULL,
	localidad VARCHAR ( 30 ) NOT NULL
);


--Se crea tabla especie
CREATE TABLE especie (
	id_especie VARCHAR ( 20 ) PRIMARY KEY,
	nombre VARCHAR ( 20 ) NOT NULL
);

--Se crea tabla caso
CREATE TABLE caso (
	id_caso int PRIMARY KEY,
	nombre VARCHAR ( 30 ) NOT NULL
);

--Se crea tabla tipoVisita
CREATE TABLE tipoVisita (
	id_tipo_visita int PRIMARY KEY,
	nombre VARCHAR ( 30 ) NOT NULL
);

--Se crea tabla UsuarioDetalle
CREATE TABLE UsuarioDetalle (
	documento VARCHAR ( 20 ) PRIMARY KEY,
	nombre VARCHAR ( 30 ) NOT NULL,
	telefono VARCHAR ( 20 ) NOT NULL,
	tipo_documento VARCHAR ( 20 ) references tipo_documento(id_tipo_documento) NOT NULL,
	id_ubicacion VARCHAR ( 20 ) references ubicación(id_ubicación) NOT NULL,
	tipo_usuario VARCHAR ( 20 ) references tipo_usuario(id_tipo_usuario) NOT NULL
);

--Se crea tabla Usuario
CREATE TABLE usuario (
	documento_usr  VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL,
	correo VARCHAR ( 40 ) NOT NULL,
	contraseña VARCHAR ( 12 ) NOT NULL
);

--Se crea tabla mascota
CREATE TABLE mascota(
	id_mascota int PRIMARY KEY,
	id_propietario VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL,
	nombre VARCHAR ( 20 ) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	id_especie VARCHAR ( 20 )  references especie (id_especie) NOT NULL,
	tamaño float NOT NULL,
	peligroso VARCHAR ( 5 ) NOT NULL, 
	fotografía VARCHAR ( 80 ), 
	microchip BOOLEAN ,
	sexo VARCHAR( 10 ) NULL
);

--Se crea tabla aprobacion_func
CREATE TABLE aprobacion_func(
	id_veterinaria  VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL,
	id_funcionario  VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL
);

--Se crea tabla registro
CREATE TABLE registro(
	id_registro  VARCHAR ( 20 ) PRIMARY KEY,
	fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE,
	id_tipo_visita int references tipoVisita (id_tipo_visita) NOT NULL,
	id_caso int references caso(id_caso),
	id_mascota int references mascota(id_mascota) NOT NULL
);

--Se crea tabla documentos
CREATE TABLE documentos(
	id_documentos VARCHAR ( 20 ) PRIMARY KEY,
	documentos VARCHAR ( 80 ),
	fotos VARCHAR ( 80 ),
	id_registro VARCHAR ( 20 ) references registro(id_registro ) NOT NULL

);

--Se crea la vista listar mascotas provierario V, que nos sirve para listar todas las mascotas que haya registrado un propiertario
CREATE VIEW listarMascotasPropietarioV AS
	SELECT 
	mas.id_mascota,
	mas.nombre,
	mas.id_propietario,
	mas.fecha_nacimiento,
	mas.id_especie,
	mas.tamaño,
	mas.peligroso,
	mas.fotografía,
	mas.microchip
	FROM mascota as mas
	INNER JOIN usuarioDetalle AS usr
	on usr.documento = mas.id_propietario
	WHERE usr.tipo_usuario = '1';

--Vista de mascotas registradas para los funcionarios
CREATE VIEW mascotasRegistradasFuncionario AS
	SELECT
	pet.nombre,
	es.nombre AS Especie,
	pet.sexo,
	pet."tamaño",
	pet.microchip,
	tv.nombre AS tipo_visita
	FROM mascota AS pet
	INNER JOIN especie AS es
	ON es.id_especie = pet.id_especie
	INNER JOIN registro AS re
	ON re.id_mascota = pet.id_mascota
	INNER JOIN tipovisita AS tv
	ON re.id_tipo_visita = tv.id_tipo_visita
	WHERE re.id_tipo_visita = '1';
	
/*
query de prueba para la vista
SELECT * FROM listarMascotasPropietarioV as lista WHERE lista.id_propietario ='1212';
*/

--indice de id de la tabla usuario detalle
CREATE INDEX usuariodetalle_id_indx 
ON usuariodetalle (documento);

--indice de id de la tabla usuario detalle
CREATE INDEX tipoUsuario_id_indx 
ON tipo_usuario (id_tipo_usuario);

--indice de id de la tabla tipo documento
CREATE INDEX tipoDocumento_id_indx 
ON tipo_documento (id_tipo_documento);

--indice de id de la tabla ubicacion
CREATE INDEX ubicacion_id_indx 
ON ubicación (id_ubicación);

--indice de id de la tabla usuario detalle
CREATE INDEX especie_id_indx 
ON especie (id_especie);

--indice de id de la tabla caso
CREATE INDEX caso_id_indx 
ON caso (id_caso);

--indice de id de la tabla tipo visita
CREATE INDEX tipoVisita_id_indx 
ON tipoVisita (id_tipo_visita);

--indice de id de la tabla mascota
CREATE INDEX mascota_id_indx 
ON mascota (id_mascota);

--indice de id de la tabla usuario detalle
CREATE INDEX registro_id_indx 
ON registro (id_registro);

--indice de id de la tabla documentos
CREATE INDEX documentos_id_indx 
ON documentos (id_documentos);

--indice de la fecha de registro de la tabla registro
CREATE INDEX registro_fechaRegistro_indx 
ON registro (fecha_registro);

--indice del nombre de la tabla mascota
CREATE INDEX mascota_nombre_indx 
ON mascota (nombre);

--indice de la localidad de la tabla ubicación
CREATE INDEX ubicacion_localidad_indx 
ON ubicación (localidad);

--indice de la especie de la tabla mascota
CREATE INDEX mascota_especie_indx 
ON mascota (id_especie);

--indice del correo de la tabla usuario
CREATE INDEX usuario_correo_indx 
ON usuario (correo);