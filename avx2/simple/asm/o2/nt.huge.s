	.file	"nt.huge.c"
	.text
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5284:
	.cfi_startproc
	endbr64
	movabsq	$62914560000, %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$64, %edi
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	call	aligned_alloc@PLT
	xorl	%edx, %edx
	movq	%rax, %rcx
	movq	%rax, %rsi
	.p2align 4,,10
	.p2align 3
.L2:
	movq	%rdx, (%rsi)
	addq	$1, %rdx
	addq	$32, %rsi
	cmpq	$1966080000, %rdx
	jne	.L2
	movabsq	$62914560000, %rsi
	mfence
	addq	%rax, %rsi
	.p2align 4,,10
	.p2align 3
.L3:
	clflush	(%rax)
	addq	$32, %rax
	cmpq	%rax, %rsi
	jne	.L3
	mfence
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L4:
	vmovntdqa	(%rcx), %ymm0
	addq	$32, %rcx
	vmovq	%xmm0, %rdx
	addq	%rdx, %rax
	cmpq	%rsi, %rcx
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
