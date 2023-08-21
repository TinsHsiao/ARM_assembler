.data
title_id : 		.asciz	"*****Input ID*****\n"
ID1in:			.asciz	"** Please Enter Member 1 ID:**\n"
ID2in:			.asciz	"** Please Enter Member 2 ID:**\n"
ID3in:			.asciz	"** Please Enter Member 3 ID:**\n"
cmd:			.asciz	"** Please Enter Command **\n"
Summation :		.asciz	"*****Print Team Member ID and ID Summation*****\n"
ID:				.asciz	"ID Summation = "
Enter:			.asciz	"\n"
End:			.asciz	"*****End Print*****\n"
int_pattern:	.asciz"%d"
char_pattern:	.asciz"%c"
p:				.asciz	"p\0\0\0"			@ fill up a space of a word

ID1:		.word 0		@ give a space for ID1
ID2: 		.word 0
ID3: 		.word 0
Sum: 		.word 0
Command: 	.word 0

.text
.global	id
.global	AddID	@ print member ID and Sum

.global Sum

id: 	stmfd sp!,{r4-r7, lr}		@ push return address and r4-r11 onto stack 
		mov r4, r0					@ ID1 address in main
		mov r5, r1 					@ ID2 address in main
		mov r6, r2					@ ID3 address in main
		mov r7, r3					@ Sum address in main
		
		ldr r0, =title_id
		bl printf

		ldr r0, =ID1in				@r0 = address of ID1in
		bl printf
		
		@ ----scan ID----
		
		ldr r0, =int_pattern		@ load address of format string
		ldr r1, =ID1				@ load ID1 address
		bl scanf					@ scanf( "%d", &ID1 )

		ldr r0, =ID2in				@r0 = address of ID2in
		bl printf

		ldr r0, =int_pattern		@ load address of format string
		ldr r1, =ID2				@ load ID2 address
		bl scanf					@ scanf( "%d", &ID2 )

		ldr r0, =ID3in				@r0 = address of ID3in
		bl printf

		ldr r0, =int_pattern		@ load address of format string
		ldr r1, =ID3				@ load ID3 address
		bl scanf					@ scanf( "%d", &ID3 )

		ldr r0, =cmd				@ r0 = address of cmd
		bl printf

		@ ---- Add ID ----

		ldr r2, =ID1				@ load address of ID1
		ldr r1, [r2], #1			@ load r1 value in address of r2, then r2 = r2 + 1 ( post order )
		mov r2, #0					@ r2 = 0
		addvc r2, r1, #1			@ if ( v = 0 ) r2 = r1 + 1 ( operand2 )
		sub r2, r2, #1				@ r2 = r2 - 1
		ldr r1, =ID2				@ load address of ID2
		sub r1, r1, #3				@ r1 = r1 - 3
		ldr r1, [r1, #3]			@ r1 = r1 + 3, then load value in address of ( r1 + 3 = ID2 )	( offset )
		addeq r2, r2, r1			@ if ( Z = 1 ) r2 = r2 + r1 ( operand2 )
		ldr r1, =ID3				@ load address of ID3
		mov r3, #0					@ r3 = 0
		ldr r1, [r1]				@ load value in address of r1		( offset )
		add r3, r3, r1, asr #1 		@ r3 = r3 + ( r1 / 2 )
		addpl r2, r2, r1			@ if ( N = 0 ) r2 = r2 + r1

		ldr r1, =Sum				@ load Sum
		str r2, [r1]				@ store value of r2 to address of Sum
		

		@ ---- compare Command ----

		ldr r0, =char_pattern		@ load address of format string
		ldr r1, =Command			@ load address of Command
		bl scanf					@ read enter

		ldr r0, =char_pattern		@ load address of format string
		ldr r1, =Command			@ load address of Command
		bl scanf					@ read command


		ldr r0, =char_pattern		@ load address of format string
        ldr r1, =Command			@ load address of Command
		ldr r1, [r1]				@ load value of Command in r1
		ldr r0, =p					@ load address of p
		ldr r0, [r0]				@ load value of p in r1
		cmp r0, r1					@ compare r0 and r1, set CPSR

		@ ---- Print ID & Summation ----
		
		bleq AddID					@ if z = 1 ( z set ) do branch AddID

		@ ---- Print End ----
		ldr r0, =End				@ load address of End
		bl printf
		
		ldr r0, =ID1 
		ldr r0, [r0]
		str r0, [r4]
		
		ldr r0, =ID2 
		ldr r0, [r0]
		str r0, [r5]

		ldr r0, =ID3 
		ldr r0, [r0]
		str r0, [r6]

		ldr r0, =Sum 
		ldr r0, [r0]
		str r0, [r7]		
		
        ldmfd sp!, {r4-r7, lr}				@ pop return address from stack
        mov pc, lr

AddID:
		stmfd sp!, {lr}				@ push return address onto stack
		ldr r0, =Summation
		bl printf

		ldr r0, =int_pattern		@ load address of format string
		ldr r1, =ID1				@ load address of ID1
		ldr r1, [r1]				@ load value
		bl printf					@ prinf( "%d", ID1 )

		ldr r0, =Enter
		bl printf					@ print "\n"

		ldr r0, =int_pattern
		ldr r1, =ID2
		ldr r1, [r1]
		bl printf

		ldr r0, =Enter
		bl printf

		ldr r0, =int_pattern
		ldr r1, =ID3
		ldr r1, [r1]
		bl printf

		ldr r0, =Enter
		bl printf

		ldr r0, =Enter
		bl printf

		ldr r0, =ID
		bl printf


		ldr r0, =int_pattern
		ldr r1, =Sum
		ldr r1, [r1]
		bl printf

		ldr r0, =Enter
		bl printf
		ldmfd sp!, {lr}
		mov pc, lr






