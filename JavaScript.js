function validarCNPJAlfanumerico(cnpj) {
    if (cnpj.length !== 14) return false;

    function charParaValor(caractere) {
        return caractere.charCodeAt(0) - 48;
    }

    const valores = Array.from(cnpj.slice(0, 12)).map(charParaValor);

    // Pesos para o primeiro DV
    const pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    let soma = valores.reduce((acc, valor, i) => acc + valor * pesos1[i], 0);
    let resto = soma % 11;
    const primeiroDV = resto < 2 ? 0 : 11 - resto;

    // Pesos para o segundo DV
    const pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    soma = valores.reduce((acc, valor, i) => acc + valor * pesos2[i], 0) + primeiroDV * pesos2[12];
    resto = soma % 11;
    const segundoDV = resto < 2 ? 0 : 11 - resto;

    return primeiroDV === charParaValor(cnpj[12]) && segundoDV === charParaValor(cnpj[13]);
}

// Exemplo de uso:
console.log(validarCNPJAlfanumerico("12ABC34501DE35")); // true ou false
