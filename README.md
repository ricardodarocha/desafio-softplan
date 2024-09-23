# desafio-softplan

### Bem vindo 👋

Clone este repositório e abra com o Delphi
Configure a conexão com o banco de dados SQLite em anexo. 
Basta configurar o FDConnection com o arquivo em anexo, e rodar o script Migrations.sql para criar as tabelas

🟢 Abra o grupo do projeto DesafioSoftplan.groupproj
🟢 Instale o pacote de componentes Componente.bpl. Clique em **Compile** e **Install** 
🟢 Selecione o projeto DesafioDelphiCep.exe e compile

### Conhecimentos empregados

#### Requisitos técnicos:
✔ 1. Possibilitar armazenar os resultados das consultas em uma tabela (Foi escolhido o BD SQLite) 
✔ 2. Possibilitar que as consultas possam ser feitas tanto por CEP quanto por
Endereço Completo.
✔ 3. Permitir navegar através dos registros já inseridos, e caso seja feita a consulta de
um CEP ou Endereço que já exista cadastrado, deverá perguntar ao usuário se
deseja atualizar os dados encontrados.
✔ 4. O Layout Foi desenvolvido usando formulários e um componente visual personalizado
✔ 5. Disponibilizar o código fonte em um repositório público do GitHub.
✔ 6. Disponibilizar o readme no github utilizando boas práticas, informando a
arquitetura utilizada, patterns aplicadas, como executar o App, etc.

#### Conhecimentos avançados
1. Utilização de Clean Code
2. Utilização de SOLID
3. Utilização de POO
4. Serialização e desserialização de objetos JSON (Ver o módulo Strategy.Json.pas)
5. Utilização de Interfaces (Ver o módulo interfaces.pas)
6. Aplicação de Patterns (Foram empregados diversos patterns, como Fluent Builder Api, Strategy e Iterator. Ver interf.iterator.pas)
7. Criação de Componentes (Foram desenvolvidos dois componentes para este desafio, sendo um Componente Visual e um Componente Não Visual)

### Arquitetura

A implementação será organizada em três módulos principais: Domínio, Infraestrutura e Aplicação. O módulo de domínio implementa a camada sintática do programa utilizando a linguagem ubíqua.
O módulo de infraestrutura permite acoplar diferentes tecnologias ao projeto, como suporte ao protocolo REST, Json, XML ou conexão com o banco de Dados.
A aplicação possui uma interface de usuário onde o usuário pode interagir e realizar suas consultas. Essa camada possui inputs (actions) e output de dados (views) para exibir os resultados.
### Teoria

- **SOLID:** A separação clara de responsabilidades (SRP) é mantida entre as camadas. Cada classe e interface tem uma única responsabilidade, e as dependências são injetadas para permitir flexibilidade e troca de repositórios.
- **DDD:** A camada de domínio define a lógica central com as interfaces e entidades, enquanto a infraestrutura lida com a implementação dos repositórios específicos.
- **Interfaces e Abstração:** Usar interfaces (`IController`, `IApi`, `IDatabase`) permite a abstração sem alterar a lógica da aplicação, enquanto as implementações definem a camada semântica

Essa estrutura é flexível e preparada para crescimento, facilitando a manutenção e a adição de novas funcionalidades no futuro.
- **Regra de Negócio no Serviço:** A lógica adicionada permite uma segunda tentativa de busca caso o CEP não seja encontrado na primeira tentativa, podendo ser expandida para incluir regras mais complexas, como diferentes repositórios ou tratamentos alternativos.
- **Uso do Controlador:** O controlador (`TCepController`) centraliza a lógica de interação com o serviço e prepara a aplicação para futuras expansões, como tratamento de eventos ou respostas assíncronas.
A figura a seguir ilustra os componentes da arquitetura sob a perspectiva do DDD Domain Driven Design

![](https://github.com/ricardodarocha/desafio-softplan/blob/main/arq.png?raw=true)
## Implementação

```delphi
TFrmApp = class(TForm)
private
  FController: ICepController;
  procedure BuscarCep(const ACep: string);
  procedure BuscarEndereco(const ALogradouro, ALocalidade, AUf: string);
public
  constructor Create(AOwner: TComponent); override;
end;

constructor TFrmApp.Create(AOwner: TComponent);
var
  RepositoryApi: ICepRepositoryApi;
  RepositoryDatabase: ICepRepositoryDatabase;
  Service: IBuscaCepService;
begin
  inherited Create(AOwner);
  RepositoryApi := TCepRepositoryApi.Create; 
  RepositoryDatabase := TCepRepositoryDatabase.Create; 
  Service := TBuscaCepService.Create(Repository);
  FController := TCepController.Create(Service);
end;

procedure TFrmApp.BuscarCep(const ACep: string);
begin
  FController.BuscarCep(ACep);
end;

procedure TFrmApp.BuscarEndereco(const ALogradouro, ALocalidade, AUf: string);
begin
  FController.BuscarEndereco( ALogradouro, ALocalidade, AUf);
end;

```
A imagem abaixo ilustra uma arquitetura similar implementada em Java
![](https://github.com/ricardodarocha/desafio-softplan/blob/main/ddd.png?raw=true)

O projeto é conectado a duas interfaces externas, sendo a primeira a conexão local com banco de dados SQLITE. Para tanto, foram criadas duas interfaces
*ICepApiProvider* e *IDatabaseRepository*

A camada semântica é implemenada usando as tecnologias RestClient e Firedac do Delphi
A implementação do repositório de dados é uma adaptação em Delphi para tirar o melhor proveito da infraestrutura nativa do Delphi, adaptando o TDataset como provedor de dados preferencial

Porém, para atender ao desafio, também foram implementados parser manuais de XML e Json, conforme pode ser visto no *Service* (TBuscaCepService) que implementa a interface IService
A interface IService foi destacada para deixar o IController mais organizado, atendendo às boas práticas do Clean Code e os princípios Solid (Single Responsability, Inversion etc)

A a outra interface externa é conectada à API viacep/ws onde é possível consultar CEPS por número ou pelo endereço. A Api também aceita duas estratégias de conexão, via Json ou Xml, devidadente implementada pela interface Strategy , usando o componente RestClient conforme já foi explicado.

A imagem abaixo ilustra a view do projeto de consulta de CEP

![](https://github.com/ricardodarocha/desafio-softplan/blob/main/View.gif?raw=true)
