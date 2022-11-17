# Desafio Final: Teste Unitário


# Vídeo explicando o problema:

[![Video](https://user-images.githubusercontent.com/32878844/201673996-1875d75b-8eed-463a-8fd4-e1c63bad39d8.jpg)](https://streamable.com/21xrj4)

# Cálculo de Frete

### Regra de Busca do Frete
Todos os centros de distribuição possuem CEP, Cidade, e Estado.
Todos os pedidos possuem obrigatoriamente CEP, Cidade, e Estado.
O sistema deve ter uma regra onde compara as igualdades entre os centros de distribuição e os pedidos a serem entregues, levando em consideração a prioridade entre os parâmetros.

**Prioridades:**  

 - Prioridade 1: Encontrar um parâmetro de frete que enquadre CEP.
   
 - Prioridade 2: Encontrar um parâmetro de frete que enquadre cidade  

 - Prioridade 3: Encontrar um parâmetro de frete que enquadre estado

Ou seja, caso encontremos mais de uma linha de frete que se enquadre em nosso pedido, devemos utilizar o nosso critério de prioridade para selecionar a linha mais específica de frete.

Parâmetros de frete que se enquadrem em qualquer um dos três níveis de prioridade são elegíveis para serem associados ao pedido.

As prioridades entram em vigor para definição do frete mais prioritário na "Lógica de Otimização da Seleção do Centro de Distribuição".

##

### Regra de Cálculo do Frete:
O sistema deve calcular o frete adequadamente para pedidos do e-commerce.
Encontrar o parâmetro e definir o valor do frete.
Os produtos possuem **volume total do item, peso total do item e quantidade total de produtos.** 
Baseado nessas informações deve-se calcular o  valor de frete do pedido.



**Dados do produto:**
**Volume total (m3):** 21
**Peso total (kg):** 650
**Quantidade total:** 17

**Dados base de cálculo:**
**Frete por volume:** 26
**Frete por peso:** 2
**Base de frete:** 13



Fórmula cálculo do frete por volume: 
**(soma(volume do item do pedido)) * frete por volume** 
soma = soma de todo volume do pedido;
fretePorVolume  = 21*26 = 546;

Fórmula cálculo do frete por peso: 
**(soma(peso do item do pedido)) * frete por peso** 
soma = soma de todo peso do pedido;
fretePorPeso  = 650*2 = 1300;

Fórmula cálculo do frete base: 
**(soma(quantidade do item do pedido)) * frete base** 
soma = soma de toda quantidade do pedido;
freteBase = 17*13 = 221;

if(fretePorVolume >= fretePorPeso && fretePorVolume >= freteBase ) {
	result = fretePorVolume;
	
} else if(fretePorPeso >= fretePorVolume && fretePorPeso  >= freteBase) {
	result = fretePorPeso ;
} 

else {
	result = freteBase;
}

O Sistema deve levar em consideração o maior valor obtido entre os cálculos.
Valor a ser usado para cobrança do frete: **1300**.


##
