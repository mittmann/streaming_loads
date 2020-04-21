	.file	"rep.unc.t.small.c"
	.text
	.section	.rodata
.LC0:
	.string	"couldn't open device"
.LC1:
	.string	"%s"
.LC2:
	.string	"mmap failed."
	.text
	.globl	get_uncached_mem
	.type	get_uncached_mem, @function
get_uncached_mem:
.LFB4006:
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
	jne	.L2
	leaq	.LC0(%rip), %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L2:
	movl	-44(%rbp), %eax
	movslq	%eax, %rbx
	movl	$30, %edi
	call	sysconf@PLT
	subq	$1, %rax
	andq	%rbx, %rax
	testq	%rax, %rax
	je	.L3
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
.L3:
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
	jne	.L4
	leaq	.LC2(%rip), %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L4:
	movq	-24(%rbp), %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4006:
	.size	get_uncached_mem, .-get_uncached_mem
	.section	.rodata
.LC3:
	.string	"dev"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4007:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	subq	$160, %rsp
	movl	%edi, 28(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 152(%rsp)
	xorl	%eax, %eax
	movq	$6291456, 56(%rsp)
	movq	56(%rsp), %rax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	call	get_uncached_mem
	movq	%rax, 64(%rsp)
	mfence
	nop
	movq	64(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	$0, 48(%rsp)
	movl	$0, 32(%rsp)
	jmp	.L7
.L8:
	movl	32(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	72(%rsp), %rax
	addq	%rax, %rdx
	movl	32(%rsp), %eax
	cltq
	movq	%rax, (%rdx)
	addl	$1, 32(%rsp)
.L7:
	cmpl	$196607, 32(%rsp)
	jle	.L8
	mfence
	nop
	movl	$0, 36(%rsp)
	jmp	.L9
.L10:
	movl	36(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	72(%rsp), %rax
	addq	%rdx, %rax
	movq	%rax, 80(%rsp)
	movq	80(%rsp), %rax
	clflush	(%rax)
	nop
	addl	$1, 36(%rsp)
.L9:
	cmpl	$196607, 36(%rsp)
	jle	.L10
	mfence
	nop
	movl	$0, 40(%rsp)
	jmp	.L11
.L15:
	movl	$0, 44(%rsp)
	jmp	.L12
.L14:
	movl	44(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	72(%rsp), %rax
	addq	%rdx, %rax
	movq	%rax, 88(%rsp)
	movq	88(%rsp), %rax
	vmovdqa	(%rax), %ymm0
	vmovdqa	%ymm0, 96(%rsp)
	leaq	96(%rsp), %rax
	movq	(%rax), %rax
	addq	%rax, 48(%rsp)
	addl	$1, 44(%rsp)
.L12:
	cmpl	$196607, 44(%rsp)
	jle	.L14
	addl	$1, 40(%rsp)
.L11:
	cmpl	$9999, 40(%rsp)
	jle	.L15
	mfence
	nop
	movq	48(%rsp), %rax
	movq	152(%rsp), %rcx
	xorq	%fs:40, %rcx
	je	.L17
	call	__stack_chk_fail@PLT
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4007:
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
