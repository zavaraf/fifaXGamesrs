-- LIGA
INSERT INTO `fifaxgamersbd`.`liga`
(`idLiga`,
`nombre`,
`descripcion`)
VALUES
(1,
'Liga Mundial Fifa xGamers',
'Liga Mundial Fifa xGamers');

INSERT INTO `fifaxgamersbd`.`division`
(`idDivision`,
`nombre`,
`descripcion`,
`activo`,
`Liga_idLiga`)
VALUES
(1,
'1ra',
'1ra division',
1,
1);

INSERT INTO `fifaxgamersbd`.`division`
(`idDivision`,
`nombre`,
`descripcion`,
`activo`,
`Liga_idLiga`)
VALUES
(2,
'2da',
'2da division',
1,
1);


-- TIPO CONCEPTO

INSERT INTO `fifaxgamersbd`.`tipoconcepto`
(`idTipoConcepto`,
`codigoConcepto`,
`descripcionConcepto`)
VALUES
(1,
'INGRESO',
'INGRESO');

INSERT INTO `fifaxgamersbd`.`tipoconcepto`
(`idTipoConcepto`,
`codigoConcepto`,
`descripcionConcepto`)
VALUES
(2,
'EGRESO',
'EGRESO');

-- CONCEPTOS 

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`
(`idCatalogoConceptos`,
`nombre`,
`descripcion`,
`TipoConcepto_idTipoConcepto`)
VALUES
(1,
'PRETEMPORADA',
'PRETEMPORADA',
1);

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`
(`idCatalogoConceptos`,
`nombre`,
`descripcion`,
`TipoConcepto_idTipoConcepto`)
VALUES
(2,
'BAJAS JUGADORES',
'BAJAS JUGADORES',
1);

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`
(`idCatalogoConceptos`,
`nombre`,
`descripcion`,
`TipoConcepto_idTipoConcepto`)
VALUES
(3,
'ALTAS JUGADORES',
'ALTAS JUGADORES',
2);

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`
(`idCatalogoConceptos`,
`nombre`,
`descripcion`,
`TipoConcepto_idTipoConcepto`)
VALUES
(4,
'VENTA JUGADORES',
'VENTA JUGADORES',
1);

-- temporada

INSERT INTO `fifaxgamersbd`.`temporada`
(`idTemporada`,
`NombreTemporada`,
`Descripcion`)
VALUES
(1,
'78',
'78 temporada');

/*
-- temporada
INSERT INTO `fifaxgamersbd`.`temporada`
(`idTemporada`,
`NombreTemporada`,
`Descripcion`,
`Liga_idLiga`
)
VALUES
(1,
'78',
'78 temporada',1);

*/

-- CONSEPTOS SPONSIORS
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (1,  'Top 4 en la general',  'Top 4 en la general',  0,  7000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (2,  '17 o Más Goles a Favor en la General', '17 o Más Goles a Favor en la General', 0,  5000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (3,  '3 Victorias de Visitante:',  '3 Victorias de Visitante:',  0,  6000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (4,  'Ascenso Directo',  'Ascenso Directo',  1,  7000000,  4000000);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (5,  '12 Puntos de Visitante', '12 Puntos de Visitante', 1,  5000000,  3000000);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (6,  '14 o Más Goles de Diferencia de Gol en la General:', '14 o Más Goles de Diferencia de Gol en la General:', 1,  5000000,  3000000);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (7,  'Top 6 en la General',  'Top 6 en la General',  0,  6000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (8,  'Máximo 2 Derrotas',  'Máximo 2 Derrotas',  0,  6000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (9,  'Hasta 13 Goles en Contra en la General', 'Hasta 13 Goles en Contra en la General', 0,  4000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (10, 'Ascenso Directo',  'Ascenso Directo',  1,  6000000,  3000000);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (11, '4 o Más Victorias Como Local', '4 o Más Victorias Como Local', 1,  4000000,  2000000);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (12, '8 o Más Goles a Favor de Visitante', '8 o Más Goles a Favor de Visitante', 1,  4000000,  2000000);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (13, 'Evitar la Última/Penultima Casilla', 'Evitar la Última/Penultima Casilla', 0,  6000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (14, '3 Victorias en la General',  '3 Victorias en la General',  0,  5000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (15, 'Hasta 15 Goles en Contra en la General', 'Hasta 15 Goles en Contra en la General', 0,  6000000,  0);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (16, 'Top 8 en la General',  'Top 8 en la General',  1,  6000000,  4000000);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (17, '3 o Más Victorias de Visitante', '3 o Más Victorias de Visitante', 1,  4000000,  2000000);
INSERT INTO `fifaxgamersbd`.`conceptosponsor`(`idConcepto`,`nombreConcepto`,`descripcionConcepto`,`opcional`,`monto`,`penalidad`)
VALUES (18, '10 o Más Goles a Favor en la General', '10 o Más Goles a Favor en la General', 1,  4000000,  2000000);

-- SPONSIORS
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`division_idDivision`,`clase`)
VALUES (1,'Arena Vision', 'Arena Vision', 20000000, 2,  'C');
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`division_idDivision`,`clase`)
VALUES (2,'Capo Deportes',  'Capo Deportes',  20000000, 2,  'C');
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`Division_idDivision`,`clase`)
VALUES (3,'FutbolArg',  'FutbolArg',  20000000, 2,  'C');
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`Division_idDivision`,`clase`)
VALUES (4,'EliteGol', 'EliteGol', 25000000, 2,  'B');
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`Division_idDivision`,`clase`)
VALUES (5,'Rojadirecta',  'Rojadirecta',  25000000, 2,  'B');
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`Division_idDivision`,`clase`)
VALUES (6,'PirloTV',  'PirloTV',  25000000, 2,  'B');
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`Division_idDivision`,`clase`)
VALUES (7,'Bein Sports',  'Bein Sports',  35000000, 2,  'A');
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`Division_idDivision`,`clase`)
VALUES (8,'EuroSport',  'EuroSport',  35000000, 2,  'A');
INSERT INTO `fifaxgamersbd`.`sponsor`(`idSponsor`,`nombreSponsor`,`descripcionSponsor`,`contratoFijo`,`Division_idDivision`,`clase`)
VALUES (9,'GolTV',  'GolTV',  35000000, 2,  'A');


-- RELACIONES SPONSIOR VS CONCEPTOS 2DA DIVISION
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(7, 1);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(7, 2);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(7, 3);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(7, 4);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(7, 5);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(7, 6);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(8, 1);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(8, 2);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(8, 3);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(8, 4);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(8, 5);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(8, 6);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(9, 1);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(9, 2);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(9, 3);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(9, 4);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(9, 5);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES(9, 6);
  
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (4, 7);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (4, 8);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (4, 9);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (4, 10);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (4, 11);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (4, 12);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (5, 7);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (5, 8);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (5, 9);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (5, 10);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (5, 11);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (5, 12);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (6, 7);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (6, 8);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (6, 9);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (6, 10);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (6, 11);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (6, 12);
  
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (1,13);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (1,14);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (1,15);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (1,16);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (1,17);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (1,18);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (2,13);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (2,14);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (2,15);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (2,16);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (2,17);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (2,18);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (3,13);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (3,14);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (3,15);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (3,16);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (3,17);
INSERT INTO `fifaxgamersbd`.`sponsor_has_concepto`(`Sponsor_idSponsor`,`Concepto_idConcepto`)
VALUES (3,18);


-- Tipo Conceptos

INSERT INTO `fifaxgamersbd`.`tipoconcepto`
(`idTipoConcepto`,
`codigoConcepto`,
`descripcionConcepto`)
VALUES
(1,
'ingreso',
'Ingreso');


INSERT INTO `fifaxgamersbd`.`tipoconcepto`
(`idTipoConcepto`,
`codigoConcepto`,
`descripcionConcepto`)
VALUES
(2,
'egreso',
'egreso');


-- Catalogo conceptos Datos Financieros

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`(`idCatalogoConceptos`,`nombre`,`descripcion`,`TipoConcepto_idTipoConcepto`)
VALUES
(1,'pretemporada','Pretemporada',1);

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`(`idCatalogoConceptos`,`nombre`,`descripcion`,`TipoConcepto_idTipoConcepto`)
VALUES
(2,'altasPC','Altas a la PC',2);

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`(`idCatalogoConceptos`,`nombre`,`descripcion`,`TipoConcepto_idTipoConcepto`)
VALUES
(3,'bajasPC','Bajas a la PC',1);

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`(`idCatalogoConceptos`,`nombre`,`descripcion`,`TipoConcepto_idTipoConcepto`)
VALUES
(4,'ventasDT','Ventas a la DT',1);

INSERT INTO `fifaxgamersbd`.`catalogoconceptos`(`idCatalogoConceptos`,`nombre`,`descripcion`,`TipoConcepto_idTipoConcepto`)
VALUES
(5,'comprasDT','Compras a la DT',2);


-- Equipos

INSERT INTO `fifaxgamersbd`.`equipos`
(`idEquipo`,
`nombreEquipo`,
`descripcionEquipo`,
`activo`,
`Division_idDivision`)
VALUES
(1,
'Agente Libre',
'Agente Libre',
1,
1);

--  Configuracion Fifa

INSERT INTO `fifaxgamersbd`.`configuraciondraft`(`idconfiguracionDraft`,`codigo`,`descripcion`,`monto`)
VALUES(1,'ofertaInicial','Oferta Inicial para draft',7000000);

INSERT INTO `fifaxgamersbd`.`configuraciondraft`(`idconfiguracionDraft`,`codigo`,`descripcion`,`monto`)
VALUES(2,'contraoferta','Contraoferta Draft',5000000);

INSERT INTO `fifaxgamersbd`.`configuraciondraft`(`idconfiguracionDraft`,`codigo`,`descripcion`,`monto`)
VALUES(3,'confirmacionDraft','Minutos para confirmar Draft',120);

INSERT INTO `fifaxgamersbd`.`configuraciondraft`(`idconfiguracionDraft`,`codigo`,`descripcion`,`monto`)
VALUES(4,'horaInicio','Hora que inicia el Draft',9);

INSERT INTO `fifaxgamersbd`.`configuraciondraft`(`idconfiguracionDraft`,`codigo`,`descripcion`,`monto`)
VALUES(5,'horaFin','Hora que termina el Draft',24);

-- Roles

INSERT INTO `fifaxgamersbd`.`roles`(`idRoles`,`nombreRol`,`descripcionRol`)
VALUES(1,'Jugador','Jugador');
INSERT INTO `fifaxgamersbd`.`roles`(`idRoles`,`nombreRol`,`descripcionRol`)
VALUES(2,'Manager','Manager');
INSERT INTO `fifaxgamersbd`.`roles`(`idRoles`,`nombreRol`,`descripcionRol`)
VALUES(3,'Admin','Admin');
INSERT INTO `fifaxgamersbd`.`roles`(`idRoles`,`nombreRol`,`descripcionRol`)
VALUES(4,'Usuario','Usuario');


INSERT INTO `fifaxgamersbd`.`usuarios`
(`userName`,
`pass`)
VALUES
('super',
'$2a$10$JTyvfmzJZzvLZOUuvnu82uuTOrf4CoVyn8sJuL8L.SnxSU1NfmHwG');

INSERT INTO `fifaxgamersbd`.`usuarios_has_roles`
(`Usuarios_userName`,
`Roles_idRoles`)
VALUES
('super',
3);


INSERT INTO `fifaxgamersbd`.`tipoImagen`
(`idTipoImagen`,
`codigoImagen`,
`descripcionimagen`)
VALUES
(1,
"Logo jornadas",
"Logo jornadas");

INSERT INTO `fifaxgamersbd`.`tipoImagen`
(`idTipoImagen`,
`codigoImagen`,
`descripcionimagen`)
VALUES
(2,
"Logo Equipo",
"Logo Equipo");


INSERT INTO `fifaxgamersbd`.`tipotorneo`
(`idtipoTorneo`,
`tipo`)
VALUES
(1,
'Torneo Normal');

INSERT INTO `fifaxgamersbd`.`tipotorneo`
(`idtipoTorneo`,
`tipo`)
VALUES
(2,
'Torneo por Grupos');
