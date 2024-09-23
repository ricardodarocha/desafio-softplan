unit jsonarray.iterator.concrete;

// Esta unit implementa um iterator para Json Array para qualquer T
// Esta não é a forma mais eficiente, porém como a api de CEP retorna
// no máximo 50 registros eu adotei esta abordagem

interface

uses SysUtils, interf.iterator, System.Json;

type
  TJsonIterator<T: constructor> = class(TInterfacedObject, IIterator<T>)
  private
    FArray: TJSONArray;
    FCurrentIndex: Integer;
    FCurrentItem: T;
  public
    constructor Create(AArray: TJSONArray);
    function MoveNext: Boolean;
    function GetCurrent: T;
  end;


  implementation
constructor TJsonIterator<T>.Create(AArray: TJSONArray);
begin
  FArray := AArray;
  FCurrentIndex := -1;
end;

function TJsonIterator<T>.MoveNext: Boolean;
begin
  Inc(FCurrentIndex);
  Result := FCurrentIndex < FArray.Count;
  if Result then
  begin
    FreeAndNil(FCurrentItem);
    FCurrentItem := T.Create;
    FCurrentItem.FromJSONObject(FArray.Items[FCurrentIndex] as TJSONObject);
  end;
end;

function TJsonIterator<T>.GetCurrent: T;
begin
  Result := FCurrentItem;
end;



end.

