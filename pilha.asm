.data
$valor1: .word 32
$valor2: .word 12

.text
.globl main

main:
    ld $a0, $valor1      # Carrega o endere�o de valor1 em $a0
    ld $a1, $valor2      # Carrega o endere�o de valor2 em $a1
    jal mdc             # Chama a fun��o mdc
    move $a0, $v0       # Move o resultado (MDC) para $a0 para impress�o
    li $v0, 1           # Servi�o para imprimir inteiro
    syscall             # Chama o syscall
    li $v0, 10          # Servi�o para sair do programa
    syscall             # Chama o syscall

mdc: 
    addi $sp, $sp, -12  # Ajusta a pilha para 3 palavras (12 bytes)
    sw $ra, 8($sp)      # Salva $ra na pilha
    sw $t0, 4($sp)      # Salva $t0 na pilha
    sw $t1, 0($sp)      # Salva $t1 na pilha

    move $t0, $a0       # Move valor a para $t0 
    move $t1, $a1       # Move valor b para $t1 

while:
    beq $t1, $zero, sair # Se $t1 � 0, sai do loop
    move $t2, $t1       # Salva $t1 em $t2 antes da divis�o
    div $t0, $t1        # Divide $t0 por $t1, quociente em $LO e resto em $HI
    mfhi $t1            # Move o resto da divis�o para $t1
    move $t0, $t2       # Move o valor anterior de $t1 para $t0
    j while             # Repete o loop

sair:
    move $v0, $t0       # Move o resultado final (MDC) para $v0

    lw $t1, 0($sp)      # Restaura $t1 da pilha
    lw $t0, 4($sp)      # Restaura $t0 da pilha
    lw $ra, 8($sp)      # Restaura $ra da pilha
    addi $sp, $sp, 12   # Ajusta a pilha de volta
    jr $ra              # Retorna para a fun��o chamadora
