	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	MAX_SIZE
	.data
	.align 4
	.type	MAX_SIZE, @object
	.size	MAX_SIZE, 4
	# Объявление констант
MAX_SIZE:
	.long	1000000
	.section	.rodata
	.align 8
.LC0:
	.string	"No output file specified. Using default output file: output.txt"
	.align 8
.LC1:
	.string	"No input file specified. Generating random input."
.LC2:
	.string	"output.txt"
	.align 8
.LC3:
	.string	"\nProgram took %ld miliseconds to execute \n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp							# Начало функции main
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi		# Сохранение аргументов функции main
	mov	QWORD PTR -64[rbp], rsi
	mov	edi, 0
	call	time@PLT				# srand(time(NULL))
	mov	edi, eax				
	call	srand@PLT
	cmp	DWORD PTR -52[rbp], 1		# Проверка наличия аргументов if(argc == 1)
	jne	.L2							# Если аргументов нет, то продолжаем. Иначе переход к метке .L2
	lea	rdi, .LC0[rip]				# Подготовка аргументов для printf
	call	puts@PLT				# printf("No output file specified. Using default output file: output.txt")
	lea	rdi, .LC1[rip]				# Подготовка аргументов для printf
	call	puts@PLT				# printf("No input file specified. Generating random input.")
	lea	rax, -40[rbp]				# Подготовка вызова функции generateRandomDouble
	mov	rdi, rax					# Подготовка аргументов для generateRandomDouble
	call	generateRandomDouble@PLT # generateRandomDouble(&x)
	lea	rax, .LC2[rip]				# output_file = "output.txt"
	mov	QWORD PTR -8[rbp], rax
	jmp	.L3							# переход к метке .L3
.L2:
	cmp	DWORD PTR -52[rbp], 2		# Проверка наличия аргументов if(argc == 2)
	jne	.L4							# Если аргументов 2, то продолжаем. Иначе переход к метке .L4
	lea	rdi, .LC1[rip]				# Подготовка аргументов для printf
	call	puts@PLT				# printf("No input file specified. Generating random input.")
	lea	rax, -40[rbp]				# Подготовка вызова функции generateRandomDouble
	mov	rdi, rax					# Подготовка аргументов для generateRandomDouble
	call	generateRandomDouble@PLT # generateRandomDouble(&x)
	mov	rax, QWORD PTR -64[rbp]		
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -8[rbp], rax
	jmp	.L3							# переход к метке .L3
.L4:
	mov	rax, QWORD PTR -64[rbp]		# input_file = argv[1]
	mov	rax, QWORD PTR 8[rax]
	mov	QWORD PTR -16[rbp], rax
	lea	rdx, -40[rbp]
	mov	rax, QWORD PTR -16[rbp]		# Подготовка вызова функции readDoubleFromFile
	mov	rsi, rdx					# Подготовка аргументов для readDoubleFromFile
	mov	rdi, rax
	call	ReadFromFile@PLT		# readDoubleFromFile(input_file, &x)
	mov	rax, QWORD PTR -64[rbp]		# output_file = argv[2]
	mov	rax, QWORD PTR 16[rax]
	mov	QWORD PTR -8[rbp], rax
.L3:
	call	clock@PLT				# timer = clock()
	mov	r12, rax
	lea	rax, -40[rbp]				# Подготовка вызова функции function
	mov	rdi, rax
	call	function@PLT			# function(&x)
	call	clock@PLT				# timer = clock() - timer
	sub	rax, r12
	mov	r12, rax		# Подготовка вызова функции writeDoubleToFile
	mov	rdx, QWORD PTR -8[rbp]		# Подготовка аргументов для writeDoubleToFile
	lea	rax, -40[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	WriteToFile@PLT			# writeDoubleToFile(output_file, &x)
	mov	rax, r12		# Приведение времени к милисекундам
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT				# printf("\nProgram took %ld miliseconds to execute \n", time_taken);
	mov	eax, 0
	leave
	ret					 			# return 0;

	