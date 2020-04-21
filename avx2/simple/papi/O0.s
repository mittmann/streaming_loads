	.file	"all-papi.c"
	.text
	.section	.rodata
.LC0:
	.string	"%s\n"
	.text
	.globl	fail
	.type	fail, @function
fail:
.LFB4006:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	stderr(%rip), %rax
	movq	-8(%rbp), %rdx
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE4006:
	.size	fail, .-fail
	.section	.rodata
.LC1:
	.string	"couldn't open device"
.LC2:
	.string	"%s"
.LC3:
	.string	"mmap failed."
	.text
	.globl	get_uncached_mem
	.type	get_uncached_mem, @function
get_uncached_mem:
.LFB4007:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movq	-40(%rbp), %rax
	movl	$0, %edx
	movl	$2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -28(%rbp)
	cmpl	$-1, -28(%rbp)
	jne	.L3
	leaq	.LC1(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L3:
	movl	-44(%rbp), %eax
	movslq	%eax, %rbx
	movl	$30, %edi
	call	sysconf@PLT
	subq	$1, %rax
	andq	%rbx, %rax
	testq	%rax, %rax
	je	.L4
	movl	$30, %edi
	call	sysconf@PLT
	subl	$1, %eax
	notl	%eax
	andl	-44(%rbp), %eax
	movl	%eax, %ebx
	movl	$30, %edi
	call	sysconf@PLT
	addl	%ebx, %eax
	movl	%eax, -44(%rbp)
.L4:
	movl	-44(%rbp), %eax
	cltq
	movl	-28(%rbp), %edx
	movl	$0, %r9d
	movl	%edx, %r8d
	movl	$1, %ecx
	movl	$3, %edx
	movq	%rax, %rsi
	movl	$0, %edi
	call	mmap@PLT
	movq	%rax, -24(%rbp)
	cmpq	$-1, -24(%rbp)
	jne	.L5
	leaq	.LC3(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L5:
	movq	-24(%rbp), %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4007:
	.size	get_uncached_mem, .-get_uncached_mem
	.section	.rodata
	.align 8
.LC4:
	.string	"qtd errada de args <TAMANHO TIPO_DE_MEM TEMPORALIDADE COUNTER>"
.LC5:
	.string	"huge"
.LC6:
	.string	"big"
.LC7:
	.string	"small"
.LC8:
	.string	"tamanho invalido"
.LC9:
	.string	"unc"
.LC10:
	.string	"dev"
.LC11:
	.string	"wb"
.LC12:
	.string	"tipo de mem invalido"
.LC13:
	.string	"nt"
.LC14:
	.string	"t"
.LC15:
	.string	"temporalidade invalida"
	.align 8
.LC16:
	.string	"PAPI_event_name_to_code falhou"
.LC17:
	.string	"PAPI_create_eventset falhou"
.LC18:
	.string	"PAPI_add_events falhou"
.LC19:
	.string	"PAPI_start falhou"
.LC20:
	.string	"PAPI_stop falhou"
.LC21:
	.string	"reps: %d, size: %ld\n"
.LC22:
	.string	"acc: %llu, %llu, %llu, %llu\n"
.LC23:
	.string	"PAPI_VALUE: %llu\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4008:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-64, %rsp
	subq	$384, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movl	%edi, 28(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 376(%rsp)
	xorl	%eax, %eax
	movl	$-1, 36(%rsp)
	movl	$84344832, %edi
	call	PAPI_library_init@PLT
	cmpl	$5, 28(%rsp)
	je	.L8
	leaq	.LC4(%rip), %rdi
	call	fail
.L8:
	movq	16(%rsp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L9
	movl	$40, %r12d
	movl	$49152000, %ebx
	jmp	.L10
.L9:
	movq	16(%rsp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L11
	movl	$500, %r12d
	movl	$3932160, %ebx
	jmp	.L10
.L11:
	movq	16(%rsp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC7(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L12
	movl	$10000, %r12d
	movl	$196608, %ebx
	jmp	.L10
.L12:
	leaq	.LC8(%rip), %rdi
	call	fail
.L10:
	movq	16(%rsp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	leaq	.LC9(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L13
	movl	%ebx, %eax
	sall	$5, %eax
	movl	%eax, %esi
	leaq	.LC10(%rip), %rdi
	call	get_uncached_mem
	movq	%rax, %r13
	jmp	.L14
.L13:
	movq	16(%rsp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L15
	movq	%rbx, %rax
	salq	$5, %rax
	movq	%rax, %rsi
	movl	$64, %edi
	call	aligned_alloc@PLT
	movq	%rax, %r13
	jmp	.L14
.L15:
	leaq	.LC12(%rip), %rdi
	call	fail
.L14:
	movq	16(%rsp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L16
	movl	$0, 40(%rsp)
	jmp	.L17
.L16:
	movq	16(%rsp), %rax
	addq	$24, %rax
	movq	(%rax), %rax
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L18
	movl	$1, 40(%rsp)
	jmp	.L17
.L18:
	leaq	.LC15(%rip), %rdi
	call	fail
.L17:
	movq	16(%rsp), %rax
	addq	$32, %rax
	movq	(%rax), %rax
	leaq	32(%rsp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	je	.L19
	leaq	.LC16(%rip), %rdi
	call	fail
.L19:
	mfence
	nop
	movq	%r13, 72(%rsp)
	movq	$0, 80(%rsp)
	vpbroadcastq	80(%rsp), %ymm0
	vmovdqa	%ymm0, 128(%rsp)
	movq	$0, 64(%rsp)
	jmp	.L21
.L23:
	movq	64(%rsp), %rax
	movq	%rax, 96(%rsp)
	vpbroadcastq	96(%rsp), %ymm0
	vmovdqa	%ymm0, 160(%rsp)
	movq	64(%rsp), %rax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	72(%rsp), %rax
	addq	%rdx, %rax
	movq	%rax, 88(%rsp)
	vmovdqa	160(%rsp), %ymm0
	vmovdqa	%ymm0, 192(%rsp)
	movq	88(%rsp), %rax
	vmovdqa	192(%rsp), %ymm0
	vmovntdq	%ymm0, (%rax)
	nop
	addq	$1, 64(%rsp)
.L21:
	movq	%rbx, %rax
	cmpq	%rax, 64(%rsp)
	jb	.L23
	mfence
	nop
	movl	$0, 44(%rsp)
	jmp	.L24
.L25:
	movl	44(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	72(%rsp), %rax
	addq	%rdx, %rax
	movq	%rax, 104(%rsp)
	movq	104(%rsp), %rax
	clflush	(%rax)
	nop
	addl	$2, 44(%rsp)
.L24:
	movl	44(%rsp), %eax
	cltq
	cmpq	%rax, %rbx
	jg	.L25
	mfence
	nop
	leaq	36(%rsp), %rax
	movq	%rax, %rdi
	call	PAPI_create_eventset@PLT
	testl	%eax, %eax
	je	.L26
	leaq	.LC17(%rip), %rdi
	call	fail
.L26:
	movl	32(%rsp), %edx
	movl	36(%rsp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	PAPI_add_event@PLT
	testl	%eax, %eax
	je	.L27
	leaq	.LC18(%rip), %rdi
	call	fail
.L27:
	movl	36(%rsp), %eax
	movl	%eax, %edi
	call	PAPI_start@PLT
	testl	%eax, %eax
	je	.L28
	leaq	.LC19(%rip), %rdi
	call	fail
.L28:
	cmpl	$0, 40(%rsp)
	je	.L29
	movl	$0, 48(%rsp)
	jmp	.L30
.L35:
	movl	$0, 52(%rsp)
	jmp	.L31
.L34:
	movl	52(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	72(%rsp), %rax
	addq	%rdx, %rax
	movq	%rax, 112(%rsp)
	movq	112(%rsp), %rax
	vmovdqa	(%rax), %ymm0
	vmovdqa	%ymm0, 160(%rsp)
	vmovdqa	128(%rsp), %ymm0
	vmovdqa	%ymm0, 224(%rsp)
	vmovdqa	160(%rsp), %ymm0
	vmovdqa	%ymm0, 256(%rsp)
	vmovdqa	224(%rsp), %ymm1
	vmovdqa	256(%rsp), %ymm0
	vpaddq	%ymm0, %ymm1, %ymm0
	nop
	vmovdqa	%ymm0, 128(%rsp)
	addl	$1, 52(%rsp)
.L31:
	movl	52(%rsp), %eax
	cltq
	cmpq	%rax, %rbx
	jg	.L34
	addl	$1, 48(%rsp)
.L30:
	cmpl	%r12d, 48(%rsp)
	jl	.L35
	jmp	.L36
.L29:
	movl	$0, 56(%rsp)
	jmp	.L37
.L42:
	movl	$0, 60(%rsp)
	jmp	.L38
.L41:
	movl	60(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	72(%rsp), %rax
	addq	%rdx, %rax
	movq	%rax, 120(%rsp)
	movq	120(%rsp), %rax
	vmovntdqa	(%rax), %ymm0
	nop
	vmovdqa	%ymm0, 160(%rsp)
	vmovdqa	128(%rsp), %ymm0
	vmovdqa	%ymm0, 288(%rsp)
	vmovdqa	160(%rsp), %ymm0
	vmovdqa	%ymm0, 320(%rsp)
	vmovdqa	288(%rsp), %ymm1
	vmovdqa	320(%rsp), %ymm0
	vpaddq	%ymm0, %ymm1, %ymm0
	nop
	vmovdqa	%ymm0, 128(%rsp)
	addl	$1, 60(%rsp)
.L38:
	movl	60(%rsp), %eax
	cltq
	cmpq	%rax, %rbx
	jg	.L41
	addl	$1, 56(%rsp)
.L37:
	cmpl	%r12d, 56(%rsp)
	jl	.L42
.L36:
	mfence
	nop
	movl	36(%rsp), %eax
	leaq	368(%rsp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	PAPI_stop@PLT
	testl	%eax, %eax
	je	.L43
	leaq	.LC20(%rip), %rdi
	call	fail
.L43:
	movl	32(%rsp), %edx
	movl	36(%rsp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	PAPI_remove_event@PLT
	call	PAPI_shutdown@PLT
	movq	%rbx, %rdx
	movl	%r12d, %esi
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	152(%rsp), %rsi
	movq	144(%rsp), %rcx
	movq	136(%rsp), %rdx
	movq	128(%rsp), %rax
	movq	%rsi, %r8
	movq	%rax, %rsi
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	368(%rsp), %rax
	movq	%rax, %rsi
	leaq	.LC23(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	128(%rsp), %rax
	movq	376(%rsp), %rcx
	xorq	%fs:40, %rcx
	je	.L45
	call	__stack_chk_fail@PLT
.L45:
	leaq	-24(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4008:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008"
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
