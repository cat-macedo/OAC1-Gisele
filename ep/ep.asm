# EXERC�CIO 5a: PROGRAMA QUE CALCULA O MDC (m�ximo divisor comum) DE DOIS INTEIROS ESCOLHIDOS PELO USU�RIO

.text
.globl main

main:
	addi $sp, $sp, -8   # alocando espa�o na pilha para os dois inteiros que serao lidos

	la $a0, msg1        # carrega a mensagem "Digite o primeiro numero:" para $a0 para impress�o
	li $v0, 4           # servi�o para imprimir string
	syscall             # chama o syscall
	
	li $v0, 5           # servi�o para ler o primeiro inteiro do usu�rio
	syscall             # chama o syscall
	sw $v0, 4($sp)      # armazane o inteiro na pilha
	
	la $a0, msg2        # carrega a mensagem "Digite o segundo numero:" para $a0 para impress�o
	li $v0, 4           # servi�o para imprimir string
	syscall             # chama o syscall
	
	li $v0, 5           # servi�o para ler o segundo inteiro do usu�rio
	syscall             # chama o syscall
	sw $v0, 0($sp)      # armazane o inteiro na pilha
	
	jal mdc             # chamando a funcao de calcular o mdc
	
	
	# comandos para quando retornar da funcao mdc
	la $a0, saida       # carrega a mensagem final "O mdc eh:" para $a0 para impress�o
    	li $v0, 4           # servi�o para imprimir string
	syscall             # chama o syscall
    
    	add $a0, $v1, $zero # carrega o resultado(MDC) de $v1 para $a0 para impress�o   
    	li $v0, 1           # servi�o para imprimir inteiro
    	syscall             # chama o syscall
    	
    	addi $sp, $sp, 8    # desalocando o espa�o na pilha
    	
    	li $v0, 10          # servi�o para sair do programa
    	syscall             # chama o syscall
	
	
	# fun��o que calcula o mdc de dois inteiros
mdc:
	lw $t0, 0($sp)      # movendo o inteiro armazenado no topo da pilha para $t0 para manipula��o
	lw $t1, 4($sp)      # movendo o inteiro armazenado na posi��o inferior da pilha para $t1 para manipula��o
		
 	while:
    		beq $t1, $zero, sair    # Se $t1 � 0, sai do loop
    		add $t2, $t1, $zero     # Salva $t1 em $t2 antes da divis�o
		div $t0, $t1            # Divide $t0 por $t1, o resto est� no registrador $hi
    		mfhi $t1                # Move o resto da divis�o para $t1
    		add $t0, $t2, $zero     # Move o valor anterior de $t2 para $t0
    		j while                 # Repete o loop

	sair:
		add $v1, $t0, $zero     # Move o resultado final (MDC) para $v1
   		jr $ra                  # Retorna para a fun��o chamadora
	
.data
msg1: .asciiz "Digite o primeiro numero: "
msg2: .asciiz "Digite o segundo numero: "
saida: .asciiz "O mdc eh: "
