--Se crea tabla mascota_audit, donde se llevarán los registros de eventos en la tabla mascota
CREATE TABLE mascota_audit(
	id_mascota int,
	id_propietario VARCHAR ( 20 ) references usuarioDetalle(documento) NOT NULL,
	nombre VARCHAR ( 20 ) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	id_especie VARCHAR ( 20 )  references especie (id_especie) NOT NULL,
	tamaño float NOT NULL,
	peligroso VARCHAR ( 5 ) NOT NULL, 
	fotografía VARCHAR ( 80 ), 
	microchip BOOLEAN ,
	sexo VARCHAR( 10 ) NULL,
	event_type VARCHAR (20),
	event_datatime date
	
);

--Función con la lógica que ejecutará nuestro trigger
CREATE OR REPLACE FUNCTION verificar_evento_fn()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
	datetimenow date;
BEGIN
	datetimenow = now();
	IF (TG_OP = 'DELETE') THEN
	RAISE NOTICE 'ENTRÓ EN ELIMINADO';
            INSERT INTO mascota_audit VALUES(OLD.*, 'DELETE', datetimenow );
            RETURN OLD;
	ELSIF (TG_OP = 'UPDATE') THEN
	RAISE NOTICE 'ENTRÓ EN ACTUALIZADO';
             INSERT INTO mascota_audit VALUES(OLD.*, 'UPDATE', datetimenow );
            RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
		RAISE NOTICE 'ENTRÓ EN INSERTADO';
            INSERT INTO mascota_audit VALUES(NEW.*, 'INSERT', datetimenow );
            RETURN NEW;
    END IF;
END;
$$;


--elimina el trigger si ya existe
DROP TRIGGER IF EXISTS verificar_evento_tr ON mascota;

--Trigger que ejecuta la funcion de verificacion antes de la insercion, eliminación o actualización en la tabla mascota
CREATE TRIGGER verificar_evento_tr
	AFTER DELETE OR INSERT OR UPDATE
	ON mascota
	FOR EACH ROW
	EXECUTE PROCEDURE verificar_evento_fn();
	
	