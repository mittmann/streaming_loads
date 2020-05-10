	.file	"lfb-pressure.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s\n"
	.text
	.p2align 4
	.globl	fail
	.type	fail, @function
fail:
.LFB5331:
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
.LFE5331:
	.size	fail, .-fail
	.section	.rodata.str1.1
.LC1:
	.string	"couldn't open device"
.LC2:
	.string	"%s"
.LC3:
	.string	"mmap failed."
	.text
	.p2align 4
	.globl	get_uncached_mem
	.type	get_uncached_mem, @function
get_uncached_mem:
.LFB5332:
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
	je	.L12
.L5:
	movl	$30, %edi
	call	sysconf@PLT
	movslq	%ebp, %rsi
	subq	$1, %rax
	testq	%rsi, %rax
	jne	.L13
.L6:
	movl	%r12d, %r8d
	xorl	%r9d, %r9d
	movl	$1, %ecx
	movl	$3, %edx
	xorl	%edi, %edi
	call	mmap@PLT
	movq	%rax, %r12
	cmpq	$-1, %rax
	je	.L14
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
.L13:
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
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L12:
	leaq	.LC1(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L14:
	leaq	.LC3(%rip), %rdx
	leaq	.LC2(%rip), %rsi
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
.LFE5332:
	.size	get_uncached_mem, .-get_uncached_mem
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"qtd errada de args <TAMANHO TIPO_DE_MEM TEMPORALIDADE COUNTER>"
	.section	.rodata.str1.1
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
	.string	"wc"
.LC11:
	.string	"wb"
.LC12:
	.string	"tipo de mem invalido"
.LC13:
	.string	"temporalidade invalida"
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"PAPI_event_name_to_code falhou"
	.section	.rodata.str1.1
.LC15:
	.string	"PAPI_create_eventset falhou"
.LC16:
	.string	"PAPI_add_events falhou"
.LC17:
	.string	"PAPI_start falhou"
.LC18:
	.string	"PAPI_stop falhou"
.LC19:
	.string	"reps: %d, size: %ld\n"
.LC20:
	.string	"acc: %llu, %llu, %llu, %llu\n"
.LC21:
	.string	"PAPI_VALUE: %llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5333:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	movl	%edi, %r12d
	movl	$84344832, %edi
	pushq	%rbx
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	andq	$-32, %rsp
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movl	$-1, 44(%rsp)
	call	PAPI_library_init@PLT
	cmpl	$5, %r12d
	jne	.L58
	movq	8(%rbx), %r12
	movl	$5, %ecx
	leaq	.LC5(%rip), %rdi
	movq	%r12, %rsi
	repz cmpsb
	seta	%al
	sbbb	$0, %al
	testb	%al, %al
	je	.L40
	leaq	.LC6(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L41
	movq	%r12, %rdi
	leaq	.LC7(%rip), %rsi
	movl	$20000, %r13d
	movl	$196608, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L59
.L17:
	movq	16(%rbx), %r8
	leaq	.LC9(%rip), %r9
	movl	$4, %ecx
	movq	%r9, %rdi
	movq	%r8, %rsi
	repz cmpsb
	seta	%al
	sbbb	$0, %al
	testb	%al, %al
	je	.L60
	cmpb	$119, (%r8)
	jne	.L21
	cmpb	$99, 1(%r8)
	je	.L61
.L21:
	leaq	.LC11(%rip), %rsi
	movq	%r8, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L22
	movq	%r12, %rsi
	movl	$64, %edi
	salq	$5, %rsi
	call	aligned_alloc@PLT
	movq	%rax, %r14
.L19:
	movq	24(%rbx), %rax
	cmpb	$110, (%rax)
	jne	.L48
	cmpb	$116, 1(%rax)
	jne	.L48
	movzbl	2(%rax), %r15d
	testl	%r15d, %r15d
	jne	.L48
.L24:
	movq	32(%rbx), %rdi
	leaq	40(%rsp), %rsi
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	jne	.L62
	mfence
	movq	%r14, %rax
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L27:
	vmovq	%rbx, %xmm2
	movq	%rbx, %rdx
	addq	$1, %rbx
	addq	$32, %rax
	vpbroadcastq	%xmm2, %ymm0
	vmovntdq	%ymm0, -32(%rax)
	cmpq	%rbx, %r12
	jne	.L27
	mfence
	shrq	%rdx
	movq	%r14, %rax
	addq	$1, %rdx
	salq	$6, %rdx
	addq	%r14, %rdx
	.p2align 4,,10
	.p2align 3
.L28:
	clflush	(%rax)
	addq	$64, %rax
	cmpq	%rdx, %rax
	jne	.L28
	mfence
	leaq	44(%rsp), %rdi
	vzeroupper
	call	PAPI_create_eventset@PLT
	testl	%eax, %eax
	jne	.L63
	movl	40(%rsp), %esi
	movl	44(%rsp), %edi
	call	PAPI_add_event@PLT
	testl	%eax, %eax
	jne	.L64
	movl	44(%rsp), %edi
	call	PAPI_start@PLT
	testl	%eax, %eax
	jne	.L65
	salq	$5, %rbx
	testl	%r15d, %r15d
	jne	.L32
	leaq	(%r14,%rbx), %rdx
	vpxor	%xmm0, %xmm0, %xmm0
	.p2align 4,,10
	.p2align 3
.L33:
	movq	%r14, %rax
	.p2align 4,,10
	.p2align 3
	pushq	%rdx
	subq	$0x280, %rdx
.L37:
	vmovntdqa	(%rax), %ymm1
	vmovntdqa	0x40(%rax), %ymm2
	vmovntdqa	0x80(%rax), %ymm3
	vmovntdqa	0xc0(%rax), %ymm4
	vmovntdqa	0x100(%rax), %ymm5
	vmovntdqa	0x140(%rax), %ymm6
	vmovntdqa	0x180(%rax), %ymm7
	vmovntdqa	0x1c0(%rax), %ymm8
	vmovntdqa	0x200(%rax), %ymm9
	#vmovntdqa	0x240(%rax), %ymm10
	#vmovntdqa	0x280(%rax), %ymm11
	#vmovntdqa	0x2c0(%rax), %ymm12
	#vmovntdqa	0x300(%rax), %ymm13
	#vmovntdqa	0x340(%rax), %ymm14
	#vmovntdqa	0x380(%rax), %ymm15
	addq	$0x240, %rax
	vpaddq	%ymm1, %ymm2, %ymm1
	vpaddq	%ymm3, %ymm4, %ymm3
	vpaddq	%ymm5, %ymm6, %ymm5
	vpaddq	%ymm7, %ymm8, %ymm7
	#vpaddq	%ymm9, %ymm10, %ymm9
	#vpaddq	%ymm11, %ymm12, %ymm11
	#vpaddq	%ymm13, %ymm14, %ymm13

	vpaddq	%ymm1, %ymm3, %ymm1
	vpaddq	%ymm5, %ymm7, %ymm5
	#vpaddq	%ymm9, %ymm11, %ymm9
	#vpaddq	%ymm13, %ymm15, %ymm13

	vpaddq	%ymm1, %ymm5, %ymm1
	#vpaddq	%ymm9, %ymm13, %ymm9
	
	vpaddq	%ymm1, %ymm9, %ymm1

	vpaddq	%ymm1, %ymm0, %ymm0

	mfence

	cmpq	%rax, %rdx
	jg	.L37

	popq	%rdx
.Lresto:
	cmpq	%rax, %rdx
	je	.Lfimresto
	vmovntdqa	(%rax), %ymm1
	vpaddq	%ymm1, %ymm0, %ymm0
	addq	$64, %rax
	jmp	.Lresto
.Lfimresto:
	addl	$1, %r15d
	cmpl	%r15d, %r13d
	jne	.L33
.L47:
	vmovdqa	%ymm0, (%rsp)
	leaq	48(%rsp), %rsi
	mfence
	movl	44(%rsp), %edi
	vzeroupper
	call	PAPI_stop@PLT
	testl	%eax, %eax
	jne	.L66
	movl	40(%rsp), %esi
	movl	44(%rsp), %edi
	call	PAPI_remove_event@PLT
	call	PAPI_shutdown@PLT
	movq	%r12, %rcx
	movl	%r13d, %edx
	movl	$1, %edi
	leaq	.LC19(%rip), %rsi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	vmovdqa	(%rsp), %ymm3
	leaq	.LC20(%rip), %rsi
	xorl	%eax, %eax
	movl	$1, %edi
	vextracti128	$0x1, %ymm3, %xmm0
	vmovq	%xmm3, %rbx
	vpextrq	$1, %xmm3, %rcx
	vpextrq	$1, %xmm0, %r9
	vmovq	%xmm0, %r8
	vmovq	%xmm3, %rdx
	vzeroupper
	call	__printf_chk@PLT
	movq	48(%rsp), %rdx
	xorl	%eax, %eax
	leaq	.LC21(%rip), %rsi
	movl	$1, %edi
	call	__printf_chk@PLT
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L67
	leaq	-40(%rbp), %rsp
	movl	%ebx, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L40:
	.cfi_restore_state
	movl	$80, %r13d
	movl	$49152000, %r12d
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L48:
	cmpb	$116, (%rax)
	je	.L68
.L49:
	leaq	.LC13(%rip), %rdi
	call	fail
.L32:
	leaq	(%r14,%rbx), %rcx
	vpxor	%xmm0, %xmm0, %xmm0
	.p2align 4,,10
	.p2align 3
.L34:
	movq	%r14, %rdx
	.p2align 4,,10
	.p2align 3
.L35:
	vpaddq	(%rdx), %ymm0, %ymm0
	addq	$32, %rdx
	cmpq	%rdx, %rcx
	jne	.L35
	addl	$1, %eax
	cmpl	%eax, %r13d
	jne	.L34
	jmp	.L47
.L68:
	cmpb	$0, 1(%rax)
	movl	$1, %r15d
	je	.L24
	jmp	.L49
.L60:
	movl	%r12d, %esi
	movq	%r9, %rdi
	sall	$5, %esi
	call	get_uncached_mem
	movq	%rax, %r14
	jmp	.L19
.L41:
	movl	$1000, %r13d
	movl	$3932160, %r12d
	jmp	.L17
.L61:
	cmpb	$0, 2(%r8)
	jne	.L21
	movl	%r12d, %esi
	leaq	.LC10(%rip), %rdi
	sall	$5, %esi
	call	get_uncached_mem
	movq	%rax, %r14
	jmp	.L19
.L59:
	leaq	.LC8(%rip), %rdi
	call	fail
.L22:
	leaq	.LC12(%rip), %rdi
	call	fail
.L62:
	leaq	.LC14(%rip), %rdi
	call	fail
.L63:
	leaq	.LC15(%rip), %rdi
	call	fail
.L64:
	leaq	.LC16(%rip), %rdi
	call	fail
.L65:
	leaq	.LC17(%rip), %rdi
	call	fail
.L66:
	leaq	.LC18(%rip), %rdi
	call	fail
.L67:
	call	__stack_chk_fail@PLT
.L58:
	leaq	.LC4(%rip), %rdi
	call	fail
	.cfi_endproc
.LFE5333:
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
