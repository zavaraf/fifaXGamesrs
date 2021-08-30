
select cons.*
from sponsor
join sponsor_has_concepto sponc on sponsor.idSponsor = sponc.Sponsor_idSponsor
join conceptosponsor cons on sponc.Concepto_idConcepto = cons.idConcepto
where sponsor.idSponsor =1
and cons.opcional = 0
;

call createOrUpdateDatosSponsor(9,1,1);

call crearTorneo('1ra');

select * from temporada;


select * from datosfinancieros dat
where dat.Equipos_idEquipo =2
and dat.idDatosFinancieros = 1
and dat.Sponsor_idSponsor = 7
and dat.Temporadas_idTemporada =1;

select cons.idConcepto,
cons.nombreConcepto,
cons.descripcionConcepto,
cons.monto,
cons.opcional,
cons.penalidad
from datosfinancieros datos
join datosfinancieros_has_conceptosponsor dathas on datos.idDatosFinancieros = dathas.DatosFinancieros_idDatosFinancieros
join conceptosponsor cons on cons.idConcepto = dathas.ConceptoSponsor_idConcepto
where datos.Equipos_idEquipo = 2
and datos.Sponsor_idSponsor = 8
and datos.Temporadas_idTemporada = 1
;

select 
dat.idDatosFinancieros,
dat.Equipos_idEquipo,
dat.presupuestoFinal,
dat.presupuestoInicial,
dat.Sponsor_idSponsor,
dat.sponsorOpcional,
dat.Temporadas_idTemporada
from datosfinancieros dat
where dat.idDatosFinancieros = 1
and dat.Equipos_idEquipo = 2
and dat.Temporadas_idTemporada = 1
;

select * from conceptosponsor;
select * from temporada;




call spTest();



SELECT 
equipos.idEquipo, 
equipos.NombreEquipo, 
equipos.DescripcionEquipo, 
equipos.activo , 
equipos.Division_idDivision,
division.nombre as nombreDivision,
division.descripcion as descripcionDivision ,
tot.totalJugadores,
tot.totalRaiting ,
temporada.idTemporada, 
temporada.NombreTemporada,
dat.presupuestoInicial,
dat.presupuestoFinal
FROM fifaxgamersbd.equipos 			
 join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision 
 join equipos_has_temporada equitor on equitor.Equipos_idEquipo = equipos.idEquipo 
					and equitor.Temporadas_idTemporada = (select idTemporada from temporada order by temporada.idTemporada desc limit 1) 
 join temporada on temporada.idTemporada = equitor.Temporadas_idTemporada 
 left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo
             from fifaxgamersbd.persona  
             join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona 
             join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles 
             join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo 
             where roles.nombreRol = 'Jugador'  
             group by equipos.idEquipo) tot on tot.idEquipo = equipos.idEquipo 
left join datosfinancieros dat on dat.Equipos_idEquipo = equipos.idEquipo
Where equipos.idEquipo = 10;
 
-- insert Equipo has Temporadas
insert into equipos_has_temporada
select idEquipo,1 from equipos
where equipos.idEquipo not in(select Equipos_idEquipo from equipos_has_temporada);

select idEquipo,1 from equipos
where equipos.idEquipo not in(select Equipos_idEquipo from equipos_has_temporada);

-- Sponsors 
 
delete from datosfinancieros_has_conceptosponsor where ConceptoSponsor_idConcepto != 0;
delete from datosfinancieros where datosfinancieros.idDatosFinancieros!= 0;

select * from datosfinancieros_has_conceptosponsor da
where da.DatosFinancieros_Equipos_idEquipo = 2
and da.DatosFinancieros_Temporadas_idTemporada;
select * from datosfinancieros where sponsorOpcional = true;


-- Finanzas

select cat.idCatalogoConceptos,
cat.nombre,
cat.descripcion,
tipo.idTipoConcepto,
tipo.codigoConcepto,
tipo.descripcionConcepto
from catalogoconceptos cat 
join tipoconcepto tipo on tipo.idTipoConcepto = cat.TipoConcepto_idTipoConcepto;

select con.idConceptosFinancieros,
con.monto,
cat.idCatalogoConceptos,
cat.nombre,
cat.descripcion,
tipo.idTipoConcepto,
tipo.codigoConcepto,
tipo.descripcionConcepto
from conceptosfinancieros con
join catalogoconceptos cat on cat.idCatalogoConceptos = con.CatalogoConceptos_idCatalogoConceptos
join tipoconcepto tipo on tipo.idTipoConcepto = cat.TipoConcepto_idTipoConcepto
where con.DatosFinancieros_Equipos_idEquipo = 2
and con.DatosFinancieros_idDatosFinancieros = 1
and con.DatosFinancieros_Sponsor_idSponsor = 7
and con.DatosFinancieros_Temporadas_idTemporada = 1;

select * from datosfinancieros;

select * from datosfinancieros_has_conceptosponsor dathas
where dathas.DatosFinancieros_Equipos_idEquipo = 2;


call createOrUpdateObjetivos('[{"id": 2, "nombre": "17 o Más Goles a Favor en la General", "descripcion": "17 o Más Goles a Favor en la General", "monto": 5000000, "cumplido": true},{"id": 1, "nombre": "17 o Más Goles a Favor en la General", "descripcion": "17 o Más Goles a Favor en la General", "monto": 5000000, "cumplido": true}]',
2,7,1);


-- Consultas para Draft DT

select 
persona.idPersona,
persona.NombreCompleto,
persona.sobrenombre,
persona.raiting,
persona.prestamo,
equipos.idEquipo,
equipos.nombreEquipo,
equipopres.idEquipo as idEquipoPres,
equipopres.nombreEquipo as nombreEquipoPres
from prestamos
join persona on prestamos.Persona_idPersona = persona.idPersona
join equipos on equipos.idEquipo = prestamos.Equipos_idEquipo
join equipos equipopres on equipopres.idEquipo = persona.Equipos_idEquipo
where prestamos.activo = 1
;

delete from prestamos where prestamos.Equipos_idEquipo =8;

select * from 
persona 
;

call createPrestamo(12,2);


select prestamos.Equipos_idEquipo 
	from prestamos
	where prestamos.Persona_idPersona= 13;
    

-- draft PC

select persona.idPersona,
persona.NombreCompleto,
persona.sobrenombre,
persona.raiting,
equipos.idEquipo,
equipos.nombreEquipo,
draftpc.fechaCompra,
draftpc.oferta,
draftpc.usuarioOferta,
draftpc.comentarios,
draftpc.abierto,
temporada.idTemporada,
temporada.NombreTemporada
from draftpc
join persona on persona.idPersona = draftpc.Persona_idPersona
join equipos on equipos.idEquipo = persona.Equipos_idEquipo
join temporada on temporada.idTemporada = draftpc.Temporadas_idTemporada
where draftpc.abierto = 1
;

select null,draftpc.oferta,
draftpc.fechaCompra,
draftpc.usuarioOferta,
draftpc.idDraftPC,
draftpc.Persona_idPersona,
draftpc.Temporadas_idTemporada,
draftpc.comentarios,
draftpc.ofertaFinal
from draftpc;

select * from historicodraft;
select * from draftpc;
delete from historicodraft where historicodraft.idHistoricoDraft >0;
delete from draftpc where draftpc.idDraftPC = 1;

 SELECT  
 equipos.idEquipo,  
 equipos.NombreEquipo,  
 equipos.DescripcionEquipo,  
 equipos.activo ,  
 equipos.Division_idDivision, 
 division.nombre as nombreDivision, 
 division.descripcion as descripcionDivision , 
 tot.totalJugadores, 
 tot.totalRaiting  
 FROM fifaxgamersbd.equipos 			 
  join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision  
  left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo 
              from fifaxgamersbd.persona   
              join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  
              join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles  
              join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  
              where roles.nombreRol = 'Jugador'   
              group by equipos.idEquipo) tot on tot.idEquipo = equipos.idEquipo  
 Where equipos.idEquipo = 1;
 

 
select username, pass as password from usuarios ;
delete from usuarios where username='zavaraf';

select 'ROLE_'+roles.nombreRol as role
from usuarios_has_roles ushas
join roles on roles.idRoles = ushas.Roles_idRoles
where ushas.Usuarios_userName = 'zavaraf'
;

select Usuarios_userNamem, Roles_idRoles from usuarios_has_roles;

 select distinct
 dat.idDatosFinancieros,
 dat.Equipos_idEquipo,
 dat.presupuestoFinal,
 dat.presupuestoInicial,
 dat.sponsorOpcional,
 dat.Temporadas_idTemporada,
 datS.Sponsor_idSponsor
 from datosfinancieros dat
 left join dadosfinancierossponsor datS on datS.DatosFinancieros_idDatosFinancieros = dat.idDatosFinancieros
		and datS.DatosFinancieros_Equipos_idEquipo = dat.Equipos_idEquipo
        and datS.DatosFinancieros_Temporadas_idTemporada = dat.Temporadas_idTemporada
 where dat.idDatosFinancieros = 1
 and dat.Equipos_idEquipo =   4
 and dat.Temporadas_idTemporada =   1;

 SELECT  
 equipos.idEquipo,  
 equipos.NombreEquipo,  
 equipos.DescripcionEquipo,  
 equipos.activo ,  
 equipos.Division_idDivision, 
 division.nombre as nombreDivision, 
 division.descripcion as descripcionDivision , 
 tot.totalJugadores, 
 tot.totalRaiting , 
 temporada.idTemporada,  
 temporada.NombreTemporada 
 FROM fifaxgamersbd.equipos                    
  join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision  
  join equipos_has_temporada equitor on equitor.Equipos_idEquipo = equipos.idEquipo  
                                      and equitor.Temporadas_idTemporada = (select idTemporada from temporada order by temporada.idTemporada desc limit 1)  
  join temporada on temporada.idTemporada = equitor.Temporadas_idTemporada  
  left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo 
              from fifaxgamersbd.persona   
              join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  
              join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles  
              join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  
              where roles.nombreRol = 'Jugador'   
              group by equipos.idEquipo) tot on tot.idEquipo = equipos.idEquipo  

 Where equipos.idEquipo =   2;
 
 
 
 call createTemporada('79','79 temporada');
 
 
 select draftpc.Persona_idPersona,draftpc.ofertaFinal 
from draftpc
where draftpc.Persona_idPersona = 42 and draftpc.Temporadas_idTemporada = 2;

select dat.presupuestoFinal 
from datosfinancieros dat
where dat.Equipos_idEquipo = 2
and dat.Temporadas_idTemporada = 2;

select monto 
from configuraciondraft
where codigo='horaFin'
limit 1;

select fechaCompra,
diasSe,
MINUTOSDIA_CERO,
minutosdia,
minutos_dia_actual,
(minutosdia+minutos_dia_actual) sumaminutosdia,
(minutosdia_cero+minutos_dia_actual) sumaminutosdia_cero

from
(
select 
draftpc.fechaCompra,
timestampdiff(day,DATE(draftpc.fechaCompra),Date(NOW())) as diasSe,
timestampdiff(MINUTE, draftpc.fechaCompra, now()) MINUTOSDIA_CERO,
timestampdiff(MINUTE, draftpc.fechaCompra, DATE_ADD(DATE(draftpc.fechaCompra),INTERVAL 24 HOUR)) MINUTOSDIA,
timestampdiff(MINUTE, DATE_ADD(DATE(now()),INTERVAL 9 HOUR), now()) Minutos_dia_Actual
from draftpc where draftpc.Persona_idPersona =  45 and draftpc.Temporadas_idTemporada = 2) ta
;

select 
draftpc.fechaCompra,
timestampdiff(DAY,DATE(draftpc.fechaCompra),Date(NOW())) as diasSe,
timestampdiff(MINUTE, draftpc.fechaCompra, NOW()) MINUTOSDIA,
timestampdiff(MINUTE, DATE_ADD(DATE(now()),INTERVAL 9 HOUR), now()) Minutos_dia_Actual
from draftpc where draftpc.Persona_idPersona =  45 and draftpc.Temporadas_idTemporada = 2;


select TIMESTAMPDIFF(MINUTE,'2019-04-08 17:37:17',NOW()) as min;
SELECT NOW();
SELECT DATE_ADD(DATE('2019-04-08 17:37:17'),INTERVAL 9 HOUR);
select * 
from 
draftpc
where draftpc.Persona_idPersona =  28 and draftpc.Temporadas_idTemporada = 2
;

update draftpc set fechacompra = '2019-04-08 23:37:17'

where draftpc.Persona_idPersona =  42 and draftpc.Temporadas_idTemporada = 2;

update prestamos set Temporadas_idTemporada = 1
where Temporadas_idTemporada = 0;
SELECT * FROM PRESTAMOS;

select prestamos.Persona_idPersona 
from prestamos
where prestamos.Persona_idPersona = 14;

 call createPrestamo(14,8,2,1);


select * from prestamos;

select * from temporada;

SELECT 
equipos.idEquipo, 
equipos.nombreEquipo, 
equipos.descripcionEquipo, 
equipos.activo , 
equipos.Division_idDivision,
division.nombre as nombreDivision,
division.descripcion as descripcionDivision ,
tot.totalJugadores,
tot.totalRaiting, 
tot.presupuestoInicial, 
tot.presupuestoFinal 
FROM fifaxgamersbd.equipos 
join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision 
left join (select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo,dat.presupuestoInicial, dat.presupuestoFinal
       from fifaxgamersbd.persona  
       join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona 
       join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles 
       join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo 
       join fifaxgamersbd.Equipos_has_Temporadas et on et.Equipos_idEquipo = equipos.idEquipo 
       join fifaxgamersbd.temporada on temporada.idTemporada = et.Temporadas_idTemporada
       left join datosfinancieros dat on dat.Equipos_idEquipo = equipos.idEquipo and dat.Temporadas_idTemporada = temporada.idTemporada
       where roles.nombreRol = 'Jugador' and temporada.idTemporada = 5
       group by equipos.idEquipo) tot on tot.idEquipo = equipos.idEquipo 
 ;


select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo,dat.presupuestoInicial, dat.presupuestoFinal
       from fifaxgamersbd.persona  
       join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona 
       join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles 
       join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo 
       join fifaxgamersbd.Equipos_has_Temporadas et on et.Equipos_idEquipo = equipos.idEquipo 
       join fifaxgamersbd.temporada on temporada.idTemporada = et.Temporadas_idTemporada
       left join datosfinancieros dat on dat.Equipos_idEquipo = equipos.idEquipo and dat.Temporadas_idTemporada = temporada.idTemporada
       where roles.nombreRol = 'Jugador' and temporada.idTemporada = 5
       group by equipos.idEquipo ;
       
select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo
       from fifaxgamersbd.persona  
       join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona 
       join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles 
       join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo 
       left join fifaxgamersbd.Equipos_has_Temporadas et on et.Equipos_idEquipo = equipos.idEquipo 
       
       
       where roles.nombreRol = 'Jugador' and et.Temporadas.idTemporada = 5
       group by equipos.idEquipo ;
       

select persona.idPersona,1 from persona where persona.Equipos_idEquipo = 13;

select * from roles;

select * from persona_has_roles;



select * from temporada;

select * from equipos_has_temporada where equipos_has_temporada.Temporadas_idTemporada = 4;

delete from equipos_has_temporada  where equipos_has_temporada.Temporadas_idTemporada = 4;
delete from temporada where temporada.idTemporada = 4;


delete from equipos where equipos.idEquipo=29 and equipos.Division_idDivision=2;

call createTemporada('94','Temporada 94',1);

usuariosusuariosusuariosusuariosselect version();


SELECT * FROM PERSONA;

INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('M. MAIGNAN','M. MAIGNAN',78,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('A. WAN-BISSAKA','A. WAN-BISSAKA',76,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('S. ROBERTO','S. ROBERTO',83,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('A. MANDI','A. MANDI',80,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('F. BALBUENA','F. BALBUENA',80,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('J. BEDNAREK','J. BEDNAREK',75,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('J. GIMÉNEZ','J. GIMÉNEZ',84,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('SARACCHI','SARACCHI',75,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('G. KONAN','G. KONAN',75,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('ALLAN','ALLAN',84,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('P. FODEN','P. FODEN',75,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('M. GUENDOUZI','M. GUENDOUZI',72,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('BRUMA','BRUMA',78,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('A. SAITN-MAXIMIN','A. SAITN-MAXIMIN',79,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('D. COSTA','D. COSTA',85,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('A. DOUCOURÉ','A. DOUCOURÉ',81,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('M. ÖZIL','M. ÖZIL',85,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('I. SANGARÉ','I. SANGARÉ',75,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('M. VARGAS','M. VARGAS',75,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('R MAHREZ','R MAHREZ',85,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('M. ZARACHO','M. ZARACHO',74,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('JOAO MARIO','JOAO MARIO',81,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('JOELINTON','JOELINTON',76,13,1);
INSERT INTO `fifaxgamersbd`.`persona`(`NombreCompleto`,`sobrenombre`,`raiting`,`Equipos_idEquipo`,`activo`)VALUES ('W. JOSÉ','W. JOSÉ',82,13,1);

 select usuarios.username, 
 usuarios.pass as password, 
 usuarios.email, 
 equipos.nombreEquipo, 
 equipos.idEquipo , 
 GROUP_CONCAT(DISTINCT roles.descripcionRol ORDER BY roles.descripcionRol ASC SEPARATOR ' - ') as roles 
 from usuarios 
 join usuarios_has_roles uhr on uhr.Usuarios_userName = usuarios.userName 
 join roles on uhr.Roles_idRoles = roles.idRoles 
 left join equipos on usuarios.idequipo = equipos.idEquipo 
 where usuarios.userName = 'zavaraf' 
 group by  equipos.nombreEquipo ;
 
 select * from usuarios;


select * from usuarios_has_roles;

select version();


select * from roles;

select * from persona where idPersona = 276;


select count(persona.idPersona) as totalJugadores, sum(persona.Raiting) totalRaiting, equipos.idEquipo
       ,dat.presupuestoInicial, dat.presupuestoFinal 
       from fifaxgamersbd.persona   
       join fifaxgamersbd.persona_has_roles pero on pero.Persona_idPersona = persona.idPersona  
       join fifaxgamersbd.roles on roles.idRoles = pero.Roles_idRoles  
       join fifaxgamersbd.equipos on equipos.idEquipo = persona.Equipos_idEquipo  
       join fifaxgamersbd.equipos_has_temporada et on et.Equipos_idEquipo = equipos.idEquipo  
       join fifaxgamersbd.temporada on temporada.idTemporada = et.Temporadas_idTemporada 
       left join datosfinancieros dat on dat.Equipos_idEquipo = equipos.idEquipo and dat.Temporadas_idTemporada = temporada.idTemporada 
       where roles.nombreRol = 'Jugador' and temporada.idTemporada = 1
       group by equipos.idEquipo and dat.presupuestoInicial;
       
       
select * from catalogoconceptos;

select * from conceptosfinancieros where CatalogoConceptos_idCatalogoConceptos = 2;


select * from temporada;

update temporada set Liga_idLiga = 1 where Liga_idLiga = 0 ;


select 
cat.idCatalogoConceptos,
cat.nombre,
cat.descripcion,
tipo.idTipoConcepto,
tipo.codigoConcepto,
tipo.descripcionConcepto
from catalogoconceptos cat 
join tipoconcepto tipo on tipo.idTipoConcepto = cat.TipoConcepto_idTipoConcepto 
;



call crearJornada(24,25,1,5,1,1);
call crearJornada(26,27,1,5,1,1);
call crearJornada(28,29,1,5,1,1);

call crearJornada(4,29,2,5,1,1);
call crearJornada(14,17,2,5,1,1);
call crearJornada(16,19,2,5,1,1);
call crearJornada(18,21,2,5,1,1);
call crearJornada(20,23,2,5,1,1);
call crearJornada(22,25,2,5,1,1);
call crearJornada(24,27,2,5,1,1);
call crearJornada(26,13,2,5,1,1);
call crearJornada(28,13,2,5,1,1);

call crearJornada(4,17,3,5,1,1);
call crearJornada(18,22,3,5,1,1);

call updateResultadoJornada(3,18,22,2,1);
call updateResultadoJornada(3,4,17,3,5);

call addGoles(1,4,399,19);

select * from golesjornadas;

select count( equipos.idEquipo) goles
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo
where golesjornadas.jornadas_has_equipos_jornadas_idJornada = 1
and equipos.idEquipo in (4)
;

select jhe.equipos_idEquipoLocal ,jhe.equipos_idEquipoVisita
from jornadas_has_equipos jhe 
where jhe.jornadas_idJornada = 1
and jhe.id = 1;





select equipos.idEquipo,
equipos.nombreEquipo,
persona.idPersona,
persona.sobrenombre,
persona.NombreCompleto
from golesjornadas
join persona on persona.idPersona = golesjornadas.persona_idPersona
join equipos on equipos.idEquipo = golesjornadas.equipos_idEquipo

where golesjornadas.jornadas_has_equipos_jornadas_idJornada = 1
and equipos.idEquipo in (18,19)
;



select * from jornadas;

select hje.id 
from jornadas_has_equipos hje
where hje.id =4644 
and hje.equipos_idEquipoLocal = 26
and hje.equipos_idEquipoVisita = 28
and hje.jornadas_idJornada = 228;


select * 
from jornadas
join jornadas_has_equipos jhe on jornadas.idJornada= jhe.jornadas_idJornada
where jornadas.division_idDivision = 2;


DELETE FROM jornadas
WHERE idJornada !=0;

delete from jornadas_has_equipos
where jornadas_idJornada  != 0;

delete from golesjornadas
where id!=0;

delete from imagenesjornadas
where id!=0;

select * from jornadas;

select version();


select * from temporada;
select * from division;
select * from liga;


select Equipos_idEquipo 
from persona
where idPersona = 11
;

-- consulta para jornadas INICIO

 select tabla.idJornada, tabla.id, tabla.numeroJornada,tabla.activa,
 tabla.equipos_idEquipoLocal, 
 (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoLocal) equipoLocal, 
 tabla.golesLocal, 
 tabla.golesVisita, 
  
 (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoVisita) equipoVisita, 
 tabla.equipos_idEquipoVisita 
  
 from ( 
  
 select jornadas.idJornada, je.id, jornadas.numeroJornada,jornadas.activa,
 je.equipos_idEquipoLocal, 
 je.golesLocal, 
 je.golesVisita, 
 je.equipos_idEquipoVisita 
 from jornadas 
 join jornadas_has_equipos je on je.jornadas_idJornada = jornadas.idJornada 
 ) tabla 
 
 order by tabla.idJornada asc ;

select tabla.idJornada,tabla.id,tabla.numeroJornada,tabla.activa,
tabla.equipos_idEquipoLocal,
(select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoLocal) equipoLocal,
tabla.golesLocal,
tabla.golesVisita,

(select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoVisita) equipoVisita,
tabla.equipos_idEquipoVisita

from (

select jornadas.idJornada,
je.id,
jornadas.numeroJornada,
jornadas.activa,
je.equipos_idEquipoLocal,
je.golesLocal,
je.golesVisita,
je.equipos_idEquipoVisita
from jornadas
join jornadas_has_equipos je on je.jornadas_idJornada = jornadas.idJornada

where jornadas.division_idDivision = 1
and  jornadas.temporada_idTemporada = 5
) tabla
order by tabla.idJornada asc
;

-- consulta para jornadas FIN

select jornadas.idJornada,
je.equipos_idEquipoLocal,
je.golesLocal,
je.golesVisita,
je.equipos_idEquipoVisita

from jornadas
join jornadas_has_equipos je on je.jornadas_idJornada = jornadas.idJornada;

-- CONSULTA PARA TABLA GENERAL INICIO

select jhe.id,jhe.equipos_idEquipoLocal as idEquipo, equipos.nombreEquipo,jhe.golesLocal gf, jhe.golesVisita as ge
from jornadas_has_equipos jhe
join equipos on equipos.idEquipo = jhe.equipos_idEquipoLocal
where
jhe.golesLocal> jhe.golesVisita

order by equipos.idEquipo;


	SELECT
	tablaGeneral.id,
    tablaGeneral.division_idDivision,
    tablaGeneral.temporada_idTemporada,
	tablaGeneral.idEquipo, 
	tablaGeneral.nombreEquipo,
	tablaGeneral.pj,
	tablaGeneral.pg, 
	tablaGeneral.pe,
	tablaGeneral.pp,
	tablaGeneral.gf,
	tablaGeneral.ge,
	tablaGeneral.dif,
	tablaGeneral.pts

	from (

	SELECT
	tablaGeneral.id,
    tablaGeneral.division_idDivision,
    tablaGeneral.temporada_idTemporada,
	tablaGeneral.idEquipo, 
	tablaGeneral.nombreEquipo,
	sum(tablaGeneral.pj) as pj,
	sum(tablaGeneral.pg) as pg, 
	sum(tablaGeneral.pe) as pe,
	sum(tablaGeneral.pp) as pp,
	sum(tablaGeneral.gf) as gf,
	sum(tablaGeneral.ge) as ge,
	(sum(tablaGeneral.gf) - sum(tablaGeneral.ge)) as dif,
	((sum(tablaGeneral.pg) * 3) + sum(tablaGeneral.pe)) as pts
	from
	(


	(
	/* PARTIDOS GANADOS LOCAL  */
	select jhe.id,
    jornadas.division_idDivision,
    jornadas.temporada_idTemporada,
	jhe.equipos_idEquipoLocal as idEquipo, 
	equipos.nombreEquipo,
	0 as pj,
	count(jhe.equipos_idEquipoLocal) as pg, 
    0 as pp,
	0 as pe,
	sum(jhe.golesLocal) as gf,
	sum(jhe.golesVisita) as ge

	from jornadas_has_equipos jhe
	join equipos on equipos.idEquipo = jhe.equipos_idEquipoLocal
    join jornadas on jornadas.idJornada = jhe.jornadas_idJornada
	where jhe.golesLocal > jhe.golesVisita
	group by jhe.equipos_idEquipoLocal
	order by equipos.idEquipo
	)

	UNION


	(
	/* PARTIDOS GANADOS VISITA */
    
	select jhe.id,
    jornadas.division_idDivision,
    jornadas.temporada_idTemporada,
	jhe.equipos_idEquipoVisita as idEquipo, 
	equipos.nombreEquipo,
	0 as pj,
	count(jhe.equipos_idEquipoVisita) as pg,
    0 as pp,
	0 as pe,
	sum(jhe.golesVisita) as gf, 
	sum(jhe.golesLocal) as ge
	from jornadas_has_equipos jhe
    join jornadas on jornadas.idJornada = jhe.jornadas_idJornada
	join equipos on equipos.idEquipo = jhe.equipos_idEquipoVisita
	where
	jhe.golesVisita> jhe.golesLocal

	group by jhe.equipos_idEquipoLocal
	order by equipos.idEquipo
	)

	UNION
	-- PARTIDOS EMPATADOS
	(
	select jhe.id,
    jornadas.division_idDivision,
    jornadas.temporada_idTemporada,
	equipos.idEquipo as idEquipo,
	equipos.nombreEquipo,
	0 as pj,
	0 as pg,
    0 as pp,
	count(equipos.idEquipo) as pe,
	sum(jhe.golesLocal) as gf, 
	sum(jhe.golesVisita) as ge
	from jornadas_has_equipos jhe
    join jornadas on jornadas.idJornada = jhe.jornadas_idJornada,
	 equipos
	 
	 where (equipos.idEquipo = jhe.equipos_idEquipoVisita 
	 or equipos.idEquipo = jhe.equipos_idEquipoLocal)
	and
	jhe.golesVisita = jhe.golesLocal and jhe.golesLocal is not null

	group by equipos.idEquipo
	order by equipos.idEquipo
	)

	UNION

	(
	select jhe.id,
    jornadas.division_idDivision,
    jornadas.temporada_idTemporada,
	equipos.idEquipo as idEquipo, 
	equipos.nombreEquipo, 
	count(equipos.idEquipo) as pj,
	0 as pg,
    0 as pp,
	0 as pe,
	0 as gf,
	0 as ge
	from jornadas_has_equipos jhe
    join jornadas on jornadas.idJornada = jhe.jornadas_idJornada,
	equipos 
	where (jhe.equipos_idEquipoLocal = equipos.idEquipo
	or jhe.equipos_idEquipoVisita = equipos.idEquipo)
    and jornadas.activa = 1

	group by equipos.idEquipo
	order by equipos.idEquipo

	)
    
    UNION 
    (
    /* PARTIDOS PERDIDOS LOCAL  */
	select jhe.id,
    jornadas.division_idDivision,
    jornadas.temporada_idTemporada,
	jhe.equipos_idEquipoLocal as idEquipo, 
	equipos.nombreEquipo,
	0 as pj,
    0 as pg,
	count(jhe.equipos_idEquipoLocal) as pp, 
	0 as pe,
	0 as gf,
	sum(jhe.golesVisita) as ge

	from jornadas_has_equipos jhe
	join equipos on equipos.idEquipo = jhe.equipos_idEquipoLocal
    join jornadas on jornadas.idJornada = jhe.jornadas_idJornada
	where jhe.golesLocal < jhe.golesVisita
	group by jhe.equipos_idEquipoLocal
	order by equipos.idEquipo
	)
    
    UNION
    (
	/* PARTIDOS PERDIDOS VISITA */
    
	select jhe.id,
    jornadas.division_idDivision,
    jornadas.temporada_idTemporada,
	jhe.equipos_idEquipoVisita as idEquipo, 
	equipos.nombreEquipo,
	0 as pj,
    0 as pg,
	count(jhe.equipos_idEquipoVisita) as pp,
	0 as pe,
	0 gf, 
	sum(jhe.golesLocal) as ge
	from jornadas_has_equipos jhe
    join jornadas on jornadas.idJornada = jhe.jornadas_idJornada
	join equipos on equipos.idEquipo = jhe.equipos_idEquipoVisita
	where
	jhe.golesVisita < jhe.golesLocal

	group by jhe.equipos_idEquipoLocal
	order by equipos.idEquipo
    
    
    )
    
	)tablaGeneral

where tablaGeneral.division_idDivision = 1 
and   tablaGeneral.temporada_idTemporada = 5

group by tablaGeneral.idEquipo
) tablaGeneral
order by tablaGeneral.pts desc,
tablaGeneral.dif desc
;

select jhe.id,
equipos.idEquipo as idEquipo, 
equipos.nombreEquipo, 
count(equipos.idEquipo) as pj,
0 as pg,
0 as pp,
0 as pe,
0 as gf,
0 as ge
from jornadas_has_equipos jhe
join jornadas on jornadas.idJornada = jhe.jornadas_idJornada
,
equipos 
where (jhe.equipos_idEquipoLocal = equipos.idEquipo
or jhe.equipos_idEquipoVisita = equipos.idEquipo)

group by equipos.idEquipo
order by equipos.idEquipo;

-- CONSULTA PARA TABLA GENERAL FIN

/* PARTIDOS PERDIDOS LOCAL  */
	select jhe.id,
    jornadas.division_idDivision,
    jornadas.temporada_idTemporada,
	jhe.equipos_idEquipoLocal as idEquipo, 
	equipos.nombreEquipo,
	0 as pj,
    0 as pg,
	count(jhe.equipos_idEquipoLocal) as pp, 
	0 as pe,
	0 as gf,
	sum(jhe.golesVisita) as ge

	from jornadas_has_equipos jhe
	join equipos on equipos.idEquipo = jhe.equipos_idEquipoLocal
    join jornadas on jornadas.idJornada = jhe.jornadas_idJornada
	where jhe.golesLocal < jhe.golesVisita
	group by jhe.equipos_idEquipoLocal
	order by equipos.idEquipo
	;
	/* PARTIDOS PERDIDOS VISITA */
    
	select jhe.id,
    jornadas.division_idDivision,
    jornadas.temporada_idTemporada,
	jhe.equipos_idEquipoVisita as idEquipo, 
	equipos.nombreEquipo,
	0 as pj,
    0 as pg,
	count(jhe.equipos_idEquipoVisita) as pp,
	0 as pe,
	0 gf, 
	sum(jhe.golesLocal) as ge
	from jornadas_has_equipos jhe
    join jornadas on jornadas.idJornada = jhe.jornadas_idJornada
	join equipos on equipos.idEquipo = jhe.equipos_idEquipoVisita
	where
	jhe.golesVisita < jhe.golesLocal

	group by jhe.equipos_idEquipoLocal
	order by equipos.idEquipo
    
    ;


SELECT  
 equipos.idEquipo,  
 equipos.nombreEquipo,  
 equipos.descripcionEquipo,  
 equipos.activo ,  
 equipos.Division_idDivision, 
 division.nombre as nombreDivision, 
 division.descripcion as descripcionDivision 
 FROM fifaxgamersbd.equipos  
 join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision  
 join equipos_has_temporada eht on eht.Equipos_idEquipo = equipos.idEquipo
 where division.idDivision = 1 and eht.Temporadas_idTemporada= 5
 ;
 
select null, nombre,1 from division;

select * from division;

call crearTorneo('LM CHAMPIONS LEAGUE',5,2,@iserr,@ip);

select * from persona;

select * from torneo;

delete from torneo where torneo.idtorneo!=0;

select * from grupos_torneo where torneo_idtorneo = 34;

select equipos.idEquipo,  
(select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 and equipos_has_imagen.equipos_idEquipo = equipos.idEquipo) img,
equipos.nombreEquipo,  
equipos.descripcionEquipo,  
equipos.activo ,  
equipos.Division_idDivision, 
division.nombre as nombreDivision, 
division.descripcion as descripcionDivision 
FROM fifaxgamersbd.equipos  
join fifaxgamersbd.division on equipos.Division_idDivision = division.idDivision  
join equipos_has_temporada eht on eht.Equipos_idEquipo = equipos.idEquipo
join grupos_torneo on grupos_torneo.equipos_idEquipo = equipos.idEquipo
where grupos_torneo.torneo_idtorneo = 33
and eht.tempodada_idTemporada= 5
and equipos.idEquipo != 1;

select idTorneo, idEquipo,null
from torneo,division, equipos
where torneo.nombreTorneo = division.nombre 
and equipos.Division_idDivision = division.idDivision and equipos.idEquipo!=1
and torneo.tempodada_idTemporada = 5
;

select * from equipos;

select idtorneo,nombreTorneo, tipoTorneo_idtipoTorneo 
from torneo 
where tempodada_idTemporada = 5
;

select * from jornadas;
select * from jornadas_has_equipos;

delete from golesjornadas where golesjornadas.id!=0;
delete from imagenesjornadas where imagenesjornadas.id!=0;
delete from jornadas_has_equipos where id!=0;
delete from jornadas where idJornada!=00;


select tabla.idJornada, tabla.id, tabla.numeroJornada, 
  tabla.equipos_idEquipoLocal, 
  tabla.activa, 
  tabla.cerrada, 
  (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoLocal) equipoLocal, 
  (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 and equipos_has_imagen.equipos_idEquipo = tabla.equipos_idEquipoLocal) imgLocal, 
  tabla.golesLocal, 
  tabla.golesVisita, 
  
  (select equipos.nombreEquipo from equipos where equipos.idEquipo = tabla.equipos_idEquipoVisita) equipoVisita, 
  (select imagen from equipos_has_imagen where tipoImagen_idTipoImagen=2 and equipos_has_imagen.equipos_idEquipo = tabla.equipos_idEquipoVisita) imgVisita, 
  tabla.equipos_idEquipoVisita 
   
  from ( 
   
  select jornadas.idJornada, 
  je.id, jornadas.numeroJornada,
  jornadas.activa,
  jornadas.cerrada,
  je.equipos_idEquipoLocal, 
  je.golesLocal, 
  je.golesVisita, 
  je.equipos_idEquipoVisita 
  from jornadas 
  join jornadas_has_equipos je on je.jornadas_idJornada = jornadas.idJornada 
  join torneo on torneo.idtorneo = jornadas.torneo_idtorneo
  
  where tempodada_idTemporada = 5
  and  jornadas.torneo_idtorneo = 33
  
  ) tabla order by tabla.idJornada asc 
  
  
  
  ;
  
  
  select * from configuraciondraft;
  
  
  
  select * from persona;
  
  UPDATE `fifaxgamersbd`.`configuraciondraft`
SET
`monto` =10
WHERE `idconfiguracionDraft` = 5;


select * from draftpc;

select persona.NombreCompleto,
persona.sobrenombre,
persona.link,
persona.raiting,
DraftPC_idDraftPC ,
fechaOferta,
updateDate,
oferta,
ofertaFinal
usuarioOferta,
DraftPC_Persona_idPersona,
comentarios,
equipos.idEquipo,
equipos.nombreEquipo

from historicodraft
join persona on persona.idPersona = historicodraft.DraftPC_Persona_idPersona
join equipos on equipos.idEquipo = historicodraft.idEquipo
where historicodraft.DraftPC_idDraftPC = 1
and persona.idPersona = 733 
and historicodraft.tempodada_idTemporada = 5
;

select * from draftpc;

select * from temporada;

select * from equipos_has_temporada where tempodada_idTemporada = 14;
