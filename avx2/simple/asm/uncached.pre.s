	.file	"uncached.pre.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"couldn't open device"
.LC1:
	.string	"%s"
.LC2:
	.string	"mmap failed."
	.text
	.p2align 4
	.globl	get_uncached_mem
	.type	get_uncached_mem, @function
get_uncached_mem:
.LFB5320:
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
	je	.L10
.L2:
	movl	$30, %edi
	call	sysconf@PLT
	movslq	%ebp, %rsi
	subq	$1, %rax
	testq	%rsi, %rax
	jne	.L11
.L3:
	movl	%r12d, %r8d
	xorl	%r9d, %r9d
	movl	$1, %ecx
	movl	$3, %edx
	xorl	%edi, %edi
	call	mmap@PLT
	movq	%rax, %r12
	cmpq	$-1, %rax
	je	.L12
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
.L11:
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
	jmp	.L3
	.p2align 4,,10
	.p2align 3
.L10:
	leaq	.LC0(%rip), %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L12:
	leaq	.LC2(%rip), %rdx
	leaq	.LC1(%rip), %rsi
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
.LFE5320:
	.size	get_uncached_mem, .-get_uncached_mem
	.section	.rodata.str1.1
.LC3:
	.string	"dev"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5321:
	.cfi_startproc
	endbr64
	movl	$8355840, %esi
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC3(%rip), %rdi
	call	get_uncached_mem
	xorl	%ecx, %ecx
	mfence
	movq	%rax, %rdx
	movq	%rax, %rsi
	.p2align 4,,10
	.p2align 3
.L14:
	movq	%rcx, (%rsi)
	addq	$1, %rcx
	addq	$32, %rsi
	cmpq	$261120, %rcx
	jne	.L14
	mfence
	addq	$8355840, %rax
	.p2align 4,,10
	.p2align 3
.L15:
	clflush	(%rdx)
	addq	$32, %rdx
	cmpq	%rax, %rdx
	jne	.L15
	mfence
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5321:
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
