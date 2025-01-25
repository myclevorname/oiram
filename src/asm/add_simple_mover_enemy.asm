;	section	.text,"ax",@progbits
;	public	_add_goomba
;_add_goomba:
;	call	__frameset0
;	ld	hl, (ix + 6)
;	push	hl
;	call	_add_simple_mover
;	push	hl
;	pop	iy
;	pop	hl
;	ld	(iy + 9), 15
;	ld	(iy + 10), 15
;	ld	(iy + 7), -1
;	ld	(iy + 8), 11
;	pop	ix
;	ret

	section	.text
	public	_add_goomba
_add_goomba:
	call	_add_simple_mover_enemy
	ld	de, $0F0F0B
	ld	(iy + 8), de
	ret

	section	.text
	private	_add_simple_mover_enemy
_add_simple_mover_enemy:
	pop	bc
	pop	de
	ex	(sp), hl
	push	de
	push	bc
	push	hl
	call	_add_simple_mover
	pop	de
	push	hl
	pop	iy
	ld	(iy + 7), -1
	ret


;	section	.text
;	public	_add_reswob
;_add_reswob:
;	call	__frameset0
;	ld	hl, (ix + 6)
;	push	hl
;	call	_add_simple_mover
;	push	hl
;	pop	iy
;	pop	hl
;	ld	(iy + 9), 31
;	ld	(iy + 10), 39
;	ld	(iy + 7), -1
;	ld	(iy + 8), 9
;	pop	ix
;	ret

	section	.text
	public	_add_reswob
_add_reswob:
	call	_add_simple_mover_enemy
	ld	de, $473F09
	ld	(iy + 8), de
	ret


;	section	.text
;	public	_add_simple_mover
;_add_simple_mover:
;	ld	hl, -6
;	call	__frameset
;	or	a, a
;	sbc	hl, hl
;	ld	a, (_num_simple_movers)
;	cp	a, -4
;	push	hl
;	call	nc, _remove_simple_mover
;	pop	hl
;	pea	ix - 6
;	pea	ix - 3
;	ld	hl, (ix + 6)
;	push	hl
;	call	_tile_to_abs_xy_pos
;	pop	hl
;	pop	hl
;	pop	hl
;	ld	hl, 21
;	push	hl
;	call	_malloc
;	push	hl
;	pop	iy
;	pop	hl
;	ld	a, (_num_simple_movers)
;	or	a, a
;	sbc	hl, hl
;	ld	l, a
;	ld	bc, 3
;	call	__imulu
;	push	hl
;	pop	de
;	ld	hl, _simple_mover
;	add	hl, de
;	ld	(hl), iy
;	ld	(iy + 6), b
;	ld	(iy + 7), b
;	ld	hl, (ix - 3)
;	ld	(iy), hl
;	ld	hl, (ix - 6)
;	ld	(iy + 3), hl
;	or	a, a
;	sbc	hl, hl
;	ld	(iy + 11), hl
;	ld	(iy + 14), b
;	ld	(iy + 16), -1
;	ld	(iy + 20), b
;	ld	(iy + 15), b
;	inc	a
;	ld	(_num_simple_movers), a
;	lea	hl, iy
;	ld	sp, ix
;	pop	ix
;	ret

	section	.text
	public	_add_simple_mover
_add_simple_mover:
	ld	l, 0		; The lower 8 bits are used because this is a char
	ld	a, (_num_simple_movers)
	cp	a, 252 - 2	; MAX_SIMPLE_MOVERS-1 - 1

	push	hl
	call	nc, _remove_simple_mover	; num_simple_movers >= MAX_SIMPLE_MOVERS-2
	pop	hl

	pop	de
	ex	(sp), hl
	push	de

	ld	de, _mover_template+3
	push	de		; &y
	dec	de
	dec	de
	dec	de
	push	de		; &x
	push	hl		; spawing_tile (not spawning_tile for some reason)
	call	_tile_to_abs_xy_pos
	pop	af, af, af
	ld	hl, 21
	push	hl
	call	_malloc
	pop	af
	ld	de, 21
	push	de		; size
	ld de, _mover_template
	push	de		; src (template)
	push	hl		; dest (malloc'd buffer)
	call	_memcpy		; returns dest
	pop	af, af, af

	ex	de, hl

	ld	bc, 0

	ld	a, (_num_simple_movers)

	ld	c, a
	ld	hl, _simple_mover
	add	hl, bc
	add	hl, bc
	add	hl, bc
	ld	(hl), de

	inc	a
	ld	(_num_simple_movers), a

	ex	de, hl
	ret


	section	.data
	private	_mover_template
_mover_template:
	rl 2		; x, y
	db 0, 0		; vy, vx
	db 0		; type
	db 0, 0		; hitbox
	db 0, 0, 0, 0	; flags
	db 0, -1	; fly_counter, counter
	dl 0		; sprite pointer
	db 0		; score counter


	extern	_num_simple_movers
	extern	_remove_simple_mover
	extern	_tile_to_abs_xy_pos
	extern	_malloc
	extern	_memcpy
	extern	_simple_mover
