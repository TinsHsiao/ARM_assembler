.data
msg1:			.asciz	"Function1: Name\n"
msg2:			.asciz	"Function2: ID\n"
msg3:			.asciz	"Main Function:\n"
msg4:			.asciz	"*****Print All*****\n"
msg5:			.asciz	"*****End Print*****\n"
ID:				.asciz	"ID Summation = "
Space:			.asciz	" "
int_pattern: 	.asciz"%d"
char_pattern: 	.asciz"%c"
Enter: 			.asciz	"\n"

.text
.global main

main:	stmfd sp!, {lr}

		ldr r0, =msg1		@ print Function1
		bl printf	

		ldr r0, =name		@ load address of name
		bl name				@ branch to name

		ldr r0, =msg2		@ print Function2
		bl printf
		
		ldr r0, =id			@ load address of id
		bl id				@ branch to id

		ldr r0, =msg3		@ print main
		bl printf

		ldr r0, =msg4		@ print All
		bl printf

		ldr r0, =TeamNum	@ print TeamNum
		bl printf

		ldr r0, =int_pattern	
		ldr r1, =ID1
		ldr r1, [r1]
		bl printf

		ldr r0, =Space		@ print " "
		bl printf

		ldr r0, =Name1
        bl printf

		ldr r0, =int_pattern
		ldr r1, =ID2
		ldr r1, [r1]
		bl printf

		ldr r0, =Space
		bl printf

        ldr r0, =Name2
        bl printf

		ldr r0, =int_pattern
		ldr r1, =ID3
		ldr r1, [r1]
		bl printf

		ldr r0, =Space
		bl printf

        ldr r0, =Name3
        bl printf

		ldr r0, =ID
		bl printf

		ldr r0, =int_pattern
		ldr r1, =Sum
		ldr r1, [r1]
		bl printf

		ldr r0, =Enter
		bl printf


		ldr r0, =msg5
		bl printf

		mov r0, #0
		ldmfd sp!, {lr}
		mov pc, lr



