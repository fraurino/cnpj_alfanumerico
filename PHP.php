function validarCNPJAlfanumerico($cnpj) {
    if (strlen($cnpj) != 14) return false;

    function charParaValor($caractere) {
        return ord($caractere) - 48;
    }

    $valores = array_map('charParaValor', str_split(substr($cnpj, 0, 12)));

    // Pesos para o primeiro DV
    $pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    $soma = 0;
    foreach ($valores as $i => $valor) {
        $soma += $valor * $pesos1[$i];
    }
    $resto = $soma % 11;
    $primeiroDV = ($resto < 2) ? 0 : 11 - $resto;

    // Pesos para o segundo DV
    $pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    $soma = 0;
    foreach ($valores as $i => $valor) {
        $soma += $valor * $pesos2[$i];
    }
    $soma += $primeiroDV * $pesos2[12];
    $resto = $soma % 11;
    $segundoDV = ($resto < 2) ? 0 : 11 - $resto;

    return $primeiroDV === charParaValor($cnpj[12]) && $segundoDV === charParaValor($cnpj[13]);
}

// Exemplo de uso:
echo validarCNPJAlfanumerico("12ABC34501DE35") ? "Válido" : "Inválido";
