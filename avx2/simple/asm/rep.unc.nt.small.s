	.file	"rep.unc.nt.small.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
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
.LFB5320:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	%esi, %ebx
	movl	$0, %edx
	movl	$2, %esi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, %ebp
	cmpl	$-1, %eax
	je	.L6
.L2:
	movl	$30, %edi
	call	sysconf@PLT
	subq	$1, %rax
	movslq	%ebx, %rdx
	testq	%rdx, %rax
	jne	.L7
.L3:
	movslq	%ebx, %rsi
	movl	$0, %r9d
	movl	%ebp, %r8d
	movl	$1, %ecx
	movl	$3, %edx
	movl	$0, %edi
	call	mmap@PLT
	movq	%rax, %rbx
	cmpq	$-1, %rax
	je	.L8
.L1:
	movq	%rbx, %rax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L6:
	.cfi_restore_state
	leaq	.LC0(%rip), %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L2
.L7:
	movl	$30, %edi
	call	sysconf@PLT
	movq	%rax, %r12
	movl	$30, %edi
	call	sysconf@PLT
	negl	%r12d
	andl	%r12d, %ebx
	addl	%eax, %ebx
	jmp	.L3
.L8:
	leaq	.LC2(%rip), %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L1
	.cfi_endproc
.LFE5320:
	.size	get_uncached_mem, .-get_uncached_mem
	.section	.rodata.str1.1
.LC3:
	.string	"dev"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5321:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	movl	$6291456, %esi
	leaq	.LC3(%rip), %rdi
	call	get_uncached_mem
	mfence
	movq	%rax, %r8
	movq	%rax, %rcx
	movl	$0, %edx
.L10:
	movq	%rdx, (%rcx)
	addq	$1, %rdx
	addq	$32, %rcx
	cmpq	$196608, %rdx
	jne	.L10
	mfence
	leaq	6291456(%rax), %rsi
.L11:
	clflush	(%rax)
	addq	$32, %rax
	cmpq	%rax, %rsi
	jne	.L11
	mfence
	movl	$10000, %edi
	movl	$0, %eax
	jmp	.L12
.L19:
	subl	$1, %edi
	je	.L14
.L12:
	movq	%r8, %rcx
.L13:
	vmovntdqa	(%rcx), %ymm0
	vmovq	%xmm0, %rdx
	addq	%rdx, %rax
	addq	$32, %rcx
	cmpq	%rcx, %rsi
	jne	.L13
	jmp	.L19
.L14:
	mfence
	leave
	.cfi_def_cfa 7, 8
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
