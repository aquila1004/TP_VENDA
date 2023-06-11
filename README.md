# TP_VENDA
ENUNCIADO([6/5, 7:25 AM] Ricardo Duarte
    Bom dia Turma PN5. Segue o enunciado do TP3 que deverá ser entregue no final da aula do dia 12/06. 
Escrever em VHDL um código sintetizável (DUT) do Projeto RTL de uma máquina de vendas que distribui pequenos artigos, como alimentos, bebidas ou cigarros, quando uma moeda, nota ou ficha é inserida. Sua máquina deverá disponibilizar a escolha do usuário 6 produtos diferentes, cada um com um valor em fichas distinto um do outro. Sua máquina poderá receber fichas de valores 1, 2, 5 e 10. Sua máquina tem que dar troco quando o valor inserido pelo usuário igualar ou superar o valor do produto. Sua máquina tem que exibir no display de 7 segmentos o valor do troco retornado. Quando sua máquina liberar um produto, um único led dedicado para exibir o resultado correto dessa ação deverá ser aceso por 5 segundos, enquanto o display de 7 segmentos exibe se houve troco (o valor do troco) ou não (exibe 0). Esse mesmo led tem ficar apagado nos demais casos. Após transcorrido esse tempo de 5 segundos a máquina voltará para o estado inicial no aguardo de um novo pedido. Um segundo led deverá acender para indicar ao usuário que o mesmo precisa inserir mais fichas para liberar o produto. Esse último led deverá ficar apagado assim que o produto for liberado e enquanto não terminar os 5 segundos necessários para alertar o usuário que o produto dele foi liberado. Um push-button (ativo em nível lógico 0) deverá ser usado para o usuário desistir da operação, quando o mesmo for pressionado. Nessa situação, sua máquina deverá devolver todo o valor que o usuário depositou até o momento. O valor devolvido deverá ser mostrado no display de 7 segmentos por 5 segundos, e após decorrido esse tempo sua máquina deverá voltar ao estado inicial a espera de um novo pedido.
Faça um relatório explicando em detalhes do projeto. Nesse relatório deverá constar:
(1) Suas tomadas de decisões (quais produtos, como o usuário pode identificá-los, valores de cada produto, caracterização do estado inicial de sua máquina, e o que mais vocês julgarem necessário para esclarecer o que vocês se propuseram a fazer).
(2) Descrição de todos os passos do método de projeto RTL (desenhos, diagramas, tabelas, deverão ser apresentadas.
Use como clock de entrada para a sua máquina, a saída de 1Hz do componente do código que eu disponibilizei para vocês: "divisor_clock.vhd", que se encontra na pasta "Scripts e exemplos de codigos". Faça as adaptações que vocês julgarem necessárias no código disponibilizado.
Escreva um testbench em VHDL para testar a funcionalidade do seu código sintetizável (seu DUT). Por fim, crie um projeto dentro do Quartus II e sintetize o DUT que você testou com o GHDL. Use como recursos do kit para definir como entradas quantos switches da placa vocês desejarem e um dos sinais de 50MHz de clock disponíveis, e como saídas além dos 2 leds, use pelo menos 1 display de 7 segmentos do kit. Faça o arquivo de associação de pinos do FPGA com as entradas e saídas da entidade do seu DUT (pin assignments). Gere o código binário (compile) de dentro do Quartus II para ser gravado no FPGA de qualquer um dos kits do laboratório. Grave o FPGA com o seu DUT, teste o funcionamento do mesmo e apresente tudo ao professor no dia da aula 14 marcada para a apresentação do trabalho 3. Compacte todos os arquivos relatorio.pdf, arquivos.vhd, arquivo.vcd, arquivo.csv e scripts em um único arquivo no formato .zip. Renomeie esse arquivo com o nome de todos os componentes do grupo.zip e faça um upload do mesmo para a pasta de Entregas de sua turma, aula LSD14 no MS-Teams até a data/horário que o professor estipular.
)
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

 

 
