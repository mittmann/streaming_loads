	.file	"multi512.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s\n"
	.text
	.p2align 4,,15
	.globl	fail
	.type	fail, @function
fail:
.LFB4819:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdi, %rcx
	movq	stderr(%rip), %rdi
	leaq	.LC0(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	movl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE4819:
	.size	fail, .-fail
	.section	.rodata.str1.1
.LC1:
	.string	"PAPI_create_eventset falhou"
.LC2:
	.string	"PAPI_add_events falhou"
.LC3:
	.string	"PAPI_start falhou"
.LC4:
	.string	"PAPI_stop falhou"
	.text
	.p2align 4,,15
	.globl	read_stream
	.type	read_stream, @function
read_stream:
.LFB4821:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	movq	%rdi, %rbx
	subq	$72, %rsp
	movl	$-1, -60(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	call	pthread_self@PLT
	leaq	72(%rbx), %rdx
	movl	$128, %esi
	movq	%rax, %rdi
	call	pthread_setaffinity_np@PLT
	leaq	-60(%rbp), %rdi
	movl	(%rbx), %r13d
	movq	8(%rbx), %r14
	call	PAPI_create_eventset@PLT
	testl	%eax, %eax
	jne	.L26
	movq	48(%rbx), %rsi
	movl	-60(%rbp), %edi
	movl	$3, %edx
	call	PAPI_add_events@PLT
	testl	%eax, %eax
	jne	.L27
	movl	-60(%rbp), %edi
	call	PAPI_start@PLT
	testl	%eax, %eax
	jne	.L28
	movl	40(%rbx), %eax
	movl	%r14d, %r12d
	movq	56(%rbx), %rsi
	vpxord	%zmm0, %zmm0, %zmm0
	testl	%eax, %eax
	jne	.L8
	testl	%r14d, %r14d
	je	.L9
	leal	-1(%r13), %eax
	xorl	%ecx, %ecx
	salq	$6, %rax
	leaq	64(%rsi,%rax), %rdx
	.p2align 4,,10
	.p2align 3
.L10:
	testl	%r13d, %r13d
	movq	%rsi, %rax
	je	.L15
	.p2align 4,,10
	.p2align 3
.L14:
	vmovntdqa	(%rax), %zmm1
	addq	$64, %rax
	cmpq	%rax, %rdx
	vpaddq	%zmm1, %zmm0, %zmm0
	jne	.L14
.L15:
	addl	$1, %ecx
	cmpl	%ecx, %r12d
	jne	.L10
.L9:
	movq	64(%rbx), %rax
	leaq	16(%rbx), %rsi
	vmovdqa64	%zmm0, (%rax)
	movl	-60(%rbp), %edi
	vzeroupper
	call	PAPI_stop@PLT
	testl	%eax, %eax
	jne	.L29
	movl	-60(%rbp), %edi
	movq	48(%rbx), %rsi
	movl	$3, %edx
	call	PAPI_remove_events@PLT
	xorl	%eax, %eax
	movq	-56(%rbp), %rdi
	xorq	%fs:40, %rdi
	jne	.L30
	addq	$72, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	.cfi_restore_state
	testl	%r14d, %r14d
	je	.L9
	leal	-1(%r13), %eax
	xorl	%ecx, %ecx
	salq	$6, %rax
	leaq	64(%rsi,%rax), %rdx
	.p2align 4,,10
	.p2align 3
.L11:
	testl	%r13d, %r13d
	movq	%rsi, %rax
	je	.L13
	.p2align 4,,10
	.p2align 3
.L12:
	vmovdqa64	(%rax), %zmm1
	addq	$64, %rax
	cmpq	%rax, %rdx
	vpaddq	%zmm1, %zmm0, %zmm0
	jne	.L12
.L13:
	addl	$1, %ecx
	cmpl	%ecx, %r12d
	jne	.L11
	jmp	.L9
.L28:
	leaq	.LC3(%rip), %rdi
	call	fail
.L30:
	call	__stack_chk_fail@PLT
.L29:
	leaq	.LC4(%rip), %rdi
	call	fail
.L27:
	leaq	.LC2(%rip), %rdi
	call	fail
.L26:
	leaq	.LC1(%rip), %rdi
	call	fail
	.cfi_endproc
.LFE4821:
	.size	read_stream, .-read_stream
	.section	.rodata.str1.1
.LC5:
	.string	"couldn't open device"
.LC6:
	.string	"%s"
.LC7:
	.string	"mmap failed."
	.text
	.p2align 4,,15
	.globl	get_uncached_mem
	.type	get_uncached_mem, @function
get_uncached_mem:
.LFB4820:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%edx, %edx
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%eax, %eax
	movl	%esi, %r12d
	movl	$2, %esi
	call	open@PLT
	cmpl	$-1, %eax
	movl	%eax, %ebp
	je	.L40
.L32:
	movl	$30, %edi
	call	sysconf@PLT
	movslq	%r12d, %rsi
	subq	$1, %rax
	testq	%rsi, %rax
	jne	.L41
.L33:
	xorl	%r9d, %r9d
	xorl	%edi, %edi
	movl	%ebp, %r8d
	movl	$1, %ecx
	movl	$3, %edx
	call	mmap@PLT
	cmpq	$-1, %rax
	movq	%rax, %rbx
	je	.L42
	movq	%rbx, %rax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L41:
	.cfi_restore_state
	movl	$30, %edi
	call	sysconf@PLT
	movl	$30, %edi
	movq	%rax, %rbx
	call	sysconf@PLT
	movl	%ebx, %esi
	negl	%esi
	andl	%r12d, %esi
	addl	%eax, %esi
	movslq	%esi, %rsi
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L40:
	leaq	.LC5(%rip), %rdx
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L42:
	leaq	.LC7(%rip), %rdx
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4820:
	.size	get_uncached_mem, .-get_uncached_mem
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC8:
	.string	"qtd errada de args <TAMANHO_A REPS_A TIPO_A TEMP_A TAMANHO_B REPS_B TIPO_B TEMP_B CORE_1 CORE_2> <opt: 3 counters papi>"
	.section	.rodata.str1.1
.LC9:
	.string	"unc"
.LC10:
	.string	"wc"
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
.LC16:
	.string	"Core 1: %d, Core 2: %d\n"
.LC17:
	.string	"papi_einval"
.LC18:
	.string	"papi library init falhou"
.LC19:
	.string	"PAPI_TOT_CYC"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"PAPI_event_name_to_code falhou cyc"
	.section	.rodata.str1.1
.LC21:
	.string	"PAPI_L3_TCM"
	.section	.rodata.str1.8
	.align 8
.LC22:
	.string	"PAPI_event_name_to_code falhou tcm"
	.section	.rodata.str1.1
.LC23:
	.string	"PAPI_L3_TCR"
	.section	.rodata.str1.8
	.align 8
.LC24:
	.string	"PAPI_event_name_to_code falhou tcr"
	.align 8
.LC25:
	.string	"PAPI_event_name_to_code falhou 1"
	.align 8
.LC26:
	.string	"PAPI_event_name_to_code falhou 2"
	.align 8
.LC27:
	.string	"PAPI_event_name_to_code falhou 3"
	.align 8
.LC28:
	.string	"quantidade invalida de argumentos"
	.section	.rodata.str1.1
.LC29:
	.string	"size a: %u, mem a: %p\n"
.LC30:
	.string	"size b: %u, mem b: %p\n"
	.section	.rodata.str1.8
	.align 8
.LC31:
	.string	"acc_a: %llu, reps_a: %llu, size_a: %uKB \n"
	.align 8
.LC32:
	.string	"acc_b: %llu, reps_b: %llu, size_b: %uKB \n"
	.section	.rodata.str1.1
.LC33:
	.string	"PAPI_THREAD_A:%s:%llu\n"
.LC34:
	.string	"PAPI_THREAD_B:%s:%llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB4822:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	subq	$1024, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	leaq	-1008(%rbp), %rax
	cmpl	$10, %edi
	movq	%rax, -800(%rbp)
	leaq	-944(%rbp), %rax
	movq	%rax, -592(%rbp)
	jle	.L93
	movl	%edi, %r14d
	movq	8(%rsi), %rdi
	movq	%rsi, %r12
	movl	$10, %edx
	xorl	%esi, %esi
	leaq	.LC9(%rip), %rbx
	call	strtol@PLT
	movq	16(%r12), %rdi
	sall	$4, %eax
	xorl	%esi, %esi
	movl	$10, %edx
	movl	%eax, -864(%rbp)
	call	strtoll@PLT
	movq	24(%r12), %r13
	movq	%rax, -856(%rbp)
	movl	$4, %ecx
	movq	%rbx, %rdi
	movq	%r13, %rsi
	repz cmpsb
	seta	%al
	sbbb	$0, %al
	testb	%al, %al
	jne	.L45
	movl	-864(%rbp), %esi
	cmpl	$2063, %esi
	jbe	.L46
	sall	$6, %esi
	movq	%rbx, %rdi
	call	get_uncached_mem
	movq	%rax, -808(%rbp)
.L47:
	movq	32(%r12), %rdx
	leaq	.LC13(%rip), %r13
	movl	$3, %ecx
	movq	%r13, %rdi
	movq	%rdx, %rsi
	repz cmpsb
	seta	%al
	sbbb	$0, %al
	testb	%al, %al
	jne	.L52
	movl	$0, -824(%rbp)
.L53:
	movq	40(%r12), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	call	strtol@PLT
	movq	48(%r12), %rdi
	sall	$4, %eax
	xorl	%esi, %esi
	movl	$10, %edx
	movl	%eax, -656(%rbp)
	call	strtoll@PLT
	movq	56(%r12), %r15
	movq	%rax, -648(%rbp)
	movl	$4, %ecx
	movq	%rbx, %rdi
	movq	%r15, %rsi
	repz cmpsb
	seta	%al
	sbbb	$0, %al
	testb	%al, %al
	jne	.L55
	movl	-656(%rbp), %esi
	cmpl	$2063, %esi
	jbe	.L56
	leaq	.LC9(%rip), %rdi
	sall	$6, %esi
	call	get_uncached_mem
	movq	%rax, -600(%rbp)
.L57:
	movq	64(%r12), %rdx
	movl	$3, %ecx
	movq	%r13, %rdi
	movq	%rdx, %rsi
	repz cmpsb
	seta	%al
	sbbb	$0, %al
	testb	%al, %al
	jne	.L61
	movl	$0, -616(%rbp)
.L62:
	movq	72(%r12), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	leaq	-864(%rbp), %rbx
	call	strtol@PLT
	movq	80(%r12), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	movq	%rax, %r15
	call	strtol@PLT
	leaq	.LC16(%rip), %rsi
	movl	%eax, %ecx
	movl	%r15d, %edx
	movl	$1, %edi
	movq	%rax, %r13
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	72(%rbx), %rdx
	xorl	%eax, %eax
	movl	$16, %ecx
	movq	%rdx, %rdi
	rep stosq
	movslq	%r15d, %rcx
	cmpq	$1023, %rcx
	ja	.L63
	movq	%rcx, %rsi
	movl	$1, %eax
	shrq	$6, %rsi
	salq	%cl, %rax
	orq	%rax, (%rdx,%rsi,8)
.L63:
	movslq	%r13d, %rcx
	cmpq	$1023, %rcx
	ja	.L64
	movq	%rcx, %rdx
	movl	$1, %eax
	shrq	$6, %rdx
	salq	%cl, %rax
	orq	%rax, -584(%rbp,%rdx,8)
.L64:
	movl	$84279296, %edi
	call	PAPI_library_init@PLT
	cmpl	$84279296, %eax
	jne	.L94
	cmpl	$11, %r14d
	je	.L95
	cmpl	$14, %r14d
	jne	.L72
	leaq	-1044(%rbp), %r13
	movq	88(%r12), %rdi
	movq	%r13, %rsi
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L96
	movl	-1044(%rbp), %eax
	movq	96(%r12), %rdi
	movq	%r13, %rsi
	movl	%eax, -876(%rbp)
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L97
	movl	-1044(%rbp), %eax
	movq	104(%r12), %rdi
	movq	%r13, %rsi
	movl	%eax, -872(%rbp)
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L98
.L75:
	movl	-1044(%rbp), %eax
	leaq	.LC29(%rip), %rsi
	movl	$1, %edi
	movl	%eax, -868(%rbp)
	leaq	-876(%rbp), %rax
	movq	%rax, -816(%rbp)
	movq	%rax, -608(%rbp)
	xorl	%eax, %eax
	mfence
	movq	-808(%rbp), %rcx
	movl	-864(%rbp), %edx
	call	__printf_chk@PLT
	movq	-600(%rbp), %rcx
	movl	-656(%rbp), %edx
	leaq	.LC30(%rip), %rsi
	xorl	%eax, %eax
	movl	$1, %edi
	call	__printf_chk@PLT
	movl	-864(%rbp), %esi
	testl	%esi, %esi
	je	.L76
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L77:
	movq	%rax, %rdx
	vpbroadcastq	%rax, %zmm0
	addq	$1, %rax
	salq	$6, %rdx
	addq	-808(%rbp), %rdx
	vmovntdq	%zmm0, (%rdx)
	movl	-864(%rbp), %edx
	cmpq	%rax, %rdx
	ja	.L77
.L76:
	mfence
	movl	-864(%rbp), %ecx
	testl	%ecx, %ecx
	je	.L78
	movq	-808(%rbp), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L79:
	movl	%eax, %edx
	salq	$6, %rdx
	clflush	(%rcx,%rdx)
	addl	$1, %eax
	cmpl	%eax, -864(%rbp)
	ja	.L79
.L78:
	mfence
	movl	-656(%rbp), %edx
	testl	%edx, %edx
	je	.L80
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L81:
	movq	%rax, %rdx
	vpbroadcastq	%rax, %zmm0
	addq	$1, %rax
	salq	$6, %rdx
	addq	-600(%rbp), %rdx
	vmovntdq	%zmm0, (%rdx)
	movl	-656(%rbp), %edx
	cmpq	%rax, %rdx
	ja	.L81
.L80:
	mfence
	movl	-656(%rbp), %eax
	testl	%eax, %eax
	je	.L82
	movq	-600(%rbp), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L83:
	movl	%eax, %edx
	salq	$6, %rdx
	clflush	(%rcx,%rdx)
	addl	$1, %eax
	cmpl	%eax, -656(%rbp)
	ja	.L83
.L82:
	leaq	-1040(%rbp), %rdi
	leaq	read_stream(%rip), %rdx
	movq	%rbx, %rcx
	xorl	%esi, %esi
	mfence
	vzeroupper
	call	pthread_create@PLT
	leaq	-656(%rbp), %rcx
	leaq	read_stream(%rip), %rdx
	leaq	-1032(%rbp), %rdi
	xorl	%esi, %esi
	leaq	-448(%rbp), %r13
	leaq	-320(%rbp), %r12
	call	pthread_create@PLT
	movq	-1040(%rbp), %rdi
	xorl	%esi, %esi
	leaq	-192(%rbp), %rbx
	call	pthread_join@PLT
	movq	-1032(%rbp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
	mfence
	call	PAPI_shutdown@PLT
	movl	-876(%rbp), %edi
	movq	%r13, %rsi
	call	PAPI_event_code_to_name@PLT
	movl	-872(%rbp), %edi
	movq	%r12, %rsi
	call	PAPI_event_code_to_name@PLT
	movl	-868(%rbp), %edi
	movq	%rbx, %rsi
	call	PAPI_event_code_to_name@PLT
	movq	-800(%rbp), %rax
	movl	-864(%rbp), %r8d
	leaq	.LC31(%rip), %rsi
	movq	-856(%rbp), %rcx
	movl	$1, %edi
	movq	(%rax), %rdx
	sall	$6, %r8d
	xorl	%eax, %eax
	shrl	$10, %r8d
	call	__printf_chk@PLT
	movq	-592(%rbp), %rax
	movl	-656(%rbp), %r8d
	leaq	.LC32(%rip), %rsi
	movq	-648(%rbp), %rcx
	movl	$1, %edi
	movq	(%rax), %rdx
	sall	$6, %r8d
	xorl	%eax, %eax
	shrl	$10, %r8d
	call	__printf_chk@PLT
	movq	-848(%rbp), %rcx
	leaq	.LC33(%rip), %rsi
	movq	%r13, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	-840(%rbp), %rcx
	leaq	.LC33(%rip), %rsi
	movq	%r12, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	-832(%rbp), %rcx
	leaq	.LC33(%rip), %rsi
	movq	%rbx, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	-640(%rbp), %rcx
	leaq	.LC34(%rip), %rsi
	movq	%r13, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	-632(%rbp), %rcx
	leaq	.LC34(%rip), %rsi
	movq	%r12, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	-624(%rbp), %rcx
	leaq	.LC34(%rip), %rsi
	movq	%rbx, %rdx
	xorl	%eax, %eax
	movl	$1, %edi
	call	__printf_chk@PLT
	movq	-592(%rbp), %rax
	movq	-800(%rbp), %rdx
	movq	(%rax), %rax
	addl	(%rdx), %eax
	movq	-56(%rbp), %rbx
	xorq	%fs:40, %rbx
	jne	.L99
	addq	$1024, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L45:
	.cfi_restore_state
	leaq	.LC10(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L100
	leaq	.LC11(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L50
	movl	-864(%rbp), %edx
	leaq	-1024(%rbp), %rdi
	movl	$64, %esi
	sall	$6, %edx
	call	posix_memalign@PLT
	xorl	%edx, %edx
	testl	%eax, %eax
	jne	.L51
	movq	-1024(%rbp), %rdx
.L51:
	movq	%rdx, -808(%rbp)
	jmp	.L47
.L100:
	movl	-864(%rbp), %esi
	cmpl	$2063, %esi
	jbe	.L49
	leaq	.LC10(%rip), %rdi
	sall	$6, %esi
	call	get_uncached_mem
	movq	%rax, -808(%rbp)
	jmp	.L47
.L46:
	movl	$131072, %esi
	movq	%rbx, %rdi
	call	get_uncached_mem
	movq	%rax, -808(%rbp)
	jmp	.L47
.L52:
	leaq	.LC14(%rip), %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L54
	movl	$1, -824(%rbp)
	jmp	.L53
.L61:
	leaq	.LC14(%rip), %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L54
	movl	$1, -616(%rbp)
	jmp	.L62
.L55:
	leaq	.LC10(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L58
	movl	-656(%rbp), %esi
	cmpl	$2063, %esi
	jbe	.L59
	leaq	.LC10(%rip), %rdi
	sall	$6, %esi
	call	get_uncached_mem
	movq	%rax, -600(%rbp)
	jmp	.L57
.L56:
	leaq	.LC9(%rip), %rdi
	movl	$131072, %esi
	call	get_uncached_mem
	movq	%rax, -600(%rbp)
	jmp	.L57
.L58:
	leaq	.LC11(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L50
	movl	-656(%rbp), %edx
	leaq	-1016(%rbp), %rdi
	movl	$64, %esi
	sall	$6, %edx
	call	posix_memalign@PLT
	xorl	%edx, %edx
	testl	%eax, %eax
	jne	.L60
	movq	-1016(%rbp), %rdx
.L60:
	movq	%rdx, -600(%rbp)
	jmp	.L57
.L95:
	leaq	-1044(%rbp), %r12
	leaq	.LC19(%rip), %rdi
	movq	%r12, %rsi
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L101
	movl	-1044(%rbp), %eax
	leaq	.LC21(%rip), %rdi
	movq	%r12, %rsi
	movl	%eax, -876(%rbp)
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L102
	movl	-1044(%rbp), %eax
	leaq	.LC23(%rip), %rdi
	movq	%r12, %rsi
	movl	%eax, -872(%rbp)
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	je	.L75
	leaq	.LC24(%rip), %rdi
	call	fail
.L59:
	leaq	.LC10(%rip), %rdi
	movl	$131072, %esi
	call	get_uncached_mem
	movq	%rax, -600(%rbp)
	jmp	.L57
.L49:
	leaq	.LC10(%rip), %rdi
	movl	$131072, %esi
	call	get_uncached_mem
	movq	%rax, -808(%rbp)
	jmp	.L47
.L94:
	movl	$84279296, %edi
	call	PAPI_library_init@PLT
	addl	$1, %eax
	je	.L103
.L66:
	leaq	.LC18(%rip), %rdi
	call	fail
.L93:
	leaq	.LC8(%rip), %rdi
	call	fail
.L99:
	call	__stack_chk_fail@PLT
.L54:
	leaq	.LC15(%rip), %rdi
	call	fail
.L98:
	leaq	.LC27(%rip), %rdi
	call	fail
.L50:
	leaq	.LC12(%rip), %rdi
	call	fail
.L103:
	leaq	.LC17(%rip), %rdi
	call	puts@PLT
	jmp	.L66
.L97:
	leaq	.LC26(%rip), %rdi
	call	fail
.L72:
	leaq	.LC28(%rip), %rdi
	call	fail
.L101:
	leaq	.LC20(%rip), %rdi
	call	fail
.L102:
	leaq	.LC22(%rip), %rdi
	call	fail
.L96:
	leaq	.LC25(%rip), %rdi
	call	fail
	.cfi_endproc
.LFE4822:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
