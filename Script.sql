
CREATE TABLE tipo_usuario (
	id_tipo_usuario VARCHAR ( 20 ) PRIMARY KEY,
	nombre VARCHAR ( 20 ) NOT NULL
);


CREATE TABLE tipo_documento(
	id_tipo_documento VARCHAR ( 20 ) PRIMARY KEY,
	nombre VARCHAR ( 15 ) NOT NULL
);

CREATE TABLE ubicación(
	id_ubicación VARCHAR ( 20 ) PRIMARY KEY,
	dirección VARCHAR ( 30 ) NOT NULL,
	barrio VARCHAR ( 30 ) NOT NULL,
	localidad VARCHAR ( 30 ) NOT NULL
);

CREATE TABLE especie (
	id_especie VARCHAR ( 20 ) PRIMARY KEY,
	nombre VARCHAR ( 20 ) NOT NULL
);

CREATE TABLE caso (
	id_caso int PRIMARY KEY,
	nombre VARCHAR ( 30 ) NOT NULL
);

CREATE TABLE tipoVisita (
	id_tipo_visita int PRIMARY KEY,
	nombre VARCHAR ( 30 ) NOT NULL
);


CREATE TABLE UsuarioDetalle (
	documento VARCHAR ( 20 ) PRIMARY KEY,
	nombre VARCHAR ( 30 ) NOT NULL,
	telefono VARCHAR ( 20 ) NOT NULL,
	tipo_documento VARCHAR ( 20 ) references tipo_documento(id_tipo_documento) NOT NULL,
	id_ubicacion VARCHAR ( 20 ) references ubicación(id_ubicación) NOT NULL,
	tipo_usuario VARCHAR ( 20 ) references tipo_usuario(id_tipo_usuario) NOT NULL
);


CREATE TABLE usuario (
	documento_usr  VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL,
	correo VARCHAR ( 40 ) NOT NULL,
	contraseña VARCHAR ( 12 ) NOT NULL
);

CREATE TABLE mascota(
	id_mascota int PRIMARY KEY,
	id_propietario VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL,
	nombre VARCHAR ( 20 ) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	id_especie VARCHAR ( 20 )  references especie (id_especie) NOT NULL,
	tamaño float NOT NULL,
	peligroso VARCHAR ( 5 ) NOT NULL, 
	fotografía VARCHAR ( 80 ), 
	microchip BOOLEAN
	
);

CREATE TABLE aprobacion_func(
	id_veterinaria  VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL,
	id_funcionario  VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL
);

CREATE TABLE registro(
	id_registro  VARCHAR ( 20 ) PRIMARY KEY,
	fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE,
	id_tipo_visita int references tipoVisita (id_tipo_visita) NOT NULL,
	id_caso int references caso(id_caso),
	id_mascota int references mascota(id_mascota) NOT NULL
);

CREATE TABLE documentos(
	id_documentos VARCHAR ( 20 ) PRIMARY KEY,
	documentos VARCHAR ( 80 ),
	fotos VARCHAR ( 80 ),
	id_registro VARCHAR ( 20 ) references registro(id_registro ) NOT NULL

);


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
	
/*
SELECT * FROM listarMascotasPropietarioV as lista WHERE lista.id_propietario ='1212';
*/

CREATE INDEX usuariodetalle_id_indx 
ON usuariodetalle (documento);

CREATE INDEX tipoUsuario_id_indx 
ON tipo_usuario (id_tipo_usuario);

CREATE INDEX tipoDocumento_id_indx 
ON tipo_documento (id_tipo_documento);

CREATE INDEX ubicacion_id_indx 
ON ubicación (id_ubicación);

CREATE INDEX especie_id_indx 
ON especie (id_especie);

CREATE INDEX caso_id_indx 
ON caso (id_caso);

CREATE INDEX tipoVisita_id_indx 
ON tipoVisita (id_tipo_visita);

CREATE INDEX mascota_id_indx 
ON mascota (id_mascota);

CREATE INDEX registro_id_indx 
ON registro (id_registro);

CREATE INDEX documentos_id_indx 
ON documentos (id_documentos);

CREATE INDEX registro_fechaRegistro_indx 
ON registro (fecha_registro);

CREATE INDEX mascota_nombre_indx 
ON mascota (nombre);