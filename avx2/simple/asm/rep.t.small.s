	.file	"rep.t.small.c"
	.text
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
	movl	$6291456, %esi
	movl	$64, %edi
	call	aligned_alloc@PLT
	movq	%rax, %rdi
	movq	%rax, %rcx
	movl	$0, %edx
.L2:
	movq	%rdx, (%rcx)
	addq	$1, %rdx
	addq	$32, %rcx
	cmpq	$196608, %rdx
	jne	.L2
	mfence
	leaq	6291456(%rax), %rcx
.L3:
	clflush	(%rax)
	addq	$32, %rax
	cmpq	%rax, %rcx
	jne	.L3
	mfence
	movl	$10000, %esi
	movl	$0, %eax
	jmp	.L4
.L11:
	subl	$1, %esi
	je	.L6
.L4:
	movq	%rdi, %rdx
.L5:
	addq	(%rdx), %rax
	addq	$32, %rdx
	cmpq	%rcx, %rdx
	jne	.L5
	jmp	.L11
.L6:
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
