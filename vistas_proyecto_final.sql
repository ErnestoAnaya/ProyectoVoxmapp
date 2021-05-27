
-- VISTAS --

--
-- Vista 1:  Encuestas problemáticas de la semana.   regresa, fecha del update, info del hospital, contecto del update y el problema .
-- 

create view encuestas_problematicas_x_dia as (
	select u.update_date "Day", u.moph_number "MOPH Number", h.hospital_name "Hospital Name",
	p.number_ "Contact Number", concat(p.first_name,' ',p.last_name) "Contact Name", c.problem "Problem"
	from update_ u 
	join control_ c using (update_id)
	join hospital h using (moph_number)
	join personal p using (moph_number)
	where c.update_status like '%problem%'
	and u.update_date <= current_date and u.update_date > (current_date - '1 day'::interval)
	order by h.district, concat(p.first_name,' ',p.last_name)
);

--
-- 	Vista 2: Reporte de monitoreo por semana: número de encuestas(updates) que se realizaron la última semana
--

create view encuestas_x_dia as (
	select concat((current_date - '1 week'::interval),' / ',current_date) "Días", 
	count(*) "Número de encuestas recibidas" 
	from update_ u 
	where u.update_date <= current_date and u.update_date > (current_date - '1 day'::interval)
);

--
-- Vista 3: da cuantas encuestas realizadas la última semana agrupadas por status.
--

create view status_x_dia as( 
	select c.update_status "Update Status", count(*) "Número de encuestas"
	from update_ u join control_ c using (update_id)
	where u.update_date <= current_date and u.update_date > (current_date - '1 day'::interval)
	group by c.update_status
);


--
--  Vista 4: Reporte de encuestas por semana: número de encuestas por hospital
--
create view encuestas_x_hospital_dia as(
	select h.hospital_name "Hospital", count(*) "Número de encuestas"
	from update_ u join control_ c using (update_id)
	join hospital h using (moph_number)
	where u.update_date <= current_date and u.update_date > (current_date - '1 day'::interval)
	group by h.moph_number
);

--
-- Vista 5: Reporte de problemas por semana
--

create view problemas_x_dia as(
	select c.problem "Problema", count(*) "Número de encuestas"
	from update_ u join control_ c using (update_id)
	where u.update_date <= current_date and u.update_date > (current_date - '1 day'::interval)
	group by c.problem
);

--
-- Vista 6: desempeño de covid por hospital.    da nombre de hospital, casos por personal y el porcentaje que se ha recuperado 
--
create view desempenio_covid_x_hodpital as (
	select h.moph_number, h.hospital_name, round(sum(cc.positive_tests_last_month)/(h.num_doctors+h.num_staff),2) casos_x_personal, round(sum(cc.recovered_patients)/sum(cc.positive_tests_last_month),4)*100 porcentage_recuperado
	from personal p join update_ u on (p.personal_id = u.personal_id) join casos_covid cc on(cc.update_id = u.update_id) join hospital h on (h.moph_number = u.moph_number) join control_ c on(u.update_id=c.update_id)
	group by h.moph_number, h.hospital_name, (h.num_doctors+h.num_staff), c.update_status having c.update_status = 'questionaire completed'
	);
	
--
-- Vista 7: Promedio reservas por region
--

create view proporciones_reservas_x_distrito as(
	with totales_reservas_x_distrito as (
	
	with conv_to_num as (
	select 
    case r.oxygen_reserves 
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as oxygen_reserves_num,
    case r.antipyretics_reserves 
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as antipyretics_reserves_num,
    case r.anesthetics_and_muscular_relaxants
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as anesthetics_and_muscular_relaxants_num,
    case r.alcohol_reserves_and_handsoap
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as alcohol_reserves_and_handsoap_num,
    case r.personal_disposable_masks
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_disposable_masks_num,
    case r.personal_vinyl_gloves
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_vinyl_gloves_num,
    case r.personal_disposable_hats
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_disposable_hats_num,
    case r.personal_disposable_aprons
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_disposable_aprons_num,
    case r.personal_visors
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_visors_num,
    case r.personal_disposable_shoe_covers
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_disposable_shoe_covers_num,
    case r.test_kits
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as test_kits_num,
    r.reservas_id,
    r.update_id
	from reservas r join update_ u on(r.reservas_id=u.update_id) join control_ c on(c.update_id=u.update_id)
	where c.update_status = 'questionaire completed'
	)
	select h.district, 
	sum(cn.oxygen_reserves_num + cn.antipyretics_reserves_num + cn.anesthetics_and_muscular_relaxants_num + cn.alcohol_reserves_and_handsoap_num + cn.personal_disposable_masks_num +
	    cn.personal_vinyl_gloves_num + cn.personal_disposable_hats_num + cn.personal_disposable_aprons_num +cn.personal_visors_num + cn.personal_disposable_shoe_covers_num + cn.test_kits_num) as total_reservas,
	sum(cn.oxygen_reserves_num) as total_oxygen,
	sum(cn.antipyretics_reserves_num) as total_antipyretics,
	sum(cn.anesthetics_and_muscular_relaxants_num) as total_anesthetics_and_musc_relaxants,
	sum(cn.alcohol_reserves_and_handsoap_num) as total_alcohol_and_handsoap,
	sum(cn.personal_disposable_masks_num) as total_masks,
	sum(cn.personal_vinyl_gloves_num) as total_vinyl_gloves,
	sum(cn.personal_disposable_hats_num) as total_hats,
	sum(cn.personal_disposable_aprons_num) as total_aprons,
	sum(cn.personal_visors_num) as total_visors,
	sum(cn.personal_disposable_shoe_covers_num) as total_shoe_covers,
	sum(cn.test_kits_num) as total_test_kits
	from conv_to_num cn join update_ u on(cn.update_id=u.update_id) join hospital h on(u.moph_number=h.moph_number)
	group by h.district
	)
	select trd.district, 
	round(trd.total_oxygen::decimal/trd.total_reservas,2) as proporcion_oxigeno, 
	round(trd.total_antipyretics::decimal/trd.total_reservas,2) as proporcion_antipireticos,
	round(trd.total_anesthetics_and_musc_relaxants::decimal/trd.total_reservas,2) as proporcion_anesthetics_y_relajantes_musculares, 
	round(trd.total_alcohol_and_handsoap::decimal/trd.total_reservas,2) as proporcion_alcohol_y_jabon, 
	round(trd.total_masks::decimal/trd.total_reservas,2) as proporcion_mascaras, 
	round(trd.total_vinyl_gloves::decimal/trd.total_reservas,2) as proporcion_guantes, 
	round(trd.total_hats::decimal/trd.total_reservas,2) as proporcion_sombreros,
	round(trd.total_aprons::decimal/trd.total_reservas,2) as proporcion_delantales,
	round(trd.total_visors::decimal/trd.total_reservas,2) as proporcion_visores,
	round(trd.total_shoe_covers::decimal/total_reservas,2) as proporcion_cubrecalzados,
	round(trd.total_test_kits::decimal/total_reservas,2) as proporcion_test_kits
	from totales_reservas_x_distrito trd
);

--
--Vista 8: Rendimiento de ayuda
--

create view rendimiento_de_ayuda as(
	with casos_x_hospital as(
	select 
	h.moph_number, h.hospital_name, sum(cc.positive_tests_last_month) casos_x_hospital, 
	round(sum(cc.recovered_patients)/sum(cc.positive_tests_last_month),4)*100 porcentaje_recuperado, 
	round(sum(cc.deaths_last_month)/sum(cc.positive_tests_last_month),4)*100 as porcentaje_fallecido
	from personal p join update_ u on (p.personal_id = u.personal_id) join casos_covid cc on(cc.update_id = u.update_id) join hospital h on (h.moph_number = u.moph_number) join control_ c on(u.update_id = c.update_id)
	group by h.moph_number, h.hospital_name, c.update_status having(c.update_status = 'questionaire completed')
	)
	select 
	i.resources_received_last_month, 
	sum(ch.casos_x_hospital) as casos_totales, 
	round(avg(ch.porcentaje_recuperado),2) as porcentaje_recuperado, 
	round(avg(ch.porcentaje_fallecido),2) as porcentaje_fallecido 
	from casos_x_hospital ch join update_ u on (ch.moph_number = u.moph_number) join infraestructura i on(i.update_id = u.update_id)
	group by i.resources_received_last_month
);

--
-- Vista 9: apoyo por zona, apoyo que han recibido las zonas durante toda la pandemia
--

create view apoyo_x_zona as (
	with dist_no_recursos as(
	select 
	h.district, count(i.resources_received_last_month) as total_hosp
	from hospital h join update_ u on(u.moph_number = h.moph_number) join infraestructura i on(i.update_id=u.update_id) join control_ c on(u.update_id=c.update_id)
	where i.resources_received_last_month = 'None' and c.update_status = 'questionaire completed'
	group by h.district order by h.district
), dist_recursos_gov as(
	select 
	h.district, count(i.resources_received_last_month) as total_hosp
	from hospital h join update_ u on(u.moph_number = h.moph_number) join infraestructura i on(i.update_id=u.update_id) join control_ c on(u.update_id=c.update_id)
	where i.resources_received_last_month = 'Yes, government' and c.update_status = 'questionaire completed'
	group by h.district order by h.district
), dist_recursos_no_gov as (
	select 
	h.district, count(i.resources_received_last_month) as total_hosp
	from hospital h join update_ u on(u.moph_number = h.moph_number) join infraestructura i on(i.update_id=u.update_id) join control_ c on(u.update_id=c.update_id)
	where i.resources_received_last_month = 'Yes, Non-governmental' and c.update_status = 'questionaire completed'
	group by h.district order by h.district
), dist_ambos as(
	select 
	h.district, count(i.resources_received_last_month) as total_hosp
	from hospital h join update_ u on(u.moph_number = h.moph_number) join infraestructura i on(i.update_id=u.update_id) join control_ c on(u.update_id=c.update_id)
	where i.resources_received_last_month = 'Yes, Both' and c.update_status = 'questionaire completed'
	group by h.district order by h.district
), dist_no_se_sabe as(
	select 
	h.district, count(i.resources_received_last_month) as total_hosp 
	from hospital h join update_ u on(u.moph_number = h.moph_number) join infraestructura i on(i.update_id=u.update_id) join control_ c on(u.update_id=c.update_id)
	where i.resources_received_last_month = 'Dont know' and c.update_status = 'questionaire completed'
	group by h.district order by h.district
)
select dnr.district, 
dnr.total_hosp as total_sin_ayuda, drg.total_hosp as total_ayuda_gobierno, dng.total_hosp as total_ayuda_no_gubernamental, da.total_hosp as total_ayuda_ambos, dns.total_hosp as total_no_se_sabe
from dist_no_recursos dnr 
join dist_recursos_gov drg on(dnr.district=drg.district) 
join dist_recursos_no_gov dng on(drg.district = dng.district)
join dist_ambos da on (dng.district=da.district)
join dist_no_se_sabe dns on (da.district = dns.district)
);

---
--- Vista 10: en promedio reservas del país durante toda la pandemia
---

create view promedio_reservas_pais as(
	with conv_to_num as (
	select 
    case r.oxygen_reserves 
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as oxygen_reserves_num,
    case r.antipyretics_reserves 
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as antipyretics_reserves_num,
    case r.anesthetics_and_muscular_relaxants
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as anesthetics_and_muscular_relaxants_num,
    case r.alcohol_reserves_and_handsoap
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as alcohol_reserves_and_handsoap_num,
    case r.personal_disposable_masks
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_disposable_masks_num,
    case r.personal_vinyl_gloves
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_vinyl_gloves_num,
    case r.personal_disposable_hats
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_disposable_hats_num,
    case r.personal_disposable_aprons
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_disposable_aprons_num,
    case r.personal_visors
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_visors_num,
    case r.personal_disposable_shoe_covers
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as personal_disposable_shoe_covers_num,
    case r.test_kits
      when 'Yes, for 30 days' then 30
      when 'Yes, for 15 days' then 15
      when 'Yes, for 7 days' then 7
      when 'Yes, for 3 days' then 3
      when 'No' then 0
    end as test_kits_num,
    r.reservas_id,
    r.update_id
	from reservas r
	)
select round(avg(cn.oxygen_reserves_num),2) as prom_oxigeno, round(avg(antipyretics_reserves_num),2) as prom_antipiréticos , round(avg(anesthetics_and_muscular_relaxants_num),2) as prom_anesteticos_y_relajantes, 
round(avg(alcohol_reserves_and_handsoap_num),2) as prom_alocohol_y_jabon, round(avg(personal_disposable_masks_num),2) as prom_mascaras_desechables, round(avg(personal_vinyl_gloves_num),2) as prom_guantes, 
round(avg(personal_disposable_hats_num),2) as prom_sombreros_desechables, round(avg(personal_disposable_aprons_num),2) as prom_delantales, round(avg(personal_visors_num),2) prom_visores, 
round(avg(personal_disposable_shoe_covers_num),2) as prom_cubrecalzado, round(avg(test_kits_num),2) as prom_test_kits
from conv_to_num cn join update_ u on(cn.update_id=u.update_id) join hospital h on(u.moph_number=h.moph_number) join control_ c on(u.update_id=c.update_id)
where c.update_status = 'questionaire completed'
);

--
-- Vista 11: asignación de recursos (ve como cambia el apoyo e infraestructura de cada hospital). Saca el udpate mas reciente de cada hospital
-- 

create view cambio_de_ayuda_x_hospital as (
	with hospital_c_infraestructura_previa as(
		select h.moph_number, h.hospital_name, u.update_date, 
		lag(u.update_date,1) over(partition by h.moph_number order by u.update_date),
		i.test_result_speed, lag(i.test_result_speed,1) over(partition by h.moph_number order by u.update_date), 
		i.test_result_speed - lag(i.test_result_speed,1) over(partition by h.moph_number order by u.update_date) dif_test_result_speed,
		i.awareness_campaigns, lag(i.awareness_campaigns,1) over(partition by h.moph_number order by u.update_date) prev_awareness_campaigns,
		i.resources_received_last_month, lag(i.resources_received_last_month,1) over(partition by h.moph_number order by u.update_date) prev_resources_received,
		i.screening_implemeted, lag(i.screening_implemeted) over(partition by h.moph_number order by u.update_date) prev_screening_implemented, 
		i.test_covid_capabilities, lag(i.test_covid_capabilities) over(partition by h.moph_number order by u.update_date) prev_test_capabilities
		from hospital h join update_ u on(h.moph_number=u.moph_number) join infraestructura i on(i.update_id=u.update_id) join control_ c on(c.update_id=u.update_id)
		where c.update_status = 'questionaire completed'
	)
	--hay casos donde salen dos registros del mismo hospital (debería de ser uno). Problema podría salir si se hacen 2 encuestas al mismo hospital el mismo día
	select hip.moph_number, hip.hospital_name, hip.update_date,
	hip.dif_test_result_speed, 
	hip.awareness_campaigns, prev_awareness_campaigns, 
	hip.resources_received_last_month, prev_resources_received, 
	hip.screening_implemeted, prev_screening_implemented, 
	hip.test_covid_capabilities, prev_test_capabilities
	from hospital_c_infraestructura_previa hip 
	inner join (select h.moph_number, max(u2.update_date) update_d 
				from update_ u2 join hospital h on(u2.moph_number=h.moph_number) join control_ c on (c.update_id = u2.update_id) 
				where c.update_status = 'questionaire completed'
				group by h.moph_number) as max_dates using(moph_number)
	where max_dates.update_d = hip.update_date
);

--
-- Vista 12: necesidades de cada facilidad
--

create view necesidades_hospital as(
	with reservas_num as (
		select
		    case r.oxygen_reserves 
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as oxygen_reserves_num,
		    case r.antipyretics_reserves 
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as antipyretics_reserves_num,
		    case r.anesthetics_and_muscular_relaxants
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as anesthetics_and_muscular_relaxants_num,
		    case r.alcohol_reserves_and_handsoap
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as alcohol_reserves_and_handsoap_num,
		    case r.personal_disposable_masks
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as personal_disposable_masks_num,
		    case r.personal_vinyl_gloves
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as personal_vinyl_gloves_num,
		    case r.personal_disposable_hats
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as personal_disposable_hats_num,
		    case r.personal_disposable_aprons
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as personal_disposable_aprons_num,
		    case r.personal_visors
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as personal_visors_num,
		    case r.personal_disposable_shoe_covers
		      when 'Yes, for 30 days' then 30
		      when 'Yes, for 15 days' then 15
		      when 'Yes, for 7 days' then 7
		      when 'Yes, for 3 days' then 3
		      when 'No' then 0
		    end as personal_disposable_shoe_covers_num,
		    r.num_test_kits,
		    r.respiratory_ventilator_machines,
		    r.reservas_id,
		    r.update_id
			from reservas r join update_ u on(r.reservas_id=u.update_id) join control_ c on(c.update_id=u.update_id)
			where c.update_status like '%completed%' 
	), health_levels as (
		select u.moph_number as hos_id, avg(reservas_num.oxygen_reserves_num) as avg_oxygen, avg(reservas_num.antipyretics_reserves_num) as avg_antipyretics, avg(reservas_num.anesthetics_and_muscular_relaxants_num) as avg_anesthetics, avg(reservas_num.alcohol_reserves_and_handsoap_num) as avg_alcohol, avg(reservas_num.personal_disposable_masks_num) as avg_masks, avg(reservas_num.personal_disposable_aprons_num) as avg_aprons, avg(reservas_num.personal_vinyl_gloves_num) as avg_gloves, avg(reservas_num.personal_disposable_hats_num) as avg_hats, avg(reservas_num.personal_visors_num) as avg_visors, avg(reservas_num.personal_disposable_shoe_covers_num) as avg_shoe_covers, avg(reservas_num.num_test_kits) as avg_test, avg(reservas_num.respiratory_ventilator_machines) as avg_venti
		from update_ u join reservas_num  using (update_id) join control_ c using (update_id)
		where c.update_status like '%completed%' and c.problem like '%none%' and u.update_date <= current_date and u.update_date > (current_date - '1 month'::interval)
		group by u.moph_number
		order by u.moph_number
	)
	select h.moph_number, h.hospital_name, h.district, h.province, health_levels.avg_oxygen, health_levels.avg_antipyretics, health_levels.avg_anesthetics, health_levels.avg_alcohol, health_levels.avg_masks, health_levels.avg_aprons, health_levels.avg_gloves, health_levels.avg_hats, health_levels.avg_visors,health_levels.avg_shoe_covers, health_levels.avg_test,  health_levels.avg_venti
	from hospital h join health_levels  on (health_levels.hos_id = h.moph_number)
	order by h.moph_number
);

--
-- Vista 13: porcentajes de scgreening y awareness a nivel distrito
--

create view porc_screening_y_awareness_dist as(
	select h.district, round((count(case when i.screening_implemeted = 'true' then 1 end)/cast (count(i.screening_implemeted) as decimal) * 100), 2) || '%' as porcTrueScreen, round((count(case when i.screening_implemeted = 'false' then 1 end)/cast (count(i.screening_implemeted)  as decimal)* 100), 2) || '%' as porcFalseScreen, round((count(case when i.awareness_campaigns = 'true' then 1 end)/cast(count(i.awareness_campaigns) as decimal) * 100), 2)  || '%' as porcTrueAwer,round((count(case when i.awareness_campaigns = 'false' then 1 end)/cast(count(i.awareness_campaigns) as decimal)* 100), 2) || '%' as porcFalseAwer
	from update_ u join infraestructura i  using (update_id) join control_ c using (update_id) join hospital h using (moph_number) 
	where c.update_status like '%completed%' and c.problem like '%none%' and u.update_date <= current_date and u.update_date > (current_date - '1 month'::interval)
	group by h.district 
	order by h.district 
);


--
-- Vista 14: staff registrado por cada hospital según el último wave
--

create view staff_x_hospital as(
	with doctores_staff_hospital as (
		select h.moph_number, sum(h.num_doctors) as sumDoctores, sum(h.num_staff) as sumStaff 
		from update_ u join hospital h using (moph_number) join control_ c using (update_id)
		where c.update_status like '%completed%' and c.problem like '%none%' and u.update_date <= current_date and u.update_date > (current_date - '1 month'::interval)
		group by h.moph_number 
		order by h.moph_number
	)
	select h.moph_number, h.hospital_name, h.district, h.province, doctores_staff_hospital.sumDoctores, doctores_staff_hospital.sumStaff
	from hospital h join doctores_staff_hospital  on (doctores_staff_hospital.moph_number = h.moph_number)
	order by h.moph_number
);

--
-- Vista 14.1 Staff a nivel distrito de acuerdo con el último wave
--

create view staff_x_distrito as(
	select h.district, sum(h.num_doctors) as sumDoctores, sum(h.num_staff) as sumStaff 
	from update_ u join hospital h using (moph_number) join control_ c using (update_id)
	where c.update_status like '%completed%' and c.problem like '%none%' and u.update_date <= current_date and u.update_date > (current_date - '1 month'::interval)
	group by h.district 
	order by h.district
);


--
-- Vista 15: capacidad de probar covid

create view capcidad_hospital_pruebas_covid as(
	with reservas_num as (
	select
	    case r.test_kits 
	      when 'Yes, for 30 days' then 30
	      when 'Yes, for 15 days' then 15
	      when 'Yes, for 7 days' then 7
	      when 'Yes, for 3 days' then 3
	      when 'No' then 0
	    end as days_test_kits,
	    r.num_test_kits,
	    r.reservas_id,
	    r.update_id
		from reservas r join update_ u on(r.reservas_id=u.update_id) join control_ c on(c.update_id=u.update_id)
		where c.update_status like '%completed%' 
	),
	covid_test_capacity as (
		select u.moph_number as hos_id, sum(reservas_num.days_test_kits) as sum_days_test_kits, sum(reservas_num.num_test_kits) as sum_num_test_kits
		from update_ u join reservas_num  using (update_id) join control_ c using (update_id) 
		where c.update_status like '%completed%' and c.problem like '%none%' and u.update_date <= current_date and u.update_date > (current_date - '1 month'::interval)
		group by u.moph_number
		order by u.moph_number
	)
	select h.moph_number, h.hospital_name, h.district, h.province, covid_test_capacity.sum_days_test_kits ,covid_test_capacity.sum_num_test_kits
	from hospital h join covid_test_capacity  on (covid_test_capacity.hos_id = h.moph_number)
	order by h.moph_number
);

--
-- Vista 15.1: capacidad de probar covid porcentaje
--

create view capcidad_hospital_pruebas_covid_porc as(
	select h.district, round((count(case when i.test_covid_capabilities = 'true' then 1 end)/cast (count(i.test_covid_capabilities) as decimal) * 100), 2) || '%' as porcTrueTestCapability, round((count(case when i.test_covid_capabilities = 'false' then 1 end)/cast (count(i.test_covid_capabilities)  as decimal)* 100), 2) || '%' as porcFalseTestCapability
	from update_ u join infraestructura i  using (update_id) join control_ c using (update_id) join hospital h using (moph_number) 
	where c.update_status like '%completed%' and c.problem like '%none%' and u.update_date <= current_date and u.update_date > (current_date - '1 month'::interval)
	group by h.district 
	order by h.district 
);


--
-- Vista 17: tendencias de casos confirmados a nivel distrito, viene desglosado por mes
--

create view covid_tendencias_mes_anio_x_dist as (
	select h.district, extract(year from u.update_date) as perYear, extract(month from u.update_date) as perMonth, sum(cc.casos_covid_id) as num_casos, sum(cc.recovered_patients) as num_recuperados, sum(cc.deaths_last_month) as num_muertos
	from update_ u join casos_covid cc  using (update_id) join control_ c using (update_id) join hospital h using (moph_number)
	where c.update_status like '%completed%' and c.problem like '%none%' 
	group by h.district, perYear, perMonth
	order by h.district, perYear, perMonth
);


--
-- Vista 18: rankings covid por distrito por mes. 
--

create view covid_rankings_x_distrito_x_mes as (
	select h.district, extract(year from u.update_date) as perYear, extract(month from u.update_date) as perMonth, sum(cc.casos_covid_id) as num_casos, sum(cc.recovered_patients) as num_recuperados, sum(cc.deaths_last_month) as num_muertos
	from update_ u join casos_covid cc  using (update_id) join control_ c using (update_id) join hospital h using (moph_number)
	where c.update_status like '%completed%' and c.problem like '%none%' 
	group by h.district, perYear, perMonth
	order by  perYear, perMonth, num_casos desc, num_recuperados desc, num_muertos desc
);