unit cep.xml.concrete;

interface

uses
  System.SysUtils, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, Xml.Win.msxmldom;



implementation

{ TEndereco }

constructor TEndereco.Create(const Cep: string);
begin
  FCep := Cep;
  proLocalizaCep;
end;

procedure TEndereco.proLocalizaCep;
resourcestring
  __rINFORME_NR_CEP = 'Informe o n�mero do cep.';
  __rCEP_INVALIDO = 'O n�mero do CEP deve ser composto por 8 bytes.';
  __rCEP_NAO_ENCONTRADO = 'Cep n�o encontrado.';
const
  _rCep = 'cep';
  _rLogradouro = 'logradouro';
  _rBairro = 'bairro';
  _rLocalidade = 'localidade';
  _rUF = 'uf';
  _rWS = 'https://viacep.com.br/ws/';
  _rXML = '/xml/';
  _rERRO = 'erro';
  _rTrue = 'true';
var
  _rDXML: IXMLDocument;
begin
  FCep := StringReplace(Cep, '-', '', [rfReplaceAll]).Trim;
  if Cep.IsEmpty then
    raise Exception.Create(__rINFORME_NR_CEP);

  if Cep.Length <> 8 then
    raise Exception.Create(__rCEP_INVALIDO);


  _rDXML := TXMLDocument.Create(nil);
  try
    _rDXML.FileName := _rWS + Cep + _rXML;
    _rDXML.Active := True;
    { Quando consultado um CEP de formato v�lido, por�m inexistente, }
    { por exemplo: "99999999", o retorno conter� um valor de "erro"  }
    { igual a "true". Isso significa que o CEP consultado n�o foi    }
    { encontrado na base de dados. https://viacep.com.br/            }

    if _rDXML.DocumentElement.ChildValues[0] = _rTrue then
      raise Exception.Create(__rCEP_NAO_ENCONTRADO);

    FCep := _rDXML.DocumentElement.ChildNodes[_rCep].Text;
    FLogradouro := _rDXML.DocumentElement.ChildNodes[_rLogradouro].Text;
    FBairro := _rDXML.DocumentElement.ChildNodes[_rBairro].Text;
    FCidade := _rDXML.DocumentElement.ChildNodes[_rLocalidade].Text;
    FUF := _rDXML.DocumentElement.ChildNodes[_rUF].Text;
  finally
    _rDXML := nil;
  end;
end;

end.
