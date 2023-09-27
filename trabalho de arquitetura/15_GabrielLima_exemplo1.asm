.data
	primeiro_numero: .asciiz "Primeiro numero: "
	segundo_numero: .asciiz "Segundo numero: "
	inteiro: .asciiz "Quociente: "
	resto: .asciiz "Resto: "
.text
	
	li $v0, 4 #printa no run o primeiro numero
	la $a0, primeiro_numero
	syscall 
	
	li $v0, 5 #salva no registrador o primeiro numero inteiro positivo
	syscall
	move $t0, $v0
	
	li $v0, 4 #printa no run segundo numero
	la $a0, segundo_numero
	syscall
	
	li $v0, 5 #salva no registrador o segunto numero inteiro positivo
	syscall
	move $t1, $v0
	
	div $t0, $t1 #faz a divisão
	
	mflo $s0 #move para o registrador $s0 a parte inteira
	mfhi $s1 #move o resto para o registrador $s1
	
	li $v0, 4 #printa o Quociente
	la $a0, inteiro
	syscall 
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 11 #Quebra de linha
	li $a0, 10
	syscall 
	
	li $v0, 4 #printa o Resto
	la $a0, resto
	syscall 
	
	li $v0, 1
	move $a0, $s1
	syscall
	
