;	section	.text
;	public	_plant_tile_handler
;_plant_tile_handler:
;	call	__frameset0
;	ld	l, 0
;	ld	a, (_handling_events)
;	bit	0, a
;	jr	nz, BB68_3
;	ld	a, (_move_side)
;	or	a, a
;	jr	nz, BB68_4
;	call	_shrink_oiram
;	ld	l, 0
;	jr	BB68_4
;BB68_3:
;	ld	l, 1
;BB68_4:
;	ld	a, l
;	pop	ix
;	ret

	section	.text
	public	_plant_tile_handler
_plant_tile_handler:
	ld	a, (_handling_events)
	and	a, 1
	ret	nz

	ld	a,(_move_side)
	or	a, a
	call	z, _shrink_oiram

	xor	a, a
	ret

	extern	_handling_events
	extern	_move_side
	extern	_shrink_oiram
