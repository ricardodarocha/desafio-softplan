unit CepMapperComponent;

interface

uses
  System.SysUtils,
  System.Classes,
  Model.Cep;

  // Este componente nao visual perite ligar um modelo TEndereco proveniente do
  // Banco de dados TDtoEndereco ou de outras fontes TEndereco;

type
  TCepMapperComponent = class(TComponent)
  private

    FCep: string;
    FLogradouro: string;
    FBairro: string;
    FLocalidade: string;
    FRegiao: string;
    FUf: string;
    FEstado: string;
    FIbge: string;
  protected
    { Protected declarations }
  public
    function Parse(Value: TEnderecoDto): Boolean; overload;
    function Parse(Value: TEndereco): Boolean; overload;
  published
    property Cep: string read FCep;
    property Logradouro: string read FLogradouro;
    property Bairro: string read FBairro;
    property Localidade: string read FLocalidade;
    property Regiao: string read FRegiao;
    property Uf: string read FUf;
    property Estado: string read FEstado;
    property Ibge: string read FIbge;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TCepMapperComponent]);
end;

{ TCepMapperComponent }

function TCepMapperComponent.Parse(Value: TEndereco): Boolean;
begin
  if not Assigned(Value) then
    exit(false);

  Self.FCep := Value.Cep;
  Self.FLogradouro := Value.Logradouro;
  Self.FBairro := Value.Bairro;
  Self.FLocalidade := Value.Cidade;
  Self.FRegiao := Value.Regiao;
  Self.FUf := Value.Uf;
  Self.FEstado := Value.Estado;
  Self.FIbge := Value.Ibge;

  result := true;
end;

function TCepMapperComponent.Parse(Value: TEnderecoDto): Boolean;
begin

  if not Assigned(Value) then
    exit(false);

  Self.FCep := Value.Cep;
  Self.FLogradouro := Value.Logradouro;
  Self.FBairro := Value.Bairro;
  Self.FLocalidade := Value.Localidade;
  Self.FRegiao := Value.Regiao;
  Self.FUf := Value.Uf;
  Self.FEstado := Value.Estado;
  Self.FIbge := Value.Ibge;

  result := true;
end;

end.