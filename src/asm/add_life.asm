; What ez80-clang produced
;	assume	adl=1
;
;	section	.text
;	public	_add_life
;_add_life:
;	ld	a, (_oiram+38)
;	inc	a
;	cp	a, 99
;	jr	c, BB28_2
;	ld	a, 99
;BB28_2:
;	ld	(_oiram+38), a
;	jp	_draw_lives


; My implementation after reading the former, which saves 9 bytes
	assume adl=1

	section	.text
	public	_add_life

_add_life:
	ld	hl, _oiram+38
	ld	a, (hl)
	cp	a, 99
	adc	a, 0		; Add 1 iff A < 99
	ld	(hl), a
	require _draw_lives

	extern	_oiram
	extern	_draw_lives
