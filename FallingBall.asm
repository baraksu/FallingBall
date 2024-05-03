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
color dw 15d

.CODE 

proc DrawStair
    
 xor si,si 
mov si,wide
    
lop:


    xor bh, bh  
	mov cx, [x_]
	mov dx, [y_]
	mov ax, [color]
	mov ah, 0ch
	int 10h
		
	inc x_ 
	dec si
cmp si,0
ja lop
     
xor si,si
mov si,cotter     
lop2:

    xor bh, bh  
	mov cx, [x_]
	mov dx, [y_]
	mov ax, [color]
	mov ah, 0ch
	int 10h 
	
  inc y_
  dec si
cmp si,0
ja lop2


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
 

MOV AX, 199   
MOV Bx, cotter
DIV dl
xor ah,ah

 
mov si,ax
inc si

mov ax,cotter       
add y_,ax       

lop0:

push si

mov bx,wide
add x_,bx
call DrawStair
mov ax,cotter       
add y_,ax

pop si
dec si

cmp si,0
ja lop0




END start
