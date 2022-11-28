create table empresa_parceira (
    id_empresa serial primary key,
   nome varchar(50),
    cnpj varchar(18),
    setor varchar(50)    
);

create table area (
    id_area serial primary key,
    nome varchar(50)
);

create table tecnologia(
    id_tecnologia serial primary key,
    id_area serial,
    nome varchar(50),
    foreign key (id_area) references area(id_area)
);

create table cadastro (
    id_cadastro serial primary key,
    id_empresa serial,
    id_tecnologia serial,
    foreign key (id_empresa) references empresa_parceira(id_empresa),
    foreign key (id_tecnologia) references tecnologia(id_tecnologia),
    "data" date    
);

select * from empresa_parceira;
select * from area;
select * from tecnologia;
select * from cadastro order by id_cadastro;

-- 1) Qual empresa utiliza o maior número de tecnologias na última pesquisa (1/2022)(primeiro semestre de 2022)?

-- Mostra quais empresas registraram em 01/2022 (primeiro semestre de 2022)
select empresa_parceira.id_empresa, empresa_parceira.nome, cadastro.id_tecnologia, tecnologia.id_area, cadastro.data from empresa_parceira 
inner join cadastro on cadastro.id_empresa = empresa_parceira.id_empresa
inner join tecnologia on tecnologia.id_tecnologia = cadastro.id_tecnologia
where cadastro.data between '01/01/2022' and '30/06/2022';

-- Mostra qual empresa utilizava o maior número de tecnologias na última pesquisa (1/2022)

select foo.id_empresa, foo.nome, count(foo.id_tecnologia) from (
    select empresa_parceira.id_empresa, empresa_parceira.nome, cadastro.id_tecnologia, tecnologia.id_area, cadastro.data from empresa_parceira 
    inner join cadastro on cadastro.id_empresa = empresa_parceira.id_empresa
    inner join tecnologia on tecnologia.id_tecnologia = cadastro.id_tecnologia
    where cadastro.data between '01/01/2022' and '30/06/2022') as foo
group by foo.id_empresa, foo.nome having count(foo.id_area) > 0 order by count(foo.id_area) desc limit 1;

-- 2) Qual empresa utilizava o menor número de tecnologias na pesquisa anterior (2/2021)(segundo semestre de 2021)?

-- Mostra quais empresas registraram em 02/2021 (segundo semestre de 2021)
select empresa_parceira.id_empresa, empresa_parceira.nome, cadastro.id_tecnologia, tecnologia.id_area, cadastro.data from empresa_parceira 
inner join cadastro on cadastro.id_empresa = empresa_parceira.id_empresa
inner join tecnologia on tecnologia.id_tecnologia = cadastro.id_tecnologia
where cadastro.data between '30/05/2021' and '31/12/2021'; -- Mostra quais empresas registraram em 02/2021 (segundo semestre de 2021)

-- Mostra qual empresa utilizava o menor número de tecnologias na pesquisa anterior (2/2021)

select foo.id_empresa, foo.nome, count(foo.id_tecnologia) from (
    select empresa_parceira.id_empresa, empresa_parceira.nome, cadastro.id_tecnologia, tecnologia.id_area, cadastro.data from empresa_parceira 
    inner join cadastro on cadastro.id_empresa = empresa_parceira.id_empresa
    inner join tecnologia on tecnologia.id_tecnologia = cadastro.id_tecnologia
    where cadastro.data between '30/05/2021' and '31/12/2021') as foo
group by foo.id_empresa, foo.nome having count(foo.id_area) > 0 order by count(foo.id_area) limit 1;

-- 3) Quantas empresas utilizam tecnologias da área de “Dados” atualmente? 

select count(id_tecnologia) from cadastro where id_tecnologia = 1 or id_tecnologia = 4;

-- 4) Quantas empresas utilizam tecnologias que não são da área de “Dados” atualmente?

select count(id_tecnologia) from cadastro where id_tecnologia != 1 and id_tecnologia != 4;


