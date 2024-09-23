unit interf.Domain;

interface

uses Model.Cep;

type

  TModo = (Json, Xml);

  // Modela os requisitos da regra de neg�cio
  ICepDomain = interface
    ['{DB4D8A4B-B2C4-46C9-B221-5C9DD09A4B85}']
    function EncontrouCepNoBancoDeDados(ACep: String): boolean;
  end;

  // Implementa as regras de neg�cio de forma organizada, usando a linguagem Ub�quoa
  // apresentada pelo especialista nas especifica��es em anexo ver especificacoes/desafio.pdf

  // N�o implementa as regras espec�ficas, apenas a camada sint�tica, adiando a implementa��o da camada sem�ntica
  // ver Controller.pas   (O controller tem acesso a infraestrutura do sistema e pode optar pelas tecnologias acopladas mais livremente)
  TCepConcreteDomain = class(TInterfacedObject, ICepDomain)
  protected
    function EncontrouCepNoBancoDeDados(ACep: String): boolean; virtual; abstract;
  public
    procedure TCepConcreteDomain.BuscarCep(ACep: String; AModo: TModo);
  end;

implementation

// Requisito US1.2 - Permitir a pesquisa do endere�o atrav�s do CEP digitado
procedure TCepConcreteDomain.BuscarCep(ACep: String; AModo: TModo);
begin
  if EncontrouCepNoBancoDeDados(ACep) then
  begin
  // CA1.2 - Pesquisar o endere�o atrav�s do CEP quando o mesmo j� existir na base de dados

  // dever�
  //    (a) mostrar uma mensagem para o usu�rio se ele deseja que seja
  //  mostrado o Endere�o encontrado na base, ou

  //    (b) que efetue uma nova consulta
  //  atualizando as informa��es do Endere�o existente
  //  E armazenar o resultado na tabela criada caso a op��o seja de atualizar
    case messageDlg('Cep j� existe, deseja exibir o endere�o da base de dados local? Escolha SIM para exibir, ou N�O para realizar uma nova consulta ' +
    'na internet', mtConfirmation, [MbYes, MbNo], 0) of
         MrYes: ExibirCepEnderecoEncontrado;
         MrNo: BuscarCepApi(ACep);
    end;

  end
  else begin
  // CA1.1 Pesquisar o endere�o atrav�s do CEP quando o mesmo n�o existir na base de dados

  // Neste caso, dever� (a) Buscar no WS (api viacep) utilizando o CEP informado
  // (b) E armazenar o resultado na tabela consultas que foi criada

    BuscarCepApi(ACep); // async   aguarda o retorno do servidor ...

    // Nota do desenvolvedor: Ao retornar, o evento _OnReceiveOne ser� disparado
    // Este evento est� programado para armazenar o resultado no banco de dados
  end;
end;

// Requisito US1.2 - Permitir a pesquisa do endere�o atrav�s do Endere�o Completo digitado
procedure TCepController.BuscarEndereco(AUf, ACidade, AEndereco: String; AModo: TModo);

  //CA1.1 - Pesquisar o Endere�o atrav�s do endere�o completo
  procedure VerificarcamposIncompletos();
  begin
    if (length(AUf) < 3) or (length(ACidade) < 3) or (length(AEndereco) < 3) then
      raise Exception.Create('Os campos foram informados incorretamente');
  end;

begin
  //CA1.1 - Pesquisar o Endere�o atrav�s do endere�o completo
  // campos incompletos (ESTADO/CIDADE/ENDERE�O)
  // QUANDO informar um endere�o completo para consulta
  // E o campo Estado ou Cidade ou Endere�o contiver menos que 3 caracteres
  // ENT�O dever� apresentar uma mensagem para o usu�rio informando que o campo
  // foi informado incorretamente
  VerificarCamposIncompletos();

  if EncontrouEnderecoNoBancoDeDados(AEndereco, Copy(AUf, 2), ACidade) then
  begin
  // CA1.3 - Pesquisar o endere�o atrav�s do endere�o completo QUANDO informar um endere�o completo para consulta
  //  E os campos informados forem maiores que 3 caracteres
  //  E o endere�o n�o existir registrado na base de dados
  //  ENT�O dever� efetuar uma consulta atrav�s do WS utilizando o Endere�o Completo
  //  E armazenar os resultados na base de dados na tabela criada

  // dever�
  //    (a) mostrar uma mensagem para o usu�rio se ele deseja que seja
  //  mostrado o Endere�o encontrado na base, ou

  //    (b) que efetue uma nova consulta
  //  atualizando as informa��es do Endere�o existente
  //  E armazenar o resultado na tabela criada caso a op��o seja de atualizar
    case messageDlg('Endereco j� existe, deseja exibir o endere�o da base de dados local? Escolha SIM para exibir, ou N�O para realizar uma nova consulta ' +
    'na internet', mtConfirmation, [MbYes, MbNo], 0) of
         MrYes: ExibirCepEnderecoEncontrado;
         MrNo: BuscarEnderecoApi(AEndereco, Copy(AUf, 2), ACidade);
    end;

  end
  else begin
  // CA1.2 - Pesquisar o Endere�o atrav�s do endere�o completo
  // DADO a pesquisa por Endere�o Completo
  //  E os campos informados forem maiores que 3 caracteres
  //  E o endere�o n�o existir registrado na base de dados

  // Neste caso, dever� (a) efetuar uma consulta atrav�s do WS utilizando o Endere�o Completo
  // (b) E armazenar o resultado na tabela consultas que foi criada

    BuscarEnderecoApi(AEndereco, Copy(AUf, 2), ACidade); // async   aguarda o retorno do servidor ...

    // Nota do desenvolvedor: Ao retornar, o evento _OnReceiveOne ser� disparado
    // Este evento est� programado para armazenar o resultado no banco de dados
  end;
end;

end.
