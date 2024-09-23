unit interf.Api;

interface

uses
  System.Classes, Data.DB;

type IApi = interface
  ['{84ABA6FD-D118-449E-8283-CBE44E6EF4FA}']
    function SetupBaseUrl(const BaseUrl: String = 'http://viacep.com.br/ws'): IApi;
    procedure BuscarCep(const ACep: String);
    procedure BuscarEndereco(const AEndereco, ACidade, AUf: String);
    procedure SetOnReceive(e: TDatasetNotifyEvent);
    procedure SetOnReceiveAll(e: TDatasetNotifyEvent);
end;

implementation

end.
