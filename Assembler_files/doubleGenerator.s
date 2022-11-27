	.file	"doubleGenerator.c"
	.intel_syntax noprefix
	.text
	.globl	generateRandomDouble
	.type	generateRandomDouble, @function
generateRandomDouble:
	endbr64
	push	rbp								# Начало функции
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi				# Сохранение аргументов
	call	rand@PLT						# Вызов rand
	cvtsi2sd	xmm0, eax
	movsd	xmm1, QWORD PTR .LC0[rip]		
	divsd	xmm0, xmm1						# Деление на (double)RAND_MAX
	mov	rax, QWORD PTR -8[rbp]				# Запись результата
	movsd	QWORD PTR [rax], xmm0
	nop
	leave
	ret

# ссылка на параметры для получения чила с плавающей точкой
.LC0:
	.long	4290772992
	.long	1105199103
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
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
