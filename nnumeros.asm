.data
prompt_n: .asciiz "Digite o numero de elementos: "
prompt_num: .asciiz "Digite o numero: "
newline: .asciiz "\n"
result_msg: .asciiz "O MDC do vetor e: "

.text
.globl main

main:
    # Leitura do numero n
    li $v0, 4              # Servi�o para imprimir string
    la $a0, prompt_n       # Endere�o da string
    syscall                # Chama o syscall

    li $v0, 5              # Servi�o para ler inteiro
    syscall                # Chama o syscall
    move $t0, $v0          # Armazena n em $t0

 
    # Leitura dos n n�meros e armazenamento na pilha
    move $t1, $zero        # �ndice i = 0
read_numbers:
    beq $t1, $t0, calc_mdc # Se i == n, vai para calcular o MDC

    # Imprime o prompt para cada n�mero
    li $v0, 4              # Servi�o para imprimir string
    la $a0, prompt_num     # Endere�o da string
    syscall                # Chama o syscall

    # L� um n�mero do usu�rio
    li $v0, 5              # Servi�o para ler inteiro
    syscall                # Chama o syscall

    # Armazena o n�mero na pilha
    addi $sp, $sp, -4      # Ajusta a pilha para baixo (aloca 4 bytes)
    sw $v0, 0($sp)         # Armazena o valor no topo da pilha
    addi $t1, $t1, 1       # Incrementa i
    j read_numbers         # Repete a leitura

calc_mdc:
    # Carrega o primeiro valor para inicializar o resultado do MDC
    lw $t2, 0($sp)         # Carrega o primeiro valor da pilha para $t2
    addi $sp, $sp, 4       # Ajusta a pilha para cima (desaloca 4 bytes)
    sub $t0, $t0, 1        # Decrementa n

calc_loop:
    beq $t0, $zero, print_result # Se n == 0, vai para imprimir o resultado

    lw $t3, 0($sp)         # Carrega o pr�ximo valor da pilha para $t3
    addi $sp, $sp, 4       # Ajusta a pilha para cima (desaloca 4 bytes)

    # Calcula o MDC de $t2 e $t3
    move $a0, $t2          # Move o valor de $t2 para $a0
    move $a1, $t3          # Move o valor de $t3 para $a1
    jal mdc                # Chama a fun��o mdc
    move $t2, $v0          # Move o resultado do MDC para $t2

    sub $t0, $t0, 1        # Decrementa n
    j calc_loop            # Repete o c�lculo

mdc:
    # Fun��o para calcular o MDC de dois n�meros usando o algoritmo de Euclides
    move $t4, $a0          # Move $a0 para $t4 (a)
    move $t5, $a1          # Move $a1 para $t5 (b)

mdc_loop:
    beq $t5, $zero, mdc_done # Se b == 0, sai do loop
    div $t4, $t5            # Divide a por b
    mfhi $t4                # Resto da divis�o vai para $t4
    move $t5, $t4           # Move o resto para b
    j mdc_loop              # Repete o loop

mdc_done:
    move $v0, $t4           # Move o resultado para $v0
    jr $ra                  # Retorna para a fun��o chamadora

print_result:
    # Imprime a mensagem de resultado
    li $v0, 4              # Servi�o para imprimir string
    la $a0, result_msg     # Endere�o da string
    syscall                # Chama o syscall

    # Imprime o valor do resultado
    move $a0, $t2          # Move o resultado do MDC para $a0
    li $v0, 1              # Servi�o para imprimir inteiro
    syscall                # Chama o syscall

    # Sa�da do programa
exit:
    li $v0, 10             # Servi�o para sair do programa
    syscall                # Chama o syscall
