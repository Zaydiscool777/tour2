	.file	"cm.c" ; file stuff
	.intel_syntax noprefix
	.text
	.globl	size
	.bss
	.align 4
	.type	size, @object
	.size	size, 4
size: ; from here...
	.zero	4
	.globl	fonth
	.data
	.align 4
	.type	fonth, @object
	.size	fonth, 4
fonth:
	.long	1065353216
	.globl	rawtime
	.bss
	.align 8
	.type	rawtime, @object
	.size	rawtime, 8 ; ...to here is one line
rawtime:
	.zero	8
	.globl	now
	.align 8
	.type	now, @object
	.size	now, 8
now:
	.zero	8
	.globl	cx
	.align 4
	.type	cx, @object
	.size	cx, 4 ; also one line
cx:
	.zero	4
	.globl	cy
	.align 4
	.type	cy, @object
	.size	cy, 4
cy:
	.zero	4
	.text
	.globl	show
	.type	show, @function ; also one line
show:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp ; function stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi
	movsd	QWORD PTR -16[rbp], xmm0 ; this is double s
	mov	eax, DWORD PTR -4[rbp] ; this is int m
	add	eax, eax ; m * 2
	pxor	xmm1, xmm1 ; sets to 0
	cvtsi2sd	xmm1, eax ; i searched it up, it converts int to float
	movsd	xmm0, QWORD PTR .LC0[rip] ; pi
	mulsd	xmm0, xmm1 ; 2mpi
	movsd	xmm1, QWORD PTR .LC1[rip] ; 60
	divsd	xmm0, xmm1 ; 2mpi/60
	movq	rax, xmm0
	movq	xmm0, rax ; but... last line...
	call	sin@PLT ; sin(2mpi/60)
	mov	eax, DWORD PTR size[rip] ; size
	pxor	xmm1, xmm1 ; sets to 0
	cvtsi2sd	xmm1, eax ; float(size)
	mulsd	xmm0, xmm1 ; sin()*size
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -16[rbp] ; *s
	movss	xmm0, DWORD PTR fonth[rip]
	cvtss2sd	xmm0, xmm0
	mulsd	xmm1, xmm0 ; *fonth
	mov	eax, DWORD PTR size[rip]
	pxor	xmm2, xmm2
	cvtsi2ss	xmm2, eax
	movss	xmm0, DWORD PTR fonth[rip]
	mulss	xmm0, xmm2 ; size*fonth
	cvtss2sd	xmm0, xmm0
	addsd	xmm1, xmm0 ; +size*fonth
	movq	rax, xmm1
	movq	xmm0, rax
	call	floor@PLT ; floor()
	cvttsd2si	eax, xmm0
	mov	DWORD PTR cx[rip], eax ; and sets to cx
	mov	eax, DWORD PTR -4[rbp]
	add	eax, eax
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, eax
	movsd	xmm0, QWORD PTR .LC0[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC1[rip]
	divsd	xmm0, xmm1
	movq	rax, xmm0
	movq	xmm0, rax
	call	cos@PLT
	movq	rax, xmm0
	movq	xmm0, QWORD PTR .LC2[rip]
	movq	xmm1, rax
	xorpd	xmm1, xmm0
	mov	eax, DWORD PTR size[rip]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mulsd	xmm0, xmm1
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -16[rbp]
	mov	eax, DWORD PTR size[rip]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	addsd	xmm1, xmm0
	movq	rax, xmm1
	movq	xmm0, rax
	call	floor@PLT
	cvttsd2si	eax, xmm0
	mov	DWORD PTR cy[rip], eax
	nop ; why?
	leave ; why are there two~three exit commands?
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	show, .-show
	.section	.rodata
.LC3:
	.string	"q to quit\nor ^c"
	.text
	.globl	init
	.type	init, @function
init:
.LFB7: ; void init(){
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	lea	rax, .LC3[rip] ; printw(.LC3);
	mov	rdi, rax
	mov	eax, 0
	call	printw@PLT
	nop ; }
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	init, .-init
	.section	.rodata
.LC6:
	.string	"%02d:%02d:%02d"
	.text
	.globl	draw
	.type	draw, @function
draw:
.LFB8:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	rax, QWORD PTR .LC4[rip] ; 1.0
	movq	xmm0, rax
	mov	edi, 0
	call	show ; show(0, 1.0);
	mov	edx, DWORD PTR cx[rip]
	mov	ecx, DWORD PTR cy[rip]
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, ecx
	mov	rdi, rax
	call	wmove@PLT ; move(cy, cx);
	mov	rax, QWORD PTR stdscr[rip] ; not as efficient
	mov	esi, 2228266 ; very efficient! or-ing constants
	mov	rdi, rax
	call	waddch@PLT ; addch('*' | A_BOLD | A_UNDERLINE)
	mov	DWORD PTR -4[rbp], 1
	jmp	.L4
.L5:
	mov	rdx, QWORD PTR .LC4[rip]
	mov	eax, DWORD PTR -4[rbp]
	movq	xmm0, rdx
	mov	edi, eax
	call	show
	mov	edx, DWORD PTR cx[rip]
	mov	ecx, DWORD PTR cy[rip]
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, ecx
	mov	rdi, rax
	call	wmove@PLT
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, 46
	mov	rdi, rax
	call	waddch@PLT
	add	DWORD PTR -4[rbp], 1 ; ++i?
.L4:
	cmp	DWORD PTR -4[rbp], 59 ; i < 60;
	jle	.L5
	lea	rax, rawtime[rip]
	mov	rdi, rax
	call	time@PLT ; time(&rawtime)
	lea	rax, rawtime[rip]
	mov	rdi, rax
	call	localtime@PLT ; localtime(&rawtime)
	mov	QWORD PTR now[rip], rax ; now = 
	mov	rax, QWORD PTR now[rip]
	mov	eax, DWORD PTR 8[rax] ; *now.tm_hour is somewhere
	lea	edx, -1[rax]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax ; -1 is somewhere
	mov	edx, eax
	mov	rax, QWORD PTR .LC5[rip]
	movq	xmm0, rax
	mov	edi, edx
	call	show
	mov	edx, DWORD PTR cx[rip]
	mov	ecx, DWORD PTR cy[rip]
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, ecx
	mov	rdi, rax
	call	wmove@PLT
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, 32
	mov	rdi, rax
	call	waddch@PLT ; remove prev. hour ('.'s only clear past Ms and Ss)
	mov	rax, QWORD PTR now[rip]
	mov	edx, DWORD PTR 8[rax]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax
	mov	edx, eax
	mov	rax, QWORD PTR .LC5[rip]
	movq	xmm0, rax
	mov	edi, edx
	call	show
	mov	edx, DWORD PTR cx[rip]
	mov	ecx, DWORD PTR cy[rip]
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, ecx
	mov	rdi, rax
	call	wmove@PLT
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, 262216 ; 'H' | A_REVERSE
	mov	rdi, rax
	call	waddch@PLT ; then the hours...
	mov	rax, QWORD PTR now[rip]
	mov	eax, DWORD PTR 4[rax]
	mov	rdx, QWORD PTR .LC4[rip]
	movq	xmm0, rdx
	mov	edi, eax
	call	show
	mov	edx, DWORD PTR cx[rip]
	mov	ecx, DWORD PTR cy[rip]
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, ecx
	mov	rdi, rax
	call	wmove@PLT
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, 77 ; 'M'
	mov	rdi, rax
	call	waddch@PLT ; minutes...
	mov	rax, QWORD PTR now[rip]
	mov	eax, DWORD PTR [rax]
	mov	rdx, QWORD PTR .LC4[rip]
	movq	xmm0, rdx
	mov	edi, eax
	call	show
	mov	edx, DWORD PTR cx[rip]
	mov	ecx, DWORD PTR cy[rip]
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, ecx
	mov	rdi, rax
	call	wmove@PLT
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, 1048659 ; 'S' | A_DIM
	mov	rdi, rax
	call	waddch@PLT ; and seconds.
	mov	eax, DWORD PTR size[rip]
	sub	eax, 3 ; size-3
	pxor	xmm1, xmm1
	cvtsi2ss	xmm1, eax ; float()
	movss	xmm0, DWORD PTR fonth[rip]
	mulss	xmm0, xmm1 ;fonth(size-3)
	cvttss2si	edx, xmm0
	mov	ecx, DWORD PTR size[rip]
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, ecx
	mov	rdi, rax
	call	wmove@PLT
	mov	rax, QWORD PTR now[rip]
	mov	ecx, DWORD PTR [rax]
	mov	rax, QWORD PTR now[rip]
	mov	edx, DWORD PTR 4[rax]
	mov	rax, QWORD PTR now[rip]
	mov	eax, DWORD PTR 8[rax]
	mov	esi, eax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printw@PLT ; digital time
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	draw, .-draw
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	call	initscr@PLT
	mov	rax, QWORD PTR stdscr[rip]
	mov	esi, 1
	mov	rdi, rax
	call	nodelay@PLT
	mov	rax, QWORD PTR stdscr[rip]
	mov	rdi, rax
	call	getmaxy@PLT ; splits getmaxyx into twain
	mov	DWORD PTR -8[rbp], eax ; length
	mov	rax, QWORD PTR stdscr[rip]
	mov	rdi, rax
	call	getmaxx@PLT
	mov	DWORD PTR -4[rbp], eax ; width
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -8[rbp] ; ternary operator!
	jge	.L7
	mov	eax, DWORD PTR -4[rbp]
	mov	edx, eax
	shr	edx, 31 ; halving: shears?
	add	eax, edx
	sar	eax ; shifts?
	jmp	.L8
.L7:
	mov	eax, DWORD PTR -8[rbp]
	mov	edx, eax
	shr	edx, 31 ; halfing again
	add	eax, edx
	sar	eax
.L8:
	mov	DWORD PTR size[rip], eax
	call	cbreak@PLT
	call	noecho@PLT
	mov	eax, 0
	call	init
	jmp	.L9
.L10:
	mov	eax, 0
	call	draw
.L9:
	mov	rax, QWORD PTR stdscr[rip]
	mov	rdi, rax
	call	wgetch@PLT
	cmp	eax, 113 ; == 'q'?
	jne	.L10 ; != 'q'
	call	endwin@PLT
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	1413754136
	.long	1074340347
	.align 8
.LC1:
	.long	0
	.long	1078853632
	.align 16
.LC2:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	-858993459
	.long	1072483532
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4: ; yay, it's the end!
