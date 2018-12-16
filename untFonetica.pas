//Developer: Rafael Brendolan
unit untFonetica;

interface

type
  TFonetica = class
    private
      class function RemoveAcento(const Texto: String): String; static;
      class function RemoveVogaisELetraH(const Texto: String): String; static;
      class function RemoveCaracteresEspeciais(const Texto: String): String; static;
      class function SubstituiInicialUouWPorV(const Texto: String): String; static;
      class function RemoverLetraMRSFinal(const Texto: String): String; static;
      class function RemoverLetrasDuplicadas(const Text: String): String; static;
      class function RemoverEspacosExcessivos(const Texto: String): String; static;
      class function SubstituirLetras(const Texto: String): String; static;
    public
      class function GetCodigoFonetico(const Texto: String): String; static;
  end;

implementation

uses
  SysUtils, System.Generics.Collections;

{ TFonetica }

class function TFonetica.GetCodigoFonetico(const Texto: String): String;
begin
  Result := Trim(Texto);

  if Result = '' then
    Exit;

  Result := RemoverEspacosExcessivos(Result);

  Result := RemoveAcento(Result);

  Result := UpperCase(Result);

  Result := RemoveCaracteresEspeciais(Result);

  if Result = '' then
    Exit;

  Result := SubstituirLetras(Result);

  if Result = '' then
    Exit;

  Result := RemoverLetraMRSFinal(Result);

  if Result = '' then
    Exit;

  Result := RemoveVogaisELetraH(Result);

  if Result = '' then
    Exit;

  Result := SubstituiInicialUouWPorV(Result);

  if Result = '' then
    Exit;

  Result := RemoverLetrasDuplicadas(Result);
end;

class function TFonetica.SubstituirLetras(const Texto: String): String;
var
  Dicionario: TDictionary<string, string>;
  Chave: String;

  function PopularDicionario: TDictionary<string, string>;
  begin
    Result := TDictionary<string, string>.Create();

    Result.Add('Ç', 'S');
    Result.Add('BL', 'B');
    Result.Add('BR', 'B');
    Result.Add('PH', 'F');
    Result.Add('GL', 'G');
    Result.Add('GR', 'G');
    Result.Add('MG', 'G');
    Result.Add('NG', 'G');
    Result.Add('RG', 'G');
    Result.Add('Y', 'I');
    Result.Add('GE', 'J');
    Result.Add('GI', 'J');
    Result.Add('RJ', 'J');
    Result.Add('MJ', 'J');
    Result.Add('CA', 'K');
    Result.Add('CO', 'K');
    Result.Add('CU', 'K');
    Result.Add('CK', 'K');
    Result.Add('Q', 'K');
    Result.Add('N', 'M');
    Result.Add('AO', 'M');
    Result.Add('AUM', 'M');
    Result.Add('GM', 'M');
    Result.Add('MD', 'M');
    Result.Add('OM', 'M');
    Result.Add('ON', 'M');
    Result.Add('PR', 'P');
    Result.Add('L', 'R');
    Result.Add('CE', 'S');
    Result.Add('CI', 'S');
    Result.Add('CH', 'S');
    Result.Add('CS', 'S');
    Result.Add('RS', 'S');
    Result.Add('TS', 'S');
    Result.Add('X', 'S');
    Result.Add('Z', 'S');
    Result.Add('TR','T');
    Result.Add('TL','T');
    Result.Add('CT','T');
    Result.Add('RT','T');
    Result.Add('ST','T');
    Result.Add('PT','T');
  end;

begin
  Result := Texto;

  Dicionario := TDictionary<string, string>.Create();
  try
    Dicionario := PopularDicionario;

    for Chave in Dicionario.Keys.ToArray do
    begin
      Result := StringReplace(Result, Chave, Dicionario[Chave], [rfReplaceAll]);
    end;

  finally
    FreeAndNil(Dicionario);
  end;
end;

class function TFonetica.RemoveAcento(const Texto: String): String;
type
  ASCIIString = type AnsiString(20127);
begin
  Result := String(ASCIIString(Texto));
end;

class function TFonetica.RemoveCaracteresEspeciais(const Texto: String): String;
var
  i: Integer;
begin
  Result := Texto;

  for I := 1 to Length(Result) do
  begin
    if not CharInSet(Result[i], ['A'..'Z', '0'..'9']) then
    begin
      if (Length(Result) = i) then //Se for no fim da frase, delete
        System.Delete(Result, i, 1)
      else //Se não, adiciona um espaço
        Result[i] := ' ';
    end;
  end;
end;

class function TFonetica.RemoveVogaisELetraH(const Texto: String): String;
begin
  Result := Texto;

  Result := StringReplace(Result, 'A', '', [rfReplaceAll]);
  Result := StringReplace(Result, 'E', '', [rfReplaceAll]);
  Result := StringReplace(Result, 'I', '', [rfReplaceAll]);
  Result := StringReplace(Result, 'O', '', [rfReplaceAll]);
  Result := StringReplace(Result, 'U', '', [rfReplaceAll]);
  Result := StringReplace(Result, 'H', '', [rfReplaceAll]);
end;

class function TFonetica.RemoverEspacosExcessivos(const Texto: String): String;
var
  i: Integer;
begin
  Result := Texto;

  for i := 1 to Length(Result) do
  begin
    if ((Result[i] = ' ') and (Result[i+1] = ' ')) then //Se a atual é espaço e a próxima tmb
       System.Delete(Result, i, 1);
  end;

  Result := Trim(Result);
end;

class function TFonetica.RemoverLetraMRSFinal(const Texto: String): String;
var
  i: Integer;
begin
  Result := Texto;

  for i := 1 to Length(Result) do
  begin
    if CharInSet(Result[i], ['M', 'R', 'S']) and
      ((Result[i+1] = ' ') or (Length(Result) = i)) then
    begin
      System.Delete(Result, i, 1);
    end;
  end;
end;

class function TFonetica.RemoverLetrasDuplicadas(const Text: String): String;
var
  i: Integer;
begin
  Result := Text;

  for i := 1 to Length(Result) do
  begin
    if  i <> Length(Result) then
      if Result[i] = Result[i+1] then
      begin
        System.Delete(Result, i+1, 1);
      end;
  end;
end;

class function TFonetica.SubstituiInicialUouWPorV(const Texto: String): String;
begin
   Result := Texto;

   if (Result[1] = 'U') or (Result[1] = 'W')  then
    Result[1] := 'V';
end;

end.
