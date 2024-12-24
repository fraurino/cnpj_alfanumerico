function ValidarCNPJAlfanumerico(const CNPJ: string): Boolean;
var
  Valores: array[1..12] of Integer;
  Pesos: array[1..13] of Integer;
  Soma, Resto, PrimeiroDV, SegundoDV, I: Integer;

  function CharParaValor(Caractere: Char): Integer;
  begin
    // Subtrair 48 conforme a especificação no anexo
    Result := Ord(Caractere) - 48;
  end;

begin
  Result := False;

  // Validar o formato (CNPJ alfanumérico deve ter 14 caracteres)
  if Length(CNPJ) <> 14 then Exit;

  // Atribuir os valores para os 12 primeiros caracteres
  for I := 1 to 12 do
    Valores[I] := CharParaValor(CNPJ[I]);

  // Pesos para o primeiro DV (da direita para a esquerda, reiniciando após o oitavo)
  Pesos := [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  // Calcular o primeiro DV
  Soma := 0;
  for I := 1 to 12 do
    Soma := Soma + (Valores[I] * Pesos[I]);
  Resto := Soma mod 11;
  if Resto < 2 then
    PrimeiroDV := 0
  else
    PrimeiroDV := 11 - Resto;

  // Adicionar o primeiro DV ao CNPJ para o segundo cálculo
  Valores[13] := PrimeiroDV;

  // Pesos para o segundo DV
  Pesos := [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  // Calcular o segundo DV
  Soma := 0;
  for I := 1 to 13 do
    Soma := Soma + (Valores[I] * Pesos[I]);
  Resto := Soma mod 11;
  if Resto < 2 then
    SegundoDV := 0
  else
    SegundoDV := 11 - Resto;

  // Comparar os DVs calculados com os fornecidos
  Result := (PrimeiroDV = CharParaValor(CNPJ[13])) and
            (SegundoDV = CharParaValor(CNPJ[14]));
end;
