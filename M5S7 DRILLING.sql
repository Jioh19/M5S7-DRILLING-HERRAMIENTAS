-- 1. Listar los clientes sin arriendos por medio de una subconsulta.
SELECT rut, nombre 
    FROM (SELECT * FROM cliente LEFT JOIN arriendo ON cliente.rut = arriendo.cliente_rut) 
        AS tabla WHERE folio IS NULL;

-- 2. Listar todos los arriendos con las siguientes columnas: Folio, Fecha, Dias, ValorDia,
-- NombreCliente, RutCliente.
SELECT folio, fecha, dias, valordia, nombre, rut 
    FROM arriendo INNER JOIN cliente ON rut = cliente_rut;

-- 3. Clasificar los clientes según la siguiente tabla:
SELECT nombre AS "Nombre", rut AS "Fecha", to_char(fecha, 'YYYY-MM') AS "Periodo", COUNT(*) AS "Arriendos",
	CASE
		WHEN COUNT(*) < 2 THEN 'Bajo'
		WHEN COUNT(*) < 4 THEN 'Medio'
		ELSE 'ALTO'
	END AS "Clasificación"
        FROM arriendo INNER JOIN cliente ON rut = cliente_rut
            GROUP BY rut, "Periodo";

-- 4. Por medio de una subconsulta, listar los clientes con el nombre de la herramienta más
-- arrendada
--* Aporte del compañero Franco Contreras
SELECT DISTINCT ON(cliente.nombre) cliente.nombre, cliente.rut, s.nombre AS "Herramienta", COUNT(*) AS "Cantidad" 
    FROM cliente INNER JOIN
        (SELECT * FROM arriendo INNER JOIN herramienta ON idherramienta = herramienta_idherramienta) AS s
            ON rut = cliente_rut GROUP BY cliente.nombre, cliente.rut, s.nombre ORDER BY cliente.nombre, "Cantidad" DESC;
