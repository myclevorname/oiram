	section	.text
	public	_add_boo
_add_boo:
	ld	hl, _num_boos
	ld	a, (hl)
	cp	a, 64 - 1 - 1	; MAX_BOOS-1 - 1
	ret	nc

	inc	(hl)

	push	af
	ld	hl, 9
	push	hl
	call	_malloc
	pop	hl
	pop	af

	push	hl
	pop	iy
	ld	e, a
	ld	d, 3
	mlt	de
	ld	hl, _boo
	add	hl, de
	ld	(hl), iy

	pop	de
	ex	(sp), hl
	push	de

	pea	iy+3		; &y
	push	iy		; &x
	push	bc		; tile

	ld	de, $0000FF	; [-1, false, 0]
	ld	(iy + 7), de

	call	_tile_to_abs_xy_pos
	pop	af, af, af
	ret

	extern	_malloc
	extern	_num_boos
	extern	_boo
	extern	_tile_to_abs_xy_pos
