	.file	"function.c"
	.intel_syntax noprefix
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
	endbr64
	push	rbp						 # Начало функции factorial
	mov	rbp, rsp
	sub	rsp, 16
	movsd	QWORD PTR -8[rbp], xmm0		 # Сохранение аргумента в стеке
	pxor	xmm0, xmm0						 # xmm0 = 0
	ucomisd	xmm0, QWORD PTR -8[rbp]			 # Сравнение аргумента с 0
	jp	.L2								 # Если аргумент < 0, то переход к метке .L2	
	pxor	xmm0, xmm0						 # xmm0 = 0
	ucomisd	xmm0, QWORD PTR -8[rbp]			 # Сравнение аргумента с 0
	jne	.L2									 # Если аргумент != 0, то переход к метке .L2
	movsd	xmm0, QWORD PTR .LC1[rip]		 # xmm0 = 1
	jmp	.L4									 # Переход к метке .L4
.L2:
	movsd	xmm0, QWORD PTR -8[rbp]			 # xmm0 = аргумент
	movsd	xmm1, QWORD PTR .LC1[rip]
	subsd	xmm0, xmm1
	call	factorial						 # Вызов функции factorial(x-1)
	mulsd	xmm0, QWORD PTR -8[rbp]			 # xmm0 = xmm0 * factorial(x-1)
.L4:
	leave									 # Конец функции factorial
	ret
	.size	factorial, .-factorial
	.globl	function
	.type	function, @function
function:
	endbr64
	push	rbp								 # Начало функции function
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi				 # Сохранение аргумента в стеке
	pxor	xmm0, xmm0
	movsd	QWORD PTR -16[rbp], xmm0			 # xmm0 = 0
	mov	DWORD PTR -4[rbp], 0					 # i = 0
	jmp	.L7									 # Переход к метке .L7
.L8:
	cvtsi2sd	xmm0, DWORD PTR -4[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR [rax]
	movapd	xmm1, xmm0						 # Подготовка аргументов к вызову функции pow
	movq	xmm0, rax 						
	call	pow@PLT							 # pow(*x, i)
	movsd	QWORD PTR -32[rbp], xmm0
	cvtsi2sd	xmm0, DWORD PTR -4[rbp]		# Подготовка аргументов к вызову функции factorial
	call	factorial						 # Вызов функции factorial(i)
	movsd	xmm2, QWORD PTR -32[rbp]
	divsd	xmm2, xmm0						 # xmm2 = pow(*x, i) / factorial(i)
	movapd	xmm0, xmm2
	movsd	xmm1, QWORD PTR -16[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0		# result += pow(*x, i) / factorial(i)
	add	DWORD PTR -4[rbp], 1				# i++
.L7:
	cmp	DWORD PTR -4[rbp], 100				 # Сравнение i с 100
	jle	.L8									 # Если i <= 100, то переход к метке .L8
	movsd	xmm0, QWORD PTR .LC1[rip]	 # xmm0 = 1
	divsd	xmm0, QWORD PTR -16[rbp]		# 1/result
	mov	rax, QWORD PTR -24[rbp]				 # Сохранение результата в стеке
	movsd	QWORD PTR [rax], xmm0				 # *x = 1/result
	nop
	leave									# Конец функции function
	ret
	.size	function, .-function
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
