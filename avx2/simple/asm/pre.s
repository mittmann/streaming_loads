	.file	"pre.c"
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
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	leaq	-8355840(%rsp), %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, 8355864(%rsp)
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L2:
	movslq	%eax, %rdx
	salq	$5, %rdx
	movq	%rax, (%rsp,%rdx)
	addq	$1, %rax
	cmpq	$261120, %rax
	jne	.L2
	mfence
	movq	%rsp, %rax
	leaq	8355840(%rsp), %rdx
	.p2align 4,,10
	.p2align 3
.L3:
	clflush	(%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L3
	mfence
	movq	8355864(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L9
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	xorl	%eax, %eax
	ret
.L9:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
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
