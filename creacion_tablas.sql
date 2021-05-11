create table hospital(
	MOPH_number numeric constraint pk_moph primary key,
  	hospital_name varchar (50) not null,
  	district varchar (50) not null,
  	province varchar (50) not null,
  	hospital_type varchar (50) not null,
  	longitude float8 not null,
  	latitude float8 not null,
  	altitude float8 not null,
  	creation_date timestamp not null,
  	--photo photo not null,
  	personal_VM_id numeric not null,
  	num_doctors numeric not null,
  	num_staff numeric not null,
  	type_ char
);


create table personal(
	personal_id numeric constraint pk_personal primary key,
	first_name varchar(50) not null,
    last_name varchar(50) not null,
    number_ numeric not null,
    
    MOPH_number numeric REFERENCES hospital (MOPH_number) 
);
create sequence personal_id_personal_seq start 1 increment 1 ;
ALTER TABLE personal ALTER COLUMN personal_id SET DEFAULT nextval('personal_id_personal_seq');


create table update_(
	update_id numeric constraint pk_update primary key,
    update_date timestamp not null,
    
    personal_id numeric REFERENCES personal (personal_id),
    MOPH_number numeric REFERENCES hospital (MOPH_number) 
);
create sequence update_id_update_seq start 1 increment 1 ;
ALTER TABLE update_ ALTER COLUMN update_id SET DEFAULT nextval('update_id_update_seq');


CREATE TABLE seguimiento (
	seguimiento_id numeric constraint pk_seguimiento primary key,
	regular_tracking boolean NOT null,
	MOPH_report_frecuency VARCHAR(50) NOT null,
	update_id numeric REFERENCES update_ (update_id) 
);
create sequence seguimiento_id_seguimiento_seq start 1 increment 1 ;
ALTER TABLE seguimiento ALTER COLUMN seguimiento_id SET DEFAULT nextval('seguimiento_id_seguimiento_seq');


CREATE TABLE infraestructura (
	infraestructura_id numeric constraint pk_infraestructura primary key,
	screening_implemeted boolean NOT null,
  	awareness_campaigns boolean NOT null,
  	test_COVID_capabilities boolean NOT null,
  	test_result_speed int NOT null,
  	resources_received_last_month varchar(50),
	update_id numeric REFERENCES update_ (update_id) 
);
create sequence infraestructura_id_infraestructura_seq start 1 increment 1 ;
ALTER TABLE infraestructura ALTER COLUMN infraestructura_id SET DEFAULT nextval('infraestructura_id_infraestructura_seq');


CREATE TABLE control_ (
	control_id numeric constraint pk_control primary key,
	update_status VARCHAR(50) NOT null,
	problem VARCHAR(50) NOT null,
	update_id numeric REFERENCES update_ (update_id) 

);
create sequence control_id_control_seq start 1 increment 1 ;
ALTER TABLE control_ ALTER COLUMN control_id SET DEFAULT nextval('control_id_control_seq');


CREATE TABLE casos_covid (
	casos_covid_id numeric constraint pk_casos_covid primary key,
	PHC_reffered_cases numeric NOT null,
	positive_tests_last_month numeric NOT null,
	intensive_care numeric NOT null,
	deaths_last_month numeric NOT null,
	non_COVID_deaths numeric NOT null,
	recovered_patients numeric NOT null,
	update_id numeric REFERENCES update_ (update_id) 

);
create sequence casos_covid_id_casos_covid_seq start 1 increment 1 ;
ALTER TABLE casos_covid ALTER COLUMN casos_covid_id SET DEFAULT nextval('casos_covid_id_casos_covid_seq');


CREATE TABLE reservas (
	reservas_id numeric constraint pk_reservas primary key,
	oxygen_reserves VARCHAR(50) NOT null,
	antipyretics_reserves VARCHAR(50) NOT null,
	anesthetics_and_muscular_relaxants VARCHAR(50) NOT null,
	alcohol_reserves_and_handsoap VARCHAR(50) NOT null,
	personal_disposable_masks VARCHAR(50) NOT null,
	personal_vinyl_gloves VARCHAR(50) NOT null,
	personal_disposable_hats VARCHAR(50) NOT null,
	personal_disposable_aprons VARCHAR(50) NOT null,
	personal_visors VARCHAR(50) NOT null,
	personal_disposable_shoe_covers VARCHAR(50) NOT null,
	test_kits VARCHAR(50) NOT null,
	num_test_kits numeric NOT null,
	respiratory_ventilator_machines numeric NOT null,
	update_id numeric REFERENCES update_ (update_id) 
);
create sequence reservas_id_reservas_seq start 1 increment 1 ;
ALTER TABLE reservas ALTER COLUMN reservas_id SET DEFAULT nextval('reservas_id_reservas_seq');


create table personal_voxmapp(
	first_name varchar(50),
  	last_name varchar(50),
  	number_ numeric
);

