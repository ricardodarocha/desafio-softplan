unit interf.Database;

interface

uses
  Model.Cep,
  Interf.Iterator,
  Data.DB;

type
  IDatabase = interface
    ['{A6BAB9FA-CE84-46D3-8EF1-ADD7B64A3BD8}']

    function SetupDatabase(const DatabaseFile: String = 'database/cepdb.sqlite'): IDatabase;
    function BuscarCep(const ACep: String): TDataset;
    function MostrarTodos: TDataset;
    function BuscarEndereco(const AEndereco, ACidade, AUf: String): IIterator<TEnderecoDto>;
    procedure ExcluirCep(ACep: String);
    procedure IncluirEndereco(ACep, ALogradouro, AComplemento, ABairro, ALocalidade, AUf: String);

  end;

implementation



end.
