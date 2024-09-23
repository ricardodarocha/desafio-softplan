unit strings.utils;

interface

uses
  System.SysUtils;

function somentenumeros(value: String): String;
function TiraAcentos(const Texto: String): String;

implementation

uses
  System.Classes;

function somentenumeros(value: String): String;

var
  numero: char;
begin
  result := emptyStr;
  for numero in value do
  begin
    if numero in ['0' .. '9'] then
      result := result + numero;
  end;
end;


function TiraAcentos(const Texto: String): String;
const
  Acentos   = 'áéíóúÁÉÍÓÚàèìòùÀÈÌÒÙäëïöüÄËÏÖÜãõÃÕâêîôûÂÊÎÔÛçÇñÑ';
  Normais   = 'aeiouAEIOUaeiouAEIOUaeiouAEIOUaoAOaeiouAEIOUcCnN';

var
  a: Integer;

begin
  Result := '';
  for a := 1 to Length(Texto) do
    if Pos(Texto[a], Acentos) > 0 then
      Result := Result + Normais[Pos(Texto[a], Acentos)]
    else
      Result := Result + Texto[a];

end;

end.
