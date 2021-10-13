


select * from torneo;


select * from cat_torneo;

INSERT INTO `fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Primera','Primera');

INSERT INTO `fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Segunda','Segunda');

INSERT INTO `fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Superliga','Superliga');

INSERT INTO `fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Champions','Champions');

INSERT INTO `fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Superliga','Superliga');

INSERT INTO `fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Euro','Euro');

INSERT INTO `fifaxgamersbd`.`cat_torneo`(`id`,`nombre`,`descripcion`)VALUES(null,'Juveniles','Juveniles');


select * from torneo;

select * from cat_salon_fama;

select max(idtorneo) from torneo;


SELECT torneo.idtorneo from torneo where torneo.idtorneo not in (select cat_salon_fama.idtorneo from cat_salon_fama);


call actualizaCampeonatos(@isErr,@cual);

select * from tipojornada;

select 
(case when tabla1.golesLocal > golesVisita then tabla1.equipos_idEquipoLocal else tabla1.equipos_idEquipoVisita end) as idEquipo,
tabla1.idtorneo

from (

select tabla.equipos_idEquipoLocal,
tabla.equipos_idEquipoVisita,
sum(golesLocal) as golesLocal,
sum(golesVisita) as golesVisita,
tabla.idtorneo
from (

select jornadas_has_equipos.equipos_idEquipoLocal ,
jornadas_has_equipos.equipos_idEquipoVisita, 
golesLocal,
golesVisita,
torneo.idtorneo
from jornadas_has_equipos
join jornadas on jornadas.idJornada = jornadas_has_equipos.jornadas_idJornada
join torneo on torneo.idtorneo = jornadas.torneo_idtorneo
where  jornadas.tipoJornada = 1
and jornadas.nombreJornada = 'Final'

UNION 

select 
jornadas_has_equipos.equipos_idEquipoVisita as equipos_idEquipoLocal, 
jornadas_has_equipos.equipos_idEquipoLocal as equipos_idEquipoVisita,
golesVisita as golesLocal,
golesLocal as golesVisita,
torneo.idtorneo

from jornadas_has_equipos
join jornadas on jornadas.idJornada = jornadas_has_equipos.jornadas_idJornada
join torneo on torneo.idtorneo = jornadas.torneo_idtorneo
where  jornadas.tipoJornada = 1
and jornadas.nombreJornada = 'Final Vuelta'
) tabla
group by tabla.equipos_idEquipoLocal, tabla.equipos_idEquipoVisita
) tabla1
;

select * from torneo;

select jornadas_has_equipos.equipos_idEquipoLocal ,
jornadas_has_equipos.equipos_idEquipoVisita, 
golesLocal,
golesVisita,
torneo.nombreTorneo,
torneo.tempodada_idTemporada,
jornadas.*
from jornadas_has_equipos
join jornadas on jornadas.idJornada = jornadas_has_equipos.jornadas_idJornada
join torneo on torneo.idtorneo = jornadas.torneo_idtorneo
where  jornadas.tipoJornada = 1
and (jornadas.nombreJornada = 'Final Vuelta' or  jornadas.nombreJornada = 'Final')
order by torneo_idtorneo
;

select * from torneo ; 


select equipos.idEquipo,
case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo else equipos_has_temporada.nombreEquipo end,
equipos_has_imagen.imagen,
torneo.tempodada_idTemporada,
usuarios.userName
from equipos_has_temporada
join torneo on torneo.tempodada_idTemporada = equipos_has_temporada.tempodada_idTemporada
join equipos on equipos.idEquipo = equipos_has_temporada.Equipos_idEquipo
join equipos_has_imagen on equipos_has_imagen.equipos_idEquipo = equipos.idEquipo and equipos_has_imagen.idTemporada = torneo.tempodada_idTemporada
join usuarios on usuarios.idequipo = equipos.idEquipo
where torneo.idtorneo = 98
and equipos.idEquipo = 15
and equipos_has_imagen.tipoImagen_idTipoImagen = 1
limit 1
;

select * from temporada;

-- delete from cat_salon_fama where cat_salon_fama.id >0;

call actualizaCampeonatos(@isErr,@cual);

select * from torneo;

SELECT count(torneo.idtorneo) from torneo where torneo.idtorneo not in (select cat_salon_fama.idtorneo from cat_salon_fama);

select * from cat_salon_fama where id > 0;

select * from cat_torneo;
select * from jornadas where jornadas.tipoJornada = 1;

SELECT cat_salon_fama.id,
    cat_salon_fama.username,
    cat_salon_fama.nombreEquipo,
    cat_salon_fama.img,
    cat_salon_fama.idtorneo,
    cat_salon_fama.idtemporada,
    cat_salon_fama.campeon,
    cat_salon_fama.idequipo,
    cat_salon_fama.idcat_torneo,
    cat_salon_fama.nombretorneo,
    cat_salon_fama.nombretemporada,
    cat_salon_fama.img_torneo,
 --   count(cat_salon_fama.idcat_torneo) totalxTorneo,    
    (select count(ca.username) from cat_salon_fama as ca where ca.username = cat_salon_fama.username ) total
FROM cat_salon_fama
-- group by cat_salon_fama.idcat_torneo, cat_salon_fama.username
order by  total desc;





select * from cat_torneo;


SELECT torneo.idtorneo from torneo where torneo.idtorneo not in (select cat_salon_fama.idtorneo from cat_salon_fama);
select * from temporada;


update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 58; 
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 59; 
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 61; 
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 62; 
update torneo set torneo.cat_torneo = 6 where torneo.idtorneo = 63; 
update torneo set torneo.cat_torneo = 5 where torneo.idtorneo = 64; 
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 65; 
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 66; 
update torneo set torneo.cat_torneo = 5 where torneo.idtorneo = 70; 
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 75; 
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 76; 
update torneo set torneo.cat_torneo = 5 where torneo.idtorneo = 80; 
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 81; 
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 82; 
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 83; 
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 84; 
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 85; 
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 86; 
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 87; 
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 88; 
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 89; 
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 90; 
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 91; 
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 92; 
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 94; 
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 95; 
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 96; 
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 97; 
update torneo set torneo.cat_torneo = 1 where torneo.idtorneo = 98; 
update torneo set torneo.cat_torneo = 2 where torneo.idtorneo = 99; 
update torneo set torneo.cat_torneo = 7 where torneo.idtorneo = 100; 
update torneo set torneo.cat_torneo = 4 where torneo.idtorneo = 101; 




select tabla.id,
                tabla.userName,
                tabla.nombreEquipo,
                tabla.imagen,
                tabla.idtorneo,
                tabla.tempodada_idTemporada,
                tabla.campeon,
                tabla.idEquipo,
                tabla.idCattorneo,
                tabla.nombre,
                tabla.NombreTemporada,
                tabla.img
                from ( 
                select null as id,
                usuarios.userName,                
				(case when equipos_has_temporada.nombreEquipo is null then equipos.nombreEquipo else equipos_has_temporada.nombreEquipo end ) as nombreEquipo,
				equipos_has_imagen.imagen,
                torneo.idtorneo,
				torneo.tempodada_idTemporada,
                1 as campeon,
				equipos.idEquipo ,
                cat_torneo.id as idCattorneo,
                cat_torneo.nombre,
                temporada.NombreTemporada,
                cat_torneo.img
				from equipos_has_temporada
				join torneo on torneo.tempodada_idTemporada = equipos_has_temporada.tempodada_idTemporada
                join temporada on temporada.idTemporada = torneo.tempodada_idTemporada
                join cat_torneo on torneo.cat_torneo = cat_torneo.id
				join equipos on equipos.idEquipo = equipos_has_temporada.Equipos_idEquipo
				join equipos_has_imagen on equipos_has_imagen.equipos_idEquipo = equipos.idEquipo and equipos_has_imagen.idTemporada = torneo.tempodada_idTemporada
				join usuarios on usuarios.idequipo = equipos.idEquipo
				where torneo.idtorneo = 100
				and equipos.idEquipo = 9
				and equipos_has_imagen.tipoImagen_idTipoImagen = 1
                limit 1) tabla


;
select * from torneo;

select 
		(case when tabla1.golesLocal > golesVisita then tabla1.equipos_idEquipoLocal else tabla1.equipos_idEquipoVisita end) 
        as idEquipo  ,
		tabla1.idtorneo
        

		from (

		select tabla.equipos_idEquipoLocal,
		tabla.equipos_idEquipoVisita,
		sum(golesLocal) as golesLocal,
		sum(golesVisita) as golesVisita,
		tabla.idtorneo
		from (

		select jornadas_has_equipos.equipos_idEquipoLocal ,
		jornadas_has_equipos.equipos_idEquipoVisita, 
		golesLocal,
		golesVisita,
		torneo.idtorneo
		from jornadas_has_equipos
		join jornadas on jornadas.idJornada = jornadas_has_equipos.jornadas_idJornada
		join torneo on torneo.idtorneo = jornadas.torneo_idtorneo
		where torneo.idtorneo = 105  and jornadas.tipoJornada > 0
		and jornadas.nombreJornada = 'Final'
        and torneo.cat_torneo != 2

		UNION 

		select 
		jornadas_has_equipos.equipos_idEquipoVisita as equipos_idEquipoLocal, 
		jornadas_has_equipos.equipos_idEquipoLocal as equipos_idEquipoVisita,
		golesVisita as golesLocal,
		golesLocal as golesVisita,
		torneo.idtorneo

		from jornadas_has_equipos
		join jornadas on jornadas.idJornada = jornadas_has_equipos.jornadas_idJornada
		join torneo on torneo.idtorneo = jornadas.torneo_idtorneo
		where torneo.idtorneo = 105 and jornadas.tipoJornada > 0
		and jornadas.nombreJornada = 'Final Vuelta'
        and torneo.cat_torneo != 2
		) tabla
		group by tabla.equipos_idEquipoLocal, tabla.equipos_idEquipoVisita
		) tabla1
		;
        
        
         
                select *
				from equipos_has_temporada
				join torneo on torneo.tempodada_idTemporada = equipos_has_temporada.tempodada_idTemporada
                join temporada on temporada.idTemporada = torneo.tempodada_idTemporada
                join cat_torneo on torneo.cat_torneo = cat_torneo.id
				join equipos on equipos.idEquipo = equipos_has_temporada.Equipos_idEquipo
				left join equipos_has_imagen on equipos_has_imagen.equipos_idEquipo = equipos.idEquipo and equipos_has_imagen.idTemporada = torneo.tempodada_idTemporada and equipos_has_imagen.tipoImagen_idTipoImagen = 1
				join usuarios on usuarios.idequipo = equipos.idEquipo
				where torneo.idtorneo = 58
				and equipos.idEquipo = 32
				-- and equipos_has_imagen.tipoImagen_idTipoImagen = 1
                limit 1;
                
       /*         INSERT INTO `fifaxgamersbd`.`equipos_has_imagen`
				(`equipos_idEquipo`,
				`tipoImagen_idTipoImagen`,
				`imagen`,
				`idTemporada`)
   select equipos_has_imagen.equipos_idEquipo,
                equipos_has_imagen.tipoImagen_idTipoImagen,
                equipos_has_imagen.imagen,
                5
                from equipos_has_imagen
                where equipos_has_imagen.idTemporada = 8  ;  */
                
                delete  from cat_torneo where cat_torneo.id > 7;
                
                select * from equipos_has_imagen;
                
                select * from temporada;
                
                
                
       select * from cat_torneo; 
       
       select * from torneo;         
                
                
            

select * from cat_salon_fama
where cat_salon_fama.campeon = 1;

INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-1,'xm1ke15','FC PORTO','https://i.postimg.cc/MTRyQnKk/Tott_18.png','-84','-84','1','12','1','Primera','84','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-2,'zaidor_co','VfB STUTTGART','https://i.postimg.cc/G9nnm007/VFB_2_36_2x.png','-84','-84','2','17','1','Primera','84','https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-silver-second-place-trophy-cup-isolated-on-transparent-background-3d-illustration-png-image_2840372.jpg');


update cat_salon_fama
set img_torneo = 'https://i.postimg.cc/jjRWJwTh/medalla.png'
where cat_salon_fama.id = -2;



INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-24,'castrolGTX','AMERICA DE CALI','-1','-73','-73','2','-1','1','Primera','73','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-25,'hazaelMx','SL BENFICA','https://i.postimg.cc/MZD70734/Bencica-2-234-2x.png','-72','-72','1','5','1','Primera','72','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-26,'zaidor_co','VFB STUTTGART','https://i.postimg.cc/G9nnm007/VFB_2_36_2x.png','-72','-72','2','17','1','Primera','72','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-27,'xm1ke15','FC PORTO','https://i.postimg.cc/MTRyQnKk/Tott_18.png','-71','-71','1','12','1','Primera','71','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-28,'hazaelMx','SL BENFICA','https://i.postimg.cc/MZD70734/Bencica-2-234-2x.png','-71','-71','2','5','1','Primera','71','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-29,'andrewmarce','FC BARCELONA','https://i.postimg.cc/QMTgcvvk/Barca-2-241-2x.png','-70','-70','1','16','1','Primera','70','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-30,'Polivioandres','LIVERPOOL FC','https://i.postimg.cc/PrCCLYg1/Liverpool-9-2x.png','-70','-70','2','8','1','Primera','70','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-31,'xm1ke15','FC PORTO','https://i.postimg.cc/MTRyQnKk/Tott_18.png','-69','-69','1','12','1','Primera','69','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-32,'sheva_Mx','AC MILAN','https://i.postimg.cc/pdHr17pB/Milan-47-2x.png','-69','-69','2','9','1','Primera','69','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-33,'Andrewmarce','FC BARCELONA','https://i.postimg.cc/QMTgcvvk/Barca-2-241-2x.png','-68','-68','1','16','1','Primera','68','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-34,'juanjose120389','WEST HAM UNITED','-1','-68','-68','2','-1','1','Primera','68','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-35,'xm1ke15','FC PORTO','https://i.postimg.cc/MTRyQnKk/Tott_18.png','-67','-67','1','12','1','Primera','67','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-36,'delpiero_mx','JUVENTUS FC','-1','-67','-67','2','-1','1','Primera','67','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-37,'andrewmarce','FC BARCELONA','https://i.postimg.cc/QMTgcvvk/Barca-2-241-2x.png','-66','-66','1','16','1','Primera','66','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-38,'zaidor_co','VFB STUTTGART','https://i.postimg.cc/G9nnm007/VFB_2_36_2x.png','-66','-66','2','17','1','Primera','66','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-39,'Polivioandres','LIVERPOOL FC','https://i.postimg.cc/PrCCLYg1/Liverpool-9-2x.png','-65','-65','1','8','1','Primera','65','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-40,'delpiero_mx','JUVENTUS FC','-1','-65','-65','2','-1','1','Primera','65','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-41,'castrolGTX','FC INTERNAZIONALE','https://i.postimg.cc/P50H9mrp/inter1-1.webp','-64','-64','1','28','1','Primera','64','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-42,'juanjose120389','WEST HAM UNITED','-1','-64','-64','2','-1','1','Primera','64','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-43,'Polivioandres','LIVERPOOL FC','https://i.postimg.cc/PrCCLYg1/Liverpool-9-2x.png','-63','-63','1','8','1','Primera','63','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-44,'sheva_Mx','AC MILAN','https://i.postimg.cc/pdHr17pB/Milan-47-2x.png','-63','-63','2','9','1','Primera','63','https://i.postimg.cc/jjRWJwTh/medalla.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-45,'zaidor_co','VFB STUTTGART','https://i.postimg.cc/G9nnm007/VFB_2_36_2x.png','-62','-62','1','17','1','Primera','62','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-46,'xm1ke15','FC PORTO','https://i.postimg.cc/MTRyQnKk/Tott_18.png','-62','-62','2','12','1','Primera','62','https://i.postimg.cc/jjRWJwTh/medalla.png');



;

select * from cat_salon_fama;


INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-184,'Andrewmarce','VELEZ SARFIELD','https://i.postimg.cc/7LcnfkPp/Velez.webp','-184','-184','1','-1','6','Euro','84','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');


INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-183,'Jorup','PSV EINDHOVEN','https://i.postimg.cc/Jnd1md4v/Psv-247-2x.png','-183','-183','1','13','6','Euro','83','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-182,'Vasidilak','REAL BETIS','https://i.postimg.cc/BnmgfFrZ/Betis.webp','-182','-182','1','-2','6','Euro','82','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-181,'fashionhn','FC INTERNAZIONALE','https://i.postimg.cc/P50H9mrp/inter1-1.webp','-181','-181','1','28','6','Euro','81','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-180,'oscarfrc93','VALENCIA CF','https://i.postimg.cc/KY0brsLj/Valencia_2_461_2x.png','-180','-180','1','14','6','Euro','80','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-179,'DoctorinhoCR','VILLARREAL CF','https://i.postimg.cc/jjLgHWsk/villarreal.png','-179','-179','1','27','6','Euro','79','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-178,'kaibamx','ATLÉTICO DE MADRID','https://i.postimg.cc/NjLkjK4n/Atletico-2-240-2x.png','-178','-178','1','19','6','Euro','78','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-177,'davis_hn','MANCHESTER CITY FC','https://i.postimg.cc/66j75Ym9/MCity-2-10-2x.png','-177','-177','1','25','6','Euro','77','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-176,'kaibamx','ATLÉTICO DE MADRID','https://i.postimg.cc/NjLkjK4n/Atletico-2-240-2x.png','-176','-176','1','19','6','Euro','76','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-175,'omarmx','BORUSSIA DORTMUND','https://i.postimg.cc/MK31NWSm/BVB-2-22-2x.png','-175','-175','1','24','6','Euro','75','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-174,'fashionhn','AS ROMA','https://i.postimg.cc/CKd4h10G/Roma.webp','-174','-174','1','-3','6','Euro','74','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-173,'romarke','CHELSEA FC','https://i.postimg.cc/1tKqHSB6/Chelsea-2-5-2x.png','-173','-173','1','3','6','Euro','73','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-172,'Polivioandres','LIVERPOOL FC','https://i.postimg.cc/PrCCLYg1/Liverpool-9-2x.png','-172','-172','1','8','6','Euro','72','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-171,'sepultura','FC INTERNAZIONALE','https://i.postimg.cc/P50H9mrp/inter1-1.webp','-171','-171','1','28','6','Euro','71','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-170,'camizidane','AS MONACO','https://i.postimg.cc/k5vGrcSP/Monaco-2-69-2x.png','-170','-170','1','22','6','Euro','70','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-169,'luigir_hn','VALENCIA CF','https://i.postimg.cc/KY0brsLj/Valencia_2_461_2x.png','-169','-169','1','14','6','Euro','69','https://i.postimg.cc/fyc4ryzw/Europa-Leage.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-168,'xm1ke15','FC PORTO','https://i.postimg.cc/MTRyQnKk/Tott_18.png','-168','-168','1','12','7','Juveniles','68','https://i.postimg.cc/VNv8kzRR/Superliga.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-167,'Polivioandres','LIVERPOOL FC','https://i.postimg.cc/PrCCLYg1/Liverpool-9-2x.png','-167','-167','1','8','7','Juveniles','67','https://i.postimg.cc/VNv8kzRR/Superliga.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-166,'juanjose120389','WEST HAM UNITED','https://i.postimg.cc/JzrqFxdd/WestHamU.webp','-166','-166','1','-4','7','Juveniles','66','https://i.postimg.cc/VNv8kzRR/Superliga.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-165,'castrolGTX','FC INTERNAZIONALE','https://i.postimg.cc/P50H9mrp/inter1-1.webp','-165','-165','1','28','7','Juveniles','65','https://i.postimg.cc/VNv8kzRR/Superliga.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-164,'Polivioandres','LIVERPOOL FC','https://i.postimg.cc/PrCCLYg1/Liverpool-9-2x.png','-164','-164','1','8','7','Juveniles','64','https://i.postimg.cc/VNv8kzRR/Superliga.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-163,'Polivioandres','LIVERPOOL FC','https://i.postimg.cc/PrCCLYg1/Liverpool-9-2x.png','-163','-163','1','8','7','Juveniles','63','https://i.postimg.cc/VNv8kzRR/Superliga.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-162,'dreck15','CHELSEA FC','https://i.postimg.cc/1tKqHSB6/Chelsea-2-5-2x.png','-162','-162','1','3','7','Juveniles','62','https://i.postimg.cc/VNv8kzRR/Superliga.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-161,'EmmanueL19800','VELEZ SARFIELD','https://i.postimg.cc/7LcnfkPp/Velez.webp','-161','-161','1','-1','7','Juveniles','61','https://i.postimg.cc/VNv8kzRR/Superliga.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES (-160,'Frederick','SS LAZIO','https://i.postimg.cc/TYq0QFQD/Lazio.webp','-160','-160','1','-5','7','Juveniles','60','https://i.postimg.cc/VNv8kzRR/Superliga.png');










INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-285,'delpiero_mx','JUVENTUS FC','https://i.postimg.cc/m2nFV8Yd/Juve-2-45-2x.png','-285','-285','1','-2','1','primera','21','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-286,'sheva_Mx','AC MILAN','https://i.postimg.cc/pdHr17pB/Milan-47-2x.png','-286','-286','1','9','1','primera','20','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-287,'sheva_Mx','AC MILAN','https://i.postimg.cc/pdHr17pB/Milan-47-2x.png','-287','-287','1','9','1','primera','19','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-288,'FxP|Franco','FC BAYERN MÜNCHEN','https://i.postimg.cc/xT1K6XWd/Bayer-Mu-21-2x.png','-288','-288','1','15','1','primera','18','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-289,'FxP|Franco','FC BAYERN MÜNCHEN','https://i.postimg.cc/xT1K6XWd/Bayer-Mu-21-2x.png','-289','-289','1','15','1','primera','17','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-290,'sheva_Mx','AC MILAN','https://i.postimg.cc/pdHr17pB/Milan-47-2x.png','-290','-290','1','9','1','primera','16','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-291,'sheva_Mx','AC MILAN','https://i.postimg.cc/pdHr17pB/Milan-47-2x.png','-291','-291','1','9','1','primera','15','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-292,'Aarón','VALENCIA CF','https://i.postimg.cc/KY0brsLj/Valencia_2_461_2x.png','-292','-292','1','14','1','primera','14','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-293,'Xx-Héctor-xX','FC BARCELONA','https://i.postimg.cc/QMTgcvvk/Barca-2-241-2x.png','-293','-293','1','16','1','primera','13','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-294,'Xx-Héctor-xX','FC BARCELONA','https://i.postimg.cc/QMTgcvvk/Barca-2-241-2x.png','-294','-294','1','16','1','primera','12','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-295,'Bothk','AC MILAN','https://i.postimg.cc/pdHr17pB/Milan-47-2x.png','-295','-295','1','9','1','primera','11','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-296,'Xx-Héctor-xX','FC BARCELONA','https://i.postimg.cc/QMTgcvvk/Barca-2-241-2x.png','-296','-296','1','16','1','primera','10','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-297,'FxP|Daniel','MANCHESTER CITY FC','https://i.postimg.cc/qvngw0MR/MCity-10-2x.png','-297','-297','1','25','1','primera','9','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-298,'delpiero_mx','JUVENTUS FC','https://i.postimg.cc/m2nFV8Yd/Juve-2-45-2x.png','-298','-298','1','-2','1','primera','8','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-299,'Cavegol','CA RIVER PLATE','https://i.postimg.cc/vTD7058t/RIVER-PLATE.webp','-299','-299','1','-43','1','primera','7','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-300,'HazardMx-','REAL MADRID CF','https://i.postimg.cc/Ghss6jbG/Real-Madrid2.webp','-300','-300','1','2','1','primera','6','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-301,'Aarón','FC BARCELONA','https://i.postimg.cc/QMTgcvvk/Barca-2-241-2x.png','-301','-301','1','16','1','primera','5','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-302,'Chuchito','CA RIVER PLATE','https://i.postimg.cc/vTD7058t/RIVER-PLATE.webp','-302','-302','1','-43','1','primera','4','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-303,'Aarón','REAL MADRID CF','https://i.postimg.cc/Ghss6jbG/Real-Madrid2.webp','-303','-303','1','2','1','primera','3','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-304,'Lethax','ARSENAL FC','https://i.postimg.cc/J4pQ8NbJ/Arsenal-1-2x.png','-304','-304','1','34','1','primera','2','https://i.postimg.cc/NFc5P2gj/Primera.png');
INSERT INTO `fifaxgam_fifaxgamersbd`.`cat_salon_fama`(`id`,`username`,`nombreEquipo`,`img`,`idtorneo`,`idtemporada`,`campeon`,`idequipo`,`idcat_torneo`,`nombretorneo`,`nombretemporada`,`img_torneo`)
VALUES(-305,'Gárgola','MANCHESTER UNITED FC','https://i.postimg.cc/rs3FGZBx/MUnited-11-2x.png','-305','-305','1','26','1','primera','1','https://i.postimg.cc/NFc5P2gj/Primera.png');
