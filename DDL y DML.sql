---------
-- DDL --
---------
-- drop schema jesus_romero cascade;
create schema jesus_romero authorization fwtzpwxy;

-- grupo empresarial --

create table jesus_romero.grupo_empresarial(
id_grupo varchar(10) not null, -- PK
nombre_grupo varchar(10) not null
);

alter table jesus_romero.grupo_empresarial 
add constraint grupoEmpresarial_PK primary key(id_grupo);

-- marca --
create table jesus_romero.marca(
id_marca varchar(10) not null, -- PK 
id_grupo varchar(10) not null, -- FK (grupo_empresarial, id_grupo)
nombre_marca varchar(100) not null
);

alter table jesus_romero.marca
add constraint marca_PK primary key (id_marca);

alter table jesus_romero.marca
add constraint marca_grupoEmpresarial_FK foreign key (id_grupo) references jesus_romero.grupo_empresarial(id_grupo);

-- modelo --
create table jesus_romero.modelo(
id_modelo varchar(10) not null, -- PK 
id_marca varchar(10) not null, -- FK (marca, id_marca)
nombre_modelo varchar(100) not null
);

alter table jesus_romero.modelo
add constraint modelo_PK primary key(id_modelo);

alter table jesus_romero.modelo
add constraint modelo_marca_FK foreign key(id_marca) references jesus_romero.marca(id_marca);

-- color --

create table jesus_romero.color(
id_color varchar(10) not null,
nombre_color varchar(100) not null
);

alter table jesus_romero.color 
add constraint color_PK primary key (id_color);

-- coches --
create table jesus_romero.coches(
id_coche varchar(10) not null, -- PK 
id_modelo varchar(10) not null, -- FK (modelo, id_modelo)
id_color varchar(10) not null, -- FK (color, id_color)
matricula varchar(20) not null, 
fecha_compra date not null
);

alter table jesus_romero.coches 
add constraint coche_PK primary key (id_coche);

alter table jesus_romero.coches 
add constraint coches_modelo_FK foreign key(id_modelo) references jesus_romero.modelo(id_modelo);

alter table jesus_romero.coches 
add constraint coches_color_FK foreign key(id_color) references jesus_romero.color(id_color);

-- historial_kms --
create table jesus_romero.historial_kms(
id_kms varchar(10) not null, -- PK 
id_coche varchar(10) not null, -- FK (coches, id_coche)
dt_revision date not null,
kilometros integer not null
);

alter table jesus_romero.historial_kms
add constraint historialKms_PH primary key (id_kms);

alter table jesus_romero.historial_kms
add constraint historialKms_coches_FK foreign key (id_coche) references jesus_romero.coches(id_coche);

-- divisa --
create table jesus_romero.divisa(
id_divisa varchar(10) not null, -- PK 
nombre_divisa varchar(50) not null,
simbolo_divisa varchar(10) not null
);

alter table jesus_romero.divisa
add constraint divisa_PK primary key(id_divisa);

-- revisiones_itv --

create table jesus_romero.revisiones_itv(
id_itv varchar(10) not null, -- PK 
id_coche varchar(10) not null, -- FK (coches, id_coche )
id_divisa varchar(10) not null, -- FK (divisa, id_divisa)
dt_itv date not null,
importe integer not null
);

alter table jesus_romero.revisiones_itv 
add constraint revisionesItv_PK primary key(id_itv);

alter table jesus_romero.revisiones_itv 
add constraint revisionesItv_coches_FK foreign key(id_coche) references jesus_romero.coches(id_coche);

alter table jesus_romero.revisiones_itv 
add constraint revisionesItv_divisa_FK foreign key(id_divisa) references jesus_romero.divisa(id_divisa);

-- aseguradora --
create table jesus_romero.aseguradora(
id_aseguradora varchar(10) not null,
nombre_aseguradora varchar(100) not null,
nif varchar(20) not null
);

alter table jesus_romero.aseguradora 
add constraint aseguradora_PK primary key(id_aseguradora);

-- coches_polizas --
create table jesus_romero.coches_polizas(
id_aseguradora varchar(10) not null, -- PK, FK (aseguradora, id_aseguradora)
id_coche varchar(10) not null, -- PK, FK (coches, id_coche)
num_poliza varchar(50) not null,
dt_alta date not null,
dt_expiracion date not null,
dt_ranovacion date null,
vigente boolean not null
);

alter table jesus_romero.coches_polizas 
add constraint cochesPolizas_PK primary key(id_aseguradora, id_coche, num_poliza);

alter table jesus_romero.coches_polizas 
add constraint cochesPolizas_aseguradora_FK foreign key (id_aseguradora) references jesus_romero.aseguradora(id_aseguradora);

alter table jesus_romero.coches_polizas 
add constraint cochesPolizas_coches_FK foreign key (id_coche) references jesus_romero.coches(id_coche);

---------
-- DML --
---------

-- grupo_empresarial
insert into jesus_romero.grupo_empresarial (id_grupo, nombre_grupo) values ('1', 'BMW Group');
insert into jesus_romero.grupo_empresarial (id_grupo, nombre_grupo) values ('2', 'Daimler');

-- marca
insert into jesus_romero.marca (id_marca, id_grupo, nombre_marca) values ('1', '1', 'Mini');
insert into jesus_romero.marca (id_marca, id_grupo, nombre_marca) values ('2', '1', 'Rolls Royce');
insert into jesus_romero.marca (id_marca, id_grupo, nombre_marca) values ('3', '1', 'BMW');
insert into jesus_romero.marca (id_marca, id_grupo, nombre_marca) values ('4', '2', 'Mercedes-Benz');
insert into jesus_romero.marca (id_marca, id_grupo, nombre_marca) values ('5', '2', 'Smart');

-- modelo
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('1', '1', 'mini cabrio');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('2', '1', 'mini clubman');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('3', '2', 'Rolls Royce Cullinan');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('4', '2', 'Rolls Royce Phantom');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('5', '3', 'BMW iX');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('6', '3', 'BMWiX M60');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('7', '4', 'Mercedes-Benz Clase C');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('8', '4', 'Mercedes-Benz Clase A');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('9', '5', 'Smart EQ fortwo');
insert into jesus_romero.modelo (id_modelo, id_marca, nombre_modelo) values ('10', '5', 'Smart EQ fortwo cabrio');

-- color
insert into jesus_romero.color (id_color, nombre_color) values ('1', 'blaco');
insert into jesus_romero.color (id_color, nombre_color) values ('2', 'rojo');
insert into jesus_romero.color (id_color, nombre_color) values ('3', 'azul');
insert into jesus_romero.color (id_color, nombre_color) values ('4', 'negro');
insert into jesus_romero.color (id_color, nombre_color) values ('5', 'gris');

-- coches
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('1', '1', '1', '1234 AAA', '2015-01-05');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('2', '1', '2', '1235 ABA', '2015-02-06');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('3', '2', '3', '1235 AAA', '2016-03-20');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('4', '2', '4', '1236 ABA', '2016-03-21');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('5', '3', '5', '1236 AAA', '2016-03-22');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('6', '3', '1', '1237 ABA', '2018-08-21');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('7', '4', '2', '1237 AAA', '2018-08-22');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('8', '4', '3', '1238 ABA', '2018-08-23');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('9', '5', '4', '1238 AAA', '2018-08-24');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('10', '5', '5', '1239 ABA', '2018-08-25');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('11', '6', '1', '1239 AAA', '2020-10-07');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('12', '6', '2', '1240 ABA', '2020-10-08');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('13', '7', '3', '1240 AAA', '2020-10-09');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('14', '7', '4', '1241 ABA', '2020-10-10');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('15', '8', '5', '1241 AAA', '2020-10-11');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('16', '8', '1', '1242 ABA', '2020-10-12');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('17', '9', '2', '1242 AAA', '2022-05-10');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('18', '9', '3', '1243 ABA', '2022-05-11');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('19', '10', '4', '1243 AAA', '2022-05-12');
insert into jesus_romero.coches (id_coche, id_modelo, id_color, matricula, fecha_compra) values ('20', '10', '5', '1244 ABA', '2022-05-13');

-- historial_kms
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('1', '1', '2015-01-05', 0);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('2', '2', '2015-02-06', 50000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('3', '1', '2015-12-31', 15000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('4', '2', '2015-12-31', 65000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('5', '1', '2016-12-31', 30000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('6', '2', '2016-12-31', 80000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('7', '1', '2017-12-31', 45000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('8', '2', '2017-12-31', 95000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('9', '1', '2018-12-31', 60000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('10', '2', '2018-12-31', 110000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('11', '1', '2019-12-31', 75000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('12', '2', '2019-12-31', 125000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('13', '1', '2020-12-31', 90000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('14', '2', '2020-12-31', 140000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('15', '1', '2021-12-31', 105000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('16', '2', '2021-12-31', 155000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('17', '3', '2020-10-01', 0);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('18', '4', '2020-10-02', 5000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('19', '5', '2020-10-03', 25000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('20', '6', '2020-10-04', 15000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('21', '7', '2020-10-05', 20000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('22', '8', '2020-10-06', 40000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('23', '9', '2020-10-07', 30000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('24', '10', '2020-10-08', 35000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('25', '11', '2020-10-07', 55000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('26', '12', '2020-10-08', 45000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('27', '13', '2020-10-09', 50000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('28', '14', '2020-10-10', 70000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('29', '15', '2020-10-11', 60000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('30', '16', '2020-10-12', 65000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('31', '3', '2021-12-31', 85000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('32', '4', '2021-12-31', 75000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('33', '5', '2021-12-31', 80000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('34', '6', '2021-12-31', 100000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('35', '7', '2021-12-31', 90000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('36', '8', '2021-12-31', 95000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('37', '9', '2021-12-31', 115000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('38', '10', '2021-12-31', 105000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('39', '11', '2021-12-31', 110000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('40', '12', '2021-12-31', 130000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('41', '13', '2021-12-31', 120000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('42', '14', '2021-12-31', 125000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('43', '15', '2021-12-31', 145000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('44', '16', '2021-12-31', 135000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('45', '17', '2022-05-10', 140000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('46', '18', '2022-05-11', 160000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('47', '19', '2022-05-12', 150000);
insert into jesus_romero.historial_kms (id_kms, id_coche, dt_revision, kilometros) values ('48', '20', '2022-05-13', 155000);

-- divisa
insert into jesus_romero.divisa (id_divisa, nombre_divisa, simbolo_divisa) values ('1', 'euro', 'EUR');
insert into jesus_romero.divisa (id_divisa, nombre_divisa, simbolo_divisa) values ('2', 'dolar', 'USD');

-- revisiones_itv
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('1', '1', '1', '2020-04-20', 55);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('2', '2', '1', '2020-04-20', 55);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('3', '3', '1', '2022-01-20', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('4', '4', '1', '2022-01-21', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('5', '5', '1', '2022-01-22', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('6', '6', '1', '2022-01-23', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('7', '7', '1', '2022-01-24', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('8', '8', '1', '2022-01-25', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('9', '9', '1', '2022-01-26', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('10', '10', '1', '2022-01-27', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('11', '11', '1', '2022-01-28', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('12', '12', '1', '2022-01-29', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('13', '13', '1', '2022-01-30', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('14', '14', '1', '2022-01-31', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('15', '15', '1', '2022-02-01', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('16', '16', '1', '2022-02-02', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('17', '1', '1', '2021-04-20', 56);
insert into jesus_romero.revisiones_itv (id_itv, id_coche, id_divisa, dt_itv, importe) values ('18', '2', '1', '2021-04-20', 56);

-- aseguradora
insert into jesus_romero.aseguradora (id_aseguradora, nombre_aseguradora, nif) values ('1', 'Mafre', 'B12345678');
insert into jesus_romero.aseguradora (id_aseguradora, nombre_aseguradora, nif) values ('2', 'Allianz', 'B23456789');
insert into jesus_romero.aseguradora (id_aseguradora, nombre_aseguradora, nif) values ('3', 'Linea Directa', 'B34567891');

-- coches_polizas
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('1', '1', '123456789', '2015-01-05', '2017-01-05', '2016-01-05', '0');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('1', '2', '123456790', '2015-02-06', '2017-02-06', '2016-02-06', '0');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('2', '1', '123456791', '2017-01-05', '2023-01-05', '2022-01-05', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('2', '2', '123456792', '2017-02-06', '2023-02-06', '2022-02-06', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '3', '123456793', '2020-10-01', '2022-10-01', '2021-10-01', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '4', '123456794', '2020-10-02', '2022-10-02', '2021-10-02', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '5', '123456795', '2020-10-03', '2022-10-03', '2021-10-03', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '6', '123456796', '2020-10-04', '2022-10-04', '2021-10-04', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '7', '123456797', '2020-10-05', '2022-10-05', '2021-10-05', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '8', '123456798', '2020-10-06', '2022-10-06', '2021-10-06', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '9', '123456799', '2020-10-07', '2022-10-07', '2021-10-07', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '10', '123456800', '2020-10-08', '2022-10-08', '2021-10-08', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '11', '123456801', '2020-10-07', '2022-10-07', '2021-10-07', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '12', '123456802', '2020-10-08', '2022-10-08', '2021-10-08', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '13', '123456803', '2020-10-09', '2022-10-09', '2021-10-09', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '14', '123456804', '2020-10-10', '2022-10-10', '2021-10-10', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '15', '123456805', '2020-10-11', '2022-10-11', '2021-10-11', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '16', '123456806', '2020-10-12', '2022-10-12', '2021-10-12', '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '17', '123456807', '2022-05-10', '2023-05-10', null, '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '18', '123456808', '2022-05-11', '2023-05-11', null, '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '19', '123456809', '2022-05-12', '2023-05-12', null, '1');
insert into jesus_romero.coches_polizas (id_aseguradora, id_coche, num_poliza, dt_alta, dt_expiracion, dt_ranovacion, vigente) values ('3', '20', '123456810', '2022-05-13', '2023-05-13', null, '1');


