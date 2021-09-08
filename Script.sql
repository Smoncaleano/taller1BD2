
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
