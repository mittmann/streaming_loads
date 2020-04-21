	.file	"rep.nt.small.c"
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
	movl	$6291456, %esi
	movl	$64, %edi
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	call	aligned_alloc@PLT
	movq	%rax, %r8
	movq	%rax, %rdx
	xorl	%eax, %eax
.L2:
	movq	%rax, (%rdx)
	addq	$1, %rax
	addq	$32, %rdx
	cmpq	$196608, %rax
	jne	.L2
	mfence
	leaq	6291456(%r8), %rsi
	movq	%r8, %rax
.L3:
	clflush	(%rax)
	addq	$32, %rax
	cmpq	%rax, %rsi
	jne	.L3
	mfence
	movl	$10000, %edi
	xorl	%eax, %eax
.L4:
	movq	%r8, %rcx
	.p2align 4,,10
	.p2align 3
.L5:
	vmovntdqa	(%rcx), %ymm0
	addq	$32, %rcx
	vmovq	%xmm0, %rdx
	addq	%rdx, %rax
	cmpq	%rcx, %rsi
	jne	.L5
	subl	$1, %edi
	jne	.L4
	mfence
	vzeroupper
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
