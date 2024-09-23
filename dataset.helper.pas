unit Dataset.Helper;

interface

  uses
    Data.Db,
    Interf.Iterator,
    Dataset.Iterator.Concrete;

type
  TDatasetHelper = class Helper for TDataset
    function IntoIterator<T: class, constructor>: IIterator<T>;
  end;

implementation

{ TDatasetHelper }

function TDatasetHelper.IntoIterator<T>: IIterator<T>;
begin
  Result := TDatasetIterator<T>.Create(Self);
end;

end.
