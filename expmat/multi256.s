	.file	"multi256.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s\n"
	.text
	.p2align 4
	.globl	fail
	.type	fail, @function
fail:
.LFB5345:
	.cfi_startproc
	endbr64
	pushq	%rax
	.cfi_def_cfa_offset 16
	popq	%rax
	.cfi_def_cfa_offset 8
	leaq	.LC0(%rip), %rdx
	movl	$1, %esi
	xorl	%eax, %eax
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdi, %rcx
	movq	stderr(%rip), %rdi
	call	__fprintf_chk@PLT
	movl	$-1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE5345:
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
	.p2align 4
	.globl	read_stream
	.type	read_stream, @function
read_stream:
.LFB5347:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r14
	pushq	%r13
	pushq	%r12
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$32, %rsp
	.cfi_offset 3, -48
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movl	$-1, 20(%rsp)
	call	pthread_self@PLT
	leaq	72(%r12), %rdx
	movl	$128, %esi
	movq	%rax, %rdi
	call	pthread_setaffinity_np@PLT
	leaq	20(%rsp), %rdi
	movl	(%r12), %ebx
	movq	8(%r12), %r14
	call	PAPI_create_eventset@PLT
	testl	%eax, %eax
	jne	.L29
	movq	48(%r12), %rsi
	movl	20(%rsp), %edi
	movl	$3, %edx
	call	PAPI_add_events@PLT
	testl	%eax, %eax
	jne	.L30
	movl	20(%rsp), %edi
	call	PAPI_start@PLT
	testl	%eax, %eax
	jne	.L31
	movl	40(%r12), %eax
	movq	56(%r12), %rcx
	movl	%r14d, %r13d
	xorl	%esi, %esi
	vpxor	%xmm0, %xmm0, %xmm0
	testl	%eax, %eax
	je	.L32
	testl	%r14d, %r14d
	je	.L10
	.p2align 4,,10
	.p2align 3
.L11:
	xorl	%eax, %eax
	testl	%ebx, %ebx
	je	.L13
	.p2align 4,,10
	.p2align 3
.L12:
	movl	%eax, %edx
	addl	$2, %eax
	salq	$5, %rdx
	vmovdqa	(%rcx,%rdx), %ymm1
	vpaddq	%ymm1, %ymm0, %ymm0
	cmpl	%eax, %ebx
	ja	.L12
.L13:
	addl	$1, %esi
	cmpl	%esi, %r13d
	jne	.L11
.L10:
	movq	64(%r12), %rax
	leaq	16(%r12), %rsi
	vmovdqa	%ymm0, (%rax)
	movl	20(%rsp), %edi
	vzeroupper
	call	PAPI_stop@PLT
	testl	%eax, %eax
	jne	.L33
	movq	48(%r12), %rsi
	movl	20(%rsp), %edi
	movl	$3, %edx
	call	PAPI_remove_events@PLT
	movq	24(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L34
	leaq	-32(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L32:
	.cfi_restore_state
	testl	%r14d, %r14d
	je	.L10
	.p2align 4,,10
	.p2align 3
.L9:
	xorl	%eax, %eax
	testl	%ebx, %ebx
	je	.L15
	.p2align 4,,10
	.p2align 3
.L14:
	movl	%eax, %edx
	addl	$2, %eax
	salq	$5, %rdx
	vmovntdqa	(%rcx,%rdx), %ymm1
	vpaddq	%ymm1, %ymm0, %ymm0
	cmpl	%eax, %ebx
	ja	.L14
.L15:
	addl	$1, %esi
	cmpl	%esi, %r13d
	jne	.L9
	jmp	.L10
.L33:
	leaq	.LC4(%rip), %rdi
	call	fail
.L34:
	call	__stack_chk_fail@PLT
.L31:
	leaq	.LC3(%rip), %rdi
	call	fail
.L30:
	leaq	.LC2(%rip), %rdi
	call	fail
.L29:
	leaq	.LC1(%rip), %rdi
	call	fail
	.cfi_endproc
.LFE5347:
	.size	read_stream, .-read_stream
	.section	.rodata.str1.1
.LC5:
	.string	"couldn't open device"
.LC6:
	.string	"%s"
.LC7:
	.string	"mmap failed."
	.text
	.p2align 4
	.globl	get_uncached_mem
	.type	get_uncached_mem, @function
get_uncached_mem:
.LFB5346:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	xorl	%edx, %edx
	xorl	%eax, %eax
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	movl	$2, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	open@PLT
	movl	%eax, %r12d
	cmpl	$-1, %eax
	je	.L43
.L36:
	movl	$30, %edi
	call	sysconf@PLT
	movslq	%ebp, %rsi
	subq	$1, %rax
	testq	%rsi, %rax
	jne	.L44
.L37:
	movl	%r12d, %r8d
	xorl	%r9d, %r9d
	movl	$1, %ecx
	movl	$3, %edx
	xorl	%edi, %edi
	call	mmap@PLT
	movq	%rax, %r12
	cmpq	$-1, %rax
	je	.L45
	movq	%r12, %rax
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
.L44:
	.cfi_restore_state
	movl	$30, %edi
	call	sysconf@PLT
	movl	$30, %edi
	movq	%rax, %rbx
	call	sysconf@PLT
	negl	%ebx
	andl	%ebp, %ebx
	leal	(%rbx,%rax), %esi
	movslq	%esi, %rsi
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L43:
	leaq	.LC5(%rip), %rdx
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L36
	.p2align 4,,10
	.p2align 3
.L45:
	leaq	.LC7(%rip), %rdx
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5346:
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
	.string	"t"
.LC14:
	.string	"temporalidade invalida"
.LC15:
	.string	"Core 1: %d, Core 2: %d\n"
.LC16:
	.string	"papi_einval"
.LC17:
	.string	"papi library init falhou"
.LC18:
	.string	"PAPI_TOT_CYC"
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	"PAPI_event_name_to_code falhou cyc"
	.section	.rodata.str1.1
.LC20:
	.string	"PAPI_L3_TCM"
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"PAPI_event_name_to_code falhou tcm"
	.section	.rodata.str1.1
.LC22:
	.string	"PAPI_L3_TCR"
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"PAPI_event_name_to_code falhou tcr"
	.align 8
.LC24:
	.string	"PAPI_event_name_to_code falhou 1"
	.align 8
.LC25:
	.string	"PAPI_event_name_to_code falhou 2"
	.align 8
.LC26:
	.string	"PAPI_event_name_to_code falhou 3"
	.align 8
.LC27:
	.string	"quantidade invalida de argumentos"
	.section	.rodata.str1.1
.LC28:
	.string	"size a: %u, mem a: %p\n"
.LC29:
	.string	"size b: %u, mem b: %p\n"
	.section	.rodata.str1.8
	.align 8
.LC30:
	.string	"acc_a: %llu, reps_a: %llu, size_a: %uKB \n"
	.align 8
.LC31:
	.string	"acc_b: %llu, reps_b: %llu, size_b: %uKB \n"
	.section	.rodata.str1.1
.LC32:
	.string	"PAPI_THREAD_A:%s:%llu\n"
.LC33:
	.string	"PAPI_THREAD_B:%s:%llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5348:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$960, %rsp
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	.cfi_offset 3, -48
	movq	%fs:40, %rax
	movq	%rax, 952(%rsp)
	xorl	%eax, %eax
	leaq	64(%rsp), %rax
	movq	%rax, 208(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 416(%rsp)
	cmpl	$10, %edi
	jle	.L98
	movl	%edi, %r14d
	movq	8(%rsi), %rdi
	movq	%rsi, %rbx
	xorl	%esi, %esi
	movl	$10, %edx
	leaq	.LC9(%rip), %r12
	call	strtol@PLT
	movq	16(%rbx), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	sall	$5, %eax
	movl	%eax, 144(%rsp)
	call	strtoll@PLT
	movq	24(%rbx), %r13
	movl	$4, %ecx
	movq	%r12, %rdi
	movq	%rax, 152(%rsp)
	movq	%r13, %rsi
	repz cmpsb
	seta	%al
	sbbb	$0, %al
	testb	%al, %al
	jne	.L48
	movl	144(%rsp), %esi
	cmpl	$4127, %esi
	jbe	.L49
	sall	$5, %esi
	movq	%r12, %rdi
	call	get_uncached_mem
	movq	%rax, 200(%rsp)
.L50:
	movq	32(%rbx), %rdi
	cmpb	$110, (%rdi)
	jne	.L56
	cmpb	$116, 1(%rdi)
	jne	.L56
	cmpb	$0, 2(%rdi)
	jne	.L56
	movl	$0, 184(%rsp)
.L57:
	movq	40(%rbx), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	call	strtol@PLT
	movq	48(%rbx), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	sall	$5, %eax
	movl	%eax, 352(%rsp)
	call	strtoll@PLT
	movq	56(%rbx), %r13
	movl	$4, %ecx
	movq	%r12, %rdi
	movq	%rax, 360(%rsp)
	movq	%r13, %rsi
	repz cmpsb
	seta	%al
	sbbb	$0, %al
	testb	%al, %al
	jne	.L59
	movl	352(%rsp), %esi
	cmpl	$4127, %esi
	jbe	.L60
	sall	$5, %esi
	leaq	.LC9(%rip), %rdi
	call	get_uncached_mem
	movq	%rax, 408(%rsp)
.L61:
	movq	64(%rbx), %rdi
	cmpb	$110, (%rdi)
	jne	.L66
	cmpb	$116, 1(%rdi)
	jne	.L66
	cmpb	$0, 2(%rdi)
	jne	.L66
	movl	$0, 392(%rsp)
.L67:
	movq	72(%rbx), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	80(%rbx), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	movq	%rax, %r13
	call	strtol@PLT
	movl	%r13d, %edx
	movl	$1, %edi
	leaq	.LC15(%rip), %rsi
	movl	%eax, %ecx
	movq	%rax, %r12
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	216(%rsp), %rdx
	movl	$16, %ecx
	xorl	%eax, %eax
	movq	%rdx, %rdi
	rep stosq
	movslq	%r13d, %rcx
	cmpq	$1023, %rcx
	ja	.L68
	movq	%rcx, %rsi
	movl	$1, %eax
	shrq	$6, %rsi
	salq	%cl, %rax
	orq	%rax, (%rdx,%rsi,8)
.L68:
	movslq	%r12d, %rcx
	cmpq	$1023, %rcx
	ja	.L69
	movq	%rcx, %rdx
	movl	$1, %eax
	shrq	$6, %rdx
	salq	%cl, %rax
	orq	%rax, 424(%rsp,%rdx,8)
.L69:
	movl	$100663296, %edi
	call	PAPI_library_init@PLT
	cmpl	$100663296, %eax
	jne	.L99
	cmpl	$11, %r14d
	je	.L100
	cmpl	$14, %r14d
	jne	.L77
	leaq	28(%rsp), %r12
	movq	88(%rbx), %rdi
	movq	%r12, %rsi
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L101
	movl	28(%rsp), %eax
	movq	96(%rbx), %rdi
	movq	%r12, %rsi
	movl	%eax, 132(%rsp)
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L102
	movl	28(%rsp), %eax
	movq	104(%rbx), %rdi
	movq	%r12, %rsi
	movl	%eax, 136(%rsp)
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L103
.L80:
	movl	28(%rsp), %eax
	leaq	.LC28(%rip), %rsi
	movl	$1, %edi
	movl	%eax, 140(%rsp)
	leaq	132(%rsp), %rax
	movq	%rax, 192(%rsp)
	movq	%rax, 400(%rsp)
	xorl	%eax, %eax
	mfence
	movq	200(%rsp), %rcx
	movl	144(%rsp), %edx
	call	__printf_chk@PLT
	movq	408(%rsp), %rcx
	movl	$1, %edi
	xorl	%eax, %eax
	movl	352(%rsp), %edx
	leaq	.LC29(%rip), %rsi
	call	__printf_chk@PLT
	movl	144(%rsp), %esi
	testl	%esi, %esi
	je	.L81
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L82:
	movq	%rax, %rdx
	vmovq	%rax, %xmm1
	addq	$1, %rax
	salq	$5, %rdx
	vpbroadcastq	%xmm1, %ymm0
	addq	200(%rsp), %rdx
	vmovntdq	%ymm0, (%rdx)
	movl	144(%rsp), %edx
	cmpq	%rax, %rdx
	ja	.L82
.L81:
	mfence
	movl	144(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L83
	movq	200(%rsp), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L84:
	movl	%eax, %edx
	salq	$5, %rdx
	clflush	(%rcx,%rdx)
	addl	$2, %eax
	cmpl	%eax, 144(%rsp)
	ja	.L84
.L83:
	mfence
	movl	352(%rsp), %edx
	testl	%edx, %edx
	je	.L85
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L86:
	movq	%rax, %rdx
	vmovq	%rax, %xmm2
	addq	$1, %rax
	salq	$5, %rdx
	vpbroadcastq	%xmm2, %ymm0
	addq	408(%rsp), %rdx
	vmovntdq	%ymm0, (%rdx)
	movl	352(%rsp), %edx
	cmpq	%rax, %rdx
	ja	.L86
.L85:
	mfence
	movl	352(%rsp), %eax
	testl	%eax, %eax
	je	.L87
	movq	408(%rsp), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L88:
	movl	%eax, %edx
	salq	$5, %rdx
	clflush	(%rcx,%rdx)
	addl	$2, %eax
	cmpl	%eax, 352(%rsp)
	ja	.L88
.L87:
	leaq	144(%rsp), %rcx
	leaq	32(%rsp), %rdi
	xorl	%esi, %esi
	mfence
	leaq	read_stream(%rip), %rdx
	vzeroupper
	call	pthread_create@PLT
	xorl	%esi, %esi
	leaq	352(%rsp), %rcx
	leaq	read_stream(%rip), %rdx
	leaq	40(%rsp), %rdi
	call	pthread_create@PLT
	movq	32(%rsp), %rdi
	xorl	%esi, %esi
	leaq	560(%rsp), %r14
	leaq	688(%rsp), %r13
	leaq	816(%rsp), %r12
	call	pthread_join@PLT
	movq	40(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
	mfence
	call	PAPI_shutdown@PLT
	movl	132(%rsp), %edi
	movq	%r14, %rsi
	call	PAPI_event_code_to_name@PLT
	movl	136(%rsp), %edi
	movq	%r13, %rsi
	call	PAPI_event_code_to_name@PLT
	movl	140(%rsp), %edi
	movq	%r12, %rsi
	call	PAPI_event_code_to_name@PLT
	movq	208(%rsp), %rax
	movl	144(%rsp), %r8d
	leaq	.LC30(%rip), %rsi
	movq	152(%rsp), %rcx
	movl	$1, %edi
	movq	(%rax), %rdx
	sall	$5, %r8d
	xorl	%eax, %eax
	shrl	$10, %r8d
	call	__printf_chk@PLT
	movq	416(%rsp), %rax
	movl	352(%rsp), %r8d
	leaq	.LC31(%rip), %rsi
	movq	360(%rsp), %rcx
	movl	$1, %edi
	movq	(%rax), %rdx
	sall	$5, %r8d
	xorl	%eax, %eax
	shrl	$10, %r8d
	call	__printf_chk@PLT
	movq	%r14, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	movq	160(%rsp), %rcx
	leaq	.LC32(%rip), %rsi
	call	__printf_chk@PLT
	movq	%r13, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	movq	168(%rsp), %rcx
	leaq	.LC32(%rip), %rsi
	call	__printf_chk@PLT
	movq	%r12, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	movq	176(%rsp), %rcx
	leaq	.LC32(%rip), %rsi
	call	__printf_chk@PLT
	movq	%r14, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	movq	368(%rsp), %rcx
	leaq	.LC33(%rip), %rsi
	call	__printf_chk@PLT
	movq	%r13, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	movq	376(%rsp), %rcx
	leaq	.LC33(%rip), %rsi
	call	__printf_chk@PLT
	movq	%r12, %rdx
	xorl	%eax, %eax
	movl	$1, %edi
	movq	384(%rsp), %rcx
	leaq	.LC33(%rip), %rsi
	call	__printf_chk@PLT
	movq	416(%rsp), %rax
	movq	208(%rsp), %rdx
	movq	(%rax), %rax
	addl	(%rdx), %eax
	movq	952(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L104
	leaq	-32(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L48:
	.cfi_restore_state
	leaq	.LC10(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L51
	movl	144(%rsp), %esi
	cmpl	$4127, %esi
	jbe	.L52
	sall	$5, %esi
	leaq	.LC10(%rip), %rdi
	call	get_uncached_mem
	movq	%rax, 200(%rsp)
	jmp	.L50
.L66:
	leaq	.LC13(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L58
	movl	$1, 392(%rsp)
	jmp	.L67
.L59:
	leaq	.LC10(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L62
	movl	352(%rsp), %esi
	cmpl	$4127, %esi
	jbe	.L63
	sall	$5, %esi
	leaq	.LC10(%rip), %rdi
	call	get_uncached_mem
	movq	%rax, 408(%rsp)
	jmp	.L61
.L56:
	leaq	.LC13(%rip), %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L58
	movl	$1, 184(%rsp)
	jmp	.L57
.L60:
	movl	$131072, %esi
	leaq	.LC9(%rip), %rdi
	call	get_uncached_mem
	movq	%rax, 408(%rsp)
	jmp	.L61
.L51:
	leaq	.LC11(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L53
	movl	144(%rsp), %edx
	leaq	48(%rsp), %rdi
	movl	$64, %esi
	sall	$5, %edx
	call	posix_memalign@PLT
	movl	%eax, %r8d
	xorl	%eax, %eax
	testl	%r8d, %r8d
	jne	.L54
	movq	48(%rsp), %rax
.L54:
	movq	%rax, 200(%rsp)
	jmp	.L50
.L49:
	movl	$131072, %esi
	movq	%r12, %rdi
	call	get_uncached_mem
	movq	%rax, 200(%rsp)
	jmp	.L50
.L62:
	leaq	.LC11(%rip), %rsi
	movq	%r13, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L53
	movl	352(%rsp), %edx
	leaq	56(%rsp), %rdi
	movl	$64, %esi
	sall	$5, %edx
	call	posix_memalign@PLT
	movl	%eax, %r8d
	xorl	%eax, %eax
	testl	%r8d, %r8d
	jne	.L64
	movq	56(%rsp), %rax
.L64:
	movq	%rax, 408(%rsp)
	jmp	.L61
.L100:
	leaq	28(%rsp), %r12
	leaq	.LC18(%rip), %rdi
	movq	%r12, %rsi
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L105
	movl	28(%rsp), %eax
	movq	%r12, %rsi
	leaq	.LC20(%rip), %rdi
	movl	%eax, 132(%rsp)
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L106
	movl	28(%rsp), %eax
	movq	%r12, %rsi
	leaq	.LC22(%rip), %rdi
	movl	%eax, 136(%rsp)
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	je	.L80
	leaq	.LC23(%rip), %rdi
	call	fail
.L63:
	movl	$131072, %esi
	leaq	.LC10(%rip), %rdi
	call	get_uncached_mem
	movq	%rax, 408(%rsp)
	jmp	.L61
.L52:
	movl	$131072, %esi
	leaq	.LC10(%rip), %rdi
	call	get_uncached_mem
	movq	%rax, 200(%rsp)
	jmp	.L50
.L104:
	call	__stack_chk_fail@PLT
.L105:
	leaq	.LC19(%rip), %rdi
	call	fail
.L106:
	leaq	.LC21(%rip), %rdi
	call	fail
.L98:
	leaq	.LC8(%rip), %rdi
	call	fail
.L99:
	movl	$100663296, %edi
	call	PAPI_library_init@PLT
	addl	$1, %eax
	je	.L107
.L71:
	leaq	.LC17(%rip), %rdi
	call	fail
.L77:
	leaq	.LC27(%rip), %rdi
	call	fail
.L58:
	leaq	.LC14(%rip), %rdi
	call	fail
.L107:
	leaq	.LC16(%rip), %rdi
	call	puts@PLT
	jmp	.L71
.L53:
	leaq	.LC12(%rip), %rdi
	call	fail
.L101:
	leaq	.LC24(%rip), %rdi
	call	fail
.L102:
	leaq	.LC25(%rip), %rdi
	call	fail
.L103:
	leaq	.LC26(%rip), %rdi
	call	fail
	.cfi_endproc
.LFE5348:
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
