	.file	"pchasing.c"
	.text
	.p2align 4
	.globl	string_to_uint64
	.type	string_to_uint64, @function
string_to_uint64:
.LFB5335:
	.cfi_startproc
	endbr64
	movzbl	(%rdi), %eax
	xorl	%r8d, %r8d
	xorl	$48, %eax
	cmpb	$9, %al
	ja	.L1
	.p2align 4,,10
	.p2align 3
.L3:
	movsbq	%al, %rax
	leaq	(%r8,%r8,4), %rdx
	addq	$1, %rdi
	leaq	(%rax,%rdx,2), %r8
	movzbl	(%rdi), %eax
	xorl	$48, %eax
	cmpb	$9, %al
	jbe	.L3
.L1:
	movq	%r8, %rax
	ret
	.cfi_endproc
.LFE5335:
	.size	string_to_uint64, .-string_to_uint64
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s\n"
	.text
	.p2align 4
	.globl	fail
	.type	fail, @function
fail:
.LFB5336:
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
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE5336:
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
.LFB5337:
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
	je	.L17
.L10:
	movl	$30, %edi
	call	sysconf@PLT
	movslq	%ebp, %rsi
	subq	$1, %rax
	testq	%rsi, %rax
	jne	.L18
.L11:
	movl	%r12d, %r8d
	xorl	%r9d, %r9d
	movl	$1, %ecx
	movl	$3, %edx
	xorl	%edi, %edi
	call	mmap@PLT
	movq	%rax, %r12
	cmpq	$-1, %rax
	je	.L19
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
.L18:
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
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L17:
	leaq	.LC1(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L19:
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
.LFE5337:
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
	.string	"nt"
.LC14:
	.string	"t"
.LC15:
	.string	"temporalidade invalida"
	.section	.rodata.str1.8
	.align 8
.LC16:
	.string	"PAPI_event_name_to_code falhou"
	.section	.rodata.str1.1
.LC17:
	.string	"Struct size %lu\n"
.LC18:
	.string	"Repetitions:%d Size:%lu\n"
.LC19:
	.string	"Memory to be accessed: %luKB\n"
.LC20:
	.string	"PAPI_create_eventset falhou"
.LC21:
	.string	"PAPI_add_events falhou"
.LC22:
	.string	"PAPI_start falhou"
.LC23:
	.string	"oi"
.LC24:
	.string	"PAPI_stop falhou"
.LC25:
	.string	"acc: %llu, print:%lu\n"
.LC26:
	.string	"PAPI_VALUE: %llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5338:
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
	pushq	%rbx
	andq	$-64, %rsp
	addq	$-128, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%fs:40, %rax
	movq	%rax, 120(%rsp)
	xorl	%eax, %eax
	movl	$-1, 60(%rsp)
	cmpl	$5, %edi
	jne	.L60
	movq	8(%rsi), %r12
	movq	%rsi, %r15
	leaq	.LC5(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L61
	movl	$40, %r14d
	movl	$49152000, %ebx
.L22:
	movq	16(%r15), %r12
	leaq	.LC9(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L62
	leaq	.LC10(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L63
	leaq	.LC11(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L26
	movq	%rbx, %rsi
	movl	$64, %edi
	salq	$6, %rsi
	call	aligned_alloc@PLT
	movq	%rax, %r13
.L24:
	movq	24(%r15), %rdi
	leaq	.LC13(%rip), %rsi
	movq	%rdi, 40(%rsp)
	call	strcmp@PLT
	movl	%eax, %r12d
	testl	%eax, %eax
	je	.L27
	movq	40(%rsp), %rdi
	leaq	.LC14(%rip), %rsi
	movl	$1, %r12d
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L64
.L27:
	movl	$84344832, %edi
	call	PAPI_library_init@PLT
	movq	32(%r15), %rdi
	leaq	56(%rsp), %rsi
	call	PAPI_event_name_to_code@PLT
	testl	%eax, %eax
	je	.L28
	leaq	.LC16(%rip), %rdi
	call	fail
.L61:
	leaq	.LC6(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L43
	leaq	.LC7(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L65
	movl	$10000, %r14d
	movl	$196608, %ebx
	jmp	.L22
.L60:
	leaq	.LC4(%rip), %rdi
	call	fail
.L43:
	movl	$500, %r14d
	movl	$3932160, %ebx
	jmp	.L22
.L26:
	leaq	.LC12(%rip), %rdi
	call	fail
.L62:
	movl	%ebx, %esi
	leaq	.LC9(%rip), %rdi
	sall	$6, %esi
	call	get_uncached_mem
	movq	%rax, %r13
	jmp	.L24
.L28:
	mfence
	movl	$64, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	leaq	.LC17(%rip), %rsi
	movq	%rbx, %r15
	call	__printf_chk@PLT
	movq	%rbx, %rcx
	movl	%r14d, %edx
	movl	$1, %edi
	leaq	.LC18(%rip), %rsi
	xorl	%eax, %eax
	salq	$6, %r15
	call	__printf_chk@PLT
	movq	%rbx, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	shrq	$4, %rdx
	leaq	.LC19(%rip), %rsi
	call	__printf_chk@PLT
	leaq	0(%r13,%r15), %rcx
	movq	%r13, %rax
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L29:
	movq	%rdx, (%rax)
	addq	$64, %rax
	addq	$1, %rdx
	movq	%rax, -56(%rax)
	movq	$0, 8(%rax)
	cmpq	%rax, %rcx
	jne	.L29
#APP
# 156 "pchasing.c" 1
	nop
# 0 "" 2
# 157 "pchasing.c" 1
	nop
# 0 "" 2
# 158 "pchasing.c" 1
	nop
# 0 "" 2
#NO_APP
	mfence
	movq	%r13, %rax
	.p2align 4,,10
	.p2align 3
.L30:
	clflush	(%rax)
	addq	$64, %rax
	cmpq	%rax, %rcx
	jne	.L30
	mfence
	leaq	60(%rsp), %rdi
	call	PAPI_create_eventset@PLT
	testl	%eax, %eax
	je	.L31
	leaq	.LC20(%rip), %rdi
	call	fail
.L63:
	movl	%ebx, %esi
	leaq	.LC10(%rip), %rdi
	sall	$6, %esi
	call	get_uncached_mem
	movq	%rax, %r13
	jmp	.L24
.L64:
	leaq	.LC15(%rip), %rdi
	call	fail
.L31:
	movl	56(%rsp), %esi
	movl	60(%rsp), %edi
	call	PAPI_add_event@PLT
	testl	%eax, %eax
	jne	.L66
	movl	60(%rsp), %edi
	call	PAPI_start@PLT
	testl	%eax, %eax
	jne	.L67
	testl	%r12d, %r12d
	je	.L46
	xorl	%r15d, %r15d
	leaq	64(%rsp), %r12
	subq	$32, %rbx
.L35:
	leaq	.LC23(%rip), %rdi
	call	puts@PLT
	movq	%r13, %rdx
	xorl	%eax, %eax
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L49:
	movq	%r12, %rdx
.L38:
	addq	$32, %rax
	cmpq	%rbx, %rax
	jbe	.L49
	movq	8(%rdx), %rax
	addq	$1, %r15
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	movq	8(%rax), %rax
	vmovdqa	(%rax), %ymm0
	vmovapd	%ymm0, 64(%rsp)
	cmpq	%r14, %r15
	jnb	.L57
	vzeroupper
	jmp	.L35
.L66:
	leaq	.LC21(%rip), %rdi
	call	fail
.L65:
	leaq	.LC8(%rip), %rdi
	call	fail
.L57:
	movl	60(%rsp), %edi
	vmovq	%xmm0, %r12
	leaq	112(%rsp), %rsi
	vzeroupper
	call	PAPI_stop@PLT
	testl	%eax, %eax
	je	.L40
	leaq	.LC24(%rip), %rdi
	call	fail
.L46:
	movq	%r13, %rax
	xorl	%esi, %esi
	leaq	64(%rsp), %rcx
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L34:
	movq	8(%rax), %rax
	addq	$1, %rdx
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	vpextrq	$1, %xmm0, %rax
	vmovntdqa	(%rax), %ymm0
	movq	%rcx, %rax
	vmovapd	%ymm0, 64(%rsp)
	cmpq	%rdx, %rbx
	ja	.L34
	addq	$1, %rsi
	cmpq	%r14, %rsi
	jnb	.L57
	movq	%r13, %rax
	xorl	%edx, %edx
	jmp	.L34
.L40:
	movl	56(%rsp), %esi
	movl	60(%rsp), %edi
	call	PAPI_remove_event@PLT
	call	PAPI_shutdown@PLT
#APP
# 336 "pchasing.c" 1
	nop
# 0 "" 2
# 337 "pchasing.c" 1
	nop
# 0 "" 2
# 338 "pchasing.c" 1
	nop
# 0 "" 2
#NO_APP
	xorl	%edx, %edx
	movq	%r12, %rcx
	leaq	.LC25(%rip), %rsi
	xorl	%eax, %eax
	movl	$1, %edi
	call	__printf_chk@PLT
	movq	112(%rsp), %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	leaq	.LC26(%rip), %rsi
	call	__printf_chk@PLT
	xorl	%edi, %edi
	call	exit@PLT
.L67:
	leaq	.LC22(%rip), %rdi
	call	fail
	.cfi_endproc
.LFE5338:
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
