using System;

public class CNPJValidator
{
    public static bool ValidarCNPJAlfanumerico(string cnpj)
    {
        if (cnpj.Length != 14) return false;

        int CharParaValor(char caractere)
        {
            return (int)caractere - 48;
        }

        int[] valores = new int[12];
        for (int i = 0; i < 12; i++)
        {
            valores[i] = CharParaValor(cnpj[i]);
        }

        // Pesos para o primeiro DV
        int[] pesos1 = { 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
        int soma = 0;
        for (int i = 0; i < 12; i++)
        {
            soma += valores[i] * pesos1[i];
        }
        int resto = soma % 11;
        int primeiroDV = resto < 2 ? 0 : 11 - resto;

        // Pesos para o segundo DV
        int[] valoresComDV = new int[13];
        Array.Copy(valores, valoresComDV, 12);
        valoresComDV[12] = primeiroDV;

        int[] pesos2 = { 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
        soma = 0;
        for (int i = 0; i < 13; i++)
        {
            soma += valoresComDV[i] * pesos2[i];
        }
        resto = soma % 11;
        int segundoDV = resto < 2 ? 0 : 11 - resto;

        return primeiroDV == CharParaValor(cnpj[12]) && segundoDV == CharParaValor(cnpj[13]);
    }

    public static void Main()
    {
        Console.WriteLine(ValidarCNPJAlfanumerico("12ABC34501DE35")); // True ou False
    }
}
