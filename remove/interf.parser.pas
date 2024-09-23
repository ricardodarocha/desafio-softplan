unit interf.parser;

interface

uses
  System.Json;

type
  IParser<T> = interface
    ['{6AB6C34A-CDED-4FFB-95A7-AA2C97231231}']
    function FromJson(Ajson: TjsonObject): T;
    function FromJsonArray(AjsonArray: TJSONArray): TArray<T>;
    function FromXml(AXml: String): T;
    function FromXmlArray(AXmlArray: String): TArray<T>;
  end;

implementation

end.
