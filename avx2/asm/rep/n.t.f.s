	.file	"n.t.f.c"
# GNU C17 (GCC) version 9.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 9.3.0, GMP version 6.1.0, MPFR version 3.1.4, MPC version 1.0.3, isl version isl-0.18-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  ../src/rep/n.t.f.c -mavx2 -mtune=generic -march=x86-64
# -O0 -fverbose-asm
# options enabled:  -faggressive-loop-optimizations -fassume-phsa
# -fasynchronous-unwind-tables -fauto-inc-dec -fcommon
# -fdelete-null-pointer-checks -fdwarf2-cfi-asm -fearly-inlining
# -feliminate-unused-debug-types -ffp-int-builtin-inexact -ffunction-cse
# -fgcse-lm -fgnu-runtime -fgnu-unique -fident -finline-atomics
# -fipa-stack-alignment -fira-hoist-pressure -fira-share-save-slots
# -fira-share-spill-slots -fivopts -fkeep-static-consts
# -fleading-underscore -flifetime-dse -flto-odr-type-merging -fmath-errno
# -fmerge-debug-strings -fpeephole -fplt -fprefetch-loop-arrays
# -freg-struct-return -fsched-critical-path-heuristic
# -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
# -fsched-last-insn-heuristic -fsched-rank-heuristic -fsched-spec
# -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-fusion
# -fsemantic-interposition -fshow-column -fshrink-wrap-separate
# -fsigned-zeros -fsplit-ivs-in-unroller -fssa-backprop -fstdarg-opt
# -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math -ftree-cselim
# -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
# -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop
# -ftree-reassoc -ftree-scev-cprop -funit-at-a-time -funwind-tables
# -fverbose-asm -fzero-initialized-in-bss -m128bit-long-double -m64 -m80387
# -malign-stringops -mavx -mavx2 -mavx256-split-unaligned-load
# -mavx256-split-unaligned-store -mfancy-math-387 -mfp-ret-in-387 -mfxsr
# -mglibc -mieee-fp -mlong-double-80 -mmmx -mpopcnt -mpush-args -mred-zone
# -msse -msse2 -msse3 -msse4 -msse4.1 -msse4.2 -mssse3 -mstv
# -mtls-direct-seg-refs -mvzeroupper -mxsave

	.text
	.globl	main
	.type	main, @function
main:
.LFB4002:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	andq	$-32, %rsp	#,
	subq	$72, %rsp	#,
	movl	%edi, -92(%rsp)	# argc, argc
	movq	%rsi, -104(%rsp)	# argv, argv
# ../src/rep/n.t.f.c:10: 	unsigned long long int acc = 0;
	movq	$0, 64(%rsp)	#, acc
# ../src/rep/n.t.f.c:11:     for(int j=0; j<REP; j++){ 	
	movl	$0, 60(%rsp)	#, j
# ../src/rep/n.t.f.c:11:     for(int j=0; j<REP; j++){ 	
	jmp	.L2	#
.L8:
# ../src/rep/n.t.f.c:12: 	for(int i=0; i<ARRAY_SIZE; i++)
	movl	$0, 56(%rsp)	#, i
# ../src/rep/n.t.f.c:12: 	for(int i=0; i<ARRAY_SIZE; i++)
	jmp	.L3	#
.L4:
# ../src/rep/n.t.f.c:15: 		temp[0]=i;
	movl	56(%rsp), %eax	# i, tmp91
	cltq
	movq	%rax, -88(%rsp)	# _1, temp
# ../src/rep/n.t.f.c:16: 		_mm256_stream_si256(&mem[i], temp);
	vmovdqa	-88(%rsp), %ymm0	# temp, temp.0_2
	movl	56(%rsp), %eax	# i, tmp93
	cltq
	salq	$5, %rax	#, tmp94
	addq	$mem.24050, %rax	#, _3
	movq	%rax, 40(%rsp)	# _3, __A
	vmovdqa	%ymm0, 8(%rsp)	# temp.0_2, __B
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/avxintrin.h:1010:   __builtin_ia32_movntdq256 ((__v4di *)__A, (__v4di)__B);
	movq	40(%rsp), %rax	# __A, tmp95
	vmovdqa	8(%rsp), %ymm0	# __B, tmp96
	vmovntdq	%ymm0, (%rax)	# tmp96,
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/avxintrin.h:1011: }
	nop	
# ../src/rep/n.t.f.c:12: 	for(int i=0; i<ARRAY_SIZE; i++)
	addl	$1, 56(%rsp)	#, i
.L3:
# ../src/rep/n.t.f.c:12: 	for(int i=0; i<ARRAY_SIZE; i++)
	cmpl	$262143, 56(%rsp)	#, i
	jle	.L4	#,
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1510:   __builtin_ia32_mfence ();
	mfence	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1511: }
	nop	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/immintrin.h:151:   __builtin_ia32_wbinvd ();
	wbinvd	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/immintrin.h:152: }
	nop	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1510:   __builtin_ia32_mfence ();
	mfence	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1511: }
	nop	
# ../src/rep/n.t.f.c:22: 	for(int i=0; i < ARRAY_SIZE; i++)
	movl	$0, 52(%rsp)	#, i
# ../src/rep/n.t.f.c:22: 	for(int i=0; i < ARRAY_SIZE; i++)
	jmp	.L5	#
.L7:
# ../src/rep/n.t.f.c:24: 		local = _mm256_load_si256(&mem[i]);
	movl	52(%rsp), %eax	# i, tmp98
	cltq
	salq	$5, %rax	#, tmp99
	addq	$mem.24050, %rax	#, _4
	movq	%rax, (%rsp)	# _4, __P
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/avxintrin.h:910:   return *__P;
	movq	(%rsp), %rax	# __P, tmp100
	vmovdqa	(%rax), %ymm0	# *__P_32, D.24080
# ../src/rep/n.t.f.c:24: 		local = _mm256_load_si256(&mem[i]);
	vmovdqa	%ymm0, -56(%rsp)	# D.24080, local
# ../src/rep/n.t.f.c:25: 		acc += *((uint64_t*)&local);
	leaq	-56(%rsp), %rax	#, local.1_6
# ../src/rep/n.t.f.c:25: 		acc += *((uint64_t*)&local);
	movq	(%rax), %rax	# MEM[(uint64_t *)local.1_6], _7
# ../src/rep/n.t.f.c:25: 		acc += *((uint64_t*)&local);
	addq	%rax, 64(%rsp)	# _7, acc
# ../src/rep/n.t.f.c:22: 	for(int i=0; i < ARRAY_SIZE; i++)
	addl	$1, 52(%rsp)	#, i
.L5:
# ../src/rep/n.t.f.c:22: 	for(int i=0; i < ARRAY_SIZE; i++)
	cmpl	$262143, 52(%rsp)	#, i
	jle	.L7	#,
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1510:   __builtin_ia32_mfence ();
	mfence	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1511: }
	nop	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/immintrin.h:151:   __builtin_ia32_wbinvd ();
	wbinvd	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/immintrin.h:152: }
	nop	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1510:   __builtin_ia32_mfence ();
	mfence	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1511: }
	nop	
# ../src/rep/n.t.f.c:11:     for(int j=0; j<REP; j++){ 	
	addl	$1, 60(%rsp)	#, j
.L2:
# ../src/rep/n.t.f.c:11:     for(int j=0; j<REP; j++){ 	
	cmpl	$999, 60(%rsp)	#, j
	jle	.L8	#,
# ../src/rep/n.t.f.c:32: 	return (int)acc;
	movq	64(%rsp), %rax	# acc, tmp101
# ../src/rep/n.t.f.c:33: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE4002:
	.size	main, .-main
	.local	mem.24050
	.comm	mem.24050,8388608,32
	.ident	"GCC: (GNU) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
