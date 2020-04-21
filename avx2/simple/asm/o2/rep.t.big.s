	.file	"rep.t.big.c"
	.text
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5284:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$64, %edi
	movl	$125829120, %esi
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	call	aligned_alloc@PLT
	movq	%rax, %rdi
	movq	%rax, %rdx
	xorl	%eax, %eax
.L2:
	movq	%rax, (%rdx)
	addq	$1, %rax
	addq	$32, %rdx
	cmpq	$3932160, %rax
	jne	.L2
	mfence
	leaq	125829120(%rdi), %rcx
	movq	%rdi, %rax
.L3:
	clflush	(%rax)
	addq	$32, %rax
	cmpq	%rax, %rcx
	jne	.L3
	mfence
	movl	$500, %esi
	xorl	%eax, %eax
.L4:
	movq	%rdi, %rdx
	.p2align 4,,10
	.p2align 3
.L5:
	addq	(%rdx), %rax
	addq	$32, %rdx
	cmpq	%rcx, %rdx
	jne	.L5
	subl	$1, %esi
	jne	.L4
	mfence
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5284:
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
