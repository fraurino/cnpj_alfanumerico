def validar_cnpj_alfanumerico(cnpj: str) -> bool:
    def char_para_valor(caractere: str) -> int:
        return ord(caractere) - 48

    if len(cnpj) != 14:
        return False

    valores = [char_para_valor(c) for c in cnpj[:12]]

    # Pesos para o primeiro DV
    pesos = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    soma = sum(valores[i] * pesos[i] for i in range(12))
    resto = soma % 11
    primeiro_dv = 0 if resto < 2 else 11 - resto

    # Pesos para o segundo DV
    valores.append(primeiro_dv)
    pesos = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    soma = sum(valores[i] * pesos[i] for i in range(13))
    resto = soma % 11
    segundo_dv = 0 if resto < 2 else 11 - resto

    return primeiro_dv == char_para_valor(cnpj[12]) and segundo_dv == char_para_valor(cnpj[13])

# Exemplo de uso:
print(validar_cnpj_alfanumerico("12ABC34501DE35"))  # True ou False
