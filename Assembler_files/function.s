	.file	"function.c"
	.intel_syntax noprefix
	.text
	.globl	function
	.type	function, @function
function:
	endbr64
	push	rbp								# Начало функции
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi				# Сохранение аргументов
	mov	rax, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR [rax]
	movq	xmm0, rax						# Подготовка аргументов для exp
	call	exp@PLT							# Вызов функции exp(x)
	movsd	xmm1, QWORD PTR .LC0[rip]		# Запись реультата
	divsd	xmm1, xmm0						# 1/exp(x)
	movapd	xmm0, xmm1
	mov	rax, QWORD PTR -8[rbp]				# Запись реультата
	movsd	QWORD PTR [rax], xmm0
	nop
	leave									# Конец функции
	ret

# ссылка на параметры для получения чила с плавающей точкой
.LC0:
	.long	0
	.long	1072693248
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
