unit interf.View;

interface

uses
  Data.DB,
  Model.Cep;

type
  ICepView = Interface
  ['{04BF4D85-66B8-4788-BCF2-0297D7EC9180}']
     procedure Notify (message: String; Logradouro, Localidade, Uf: String);
     procedure PlugDataset(ADataset: TDataset);
     procedure ExibirCepBD(ACepBD: TEnderecoDto);
     procedure ExibirCepWS(ACepWS: TEndereco);
  end;

implementation

end.
