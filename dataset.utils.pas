unit dataset.utils;

interface

uses data.db;

type
  TSuperDataset = class
  public
    class function Parse<T: class, constructor>(ADataSet: TDataSet): T;
  end;

implementation

uses
  System.Rtti,
  System.TypInfo,
  System.SysUtils;

class function TSuperDataset.Parse<T>(ADataSet: TDataSet): T;
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  CampoObj: TRttiField;
  Valor: TValue;
  NomeCampo: String;
  Field: TField;
begin
  Result := T.Create;

  Contexto := TRttiContext.Create;
  try
    Tipo := Contexto.GetType(Result.ClassType);
    for CampoObj in Tipo.GetFields do
    begin
      NomeCampo := Copy(CampoObj.Name, 2);
      Field := ADataSet.FindField(NomeCampo);
      if Field <> nil then
      begin
        Valor := TValue.FromVariant(Field.Value);
        CampoObj.SetValue(Pointer(Result), Valor);
      end else if ADataSet.FindField(CampoObj.Name) <> nil then
      begin
        Field := ADataSet.FindField(CampoObj.Name);
        Valor := TValue.FromVariant(Field.Value);
        CampoObj.SetValue(Pointer(Result), Valor);
      end;
    end;
  finally
    Contexto.Free;
  end;
end;

end.
