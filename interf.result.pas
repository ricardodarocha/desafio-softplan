unit interf.result;

interface

type

  TKind = (Encontrou, Vazio);

  // Esta interface encapsula um wraper seguro para tipos nulos
  IResult<T: class> = interface
    ['{B20FA165-8D8D-4644-9B7A-D029772C2147}']

    function Encontrou: Boolean;
    function Consume: T;
    function Match: TKind;

  end;

  TResult<T: class> = class(TInterfacedObject, IResult<T>)
    class function New(AValue: T): IResult<T>;
    class function Vazio: IResult<T>;
    destructor Destroy; override;

    function Encontrou: Boolean;
    function Consume: T;
    function Match: TKind;

  private
    FVazio: Boolean;
    FValue: T;
  end;

implementation

{ TResult<T> }

class function TResult<T>.New(AValue: T): IResult<T>;
begin
  Result := TResult<T>.Create;
  (Result as TResult<T>).FVazio := false;
  (Result as TResult<T>).FValue := AValue;
end;

class function TResult<T>.Vazio: IResult<T>;
begin
  Result := TResult<T>.Create;
  (Result as TResult<T>).FVazio := true;
  (Result as TResult<T>).FValue := nil;
end;

destructor TResult<T>.Destroy;
begin
  FValue := nil;
  inherited;
end;

function TResult<T>.Encontrou: Boolean;
begin
  Result := not FVazio
end;

function TResult<T>.Match: TKind;
begin
  if FVazio then
    Result := TKind.Vazio
  else
    Result := Tkind.Encontrou
end;

function TResult<T>.Consume: T;
begin
  Result := FValue;
end;

end.
