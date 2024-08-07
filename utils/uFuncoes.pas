unit uFuncoes;

interface

type
  TFuncoes = class

  public
    class function SoNumero(value : String): String;
  end;

implementation


class function TFuncoes.SoNumero(value : String): String;
var
  I : Byte;
begin
   Result := '';
   for I := 1 To Length(value) do
       if value[I] In ['0'..'9', '.', ','] Then
            Result := Result + value[I];
end;

end.
