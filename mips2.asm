.text
.globl main

# main:
########## SOMAR 5 EM UM VALOR PASSADO NA INSTRUÇÃO (LOAD IMDEDIATO)
	# li $a0, 10
	# addi $a0, $a0, 5
	# li $v0, 1
	# syscall
	# li $v0, 10
	# syscall
	
########## SOMAR 20 EM UM VALOR DOUBLE PASSADO NA ÁREA .data   
	# ld $a0, $valor
	# addi $a0, $a0, 20
	# li $v0, 1
	# syscall
	# li $v0, 10
	# syscall

# .data 
# $valor: .word 35

########## DIZER SE EH MAIOR DE IDADE
# main:
	# ld $a1, $idade       # carrega a idade em a1
	# blt $a1, 18, menor   # salta para menor se a condição for satisfeita
	# la $a0, $texto1      # carrega texto 1
	# j fim               # salta para fim (j = jump)
# menor:                       # pula para cá caso a condição do blt for satisfeita
	# la $a0, $texto2      # carrega texto 2
# fim:                         # continua aqui em ambas as condições
	# li $v0, 4            # imprime o texto escolhido
	# syscall
	# li $v0, 10           # exit
	# syscall

# .data
# $idade: .word 20
# $texto1: .asciiz "maior de idade"
# $texto2: .asciiz "menor de idade"

# LOOP SIMPLES COM SOMA
# main:
	# li $a0, 0
	# li $a1, 1
# loop:
	# add $a0, $a0, $a1
	# addi $a1, $a1, 1
	# ble $a1, 10, loop
	# li $v0, 1
	# syscall
	# li $v0, 10
	# syscall
	
# VETOR E LOOP PARA SOMAR OS ELEMENTOS DE UM VETOR
# main:
	# li $a0, 0            # inicializa a0 com 0
	# la $a1, $vetor       # coloca o ponteiro do vetor em a1
	# la $a2, 0            # inicializa a2 com 0
# loop:
	# ld $a3, ($a1)        # carrega o valor de a1 em a3
	# add $a0, $a0, $a3    # Soma o valor de $a3 a $a0
	# addi $a1, $a1, 4     # Incrementa o ponteiro do vetor ($a1) para o próximo elemento
	# addi $a2, $a2, 1     # Incrementa o contador do loop ($a2)
	# blt $a2, 5, loop     # Se $a2 < 5, continua o loop
	# li $v0, 1
	# syscall
	# li $v0, 10
	# syscall

# .data
# $vetor: .word 20 24 28 32 36	

# FATORIAL (EU QUE FIZ)
# main:
	# ld $a1, $valor
	# li $a0, 1

# loop:
	# mul $a0, $a0, $a1
	# subi $a1, $a1, 1
	# bge $a1, 1, loop
	# li $v0, 1
	# syscall
	# li $v0, 10
	# syscall
# .data
# $valor: .word 4

# TESTE DE FUNCAO COM WHILE
# main:
	# ld $a0, $valor1    # carrego o valor1 passado no registrador $a0 (parametro da funcao)
	# ld $a1, $valor2    # carrego o valor2 passado no registrador $a1 (parametro da funcao)
	# jal funcao         # chamo a funcao
	# move $a0, $v0	   # apos retornar da funcao, movo o valor retornado em $v0 para $a0 para poder imprimi-lo
	# li $v0, 1	   # impressao e fim do programa
	# syscall
	# li $v0, 10
	# syscall
	
# funcao:
	# move $t0, $a0      # movo o valor do parametro $a0 para $t0 para poder manipula-lo
	# move $t1, $a1      # movo o valor do parametro $a1 para $t1 para poder manipula-lo
	# while:             # laco
		# bgt $t0, 12, sair     # se o valor em $t0 for maior que 12, eu saio do laco
		# add $t0, $t0, $t1     # somo o valor em $t0 com o valor em $t1
		# j while               # enquanto $t0 for menor/igual a 12, continuo no laco
	# sair:
		# move $v0, $t0         # movo o valor final de $t0, apos sair do laco, para o registrador $v0
		# jr $ra                # retorno para o bloco chamador da funcao
	
	
# .data
# $valor1: .word 1
# $valor2: .word 2

# MDC (EUCLIDES)
main:
	ld $a0, $valor1
	ld $a1, $valor2
	jal mdc
	move $a0, $v0           # impressao da resposta final (mdc)
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
mdc: 
	move $t0, $a0    # valor a = 32 (movo o valor em $a0 para $t0 para poder manipula-lo)
	move $t1, $a1    # valor b = 12 (movo o valor em $a1 para $t1 para poder manipula-lo)
	
	while:
		beq $t1, 0, sair       # se o valor em $t1 for zero, eu saio do laco
		add $t2, $t1, $zero    # temp = valor b = 12 (copio o valor em $t1 para uma "variavel temporaria" -> registrador $t2)
		div $t0, $t1           # $t0 = valor b = a/b = 32/12(divido o valor em $t0 pelo valor em %t1 para utilizar o resto)
		mfhi $t1               # movo o resto dessa divisao (8) para $t1
		move $t0, $t2          # $t0 = $t2 = valor b = 12 (movo o valor em $t2 para $t1)
		j while                # continuo no laco enquanto $t1 for diferente de zero
		
	sair:                          # quando sair do laco, executo esse bloco
		move $v0, $t0          # movo o valor em $t0 (o mdc) para $v0(registrador usado para retonar valores de funcoes)
		jr $ra	               # retorno para o bloco que chamou a funcao

.data
$valor1: .word 128
$valor2: .word 9


	
