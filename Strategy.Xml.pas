unit Strategy.Xml;

interface

uses
  Strategy,
  Xml.XMLIntf,
  System.Generics.Collections;

type
  TXmlStrategy = class
    class function Parse<T: class, constructor>(XmlContent: String): T;
    class function ParseArray<T: class, constructor>(XmlContent: String): TObjectList<T>;

  private
    class function ParseItem<T: class, constructor>(XmlNode: IXMLNode): T;

  end;

implementation

uses
  System.Rtti,
  Xml.XMLDoc,
  System.SysUtils,
  System.Variants;

{ TXmlStrategy }

class function TXmlStrategy.parse<T>(Xmlcontent: String): T;
var
  Xmldocument: IXmlDocument;
  RootNode: IXMLNode;
  NodeValue: IXMLNode;
begin
  Xmldocument := TXMLDocument.Create(nil);
  XMLDocument.LoadFromXML(xmlcontent);
  XMLDocument.Active := True;

  // Obtendo o nó raiz <xmlcep>
  RootNode := XMLDocument.DocumentElement;

  if not Assigned(RootNode) then
    raise Exception.Create('XML inválido.');

  if xmldocument.DocumentElement.ChildValues[0] = 'true' then
    raise Exception.Create('Cep não encontrado');

    if not Assigned(RootNode) then
      raise Exception.Create('Nó raiz não encontrado.');

  // Uma alternativa é chamar de forma nominal, mas eu prefiro uma forma mais automatizada orientada a Model , como se verá abaixo
  // FCep := XMLDocument.DocumentElement.ChildNodes['cep'].Text;
  // FLogradouro := XMLDocument.DocumentElement.ChildNodes['logradouro'].Text;
  // FBairro := XMLDocument.DocumentElement.ChildNodes['bairro'].Text;
  // FCidade := XMLDocument.DocumentElement.ChildNodes['localidade'].Text;
  // FUF := XMLDocument.DocumentElement.ChildNodes['uf'].Text;

  Result := parseitem<T>(rootNode);

end;

class function TXmlStrategy.parseitem<T>(xmlNode: IXMLNode): T;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  Field: TRttiField;
  NodeValue: IXMLNode;
  nomeField: String;
begin
  Result := T.Create;
  Context := TRttiContext.Create;
  try
    try
      RttiType := Context.GetType(TClass(Result.ClassType));

      for Field in RttiType.GetFields do
      begin
        nomeField := copy(Field.Name, 2);
        if xmlNode.ChildNodes.FindNode(nomeField) <> nil then
        begin
          NodeValue := xmlNode.ChildNodes[nomeField].NextSibling;

          case Field.FieldType.TypeKind of
            tkUString, tkString, tkLString, tkWString:
              Field.SetValue(Pointer(Result), NodeValue.Text);
            tkInteger:
              Field.SetValue(Pointer(Result), StrToIntDef(NodeValue.Text, 0));
            tkFloat:
              if Field.FieldType.Handle = TypeInfo(TDateTime) then
                Field.SetValue(Pointer(Result), VarToDateTime(NodeValue.Text))
              else
                Field.SetValue(Pointer(Result),
                  StrToFloatDef(NodeValue.Text, 0));
            tkEnumeration:
              if Field.FieldType.Handle = TypeInfo(Boolean) then
                Field.SetValue(Pointer(Result), SameText(NodeValue.Text, 'true')
                  or (NodeValue.Text = '1'))
              else
                continue;
          else
            continue;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        Result.Free;
        raise Exception.Create('Erro ao processar o XML: ' + E.Message);
      end;
    end;
  finally
    Context.Free;
  end;
end;


class function TXmlStrategy.ParseArray<T>(xmlcontent: String): TObjectList<T>;
var
  xmldocument: IXmlDocument;
  RootNode: IXMLNode;
  NodeValue: IXMLNode;
  EnderecosNode: IXMLNode;
  ItemNode: IXMLNode;
  i: Integer;
  Item: T;
begin
  xmldocument := TXMLDocument.Create(nil);
  XMLDocument.LoadFromXML(xmlcontent);
  XMLDocument.Active := True;

  // Obtendo o nó raiz <xmlcep>
  RootNode := XMLDocument.DocumentElement;

  if not Assigned(RootNode) then
    raise Exception.Create('XML inválido.');

  // Uma alternativa é chamar de forma nominal, mas eu prefiro uma forma mais automatizada orientada a Model , como se verá abaixo
  // FCep := XMLDocument.DocumentElement.ChildNodes['cep'].Text;
  // FLogradouro := XMLDocument.DocumentElement.ChildNodes['logradouro'].Text;
  // FBairro := XMLDocument.DocumentElement.ChildNodes['bairro'].Text;
  // FCidade := XMLDocument.DocumentElement.ChildNodes['localidade'].Text;
  // FUF := XMLDocument.DocumentElement.ChildNodes['uf'].Text;
  EnderecosNode := RootNode.ChildNodes.FindNode('enderecos');
  Result := TObjectList<T>.Create;

  for I := 0 to RootNode.ChildNodes.Count - 1 do
    begin
//      FieldNode := RootNode.ChildNodes[I];
//      FieldName := FieldNode.NodeName;
//      FieldValue := Trim(FieldNode.Text);
//
//      // Cria campos do tipo string dinamicamente
//      MemTable.FieldDefs.Add(FieldName, Data.DB.FtString, 255);
    end;

  for i := 0 to EnderecosNode.ChildNodes.Count - 1 do
  begin
    ItemNode := EnderecosNode.ChildNodes[i];
    if ItemNode.NodeName = 'endereco' then
    begin
      item := parseitem<T>(ItemNode);
      Result.add(item);
    end;
  end;

end;

end.
