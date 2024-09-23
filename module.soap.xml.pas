unit module.soap.xml;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Rtti,
  Strategy,
  Module.Rest.Suport,
  IPPeerClient,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  REST.Response.Adapter,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Xml.XMLDoc,
  Xml.XMLIntf,
  System.TypInfo,
  Xml.xmldom,
  Datasnap.DBClient,
  Datasnap.Provider,
  Datasnap.Xmlxform,
  Model.Cep;

type
  TApiXml = class(TApi, IXmlContent)
    FDMemTableXml: TFDMemTable;
    function XmlContent: String;
  private
    procedure LoadXMLToFDMemTable(const XmlContent: string; MemTable: TFDMemTable);
    procedure LoadXMLArrayToFDMemTable(const XmlContent: string; MemTable: TFDMemTable);

    protected
    function GetDataset: TDataset; override;
    function GetResponse: TCepResponse; override;
  end;

var
  ApiXml: TApiXml;

implementation

uses
  System.Variants,
  Vcl.Dialogs,
  Strings.Utils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TapiXml }

function TApiXml.GetDataset: TDataset;
begin
  Result := FDMemTableXml;
  try
    if pos('<enderecos>', XmlContent) > 0 then
      LoadXMLArrayToFDMemTable(XmlContent, FDMemTableXml)
    else
      LoadXMLToFDMemTable(XmlContent, FDMemTableXml);
  finally

  end;
end;

function TApiXml.GetResponse: TCepResponse;
begin
  inherited;
  Result.Content := XmlContent;
  Result.Estrategia := TEstrategiaRequest.Xml;
end;

function TApiXml.XmlContent: String;
begin
  Result := GetString
end;

procedure TApiXml.LoadXMLToFDMemTable(const XmlContent: string; MemTable: TFDMemTable);
var
  XMLDocument: IXMLDocument;
  RootNode, FieldNode: IXMLNode;
  FieldName, FieldValue: string;
  I: Integer;
begin
  // Cria e carrega o documento XML
  XMLDocument := TXMLDocument.Create(nil);
  try
    XMLDocument.LoadFromXML(XMLContent);
    XMLDocument.Active := True;

    // Obtém o nó raiz <xmlcep>
    RootNode := XMLDocument.DocumentElement;
    if not Assigned(RootNode) then
      raise Exception.Create('Nó raiz <xmlcep> não encontrado.');

    // Abre a tabela para adicionar campos
    MemTable.Close;
    MemTable.FieldDefs.Clear;

    // Percorre os campos do nó raiz para criar dinamicamente os campos do MemTable
    for I := 0 to RootNode.ChildNodes.Count - 1 do
    begin
      FieldNode := RootNode.ChildNodes[I];
      FieldName := FieldNode.NodeName;
      FieldValue := Trim(FieldNode.Text);

      // Cria campos do tipo string dinamicamente
      MemTable.FieldDefs.Add(FieldName, Data.DB.FtString, 255);
    end;

    // Cria a estrutura da tabela e adiciona um registro
    MemTable.CreateDataSet;
    MemTable.Append;

    // Preenche os campos com os valores do XML
    for I := 0 to RootNode.ChildNodes.Count - 1 do
    begin
      FieldNode := RootNode.ChildNodes[I];
      FieldName := FieldNode.NodeName;
      FieldValue := Trim(FieldNode.Text);

      // Atribui os valores aos campos correspondentes
      MemTable.FieldByName(FieldName).AsString := FieldValue;
    end;

    // Confirma a inclusão do registro
    MemTable.Post;
  finally
    XMLDocument := nil;
  end;
end;

procedure TApiXml.LoadXMLArrayToFDMemTable(const XmlContent: string; MemTable: TFDMemTable);
var
  XMLDocument: IXMLDocument;
  RootNode, EnderecosNode, EnderecoNode, FieldNode: IXMLNode;
  FieldName, FieldValue: string;
  I, J: Integer;
begin
  // Cria e carrega o documento XML
  XMLDocument := TXMLDocument.Create(nil);
  XMLDocument.LoadFromXML(XmlContent);
  XMLDocument.Active := True;

  // Obtém o nó raiz <xmlcep>
  RootNode := XMLDocument.DocumentElement;
  if not Assigned(RootNode) then
    raise Exception.Create('Nó raiz <xmlcep> não encontrado.');

  // Obtém o nó <enderecos>
  EnderecosNode := RootNode.ChildNodes.FindNode('enderecos');
  if not Assigned(EnderecosNode) then
    raise Exception.Create('Nó <enderecos> não encontrado.');

  // Limpa a estrutura do TFDMemTable
  MemTable.Close;
  MemTable.FieldDefs.Clear;

  // Cria os campos dinamicamente com base no primeiro <endereco>
  if EnderecosNode.ChildNodes.Count > 0 then
  begin
    EnderecoNode := EnderecosNode.ChildNodes[0]; // Primeiro endereço
    for I := 0 to EnderecoNode.ChildNodes.Count - 1 do
    begin
      FieldNode := EnderecoNode.ChildNodes[I];
      FieldName := FieldNode.NodeName;

      // Cria campos do tipo string (ajustar conforme necessidade)
      MemTable.FieldDefs.Add(FieldName, Data.DB.FtString, 255);
    end;
  end;

  // Cria a estrutura da tabela
  MemTable.CreateDataSet;

  // Preenche a tabela com os registros do XML
  for I := 0 to EnderecosNode.ChildNodes.Count - 1 do
  begin
    EnderecoNode := EnderecosNode.ChildNodes[I];
    MemTable.Append;

    for J := 0 to EnderecoNode.ChildNodes.Count - 1 do
    begin
      FieldNode := EnderecoNode.ChildNodes[J];
      FieldName := FieldNode.NodeName;
      FieldValue := Trim(FieldNode.Text);
      MemTable.FieldByName(FieldName).AsString := FieldValue;
    end;

    MemTable.Post;
  end;
end;

//   View  --> Controller --> Service --> [ INFRA {Xml} ]

end.
