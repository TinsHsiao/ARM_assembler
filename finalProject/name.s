.data
title:  	.asciz "*****Print Name*****\n"
TeamNum : 	.asciz "Team 33\n"
Name1 :   	.asciz "Tsai-Jou Yang\n"
Name2 :   	.asciz "Tina Hsiao\n"
Name3 :   	.asciz "Yi-An Lien\n"
endPrint : 	.asciz "*****End Print*****\n"


.text
.globl name
.globl Name1
.globl Name2
.globl Name3
.globl TeamNum

name:   stmfd sp!,{lr}		@ push return address onto stack

        ldr r0, =title		@ r0 = address of title
        bl printf

		mov r1, #0			@r1 = 0
		adds r1, sp, #0		@r1 = sp + 0, set CPSR
		mov r2, #0			@r2 = 0
		adcs r13, r1, r2	@r13(sp) = r1 + r2 + c ( sp = sp + 0 + 0 )

        ldr r0, =TeamNum	@r0 = address of TeamNum
        bl printf

        ldr r0, =Name1		@r0 = address of Name1	
        bl printf

        ldr r0, =Name2		@r0 = address of Name2
        bl printf

        ldr r0, =Name3		@r0 = address of Name3
        bl printf

        ldr r0, =endPrint	@r0 = address of endPrint
        bl printf

        mov r0, #0			@move return code into r0 
        ldmfd sp!, {lr}		@ pop return address from stack
        mov pc, lr			@ move pc to main return address

