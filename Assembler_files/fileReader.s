	.file	"fileReader.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	# Объявление строковых констант
.LC0:
	.string	"r"
.LC1:
	.string	"Error opening file"
.LC2:
	.string	"%lf"
	.text
	.globl	ReadFromFile
	.type	ReadFromFile, @function
ReadFromFile:
	endbr64
	push	rbp							# Начало функции
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi			# Сохранение аргументов
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR -24[rbp]			# rax = filename
	lea	rsi, .LC0[rip]					# rsi = "r"
	mov	rdi, rax						# rdi = filename
	call	fopen@PLT					# Вызов функции fopen
	mov	QWORD PTR -8[rbp], rax			# Сохранение возвращаемого значения в переменную file
	cmp	QWORD PTR -8[rbp], 0			# file == NULL
	jne	.L2								# Если file != NULL, то переход к метке .L2
	lea	rdi, .LC1[rip]					# rdi = "Error opening file"
	mov	eax, 0							# eax = 0
	call	printf@PLT					# Вызов функции printf("Error opening file");
	mov	edi, 1
	call	exit@PLT					# Вызов функции exit(1)
.L2:
	mov	rdx, QWORD PTR -32[rbp]		    # Подготовка аргументов для fscanf
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT			# Вызов функции fscanf(file, "%lf", &number)
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT					# Вызов функции fclose(file)
	nop
	leave
	ret									# Конец функции
