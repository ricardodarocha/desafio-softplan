unit repository.cep.api;

interface

uses
  Model.cep,
  Interfaces,
  Data.Db,
  System.Classes;

type

  TJsonCepRepository = class(TinterfacedObject)
  private
    FProvider: IBuscaCepApiProvider;
    FOnReceive: TNotifyEvent;
    FOnReceiveAll: TNotifyEvent;
    procedure SetOnReceive(const Value: TNotifyEvent);
    procedure SetOnReceiveAll(const Value: TNotifyEvent);
  published
    constructor Create(AApiProvider: IBuscaCepApiProvider);

    /// Para a API trabalhar assíncrona, vamos conectar o evento OnReceive e OnReceiveAll
    procedure getByCep(ACep: String);
    procedure getByEndereco(AUf: String; ACidade: String; AEndereco: String);

    procedure DoReceive(ADataset: TDataset);
    procedure DoReceiveAll(ADataset: TDataset);

    property OnReceive: TNotifyEvent read FOnReceive write SetOnReceive;
    property OnReceiveAll: TNotifyEvent read FOnReceiveAll write SetOnReceiveAll;
  end;



implementation

{ TJsonCepRepository }

constructor TJsonCepRepository.Create(AApiProvider: IBuscaCepApiProvider);
begin
  FProvider := AApiProvider;
end;

procedure TJsonCepRepository.DoReceive(ADataset: TDataset);
begin
   if Assigned (FOnReceive) then FOnReceive(ADataset);

end;

procedure TJsonCepRepository.DoReceiveAll(ADataset: TDataset);
begin
   if Assigned (FOnReceiveAll) then FOnReceiveAll(ADataset);
end;

procedure TJsonCepRepository.getByCep(ACep: String);
begin
  FProvider.BuscarCep(ACep);
end;

procedure TJsonCepRepository.getByEndereco(AUf, ACidade, AEndereco: String);
begin
  FProvider.BuscarEndereco(AEndereco, AUf, ACidade);
end;

procedure TJsonCepRepository.SetOnReceive(const Value: TNotifyEvent);
begin
  FOnReceive := Value;
end;

procedure TJsonCepRepository.SetOnReceiveAll(const Value: TNotifyEvent);
begin
  FOnReceiveAll := Value;
end;

end.
