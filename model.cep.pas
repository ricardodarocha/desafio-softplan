unit model.cep;

interface

type

  TEndereco = class (TObject)
  private
    FCep: string;
    FLogradouro: string;
    FComplemento: string;
//    FUnidade: string;
    FBairro: string;
    FLocalidade: string; //Cidade
    FRegiao: string;
    FUf: string;
    FEstado: string;
    FIbge: string;
//    FGia: string;
//    FDdd: string;
//    FSiafi: string;

  public

    property Cep: string read FCep;
    property Logradouro: string read FLogradouro;
    property Complemento: string read FComplemento;
    property Bairro: string read FBairro;
    property Cidade: string read FLocalidade;
    property Estado: string read FEstado;
    property Regiao: String read FRegiao;
    property UF: string read FUf;
    property IBGE: string read FIbge;
  end;

  TEnderecoDto = class

    Cep: string;
    Logradouro: string;
    Bairro: string;
    Localidade: string;
    Regiao: string;
    Uf: string;
    Estado: string;
    Ibge: string;

    property Cidade: String read Localidade;

  end;

  TEstrategiaRequest = (xml, json);
  TTipoRequest = (cep, endereco);

//  TCepRequest = record
//    logradouro: String;
//    localidade: String;
//    uf: String;
//  end;

//  TEndrecoRequest = record
//    cep: String;
//  end;

  TCepResponse = record
    content: String;
    estrategia: TEstrategiaRequest;
  end;

implementation

end.
