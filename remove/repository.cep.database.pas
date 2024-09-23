unit repository.cep.database;

interface

uses
  Model.cep,
  Interfaces,
  Interf.Iterator,
  Data.Db,
  System.Classes,
  dataset.utils;

type

  TDatabaseCepRepository = class(TinterfacedObject)
  private
    FProvider: IDatabaseRepository;
    FOnReceive: TNotifyEvent;
    FOnReceiveAll: TNotifyEvent;

  published
    constructor Create(ADatabaseProvider: IDatabaseRepository);

    function BuscarCep(ACep: String): TEnderecoDto;
    function BuscarEndereco(AUf: String; ACidade: String; AEndereco: String) : IIterator<TEnderecoDto>;

  end;

implementation

uses
  dataset.iterator.concrete;

{ TDatabaseCepRepository }

constructor TDatabaseCepRepository.Create(ADatabaseProvider: IDatabaseRepository);
begin
  FProvider := ADatabaseProvider;
end;

function TDatabaseCepRepository.BuscarCep(ACep: String): TEnderecoDto;
var
  ADataset : TDataset;
begin
  ADataset := FProvider.BuscarCep(ACep);
  Result := TSuperDataset.parse<TEnderecoDto>(ADataset);
end;

function TDatabaseCepRepository.BuscarEndereco(AUf, ACidade, AEndereco: String): IIterator<TEnderecoDto>;

begin
  Result := FProvider.BuscarEndereco(AUf, ACidade, AEndereco);
end;

end.
