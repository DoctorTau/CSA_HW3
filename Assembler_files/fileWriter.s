	.file	"fileWriter.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	# Объявление строковых констант
.LC0:
	.string	"w"
.LC1:
	.string	"Error opening file"
.LC2:
	.string	"%.10lf"
	.text
	.globl	WriteToFile
	.type	WriteToFile, @function
WriteToFile:
	endbr64
	push	rbp						# Начало функции
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi		# Сохранение аргументов
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR -32[rbp]	    # Подготовка аргументов для вызова fopen
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	fopen@PLT				# Вызов fopen для открытия файла
	mov	QWORD PTR -8[rbp], rax    	# Сохранение возвращаемого значения
	cmp	QWORD PTR -8[rbp], 0		# file == NULL
	jne	.L2							# Если file != NULL, то переход к .L2
	lea	rdi, .LC1[rip]				# Вывод сообщения об ошибке
	mov	eax, 0
	call	printf@PLT				# Вызов printf("Error opening file");
	mov	edi, 1
	call	exit@PLT				# exit(1)
.L2:
	mov	rax, QWORD PTR -24[rbp]		# Подготовка аргументов для вызова fprintf
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rdx			
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT				# Вызов fprintf(file, "%.10lf", x);
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT				# Вызов fclose(file);
	nop
	leave
	ret								# Конец функции
