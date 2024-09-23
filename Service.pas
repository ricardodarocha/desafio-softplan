unit Service;

interface

uses
  Interfaces,
  Data.Db,
  Model.Cep,
  Interf.Result, Strategy.Json, Strategy.Xml;

{$M+}

type
  TBuscaCepService = class(TInterfacedObject, IBuscaCepDomain)

  public
    //Requisito US1.1 - Permitir a pesquisa do endereço através do CEP
    procedure BuscarCep(const ACep: String; AApiProvider: IBuscaCepApiProvider);

    //Requisito US1.2 - Permitir a pesquisa através do endereco
    procedure BuscarEndereco(const AEndereco, ACidade, AUf: String; AApiProvider: IBuscaCepApiProvider);
    destructor Destroy; override;

{$REGION 'Fluent Builder Pattern'}
    function PlugarViewObserver(AView: IBuscaCepView): IBuscaCepDomain;
    function PlugarDatabaseRepository(ADatabaseRepository: IDatabaseRepository): IBuscaCepDomain;
{$ENDREGION}

  private
    FView: IBuscaCepView;
    FDatabaseRepository: IDatabaseRepository;

{$REGION 'Estrategia Api'}
    procedure BuscarCepApi(const ACep: String; AApiProvider: IBuscaCepApiProvider);
    procedure BuscarEnderecoApi(const AEndereco, ACidade, AUf: String; AApiProvider: IBuscaCepApiProvider);
{$ENDREGION}

{$REGION 'Estrategia DB'}
    function  PesquisarCepDb<T: TDataset>(ACep: String): IResult<TDataset>;
    function  PesquisarEnderecoDb<T: TDataset>(AEndereco, ACidade, AUf: String): IResult<TDataset>;
    procedure Persistir(ACep: TEndereco);
    procedure ExibirCepEnderecoEncontrado(ADataset: TDataset);
{$ENDREGION}

  protected
    procedure Receive(ADataset: TDataset);

    //Trata um Stream que contém apenas um registro
    procedure Response(AResponse: TCepResponse);

    //Trata um Stream que contém um array com vários registros
    procedure ResponseMany(AResponse: TCepResponse);

  published

    property View: IBuscaCepView read FView;
    property DatabaseRepository: IDatabaseRepository read FDatabaseRepository;

  end;

implementation

uses
  Dataset.Utils,
  Vcl.Dialogs,
  Vcl.Controls,
  System.SysUtils,
  System.UITypes,
  Strings.Utils,
  Interf.Iterator,
  Dataset.Iterator.Concrete, System.Generics.Collections;

function TBuscaCepService.PesquisarCepDb<T>(ACep: String): IResult<TDataset>;
var
  Resultado: TDataset;
begin
  Resultado := DatabaseRepository.BuscarCep(ACep);
  if Resultado.RecordCount > 0 then
  begin
    FView.ExibirCepDb( Resultado );
    Result := TResult<TDataset>.New(Resultado);
  end else
    Result := TResult<TDataset>.Vazio;

end;

function TBuscaCepService.PesquisarEnderecoDb<T>(AEndereco, ACidade, AUf: String): IResult<TDataset>;
var
  Resultado: TDataset;
begin
  Resultado := DatabaseRepository.BuscarEndereco(AEndereco, ACidade, Copy(AUf, 1, 2));
  if Resultado.RecordCount > 0 then
  begin
    FView.ExibirCepDb( Resultado );

    Result := TResult<TDataset>.New(Resultado);
  end else
    Result := TResult<TDataset>.Vazio;
end;

//procedure TBuscaCepService.ExibirCepEnderecoEncontrado(aValue: TDataset);
//var AEnderecoDto: TEnderecoDto;
//begin
//  AEnderecoDto := TSuperDataset.Parse<TEnderecoDto>(AValue);
//  FView.ExibirCepDto(AEnderecoDto);
//  FreeAndNil(AEnderecoDto);
//end;

procedure TBuscaCepService.ExibirCepEnderecoEncontrado(ADataset: TDataset);
var
  AEnderecoDto: TEnderecoDto;
  AIterator: IIterator<TEnderecoDto>;

begin
  AIterator := TDatasetIterator<TEnderecoDto>.Create(ADataset);
  for AEnderecoDto in AIterator do
  begin
    FView.ExibirCepDto(AEnderecoDto);
  end;
end;

procedure TBuscaCepService.Persistir(ACep: TEndereco);
begin
  if Assigned(ACep) then
  begin
    DatabaseRepository.ExcluirCep(ACep.Cep);
    DatabaseRepository.IncluirEndereco(Acep.Cep, ACep.Logradouro, ACep.Complemento, ACep.Bairro, ACep.Cidade, ACep.UF);
  end;
end;

function TBuscaCepService.PlugarDatabaseRepository(ADatabaseRepository: IDatabaseRepository): IBuscaCepDomain;
begin
  FDatabaseRepository := ADatabaseRepository;
  Result := Self;
end;

function TBuscaCepService.PlugarViewObserver(AView: IBuscaCepView): IBuscaCepDomain;
begin
  FView := AView;
  Result := Self;
  //A View é notificada sempre que encontrar um novo CEP
end;

procedure TBuscaCepService.Receive(ADataset: TDataset);
var
  AEnderecoApi: TEndereco;
  AIterator: IIterator<TEndereco>;

begin
  AIterator := TDatasetIterator<TEndereco>.Create(ADataset);
  for AEnderecoApi in AIterator do
  begin
    FView.ExibirCepDb(ADataset);
    Persistir(AEnderecoApi);
    FView.ExibirCepApi(AEnderecoApi);
  end;

end;

procedure TBuscaCepService.Response(AResponse: TCepResponse);
var
  AEndereco: TEndereco;
begin
  case AResponse.Estrategia of
    xml: AEndereco := TXmlStrategy.Parse<TEndereco>(AResponse.content);
    json: AEndereco:= TJsonStrategy.Parse<TEndereco>(AResponse.content);
    else
      AEndereco := nil;
  end;

  if Assigned(AEndereco) then
    FreeAndNil(AEndereco)
end;

procedure TBuscaCepService.ResponseMany(AResponse: TCepResponse);
var
  AEndereco: TObjectList<TEndereco>;
begin
  case AResponse.Estrategia of
    xml: AEndereco := TXmlStrategy.ParseArray<TEndereco>(AResponse.content);
//    json: AEndereco:= TJsonStrategy.ParseArray<TEndereco>(AResponse.content);
    else
      AEndereco := nil;
  end;

  if Assigned(AEndereco) then
    FreeAndNil(AEndereco)
end;

// Requisito US1.1 - Permitir a pesquisa do endereço através do CEP
procedure TBuscaCepService.BuscarCep(const ACep: String; AApiProvider: IBuscaCepApiProvider);
var CepDbLocal: IResult<TDataset>;
begin
  CepDbLocal := PesquisarCepDb<TDataset>(ACep);
  if CepDbLocal.Encontrou then
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
         MrYes: ExibirCepEnderecoEncontrado(CepDbLocal.Consume);
         MrNo: BuscarCepApi(ACep, AApiProvider);
    end;

  end
  else begin
  // CA1.1 Pesquisar o endereço através do CEP quando o mesmo não existir na base de dados

  // Neste caso, deverá (a) Buscar no WS (api viacep) utilizando o CEP informado
  // (b) E armazenar o resultado na tabela consultas que foi criada

    BuscarCepApi(ACep, AApiProvider); // async   aguarda o retorno do servidor ...

    // Nota do desenvolvedor: Ao retornar, o evento _OnReceiveOne será disparado
    // Este evento está programado para armazenar o resultado no banco de dados
  end;
    CepDbLocal := nil;
end;


procedure TBuscaCepService.BuscarEndereco(const AEndereco, ACidade, AUf: String; AApiProvider: IBuscaCepApiProvider);

var
  CepDbLocal: IResult<TDataset>;

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

  CepDbLocal := PesquisarEnderecoDb<TDataset>(AEndereco, ACidade, Copy(AUf, 1, 2));
  if CepDbLocal.Encontrou then
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
         MrYes: ExibirCepEnderecoEncontrado(CepDbLocal.Consume);
         MrNo: BuscarEnderecoApi(AEndereco, ACidade, AUf, AApiProvider);
    end;

  end
  else begin
  // CA1.2 - Pesquisar o Endereço através do endereço completo
  // DADO a pesquisa por Endereço Completo
  //  E os campos informados forem maiores que 3 caracteres
  //  E o endereço não existir registrado na base de dados

  // Neste caso, deverá (a) efetuar uma consulta através do WS utilizando o Endereço Completo
  // (b) E armazenar o resultado na tabela consultas que foi criada

    BuscarEnderecoApi(AEndereco, ACidade, AUf, AApiProvider); // async   aguarda o retorno do servidor ...

    // Nota do desenvolvedor: Ao retornar, o evento _OnReceiveOne será disparado
    // Este evento está programado para armazenar o resultado no banco de dados
  end;
    CepDbLocal := nil;
 end;

procedure TBuscaCepService.BuscarCepApi(const ACep: String; AApiProvider: IBuscaCepApiProvider);
begin
  AApiProvider.SetOnReceive(Receive);
  AApiProvider.SetOnResponse(Response);
  AApiProvider.SetOnResponseMany(ResponseMany);
  AApiProvider.BuscarCep(ACep); //async await -> Ao retornar, dispara o evento OnReceived
end;

procedure TBuscaCepService.BuscarEnderecoApi(const AEndereco, ACidade, AUf: String; AApiProvider: IBuscaCepApiProvider);
begin
  AApiProvider.SetOnReceive(Receive);
  AApiProvider.SetOnResponse(Response);
  AApiProvider.SetOnResponseMany(ResponseMany);
  AApiProvider.BuscarEndereco(AEndereco, ACidade, Copy(AUf, 1, 2));
end;

destructor TBuscaCepService.Destroy;
begin

  inherited;

  FView := nil;
  FDatabaseRepository := nil;
end;

//   View  --> Controller --> [ SERVICE ] --> Infra {Xml, Json, Database}

end.
