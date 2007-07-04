; Mouse wheel test program
; Copyright (c) 1997-2002 Nagy Daniel <nagyd@users.sourceforge.net>
;
; Description: This program should print a 'd' for wheel downward and 'u'
;		for wheel upward movement
;
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the Free Software
; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;
;
; History:
;
; 2002-02-12 First public release
;

WARN
LOCALS

.model use16 tiny


;лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

.const

S_nodriver	db 'Mouse driver$'
S_nohardware	db 'Mouse hardware$'
S_doesnt	db	' does not support Wheel API',13,10,'$'
S_anykey	db 'Move wheel now or press a key to quit...',13,10,'$'


;лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

.code
.startup

;---------- check for wheel support presence

		mov	ax,11h
		int	33h		; check for wheel support

		mov	dx,offset @data:S_nodriver
		cmp	ax,'WM'
		jne	nowheel		; jump if wheel not supported

		mov	dx,offset @data:S_nohardware
		test	cl,1
		jz	nowheel		; jump if wheel not present

;---------- run test program if wheel is OK

		mov	dx,offset @data:S_anykey
		mov	ah,9
		int	21h		; print message

wheelloop:	hlt			; stop CPU until external event
		mov	ah,1
		int	16h		; check keyboard
		jnz	exit		; continue until key pressed

		mov	ax,3
		int	33h		; get position, button and wheel
		test	bh,bh		; check wheel counter since last call
		jz	wheelloop	; jump if wheel not moved

		mov	dl,'u'		; print 'u' if moved up
		js	showchar	; jump if wheel moved upward
		mov	dl,'d'		; else print a 'd' character
showchar:	mov	ah,2
		int	21h		; print character
		jmp	wheelloop	; and continue loop

exit:		mov	ah,0
		int	16h		; remove the last key
		int	20h		; exit

;---------- error processing

nowheel:	mov	ah,9		; print 1st part of error
		int	21h
		mov	dx,offset @data:S_doesnt
		;mov	ah,9
		int	21h		; print end part of error
		int	20h		; exit

;лллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

end
