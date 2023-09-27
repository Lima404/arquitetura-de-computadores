.data
	primeiro_numero: .asciiz "Primeiro número: "
	segundo_numero: .asciiz "Segundo número: "
	inteiro: .asciiz "Quociente: "
	resto: .asciiz "Resto: "
	impar: .asciiz "O divisor é impar"
	par: .asciiz "O divisor é par"
.text

Primeiro_numero:	
	li $v0, 4 #pergunta o primeiro número
	la $a0, primeiro_numero
	syscall 
	
	li $v0, 5 #salva no registrador o primeiro número inteiro positivo
	syscall
	move $t0, $v0
	
Segundo_numero:
	li $v0, 4 #pergunta segundo número
	la $a0, segundo_numero
	syscall
	
	li $v0, 5 #salva no registrador o segunto número inteiro positivo
	syscall
	move $t1, $v0

Divisão:
	div $t0, $t1 #faz a divisão
	
Reg_quociente_resto:
	mflo $s0 #move para o registrador $s0 a quociente
	mfhi $s1 #move o resto para o registrador $s1
	
Print_quociente:
	li $v0, 4 #printa Quociente
	la $a0, inteiro
	syscall 
	
	
	li $v0, 1 #printa o valor do quociente
	move $a0, $s0
	syscall
	
	li $v0, 11 #Quebra de linha
	li $a0, 10
	syscall 

Resto:
	li $v0, 4 #printa Resto
	la $a0, resto
	syscall 
	
	li $v0, 1#printa o valor do resto
	
	move $a0, $s1
	syscall
	
	li $v0, 11 #Quebra de linha
	li $a0, 10
	syscall 
	
Ler_o_inteiro:
	beq $s1, $zero _par
	li $v0, 4 #printa se o valor é impar
	la $a0, impar
	j _end
	syscall 

	_par:
		li $v0, 4 #printa se o valor é par
		la $a0, par
		syscall 

	_end:
		syscall
