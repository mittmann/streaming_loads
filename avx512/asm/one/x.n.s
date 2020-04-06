	.file	"x.n.c"
# GNU C17 (GCC) version 9.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 9.3.0, GMP version 6.1.0, MPFR version 3.1.4, MPC version 1.0.3, isl version isl-0.18-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  ../src/one/x.n.c -mavx512vl -mtune=generic -march=x86-64
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
# -mavx256-split-unaligned-store -mavx512f -mavx512vl -mfancy-math-387
# -mfp-ret-in-387 -mfxsr -mglibc -mieee-fp -mlong-double-80 -mmmx -mpopcnt
# -mpush-args -mred-zone -msse -msse2 -msse3 -msse4 -msse4.1 -msse4.2
# -mssse3 -mstv -mtls-direct-seg-refs -mvzeroupper -mxsave

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
	andq	$-64, %rsp	#,
	subq	$264, %rsp	#,
	movl	%edi, -60(%rsp)	# argc, argc
	movq	%rsi, -72(%rsp)	# argv, argv
# ../src/one/x.n.c:10: 	unsigned long long int acc = 0;
	movq	$0, 256(%rsp)	#, acc
# ../src/one/x.n.c:12: 	int i=0;
	movl	$0, 248(%rsp)	#, i
# ../src/one/x.n.c:14: 		temp[0]=i;
	movl	248(%rsp), %eax	# i, tmp91
	cltq
	movq	%rax, -56(%rsp)	# _1, temp
# ../src/one/x.n.c:15: 		_mm512_stream_si512(&mem[i], temp);
	vmovdqa64	-56(%rsp), %zmm0	# temp, temp.0_2
	movl	248(%rsp), %eax	# i, tmp93
	cltq
	salq	$6, %rax	#, tmp94
	addq	$mem.24050, %rax	#, _3
	movq	%rax, 240(%rsp)	# _3, __P
	vmovdqa64	%zmm0, 136(%rsp)	# temp.0_2, __A
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/avx512fintrin.h:8633:   __builtin_ia32_movntdq512 ((__v8di *) __P, (__v8di) __A);
	movq	240(%rsp), %rax	# __P, tmp95
	vmovdqa64	136(%rsp), %zmm0	# __A, tmp96
	vmovntdq	%zmm0, (%rax)	# tmp96,
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/avx512fintrin.h:8634: }
	nop	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1510:   __builtin_ia32_mfence ();
	mfence	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1511: }
	nop	
# ../src/one/x.n.c:20: 	for(int i=0; i < ARRAY_SIZE; i++)
	movl	$0, 252(%rsp)	#, i
# ../src/one/x.n.c:20: 	for(int i=0; i < ARRAY_SIZE; i++)
	jmp	.L2	#
.L4:
# ../src/one/x.n.c:22: 		local = _mm512_stream_load_si512(&mem[i]);
	movl	252(%rsp), %eax	# i, tmp98
	cltq
	salq	$6, %rax	#, tmp99
	addq	$mem.24050, %rax	#, _4
	movq	%rax, 128(%rsp)	# _4, __P
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/avx512fintrin.h:8654:   return __builtin_ia32_movntdqa512 ((__v8di *)__P);
	movq	128(%rsp), %rax	# __P, tmp100
	vmovntdqa	(%rax), %zmm0	#, D.24072
# ../src/one/x.n.c:22: 		local = _mm512_stream_load_si512(&mem[i]);
	vmovdqa64	%zmm0, 8(%rsp)	# D.24072, local
# ../src/one/x.n.c:23: 		acc += *((uint64_t*)&local);
	leaq	8(%rsp), %rax	#, local.1_6
# ../src/one/x.n.c:23: 		acc += *((uint64_t*)&local);
	movq	(%rax), %rax	# MEM[(uint64_t *)local.1_6], _7
# ../src/one/x.n.c:23: 		acc += *((uint64_t*)&local);
	addq	%rax, 256(%rsp)	# _7, acc
# ../src/one/x.n.c:20: 	for(int i=0; i < ARRAY_SIZE; i++)
	addl	$1, 252(%rsp)	#, i
.L2:
# ../src/one/x.n.c:20: 	for(int i=0; i < ARRAY_SIZE; i++)
	cmpl	$262143, 252(%rsp)	#, i
	jle	.L4	#,
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1510:   __builtin_ia32_mfence ();
	mfence	
# /usr/local/gcc-9.3/lib/gcc/x86_64-linux-gnu/9.3.0/include/emmintrin.h:1511: }
	nop	
# ../src/one/x.n.c:27: 	return (int)acc;
	movq	256(%rsp), %rax	# acc, tmp101
# ../src/one/x.n.c:28: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE4002:
	.size	main, .-main
	.local	mem.24050
	.comm	mem.24050,16777216,64
	.ident	"GCC: (GNU) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
