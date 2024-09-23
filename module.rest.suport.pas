unit module.rest.suport;

/// Esta Unit adiciona suporte à REST, respeitando a arquitetura DDD de módulos e infraestrutura
///  e de acordo com os princípios SOLID

interface

uses
  System.SysUtils,
  IPPeerClient,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  REST.Response.Adapter,
  System.Classes,
  Strings.Utils,
  Model.Cep,
  Interfaces;

type
  TApi = class(TDataModule, IBuscaCepApiProvider)
    RESTClient: TRESTClient;
    RESTRequestBuscaCep: TRESTRequest;
    RESTResponseCep: TRESTResponse;
    RESTRequestBuscaEndereco: TRESTRequest;
    RESTResponseEndereco: TRESTResponse;
  private
    FTipoRequisicao: TTipoRequest;
    procedure SetOnResponse(f: TProc<TCepResponse>);
    procedure SetOnResponseMany(f: TProc<TCepResponse>);
    procedure DoReceive(Dataset: TDataset);
  protected
    UltimoParametroInformado: String;
    FOnReceive: TDataSetNotifyEvent;
    FOnResponse: TProc<TCepResponse>;
    FOnResponseMany: TProc<TCepResponse>;
    function GetString: String;

    function GetDataset: TDataset; virtual;
    function GetResponse: TCepResponse; virtual; abstract;
  public
    function SetupBaseUrl(const BaseUrl: String = 'http://viacep.com.br/ws'): IBuscaCepApiProvider;
    procedure BuscarCep(const ACep: String);  virtual;
    procedure BuscarEndereco(const AEndereco, ACidade, AUf: String);  virtual;

    procedure SetOnReceive(e: TDatasetNotifyEvent);
    procedure SetOnReceiveAll(e: TDatasetNotifyEvent);

    property onResponse: TProc<TCepResponse> read FOnResponse;
    property onResponseMany: TProc<TCepResponse> read FOnResponseMany;

    //Este evento dispara quando receber a resposta do servidor. Desta forma a API pode ser consumida de forma assíncrona
    property OnReceive: TDataSetNotifyEvent read FOnReceive;

    property Response: TCepResponse read getResponse;
  end;

implementation

uses
  Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TApi }

procedure TApi.BuscarCep(const ACep: String);
var Resource: String;
begin
  FTipoRequisicao := TTipoRequest.Cep;
  RESTRequestBuscaCep.Params.ParameterByName('CEP').Value := somentenumeros(ACep);
  UltimoParametroInformado :=  format(' CEP %s', [ACep]);

  Resource := RESTRequestBuscaCep.Resource;

  RESTRequestBuscaCep.ExecuteAsync(
    procedure begin TThread.Queue(
    nil,
      procedure
      begin
        //aguarda a resposta do servidor
        Sleep(20);

        //notifica os Observers
        doreceive(GetDataset);

      end);
  end);

end;

procedure TApi.BuscarEndereco(const AEndereco, ACidade, AUf: String);
begin
  FTipoRequisicao := TTipoRequest.Endereco;
  RESTRequestBuscaEndereco.Params.ParameterByName('uf').Value := AUf;
  RESTRequestBuscaEndereco.Params.ParameterByName('localidade').Value := ACidade;
  RESTRequestBuscaEndereco.Params.ParameterByName('logradouro').Value := AEndereco;
  UltimoParametroInformado :=  format(' Endereço %s %s %s', [AEndereco, ACidade, AUf]);

  RESTRequestBuscaEndereco.ExecuteAsync(
    procedure begin TThread.Queue(
    nil,
      procedure
      begin
        //aguarda a resposta do servidor
        Sleep(20);

        //notifica os Observers
        doreceive(GetDataset);

      end);
  end);
end;

function TApi.GetDataset: TDataset;
begin
  Result := nil
end;

function TApi.GetString: String;
begin
  case FTipoRequisicao of
    cep: Result := RESTResponseCep.Content;
    endereco: Result := RESTResponseEndereco.Content;
    else raise Exception.Create('TipoDeRequisicao não implementado para Response Content em procedure TApi.DoReceive(Dataset: TDataset);');
  end;
end;

procedure TApi.DoReceive(Dataset: TDataset);
var
  StatusCode: Integer;

  procedure NaoEncontrado;
  begin
      ShowMessage(format(' O parâmetro informado não foi encontrado [%s]', [ UltimoParametroInformado ]));
  end;

begin
  // verifica o status da resposta

  case FTipoRequisicao of
    cep: StatusCode := RESTResponseCep.StatusCode;
    endereco: StatusCode := RESTResponseEndereco.StatusCode;
    else raise Exception.Create('TipoDeRequisicao não implementado para StatusCode em procedure TApi.DoReceive(Dataset: TDataset);');
  end;

  if StatusCode <> 200 then
    NaoEncontrado
  else
  begin
    if DataSet.RecordCount = 0 then
      NaoEncontrado
    else
    begin
      if Assigned(FOnReceive) then
        FOnReceive(DataSet)
      else
        ShowMessage
          ('200 OK. Conecte o evento OnReceive para receber a visualização da resposta');

      case FTipoRequisicao of
        Cep:
          if Assigned(FOnResponse) then
            FOnResponse(Response)
          else
            ShowMessage
              ('200 OK. Conecte o evento OnResponse para receber o string');
        endereco:
          if Assigned(FOnResponseMany) then
            FOnResponseMany(Response)
          else
            ShowMessage
              ('200 OK. Conecte o evento OnResponseMany para receber o string');

        else
            ShowMessage
              ('TipoDeRequisicao não implementado em FOnResponse procedure TApi.DoReceive(Dataset: TDataset)');
      end;
    end;
  end;
end;

procedure TApi.SetOnResponse(f: TProc<TCepResponse>);
begin
  FOnResponse := f;
end;

procedure TApi.SetOnResponseMany(f: TProc<TCepResponse>);
begin
  FOnResponseMany := f;
end;

procedure TApi.SetOnReceive(e: TDatasetNotifyEvent);
begin
  FOnReceive := e;
end;

procedure TApi.SetOnReceiveAll(e: TDatasetNotifyEvent);
begin
   {Todo!} ;
end;

function TApi.SetupBaseUrl(const baseUrl: String): IBuscaCepApiProvider;
begin
  if RESTClient.BaseURL <> baseUrl then
    RESTClient.BaseURL := baseUrl;
  Result := Self;
end;

//   View  --> Controller --> Service --> [ INFRA {Rest} ]

end.
