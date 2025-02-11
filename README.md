# Carrinho de Compras API (E-commerce)

Este repositório contém a implementação de uma API para gerenciamento de carrinhos de compras de e-commerce, desenvolvida como parte de um desafio técnico para backend. A API foi implementada utilizando Ruby on Rails, PostgreSQL, Redis e Sidekiq para o gerenciamento de carrinhos abandonados.

# PONTOS IMPORTANTES!!

Para melhor entendimento, criei estes passos relatados de todo o processo, para uma visibilidade do geral e aspectos que foram decididos durante o desenvolvimento. Pois não tenho expertise na area de backend, apenas sou Developer Frontend Junior e ainda não havia instalado o ambiente para este tipo de projeto e desafio. 

-----> Configuração do Ambiente: <---------

````
1.Realizei a instalação do Ruby e o Rails, além do PostgreSQL e do Redis, que são necessários para o funcionamento do projeto.

2.Ajustei a configuração do PostgreSQL, criando os bancos de dados e garantindo que o Rails pudesse se conectar corretamente, dentro de modelos e padrões gerais.

3.Criação do Projeto Rails: Criado o projeto Rails e configurado o repositório Git para subir o código para o GitHub, e neste momento deu um git diff, para verificar se havia arquivos que não estao seguros antes de ser enviados em commit - enviado as estruturas e testes.

4.Configuração do Banco de Dados: Ajustado o arquivo ``database.yml`` para garantir que as configurações de banco de dados estavam corretas, especialmente para o ambiente de desenvolvimento (local)

5.Criação dos bancos de dados necessários usando o comando rails db:create.
No inicio decidi implementar a funcionalidade do carrinho de compras, criando uma API com a rota /cart para adicionar produtos ao carrinho.


6.Desenvolvimento do Carrinho de Compras
Criação de uma API REST para gerenciar o carrinho de compras, com uma rota POST /cart para adicionar um produto ao carrinho e partindo disso, utilizei modelo de carrinho e o modelo de produto, incluindo os atributos necessários (ID, quantidade, preço, etc.).

7.Configuração  da rota e os controladores para adicionar um produto ao carrinho.

8. Testando a API: realizei alguns testes na API com  curl, porque o Postman  não consegui instalar de uma forma completa, cheguei a baixar tudo o possivel e testes varias outras formas de corrigir os erros de instalação ( minha máquina é de baixa capacidade) para garantir que os produtos possam ser adicionados ao carrinho, e o sistema responda com a lista de produtos atualizada e o preço total, respondendo com o JSON.

````

## Funcionalidades Implementadas:

### 1. **Criação de um carrinho de compras**
- Endpoint: `POST /cart`
- Criação de um carrinho de compras vazio na sessão.

### 2. **Lista de itens do carrinho atual**
- Endpoint: `GET /cart`
- Retorna os itens presentes no carrinho atual, com a quantidade de cada produto e o valor total.

### 3. **Adicionar ou alterar a quantidade de produtos no carrinho**
- Endpoint: `POST /cart/add_item`
- Permite adicionar um produto ao carrinho ou alterar a quantidade de um produto já existente no carrinho.

### 4. **Remover um produto do carrinho**
- Endpoint: `DELETE /cart/:product_id`
- Remove um produto específico do carrinho.

### 5. **Excluir carrinhos abandonados**
- Implementação de um **Job** para verificar carrinhos inativos.
  - Carrinhos que estão sem interação por mais de 3 horas são marcados como abandonados. ( cheguei a testar na escrita de outras formas do teste - mas resolvi buscar o conceito de clean code que foi solicitado no desafio)
  - Carrinhos abandonados por mais de 7 dias são excluídos automaticamente.

## Dependências

- **Ruby** 3.3.1
- **Rails** 7.1.3.2
- **PostgreSQL** 16
- **Redis** 7.0.15
- **Sidekiq** para gerenciamento de Jobs
- **RSpec** para testes

## Como rodar o projeto

### Pré-requisitos

1. Certifique-se de ter o Ruby, Rails, PostgreSQL e Redis instalados em sua máquina. Caso não tiver, recomendo buscar no google as fontes de instalação - que contenha a documentação original ou proprio site.

2. Instale as dependências do projeto com o comando (recomendo fazer isso em Linux e Mac, pois no Windows que foi meu caso, existe um pouco de detalhes para esta instalação das dependencias.):

```bash
bundle install
```

### Executando a aplicação

1. Inicie o banco de dados:

```bash
bin/rails db:create
bin/rails db:migrate
```

2. Para rodar a aplicação localmente, use o comando:

```bash
bin/rails server
```

3. Inicie o **Sidekiq** para gerenciar os Jobs (carrinhos abandonados):

```bash
bundle exec sidekiq
```

### Rodando os testes

Para rodar os testes com **RSpec**, use o seguinte comando:

```bash
bundle exec rspec
```

## Dockerização (Opcional) 
>> Este não consegui concretizar e instalar e ver a finalização de todo ambiente.

A aplicação já possui um `Dockerfile` para facilitar o deployment (criei pelo menos o arquivo) dentro de um container. Para rodar a aplicação com Docker, siga os passos abaixo:

1. **Construir as imagens Docker**:

```bash
docker-compose build
```

2. **Subir os containers**:

```bash
docker-compose up
```

Com isso, o banco de dados, a aplicação Rails e o Sidekiq irão rodar dentro dos containers Docker.

## Estrutura do Projeto

O projeto segue a estrutura padrão de um aplicativo Rails com as seguintes funcionalidades adicionais:

- **CartsController**: Lida com as rotas de gerenciamento de carrinho (adicionar, listar, remover produtos).
- **Job** de carrinhos abandonados: Verificar periodicamente carrinhos inativos e os marca ou exclui conforme o critério de inatividade.
- **Modelos** `Cart`, `Product`, `CartItem`: Relacionamentos entre carrinhos, produtos e itens no carrinho.

## Melhorias Possíveis

- **Autenticação**: Implementar autenticação de usuários para permitir carrinhos associados a contas de usuários. Isso não consegui implementar ou mesmo até pensar numa estratégia especifica.
- **Notificações**: Se possivel adicionar notificações para carrinhos abandonados, enviando emails ou mensagens de alerta aos usuários. Isso é muito usado em projetos ate do REMIX e NextJS - Já fiz estes testes em projetos com REVALIDAÇÃO AUTOMÁTICA de Formulários.
- **API de Produtos**: Integrar com uma API externa para listar produtos em vez de ter produtos hardcoded no banco.

---

Licença

Este projeto está licenciado sob a MIT License - veja o arquivo [LICENSE](https://github.com/lirasusejdev/projeto-chunking-revision/blob/main/LICENSE) para mais detalhes. Este projeto foi criado por LIS REGINE AMARAL - baseado em desafio técnico.
