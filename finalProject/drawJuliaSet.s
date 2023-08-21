.data
.text
	.globl drawJuliaSet

drawJuliaSet :

			stmfd sp!, {r4-r11,lr}
			movne r4, r0 					@ r4 = cY, if ( Z = 0 ) 
			movpl r5, r1 					@ r5 = frame, if ( N = 0 ) 
			mov r9, #0 						@ r9 = x
			adds r14, r0, r15 				@ !!!!!!!!!


Loop1:
			cmp	r9, #640					@ while( x < 640(width) )
			bge Done1
			mov r10, #0 					@ r10 = y

Loop2: 		
			cmp r10, #480 					@ while( y < 480( height) )
			bge Done2

			@ ---- Calculate zx ----

			mov r1, #640					@ r1 = width
			mov r1, r1, asr #1 				@ r1 = width >> 1  , operand2
			sub r2, r9, r1					@ r2 = ( x - ( width >> 1 ) )
			ldr r0, .constant				@ r0 = 1500
			mul r0, r0, r2					@ r0 = 1500 * ( x - ( width >> 1 ) )
			bl  __aeabi_idiv				@ zx = r0 = 1500 * ( x - ( width >> 1 ) ) / ( width >> 1 )
			mov r6, r0 						@ r6 = zx

			@ ---- Calculate zy ----

			mov r1, #480					@ r1 = height
			mov r1, r1, asr #1				@ r1 = height >> 1
			sub r2, r10, r1					@ r2 = ( y - ( height >> 1 ) )
			mov r0, #1000					@ r0 = 1000
			mul r0, r0, r2					@ r0 = 1000 * ( y - ( height >> 1 ) )
			bl __aeabi_idiv					@ zy = r0 = 1000 * ( y - ( height >> 1 ) ) / ( height >> 1 )
			mov r7, r0 						@ zy = r7 = r0

			@ ---- i ----
			mov r8, #255					@ i = maxIter( 255 )

While:
			@ ---- while () ----

			mul r0, r6, r6					@ r0 = zx * zx
			mul r1, r7, r7	 				@ r1 = zy * zy 							
			add r2, r0, r1					@ r0 = r0 + r1 = zx * zx + zy * zy
			ldr r3, .constant+4				@ r1 = 4000000
			cmp r2, r3						@ zx * zx + zy * zy < 4000000
			bge DoneWhile
			cmplt r8, #0 					@ i > 0 , condition (lt)
			ble DoneWhile

			@ ---- Calculate tmp ----

			sub r0, r1 						@ r0 = r0 - r1 = zx * zx - zy * zy, operand2
			mov r1, #1000					@ r1 = 1000
			bl __aeabi_idiv					@ r0 = ( zx * zx - zy * zy ) / 1000
			sub r11, r0, #700 				@ r11 = tmp = ( zx * zx - zy * zy ) / 1000 + ( - 700 ), operand2

			@ ---- Calculate zy ----
			
			mul r0, r6, r7					@ r0 = zx * zy 
			mov r0, r0, lsl # 1 			@ r0 = 2 * zx * zy
			mov r1, #1000 					@ r1 = 1000
			bl __aeabi_idiv					@ r0 = ( 2 * zx * zy ) / 1000
			add r7, r0, r4 					@ r7 = ( 2 * zx * zy ) / 1000 + cY

			@ ---- assign zx ----

			mov r6, r11

			@ ---- Calculate i ----

			sub r8, #1					@ i = i - 1
			b While


DoneWhile:
			@ ---- set color ----

			and r0, r8, #0xff				@ r0 = r8 & 0xff = ( i & 0xff )
			orr r0, r0, lsl #8				@ r0 = color = ( i & 0xff ) | ( ( i & 0xff ) << 8 )
			ldr r1, .constant+8				@ r1 = 0xffff
			bic r6, r1, r0 					@ r6 = (~color)&0xffff

			@ ---- set frame[y][x] ----

			mov r2, #1280
			mul r0, r10, r2					@ r0 = y * 1280
			add r0, r9, lsl #1				@ r0 = r0 + r9 = y * 1280 + x * 2
			strh r6, [r0, r5]!				@ frame[x][y] = color ( r0 + r5 = frame[x][y] address ) 

			@ ---- back to loop2 ----

			add r10, #1						@ r10 = r10 + 1 ( y = y + 1 )
			b Loop2

Done2:
			@ ---- back to loop1 ----

			add r9, #1						@ r9 = r9 + 1 ( x = x + 1 ) 
			b Loop1

Done1 :
			@ ---- back to caller ----

			ldmfd sp!, {r4-r11, lr}
			mov pc, lr


.constant :
			.word 	1500			@ +0
			.word 	4000000			@ +4
			.word 	0xffff			@ +8

