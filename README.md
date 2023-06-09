# TP_VENDA
Introdução: O objetivo deste projeto é criar um sistema que permita aos usuários selecionar um tipo de produto através de pinos de seleção, inserir moedas através de pinos específicos e calcular o troco a ser retornado. Além disso, o valor do troco deve ser exibido em um display de sete segmentos. Neste relatório, iremos descrever o funcionamento do sistema, incluindo a lógica por trás das combinações dos pinos, a associação com o produto correspondente, o cálculo do valor total inserido e a exibição do troco no display. 

Descrição do Sistema: O sistema consiste em três pinos rotulados como Pino 1, Pino 2 e Pino 3 para seleção do tipo de produto, quatro pinos rotulados como Pino 4, Pino 5, Pino 6 e Pino 7 para inserção das moedas, e um display de sete segmentos para exibir o valor do troco. 

Tabela de Combinações e Informações Adicionais: A tabela de combinações dos pinos de seleção de tipo de produto permanece a mesma do relatório anterior. Porém, agora é necessário adicionar informações sobre o valor de troca para cada produto, bem como o cálculo e exibição do troco. 

Pino 1 | Pino 2 | Pino 3 | Tipo de Produto | Preço | Símbolo | Valor do Troco 

0 | 0 | 0 | Produto 1 | 1 | A | -  

0 | 0 | 1 | Produto 2 | 2 | B | -  

0 | 1 | 0 | Produto 3 | 3 | C | - 

 0 | 1 | 1 | Produto 4 | 5 | D | - 

 1 | 0 | 0 | Produto 5 | 10 | E | -  

1 | 0 | 1 | Produto 6 | 15 | F | - 

Nessa tabela, cada linha representa uma combinação específica dos estados dos pinos de seleção, e são fornecidos o tipo de produto, preço, símbolo e um espaço reservado para o valor do troco. 

Funcionamento do Sistema: O sistema funciona da seguinte maneira: os usuários ajustam os estados dos pinos de seleção para escolher o tipo de produto desejado. Em seguida, inserem as moedas através dos pinos de moedas correspondentes aos valores de 1, 2, 5 e 10 unidades monetárias. 

Após a inserção das moedas, o sistema verifica se o valor total das moedas inseridas é maior, menor ou igual ao preço do produto selecionado. Se for menor, o display de sete segmentos mostra o valor do troco a ser retornado. Caso contrário, não há troco. 

Para o funcionamento adequado do projeto, será necessário a utilização de registradores para armazenar os valores do preço do produto selecionado e também das moedas inseridas na máquina. Os registradores serão responsáveis por armazenar e manter os valores atualizados durante todo o processo de seleção e inserção de moedas. 

Além disso, será necessário a implementação de um somador, que será responsável por contar a quantidade total de moedas inseridas na máquina. O somador irá acumular os valores das moedas à medida que forem sendo inseridas, permitindo o cálculo correto do valor total inserido pelos usuários. 

Outro componente essencial será um subtrator, que será utilizado para calcular o troco a ser retornado aos usuários. O subtrator realizará a subtração do valor total inserido pelas moedas do preço do produto selecionado. O resultado dessa operação será o valor do troco que deverá ser exibido no display de sete segmentos. 

Dessa forma, a combinação do uso de registradores, somador e subtrator permitirá um controle preciso dos valores envolvidos no processo de seleção de produto, inserção de moedas e cálculo do troco. Esses componentes essenciais garantirão um funcionamento eficiente e confiável do sistema, proporcionando uma experiência satisfatória para os usuários. 

 

 
