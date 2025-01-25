; 
;void remove_simple_mover(uint8_t i) {
;	simple_move_t *mover = simple_mover[i];
;	if (!num_simple_movers) {
;		return;
;	}
;
;	memmove(&simple_mover[i], &simple_mover[i+1], 3*(num_simple_movers-i));
;
;	num_simple_movers--;
;	free(mover);
;}

	section	.text
	public	_remove_simple_mover
_remove_simple_mover:
	ld hl, _num_simple_movers
	ld a, (hl)
	inc (hl)
	or a, a
	ret z

	pop	de
	ex	(sp), hl
	push	de

	sub	a, l		; num_simple_movers - i

	ld	h, 3
	mlt	hl		; i*3

	ld	de, _simple_mover
	add	hl, de		; mover

	push	hl, af
	ld	hl, (hl)
	push	hl
	call	_free
	pop	af
	pop	af, hl

	ld	c, a
	ld	b, 3
	mlt	bc
	push	bc		; size

	inc	hl
	inc	hl
	inc	hl
	push	hl		; mover+3

	dec	hl
	dec	hl
	dec	hl
	push	hl		; mover

	call	_memmove	; memmove(mover, mover+3, (num_simple_mover+1)*3-i*3)
	pop	af, af, af

	ret



	extern	_num_simple_movers
	extern	_simple_mover
	extern	_free
	extern	_memmove
