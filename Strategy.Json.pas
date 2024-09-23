unit Strategy.Json;

interface

uses
  Strategy,
  System.Generics.Collections;

type
  TJsonStrategy = class
    class function Parse<T: class, constructor>(JsonContent: String): T;
    class function ParseArray<T: class, constructor>(JsonContent: String): TObjectList<T>;
  end;

implementation

  uses
    Rest.Json,
    System.Json,
    System.Classes;

{ TXmlStrategy }

class function TJsonStrategy.Parse<T>(JsonContent: String): T;
begin
  Result := TJson.JsonToObject<T>(JsonContent);
end;

class function TJsonStrategy.ParseArray<T>(JsonContent: String): TObjectList<T>;
var
  JSONArray: TJSONArray;
  Item: TJSONValue;
begin
  Result := TObjectList<T>.Create();
  try
    JSONArray := TJSONObject.ParseJSONValue(JsonContent) as TJSONArray;
    if Assigned(JSONArray) then
    try
      for Item in JSONArray do
        Result.Add(TJson.JsonToObject<T>(Item.ToString));
    finally
      JSONArray.Free;
    end;
  finally

  end;
end;

end.

