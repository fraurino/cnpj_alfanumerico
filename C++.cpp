#include <iostream>
#include <string>

using namespace std;

int CharParaValor(char caractere) {
    return static_cast<int>(caractere) - 48;
}

bool ValidarCNPJAlfanumerico(const string& cnpj) {
    if (cnpj.length() != 14) return false;

    int valores[12];
    for (int i = 0; i < 12; ++i) {
        valores[i] = CharParaValor(cnpj[i]);
    }

    // Pesos para o primeiro DV
    int pesos1[12] = {5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};
    int soma = 0;
    for (int i = 0; i < 12; ++i) {
        soma += valores[i] * pesos1[i];
    }
    int resto = soma % 11;
    int primeiroDV = resto < 2 ? 0 : 11 - resto;

    // Pesos para o segundo DV
    int pesos2[13] = {6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};
    soma = 0;
    for (int i = 0; i < 12; ++i) {
        soma += valores[i] * pesos2[i];
    }
    soma += primeiroDV * pesos2[12];
    resto = soma % 11;
    int segundoDV = resto < 2 ? 0 : 11 - resto;

    return primeiroDV == CharParaValor(cnpj[12]) && segundoDV == CharParaValor(cnpj[13]);
}

int main() {
    cout << (ValidarCNPJAlfanumerico("12ABC34501DE35") ? "Válido" : "Inválido") << endl;
    return 0;
}
