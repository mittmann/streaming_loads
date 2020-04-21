	.file	"rep.nt.small.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4006:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	addq	$-128, %rsp
	movl	%edi, 12(%rsp)
	movq	%rsi, (%rsp)
	movq	%fs:40, %rax
	movq	%rax, 120(%rsp)
	xorl	%eax, %eax
	movl	$6291456, %esi
	movl	$64, %edi
	call	aligned_alloc@PLT
	movq	%rax, 40(%rsp)
	movq	$0, 32(%rsp)
	movl	$0, 16(%rsp)
	jmp	.L2
.L3:
	movl	16(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	40(%rsp), %rax
	addq	%rax, %rdx
	movl	16(%rsp), %eax
	cltq
	movq	%rax, (%rdx)
	addl	$1, 16(%rsp)
.L2:
	cmpl	$196607, 16(%rsp)
	jle	.L3
	mfence
	nop
	movl	$0, 20(%rsp)
	jmp	.L4
.L5:
	movl	20(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	40(%rsp), %rax
	addq	%rdx, %rax
	movq	%rax, 48(%rsp)
	movq	48(%rsp), %rax
	clflush	(%rax)
	nop
	addl	$1, 20(%rsp)
.L4:
	cmpl	$196607, 20(%rsp)
	jle	.L5
	mfence
	nop
	movl	$0, 24(%rsp)
	jmp	.L6
.L10:
	movl	$0, 28(%rsp)
	jmp	.L7
.L9:
	movl	28(%rsp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	40(%rsp), %rax
	addq	%rdx, %rax
	movq	%rax, 56(%rsp)
	movq	56(%rsp), %rax
	vmovntdqa	(%rax), %ymm0
	nop
	vmovdqa	%ymm0, 64(%rsp)
	leaq	64(%rsp), %rax
	movq	(%rax), %rax
	addq	%rax, 32(%rsp)
	addl	$1, 28(%rsp)
.L7:
	cmpl	$196607, 28(%rsp)
	jle	.L9
	addl	$1, 24(%rsp)
.L6:
	cmpl	$9999, 24(%rsp)
	jle	.L10
	mfence
	nop
	movq	32(%rsp), %rax
	movq	120(%rsp), %rcx
	xorq	%fs:40, %rcx
	je	.L12
	call	__stack_chk_fail@PLT
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4006:
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
