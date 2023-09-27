.data
  _result:      .word 0
  _base:        .asciiz "Digite a base:  "
  _expoente:    .asciiz "Digite o expoente: "
  _answer:      .asciiz "O resultado e: "

.text
.globl _main
  _main:
     jal read_base          #Lê a base
     move $a1, $v0          #move a base para a1 (onde ficará o resultado)
     move $a3, $a1          #move a base para a3 (base para multiplicação)
     jal read_expoente      #Lê o expoente
     move $a2, $v0          #move o expoente em $a2
     jal calculo            #realiza o calculo da função
     sw $a1, _result        #salva o resultado de $a1 em _result
     jal print_result       #printa a resposta
     #Termina o programa    #finaliza o programa
     li $v0, 10
     syscall 
     
  L1:
     mult  $a1, $a3        #multiplica a1(resultado) pelo a3(base)
     mflo  $a1             #copia o resultado da multiplicação para a1
     subi  $a2, $a2, 1     #subtrai 1 do expoente
     j  calculo            #retorna para calculo

  calculo:
     slti  $t0, $a2, 2      #testa se o a2(expoente) é menor que 2, se a2<2 -> t0 = 1, se a2>=2 -> t0 = 0
     beq  $t0, $zero, L1    #se 0 = 0, pula para L1
     jr   $ra               #sai do loop e retorna para o programa principal

  read_base:
     li $v0, 4		    #pergunta qual o numero de base
     la $a0, _base
     syscall
     li $v0, 5		    #salva em um registrador o valor da base
     syscall
     jr $ra
     
  read_expoente:
     li $v0, 4		    #pergunta qual o valor do expoente
     la $a0, _expoente
     syscall
     li $v0, 5		    #salva em um registrador o valor do expoente
     syscall
     jr $ra

  print_result:
     li $v0, 4		    #printa Resultado
     la $a0, _answer
     syscall
     li $v0, 1		    #printa o valor do resultado
     lw $a0, _result
     syscall
     jr $ra		    # faz o jump register no $ra