unit dataset.iterator.concrete;

// Esta unit implementa um iterator para Dataset, sendo na minha opinião
// a forma mais eficiente pois considera reutiliza o próprio recurso de cursor
// nativo do TDataset do Delphi

interface

uses
  SysUtils,
  interf.iterator,
  dataset.utils,
  Data.Db;

type
  TDatasetIterator<T: class, constructor> = class(TInterfacedObject, IIterator<T>)
  private
    FDataset: TDataset;
    FCurrentIndex: Integer;
    FCurrentItem: T;
  protected
    function GetCurrent: T;
    function GetEnumerator: IIterator<T>;
  public
    constructor Create(ADataset: TDataset);
    destructor Destroy; override;
    function MoveNext: Boolean;
    property Current: T read GetCurrent;
  end;

implementation

function TDatasetIterator<T>.GetEnumerator: IIterator<T>;
begin
  Result := Self;
end;

constructor TDatasetIterator<T>.Create(ADataset: TDataset);
begin
  FDataset := ADataset;
  FCurrentIndex := -1;
  if FDataset.Active then  
  FDataset.First;
end;

function TDatasetIterator<T>.MoveNext: Boolean;
begin
  Inc(FCurrentIndex);
  Result := FCurrentIndex < FDataset.RecordCount;
  if Result then
  begin
    if assigned (FCurrentItem) then FreeAndNil(FCurrentItem);
    FCurrentItem := TSuperDataset.Parse<T>(FDataset);
    FDataset.Next;
  end;
end;

destructor TDatasetIterator<T>.destroy;
begin
    if assigned (FCurrentItem) then FreeAndNil(FCurrentItem);
    FDataset := nil;

end;

function TDatasetIterator<T>.GetCurrent: T;
begin
  Result := FCurrentItem;
end;


end.
