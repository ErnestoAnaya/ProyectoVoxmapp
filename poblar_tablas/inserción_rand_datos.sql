--para update_

with update_datos as (
	select 
	generate_series(1,10000) as update_id, 
	date((current_date - '2 years'::interval) + trunc(random() * 365) * '1 day'::interval + trunc(random() * 2) * '1 year'::interval ) as update_date,
	round(random()*226) as personal_id
)
insert into update_ 
select update_id,update_date, personal_id, p.moph_number from update_datos join personal p using(personal_id);


--para control (control_id, update_status, problem, update_id)   (hay un control por cada update)
with control_cases as (
	select
    case (random() * 2)::integer
      when 0 then 'questionaire completed'
      when 1 then 'problem with questionaire'
      when 2 then 'this was a test'
    end as update_status,
    case (random() * 7)::integer
      when 0 then 'questionaire not done'
      when 1 then 'some data is missing'
      when 2 then 'refused to speak'
      when 3 then 'no answer'
      when 4 then 'wrong phone number'
      when 5 then 'doctor has quit'
      when 6 then 'none'
      when 7 then 'none'
    end as problem,
    seq as control_id,
    seq as update_id
	from generate_series(1, 10000) seq
)
insert into control_ 
select control_id, update_status, problem, u.update_id from control_cases join update_ u using(update_id);

--para casos covid (positive_testas )

with casos_covid_datos as (
	select 
	generate_series(1,10000) as casos_covid_id,
	round(random()*700)+10 as positive_tests_last_month,
	generate_series(1,10000) as update_id
)
insert into casos_covid 
select 
casos_covid_id, positive_tests_last_month, 
round(round(random())*0.1*positive_tests_last_month) as intensive_care,
round(random()*positive_tests_last_month) as phc_referred_cases,
round(round(random())*0.05*positive_tests_last_month) as deaths_last_month,
round(random()*100) as non_covid_deaths,
round(random()*0.4*positive_tests_last_month) as recovered_patients,
update_id 
from casos_covid_datos join update_ u using(update_id);

--para infraestructura

with infraestructura_datos as (
	select
	generate_series(1,10000) as infraestructura_id,
	random()::int::boolean as screening_implemented,
	random()::int::boolean as awareness_campaigns,
	random()::int::boolean as test_covid_capabilities,
	round(random()*20) as test_result_speed,
	case (random() * 4)::integer
      when 0 then 'Yes, government'
      when 1 then 'Yes, Non-governmental'
      when 2 then 'Yes, Both'
      when 3 then 'None'
      when 4 then 'Dont know'
    end as resources_received_last_month,
    generate_series(1,10000) as update_id
)
insert into infraestructura 
select infraestructura_id, screening_implemented, awareness_campaigns, test_covid_capabilities, 
test_result_speed, resources_received_last_month, u.update_id 
from infraestructura_datos join update_ u using(update_id);


--para reservas 

with reservas_datos as(
	select
	generate_series(1,10000) as reservas_id,
	case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as oxygen_reserves,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as antipyretics_reservas,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as anesthetics_and_muscular_relaxants,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as alcohol_reserves_and_handsoap,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as personal_disposable_masks,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as personal_vinyl_gloves,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as personal_disposable_hats,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as personal_disposable_aprons,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as personal_visors,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as personal_disposable_shoe_covers,
    case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as test_kits,
    round(random()*100) as num_test_kits, 
    round(random()*8) as respiratory_ventilator_machines,
    generate_series(1,10000) as update_id
)
insert into reservas 
select reservas_id, oxygen_reserves, antipyretics_reservas, anesthetics_and_muscular_relaxants,
alcohol_reserves_and_handsoap, personal_disposable_masks, personal_vinyl_gloves, personal_disposable_hats,
personal_disposable_aprons, personal_visors, personal_disposable_shoe_covers, test_kits, num_test_kits,
respiratory_ventilator_machines, u.update_id
from reservas_datos join update_ u using(update_id);

--para seguimiento
with seguimiento_datos as(
	select 
	generate_series(1,10000) as seguimiento_id,
	random()::int::boolean as regular_tracking,
	case (random() * 4)::integer
      when 0 then 'Yes, for 30 days'
      when 1 then 'Yes, for 15 days'
      when 2 then 'Yes, for 7 days'
      when 3 then 'Yes, for 3 days'
      when 4 then 'No'
    end as moph_report_frequency,
    generate_series(1,10000) as update_id
)
insert into seguimiento 
select seguimiento_id, regular_tracking, moph_report_frequency, update_id from seguimiento_datos join update_ u using(update_id);







