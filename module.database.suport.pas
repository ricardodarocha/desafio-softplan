unit module.database.suport;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Interfaces,
  Model.Cep,
  Interf.Iterator;

type
  TDados = class(TDataModule, IDatabaseRepository)
    Conexao: TFDConnection;
    listar_todos: TFDQuery;
    busca_cep: TFDQuery;
    busca_endereco: TFDQuery;
  private
    procedure IncluirEndereco(ACep, ALogradouro, AComplemento, ABairro, ALocalidade, AUf: String);
    { Private declarations }
  public
    function SetupDatabase(const DatabaseFile: String = 'database/cepdb.sqlite'): IDatabaseRepository;
    function BuscarCep(const ACep: String): TDataset;
    function BuscarEndereco(const AEndereco, ACidade, AUf: String): TDataset;
    function MostrarTodos: TDataset;
    procedure ExcluirCep(ACep: String);
    procedure LimparTodos;
  end;

var
  Dados: Tdados;

implementation

uses
  Strings.Utils,
  Dataset.Iterator.Concrete;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDados }

function TDados.BuscarCep(const ACep: String): TDataset;
begin
   busca_cep.Close;
   busca_cep.ParamByName('cep').AsString := ACep;
   busca_cep.open;

   Result :=  busca_cep;
end;

function TDados.BuscarEndereco(const AEndereco, ACidade, AUf: String): TDataset;
begin
   busca_endereco.Close;
   busca_endereco.ParamByName('uf').AsString := AUf;
   busca_endereco.ParamByName('localidade').AsString := ACidade;
   busca_endereco.ParamByName('logradouro').AsString := AEndereco;
   busca_endereco.open;

   result :=  busca_endereco;
end;

procedure TDados.ExcluirCep(ACep: String);
begin
  Conexao.ExecSQL('delete from consultas where cep = :cep', [ ACep ]);
end;

procedure TDados.IncluirEndereco(ACep,
    ALogradouro,
    AComplemento,
    ABairro,
    ALocalidade,
    AUf: String);
begin
  Conexao.ExecSQL('insert into consultas (cep, logradouro, complemento, bairro, localidade, uf, logradouro_, localidade_)' +
  ' values (:cep, :logradouro, :complemento, :bairro, :localidade, :uf, :logradouro_normalizado, :localidade_normalizada)', [
    ACep,
    ALogradouro,
    AComplemento,
    ABairro,
    ALocalidade,
    AUf ,
    TiraAcentos(Alogradouro),
    TiraAcentos(ALocalidade)

     ]);
end;

procedure TDados.LimparTodos;
begin
    Conexao.ExecSQL('delete from consultas');
end;

function TDados.SetupDatabase(const DatabaseFile: String): IDatabaseRepository;
begin
  Result := self;
  Conexao.Params.Database := DatabaseFile;
  Conexao.Connected := true;
end;


function TDados.MostrarTodos: TDataset;
begin

   listar_todos.Close;
   listar_todos.open;

   Result :=  listar_todos;
end;

//   View  --> Controller --> Service --> [ INFRA {Database} ]

end.
