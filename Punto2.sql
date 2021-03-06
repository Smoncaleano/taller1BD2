/*
Funcion que verifica si una mascota ya esta esterilizada o ya tiene microchip,
si esto se cumple no deja hacer el registro de la visita
*/
CREATE OR REPLACE FUNCTION verificar_unicidad_fn()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
	microchip boolean;
	estrilizacion boolean;
BEGIN
	
	SELECT CASE WHEN (COUNT(*) = 0) THEN FALSE ELSE TRUE END
	INTO estrilizacion
	FROM registro as r INNER JOIN
	tipovisita as tv ON
	r.id_tipo_visita = tv.id_tipo_visita
	WHERE NEW.id_tipo_visita = tv.id_tipo_visita;
	
	IF estrilizacion THEN
		RAISE EXCEPTION 'La mascota ya esta esterilizada';
	END IF;
	
	SELECT CASE WHEN (COUNT(*) = 0) THEN FALSE ELSE TRUE END
	INTO microchip
	FROM registro AS r
	INNER JOIN tipovisita AS tv
	ON tv.id_tipo_visita = r.id_tipo_visita
	INNER JOIN mascota AS m
	ON m.id_mascota = r.id_mascota
	WHERE NEW.id_tipo_visita = tv.id_tipo_visita
	OR m.microchip = true;
	
	IF microchip THEN
		RAISE EXCEPTION 'La mascota ya tiene un microchip';
	END IF;
	
	RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS verificar_unicidad_tr ON registro;

--Trigger que ejecuta la funcion de verificacion antes de la insercion
CREATE TRIGGER verificar_unicidad_tr
	BEFORE INSERT
	ON registro
	FOR EACH ROW
	EXECUTE PROCEDURE verificar_unicidad_fn();