--PRUEBAS

insert into public.hospital (moph_number, hospital_name, 
district, province, hospital_type, longitude, latitude, altitude, creation_date, 
personal_vm_id, num_doctors, num_staff, type_)
values (123,'Hospital 1', 'DF', 'P1','tipo 1', 20.0,10.0,25.0,now(),1,1,1,'a');

insert into public.hospital (moph_number, hospital_name, 
district, province, hospital_type, longitude, latitude, altitude, creation_date, 
personal_vm_id, num_doctors, num_staff, type_)
values (124,'Hospital 2', 'DF', 'P2','tipo 2', 20.0,10.0,25.0,now(),1,1,1,'b');

insert into public.hospital (moph_number, hospital_name, 
district, province, hospital_type, longitude, latitude, altitude, creation_date, 
personal_vm_id, num_doctors, num_staff, type_)
values (125,'Hospital 3', 'DF', 'P3','tipo 3', 20.0,10.0,25.0,now(),1,1,1,'c');

insert into personal (first_name, last_name, number_, moph_number) values ('Javier', 'Orcazas', 1, 123);
insert into personal (first_name, last_name, number_, moph_number) values ('Santiago', 'Fernández', 2, 123);
insert into personal (first_name, last_name, number_, moph_number) values ('Sebastián', 'Murillo', 3, 123);
insert into personal (first_name, last_name, number_, moph_number) values ('Erick', 'Martínez', 4, 123);
insert into personal (first_name, last_name, number_, moph_number) values ('Javier', 'Orcazas', 5, 123);
