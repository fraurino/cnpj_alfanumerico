def validar_cnpj_alfanumerico(cnpj)
  return false if cnpj.length != 14

  char_para_valor = ->(char) { char.ord - 48 }

  valores = cnpj[0..11].chars.map(&char_para_valor)

  # Pesos para o primeiro DV
  pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
  soma = valores.each_with_index.sum { |valor, i| valor * pesos1[i] }
  resto = soma % 11
  primeiro_dv = resto < 2 ? 0 : 11 - resto

  # Pesos para o segundo DV
  pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
  soma = valores.each_with_index.sum { |valor, i| valor * pesos2[i] } + primeiro_dv * pesos2[12]
  resto = soma % 11
  segundo_dv = resto < 2 ? 0 : 11 - resto

  primeiro_dv == char_para_valor.call(cnpj[12]) && segundo_dv == char_para_valor.call(cnpj[13])
end

# Exemplo de uso:
puts validar_cnpj_alfanumerico("12ABC34501DE35") ? "Válido" : "Inválido"
