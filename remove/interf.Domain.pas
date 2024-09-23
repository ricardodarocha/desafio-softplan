unit interf.Domain;

interface

uses Model.Cep;

type

  TModo = (Json, Xml);

  // Modela os requisitos da regra de negócio
  ICepDomain = interface
    ['{DB4D8A4B-B2C4-46C9-B221-5C9DD09A4B85}']
    function EncontrouCepNoBancoDeDados(ACep: String): boolean;
  end;

  // Implementa as regras de negócio de forma organizada, usando a linguagem Ubíquoa
  // apresentada pelo especialista nas especificações em anexo ver especificacoes/desafio.pdf

  // Não implementa as regras específicas, apenas a camada sintática, adiando a implementação da camada semântica
  // ver Controller.pas   (O controller tem acesso a infraestrutura do sistema e pode optar pelas tecnologias acopladas mais livremente)
  TCepConcreteDomain = class(TInterfacedObject, ICepDomain)
  protected
    function EncontrouCepNoBancoDeDados(ACep: String): boolean; virtual; abstract;
  public
    procedure TCepConcreteDomain.BuscarCep(ACep: String; AModo: TModo);
  end;

implementation

// Requisito US1.2 - Permitir a pesquisa do endereço através do CEP digitado
procedure TCepConcreteDomain.BuscarCep(ACep: String; AModo: TModo);
begin
  if EncontrouCepNoBancoDeDados(ACep) then
  begin
  // CA1.2 - Pesquisar o endereço através do CEP quando o mesmo já existir na base de dados

  // deverá
  //    (a) mostrar uma mensagem para o usuário se ele deseja que seja
  //  mostrado o Endereço encontrado na base, ou

  //    (b) que efetue uma nova consulta
  //  atualizando as informações do Endereço existente
  //  E armazenar o resultado na tabela criada caso a opção seja de atualizar
    case messageDlg('Cep já existe, deseja exibir o endereço da base de dados local? Escolha SIM para exibir, ou NÃO para realizar uma nova consulta ' +
    'na internet', mtConfirmation, [MbYes, MbNo], 0) of
         MrYes: ExibirCepEnderecoEncontrado;
         MrNo: BuscarCepApi(ACep);
    end;

  end
  else begin
  // CA1.1 Pesquisar o endereço através do CEP quando o mesmo não existir na base de dados

  // Neste caso, deverá (a) Buscar no WS (api viacep) utilizando o CEP informado
  // (b) E armazenar o resultado na tabela consultas que foi criada

    BuscarCepApi(ACep); // async   aguarda o retorno do servidor ...

    // Nota do desenvolvedor: Ao retornar, o evento _OnReceiveOne será disparado
    // Este evento está programado para armazenar o resultado no banco de dados
  end;
end;

// Requisito US1.2 - Permitir a pesquisa do endereço através do Endereço Completo digitado
procedure TCepController.BuscarEndereco(AUf, ACidade, AEndereco: String; AModo: TModo);

  //CA1.1 - Pesquisar o Endereço através do endereço completo
  procedure VerificarcamposIncompletos();
  begin
    if (length(AUf) < 3) or (length(ACidade) < 3) or (length(AEndereco) < 3) then
      raise Exception.Create('Os campos foram informados incorretamente');
  end;

begin
  //CA1.1 - Pesquisar o Endereço através do endereço completo
  // campos incompletos (ESTADO/CIDADE/ENDEREÇO)
  // QUANDO informar um endereço completo para consulta
  // E o campo Estado ou Cidade ou Endereço contiver menos que 3 caracteres
  // ENTÃO deverá apresentar uma mensagem para o usuário informando que o campo
  // foi informado incorretamente
  VerificarCamposIncompletos();

  if EncontrouEnderecoNoBancoDeDados(AEndereco, Copy(AUf, 2), ACidade) then
  begin
  // CA1.3 - Pesquisar o endereço através do endereço completo QUANDO informar um endereço completo para consulta
  //  E os campos informados forem maiores que 3 caracteres
  //  E o endereço não existir registrado na base de dados
  //  ENTÃO deverá efetuar uma consulta através do WS utilizando o Endereço Completo
  //  E armazenar os resultados na base de dados na tabela criada

  // deverá
  //    (a) mostrar uma mensagem para o usuário se ele deseja que seja
  //  mostrado o Endereço encontrado na base, ou

  //    (b) que efetue uma nova consulta
  //  atualizando as informações do Endereço existente
  //  E armazenar o resultado na tabela criada caso a opção seja de atualizar
    case messageDlg('Endereco já existe, deseja exibir o endereço da base de dados local? Escolha SIM para exibir, ou NÃO para realizar uma nova consulta ' +
    'na internet', mtConfirmation, [MbYes, MbNo], 0) of
         MrYes: ExibirCepEnderecoEncontrado;
         MrNo: BuscarEnderecoApi(AEndereco, Copy(AUf, 2), ACidade);
    end;

  end
  else begin
  // CA1.2 - Pesquisar o Endereço através do endereço completo
  // DADO a pesquisa por Endereço Completo
  //  E os campos informados forem maiores que 3 caracteres
  //  E o endereço não existir registrado na base de dados

  // Neste caso, deverá (a) efetuar uma consulta através do WS utilizando o Endereço Completo
  // (b) E armazenar o resultado na tabela consultas que foi criada

    BuscarEnderecoApi(AEndereco, Copy(AUf, 2), ACidade); // async   aguarda o retorno do servidor ...

    // Nota do desenvolvedor: Ao retornar, o evento _OnReceiveOne será disparado
    // Este evento está programado para armazenar o resultado no banco de dados
  end;
end;

end.
