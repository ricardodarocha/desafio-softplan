unit interf.Controller;

interface

uses
  Data.Db,
  System.Classes,
  Interf.Domain;

type

  ICepController = interface
    ['{90E60487-E028-46B2-82DD-4BC0FB153A27}']


    procedure SetOnReceive(const Value: TDatasetNotifyEvent);
    procedure SetOnReceiveAll(const Value: TDatasetNotifyEvent);
    function GetOnReceive: TDatasetNotifyEvent;
    function GetOnReceiveAll: TDatasetNotifyEvent;


    procedure BuscarCep(ACep: String; AModo: TModo);
    procedure BuscarEndereco(AUf: String; ACidade: String; AEndereco: String; AModo: TModo);
    procedure MostrarTodos;

    procedure DoReceive(ADataset: TDataset);
    procedure DoReceiveAll(ADataset: TDataset);

    property OnReceive: TDatasetNotifyEvent read GetOnReceive write SetOnReceive;
    property OnReceiveAll: TDatasetNotifyEvent read GetOnReceiveAll write SetOnReceiveAll;
  end;

implementation

end.
