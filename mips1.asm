########## HELLO WORLD
.text
.globl main

main:
        la $a0,texto               # &texto ou texto: não faz diferença / # imprime texto "Hello World"
        li $v0,4
        syscall
        li $v0,10                        # termina (exit)
        syscall
.data

texto: .asciiz "Hello World"