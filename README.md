# To Do 6: BANCO RESILIA

Vocês lembram do nosso modelo de banco para a ResiliaData? (Todo 5)

Nosso projeto foi aprovado com algumas solicitações extras, vamos ajustar nosso modelo e colocar o banco de dados para funcionar. Os únicos ajustes que foram solicitados:

* Criar uma nova entidade chamada “relatórios”, essa entidade vai armazenar a data de compilação dos dados e garantir um histórico de quais tecnologias as empresas estavam usando no momento que a Resilia compilou os dados, ou seja, não vamos mais marcar as tecnologias diretamente nas empresas, vamos ter essa tabela de compilado para checar a cada seis meses como estão as stacks.

* Vamos popular esse banco de dados de forma fictícia com informações de 4 empresas e 2 pesquisas (de diferentes datas). 

Depois de aplicar esses ajustes no nosso modelo, criar o banco de dados, popular com dados fictícios vamos pensar nas seguintes queries SQL:

* Qual empresa utiliza o maior número de tecnologias na última pesquisa (1/2022)?
* Qual empresa utilizava o menor número de tecnologias na pesquisa anterior (2/2021)?
* Quantas empresas utilizam tecnologias da área de “Dados” atualmente?
* Quantas empresas utilizam tecnologias que não são da área de “Dados” atualmente?