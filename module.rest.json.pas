unit module.rest.json;

interface

uses
  System.SysUtils,
  System.Classes,
  Strategy,
  module.rest.suport,
  IPPeerClient,
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
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Model.Cep;

type
  TApiJson = class(TApi, IJsonContent)
    RESTResponseAdapter: TRESTResponseDataSetAdapter;
    MemTableResponse: TFDMemTable;
    function JsonContent: String;
    procedure BuscarEndereco(const AEndereco, ACidade, AUf: String); override;

  protected
    function GetResponse: TCepResponse; override;
    function GetDataset: TDataset; override;
  end;

var
  ApiJson: TApiJson;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

function TApiJson.GetDataset: TDataset;
begin
  Result := MemTableResponse
end;

procedure TApiJson.BuscarEndereco(const AEndereco, ACidade, AUf: String);
begin
  RestResponseAdapter.Response := RESTResponseEndereco;
  inherited;
end;

function TApiJson.JsonContent: String;
begin
  Result := GetString;
end;

function TApiJson.getResponse: TCepResponse;
begin
  inherited;
  Result.Content := JsonContent;
  Result.Estrategia := TEstrategiaRequest.Json;
end;

//   View  --> Controller --> Service --> [ INFRA {Json} ]

end.
