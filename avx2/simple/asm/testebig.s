	.file	"testebig.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"repetiu: %llu\n"
.LC1:
	.string	"acc: %llu\n"
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
	pushq	%rbx
	andq	$-32, %rsp
	.cfi_offset 3, -24
	movl	$125829120, %esi
	movl	$64, %edi
	call	aligned_alloc@PLT
	movq	%rax, %rsi
	movq	%rax, %rcx
	movl	$0, %edx
.L2:
	movq	%rdx, (%rcx)
	addq	$1, %rdx
	addq	$32, %rcx
	cmpq	$3932160, %rdx
	jne	.L2
	mfence
	leaq	125829120(%rax), %rdx
.L3:
	clflush	(%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L3
	mfence
	movl	$500, %ecx
	movl	$0, %ebx
	jmp	.L4
.L11:
	subl	$1, %ecx
	je	.L6
.L4:
	movq	%rsi, %rax
.L5:
	addq	(%rax), %rbx
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L5
	jmp	.L11
.L6:
	mfence
	movl	$1966080000, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	%rbx, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	%ebx, %eax
	movq	-8(%rbp), %rbx
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
