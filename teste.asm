.text
.globl main

main:
	la $a0, msg1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $a1, $v0
	
	la $a0, msg2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $a2, $v0
	
    
    jal mdc             # Chama a função mdc
    la $a0, saida
    li $v0, 4
    syscall
    
    move $a0, $v1       # Move o resultado (MDC) para $a0 para impressão
    li $v0, 1           # Serviço para imprimir inteiro
    syscall             # Chama o syscall
    li $v0, 10          # Serviço para sair do programa
    syscall             # Chama o syscall

mdc: 
    addi $sp, $sp, -12  # Ajusta a pilha para 3 palavras (12 bytes)
    sw $ra, 8($sp)      # Salva $ra na pilha
    sw $t0, 4($sp)      # Salva $t0 na pilha
    sw $t1, 0($sp)      # Salva $t1 na pilha

    move $t0, $a1       # Move valor a para $t0 
    move $t1, $a2       # Move valor b para $t1 

while:
    beq $t1, $zero, sair # Se $t1 é 0, sai do loop
    move $t2, $t1       # Salva $t1 em $t2 antes da divisão
    div $t0, $t1        # Divide $t0 por $t1, quociente em $LO e resto em $HI
    mfhi $t1            # Move o resto da divisão para $t1
    move $t0, $t2       # Move o valor anterior de $t1 para $t0
    j while             # Repete o loop

sair:
    move $v1, $t0       # Move o resultado final (MDC) para $v0

    lw $t1, 0($sp)      # Restaura $t1 da pilha
    lw $t0, 4($sp)      # Restaura $t0 da pilha
    lw $ra, 8($sp)      # Restaura $ra da pilha
    addi $sp, $sp, 12   # Ajusta a pilha de volta
    jr $ra              # Retorna para a função chamadora
    
.data
msg1: .asciiz "Digite o primeiro numero: "
msg2: .asciiz "Digite o segundo numero: "
saida: .asciiz "O mdc eh: "
# $valor1: .word 32
# $valor2: .word 12    
