# taller2BD2

## Integrantes:
- Nicolás Ávila Ávila
- Sebastián Moncaleano Mosquera
- Diego Fernando Torres Jiménez

## Herramientas:

- PostgreSQL 13
- PGAdmin 4

## Estructura del repositorio

El presente repositorio contiene los siguientes 4 archivos:
  - Script.sql : Contiene los scripts necesarios para crear la respectiva base de datos, se encuentra en la raíz del repositorio.
  - Diagrama_BD.pdf: Contiene el modelo relacional de la base de datos.
  - Diccionaro.pdf: Almacena el diccionario de datos de la bd.
  - Evidencia_ejecucion_scripts.pdf : Almacena la evidencia del correcto funcionamiento de la base de datos. 
  - Trigger_punto1.sql: Query del trigger del punto 1
  - punto2.sql: Query del trigger del punto 2
  - funcion_punto3.sql: Query de la funcion del punto 3
  - Evidencias Ejecucion punto 1 taller 2.pdf: Evidencia de la ejecucion del correcto funcionamiento del punto 1
  - Evidencias Ejecucion punto 2 taller 2.pdf: Evidencia de la ejecucion del correcto funcionamiento del punto 2
  - Evidencias Ejecucion punto 3 taller 2.pdf: Evidencia de la ejecucion del correcto funcionamiento del punto 3

## Modelo de datos

El modelo de base de datos que se creó consta de 12 tablas, dichas tablas representan la base de datos de "Ciudadanos de 4 Patas", dichas tablas se crearon de forma que se cumpla con una optima relación de tablas que permite manejar la información necesaria para la aplicación de manera eficáz.

A continuación se relacionan las tablas que se describen en el modelo relacional y una breve descripción de lo que almacenan, cabe destacar que dichas tablas se pensaron en un esquema de normalización de 3FN : 
  ### Tablas generadas
  - aprobacion_func : Almacena los usuarios de veterinaria que son aprobados por un funcionario de la alcaldía.
  - caso : Tipos de caso disponibles para registro.
  - documentos: Documentos adjuntos para los registros.
  - especie: Tipos de especies de mascotas.
  - mascota: Información general de la mascota.
  - registro: Registros de casos y visitas asignadas a cada mascota.
  - tipo_documento: Tipo de documento del usuario (nit,cc,etc).
  - tipo_usuario: Tipo de usuario que se almacena (Funcionario,Veterinaria o propietario).
  - tipovisita: Tipo de visita que se realiza (Esterilización, Implantación de microchip, etc).
  - ubicacion: Ubicación geográfica del propietario incluyendo ciudad, barrio y localidad.
  - usuario: Usuario de acceso a la plataforma que contiene el correo y contraseña con el que los usuarios se autentican.
  - usuariodetalle: Información general de los usuarios.
  - mascota_audit: Registro de audirotria de cuando se modifica, inserta o elimina en la tabla mascota.
  - microchip_goals: metas de implantacion de microchip en mascotas.

## Orden de ejecución

Para poder verificar los respectivos scripts es necesario tener instalado en su ordenador PostgreSQL13 como también es recomendable instalar el entorno de trabajo PGAdmin4.

Una vez instalado se debe abrir PGAdmin4 y posteriormente crear una nueva base de datos, una vez creada por medio del menú tools se debe seleccionar la opción de Query tool y posteriormente abrir el archivo Script.sql, dicho archivo contiene la creación de tablas e Indexes necesarios para el correcto funcionamiento de la base de datos.

## Por qué se crearon los indices?

  Los indices se crearon para dar mayor velocidad a las respectivas consultas aumentando su optimización
  
## Por qué se crearon vistas?

  Las vistas se generaron para crear mayor seguridad al acceso de la información y para cumplir con los respectivos requerimientos no funcionales
  
## Triggers generados

  - verificar_evento_tr: Trigger que ejecuta una funcion que registra los eventos en la tabla de mascota_audit
  - verificar_unicidad_tr: Trigger que ejecuta la funcion que verifica si una mascota ya esta esterilizada o ya tiene microchip
