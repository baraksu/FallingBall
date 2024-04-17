.MODEL SMALL
.STACK 100h

.DATA

msg1 db 13,10,'Enter the stair wide $'
msg2 db 13,10,'Enter the radios od the ball $'

wide dw 0
radios db 0
cotter dw 0

x_ dw 0
y_ dw 0
color dw 255

.CODE 

proc DrawStair 
 pusha
mov cx,wide
    
lop:


    xor bh, bh  ; bh = 0
	mov cx, [x_]
	mov dx, [y_]
	mov ax, [color]
	mov ah, 0ch
	int 10h
		
	inc x_
loop lop



popa
ret              
endp DrawStair

    
start:
mov ax , @data
mov DS, AX
xor ax,ax

lea dx,msg1
mov ah,9
int 21h

xor ax,ax

mov AH, 01h
int 21h

sub al,'0' 
cbw
mov wide,ax


lea dx,msg2
mov ah,9
int 21h

mov AH, 01h
int 21h

sub al,'0'
mov radios,al

mov al,radios
add al,radios
cbw
mov cotter,ax


mov ax, 13h
int 10h

mov ax,cotter       
mov y_,ax       
call DrawStair






END start
