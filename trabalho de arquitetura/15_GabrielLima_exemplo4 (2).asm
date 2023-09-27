.data
	vectsize:	.asciiz "Type how many numbers u want to sort: "
	vectpos1:	.asciiz "Type the pos "
	vectpos2:	.asciiz " of the vector: "
	vecttittle:	.asciiz "Vector list of numbers:"
	
.text
.globl	main
main:
	jal vectLength 
	jal vectAllocation 
	jal indiceReset 
	jal vectNumbers
	jal indiceReset
	jal newLine
	jal vectTittle
	jal printVector
	move $a0, $zero
	jal vectorSort
	jal newLine
	jal vectTittle
	jal indiceReset
	jal printVector
	jal exit
	
indiceReset:			#Volta o índice do vetor para 0(Zero) ou primeira posição
	move $s3, $zero
	jr $ra
newLine:			#Realiza uma quebra de linha
	li $v0, 11
	li $a0, 10
	syscall
	jr $ra
vectTittle:			#printa o texto antes do vetor
	li $v0, 4
	la $a0, vecttittle
	syscall
	jr $ra
vectLength:			#Coleta o tamanho do vetor e salva em $s0
	li $v0, 4	
	la $a0, vectsize
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	jr $ra
vectAllocation:			#Aloca o vetor na memória e salva o endereço base em $s1
	sll $t0, $s0, 2
	move $a0, $t0
	li $v0, 9
	syscall
	move $s1, $v0
	jr $ra
else:				#Pula para o $ra atual
	jr $ra
vectNumbers:			#Printa o texto na tela e coleta os valores do vetor por posição
	slt $t0, $s3, $s0	
	beq $t0, $zero, else
	sll $t0, $s3, 2
	addu $a1, $s1, $t0
	addi $s3, $s3, 1
	li $v0, 4
	la $a0, vectpos1
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, vectpos2
	syscall
	li $v0, 5
	syscall
	sw $v0, ($a1)
	j vectNumbers
printVector:			#Printa os valores do vetor
	slt $t0, $s3, $s0
	beq $t0, $zero, else
	sll $t0, $s3, 2
	addu $a1, $s1, $t0
	li $v0, 11
	la $a0, 32
	syscall
	li $v0, 1
	lw $a0, ($a1)
	syscall
	addi $s3, $s3, 1
	j printVector
vectorSort:			#Loop principal sort
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	bge $a0, $s0, return
	move $a3, $a0
	jal L1
	addi $a0, $a0, 1
	jal vectorSort
L1:				#Carrega os valores da posição v[i] e v[j] para os registradores e volta ao loop principal
	bge $a3, $s0, return
	addi $sp, $sp, -4
	sw $ra, ($sp)
	sll $t2, $a3, 2
	sll $t3, $a0, 2
	addu $t4,$t2,$s1
	addu $t5,$t3,$s1
	lw $s2, 0($t4)
	lw $s4, 0($t5)
	jal L2
	addi $a3,$a3,1
	jal L1
return:				#Traz o $ra guardado na pilha e incrementa o ponteiro
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
L2:				#Caso necerrásio, faz a troca entre os valores carregados anteriormente
	bge $s2,$s4, else
	sw $s2, 0($t5)
	sw $s4, 0($t4)
	jr $ra
exit:				#Finaliza o programa
	li $v0, 10
	syscall
