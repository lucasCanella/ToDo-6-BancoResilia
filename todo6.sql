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

insert into empresa_parceira(id_empresa, nome, cnpj, setor)
values
      (1, 'Xdevelopers', '73.072.245/0001-06', 'Tecnologia'),
      (2, 'Construções Jr', '74.870.473/0001-86', 'Infraestrutura'),
      (3, 'Comes e Bebes', '09.525.761/0001-31', 'Alimentício'),
      (4, 'Banco verde', '16.002.111/0001-77', 'Bancário'),
      (5, 'empresa oy',	'45.002.111/0001-77', 'Comercial');

insert into area(id_area, nome)
values
      (1, 'Webdev'),
      (2, 'Dados'),
      (3, 'Marketing');
      
insert into tecnologia(id_tecnologia, id_area, nome)
values
      (1, 2, 'SQL'),
      (2, 1, 'JavaScript'),
      (3, 3, 'CRM'),
      (4, 2, 'Python');
      
insert into cadastro(id_cadastro, id_empresa, id_tecnologia, data)
values
       (1,1,2,'2021-08-25'),
       (2,2,1,'2021-10-30'),
       (3,1,4,'2021-09-07'),
       (4,3,3,'2022-02-15'),
       (5,4,4,'2022-04-23'),
       (6,4,2,'2022-05-14'),
       (7,5,3,'2022-03-13');

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

select count(id_tecnologia) total_dados from cadastro where id_tecnologia = 1 or id_tecnologia = 4;

-- 4) Quantas empresas utilizam tecnologias que não são da área de “Dados” atualmente?

select total.qtd_total - total_dados.qtd_dados as empresas_sem_dados
from
(select count(id_tecnologia) qtd_dados from cadastro where id_tecnologia = 1 or id_tecnologia = 4) as total_dados
cross join 
(select count(id_empresa) qtd_total from empresa_parceira) total
