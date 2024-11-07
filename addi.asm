.text
.globl main

main:
	li $t0, 0 # contador de 1 a 10
	li $t1, 0 # soma total
	li $t2, 10
		
loop:
	add $t1, $t1, $t0
	addi $t0, $t0, 1
	bne $t0, $t2, loop	
	
	add $a0, $t1, $zero
	li $v0, 1
	syscall
	li $v0, 10
	syscall	


