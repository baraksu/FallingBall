.MODEL SMALL
.STACK 100h

.DATA

msg1 db 13,10,'Enter the stair wide $'
msg2 db 13,10,'Enter the radios od the ball $'

t1 db 13,10,'  _____     _ _ _               ____        _ _ $' 
t2 db 13,10,' |  ___|_ _| | (_)_ __   __ _  | __ )  __ _| | |$'
t3 db 13,10,' | |_ / _  | | | |  _ \ / _  | |  _ \ / _  | | |$'
t4 db 13,10,' |  _| (_| | | | | | | | (_| | | |_) | (_| | | |$'
t5 db 13,10,' |_|  \__,_|_|_|_|_| |_|\__, | |____/ \__,_|_|_|$'
t6 db 13,10,'                        |___/                   $'

wide dw 0
radios dw 0
cotter dw 0

lop_y dw 0
lop_x dw 0
final_loop dw 0

x_ dw 0
y_ dw 0
color dw 15d 

half_wide dw 0
x_center dw 0
y_center dw 0

color2 dw 0

.CODE
;=============
proc get_wide
    lea dx,msg1
    mov ah,9
    int 21h

    xor ax,ax

    mov AH, 01h
    int 21h

    sub al,'0' 
    cbw 

    mov wide,ax 
ret 
endp get_wide  

;==============

proc get_radios
    lea dx,msg2
    mov ah,9
    int 21h
    
    mov AH, 01h
    int 21h
    
    sub al,'0'
    cbw
    mov radios,ax

ret
endp get_radios    

;==============
    
proc titel
    lea dx,t1
    mov ah,9
    int 21h 
    
    lea dx,t2
    mov ah,9
    int 21h
    
    lea dx,t3
    mov ah,9
    int 21h
    
    lea dx,t4
    mov ah,9
    int 21h
    
    lea dx,t5
    mov ah,9
    int 21h
    
    lea dx,t6
    mov ah,9
    int 21h
    
ret
endp titel 

;=========

proc circle

 mov bp,sp
 pusha

 
 mov bx, [bp+4]
 mov ax,2
 mul bx
 mov bx,3
 sub bx,ax ; E=3-2r

 mov [bp+2],bx

 mov ax,[bp+12] ;color goes in al
 mov ah,0ch

 
drawcircle:

 mov ax,[bp+12] ;color goes in al
 mov ah,0ch

 mov cx, [bp+4] ;Octonant 1
 add cx, [bp+10] ;( x_value + x_center,  y_value + y_center)
 mov dx, [bp+6]
 add dx, [bp+8]
 int 10h

 

 mov cx, [bp+4] ;Octonant 4
 neg cx
 add cx, [bp+10] ;( -x_value + x_center,  y_value + y_center)
 int 10h

;

 mov cx, [bp+6] ;Octonant 2
 add cx, [bp+10] ;( y_value + x_center,  x_value + y_center)
 mov dx, [bp+4]
 add dx, [bp+8]
 int 10h

;

 mov cx, [bp+6] ;Octonant 3
 neg cx
 add cx, [bp+10] ;( -y_value + x_center,  x_value + y_center)
 int 10h

 

 mov cx, [bp+4] ;Octonant 8
 add cx, [bp+10] ;( x_value + x_center,  -y_value + y_center)
 mov dx, [bp+6]
 neg dx
 add dx, [bp+8]
 int 10h

;

 mov cx, [bp+4] ;Octonant 5
 neg cx
 add cx, [bp+10] ;( -x_value + x_center,  -y_value + y_center)
 int 10h

 
 mov cx, [bp+6] ;Octonant 7
 add cx, [bp+10] ;( y_value + x_center,  -x_value + y_center)
 mov dx, [bp+4]
 neg dx
 add dx, [bp+8]
 int 10h

;

 mov cx, [bp+6] ;Octonant 6
 neg cx
 add cx, [bp+10] ;( -y_value + x_center,  -x_value + y_center)
 int 10h

 

condition1:

 cmp [bp+2],0

 jg condition2     

 mov cx, [bp+6]

 mov ax, 2

 imul cx ;2y

 add ax, 3 ;ax=2y+3

 mov bx, 2

 mul bx  ; ax=2(2y+3)

 add [bp+2], ax

 mov bx, [bp+6]

 mov dx, [bp+4]

 cmp bx, dx 

 inc [bp+6]

 jmp drawcircle

 

condition2:

 ;e>0

 mov cx, [bp+6]

 mov ax,2

 mul cx  ;cx=2y

 mov bx,ax

 mov cx, [bp+4]

 mov ax, -2

 imul cx ;cx=-2x

 add bx,ax

 add bx,5;bx=5-2z+2y

 mov ax,2

 imul bx ;ax=2(5-2z+2y)      

 add [bp+2],ax

 mov bx, [bp+6]

 mov dx, [bp+4]

 cmp bx, dx

 ja donedrawing

 dec [bp+4]   

 inc [bp+6]

 jmp drawcircle

 

donedrawing:

popa

ret 

endp circle 
 
;==============
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

;=============

    
start:
mov ax , @data
mov DS, AX
xor ax,ax

call titel ; print the titel

call get_wide ; get & set the wide value
 
call get_radios ; get & set the radios value

mov ax,radios
add ax,radios
mov cotter,ax ; the cotter is for the y value (for the length of the stair)


mov ax, 13h
int 10h
 

MOV AX, 199h   
MOV Bx, cotter
DIV dl
xor ah,ah
mov lop_y,ax  ; the number of the times the y wont exceed of the boerd 

MOV AX, 319h   
MOV Bx,wide
DIV dl
xor ah,ah
mov lop_x,ax ; the number of the times the x wont exceed of the boerd

cmp ax,lop_y
jb run_lop_x

    mov si,lop_y
    mov final_loop,si  ; the number of the times the proces will run until they sould be stopped
    
    jmp continue
 
run_lop_x:
 
    mov si,lop_x
    mov final_loop,si ; the number of the times the proces will run until they sould be stopped
    
continue:

inc si

mov ax,cotter       
add y_,ax 

mov bx,wide
add x_,bx 

mov ax,cotter       
add y_,ax     

lop0:

push si


call DrawStair ; draw the stairs


pop si
dec si

cmp si,0
ja lop0

;===============

MOV AX, wide
MOV BL, 2
DIV BL
cbw
mov half_wide,ax ; for the center of the circle
mov x_center,ax
xor ax,ax

mov ax,cotter
mov y_center,ax 

mov si,final_loop

lop1:
;push si 
mov bx,color
Push bx ; color
 
mov bx,x_center 
Push bx ;x center


mov bx,y_center
Push bx ;y center

mov bx, 0
Push bx ;zero

mov bx, radios
Push bx ; radius

mov bx,0
Push bx ; color

Call circle

pop bx

pop bx

pop bx

pop bx

pop bx



mov bx ,color2  
Push bx ; color

mov bx,x_center 
Push bx ;x center

mov bx, y_center
Push bx ;y center

mov bx, 0
Push bx ;zero

mov bx, radios
Push bx ; radius
  
mov bx ,0  
Push bx ; color

Call circle ; draw the circle with rhe entered values

pop bx

pop bx

pop bx

pop bx

pop bx 

mov ax,x_center
add ax, wide
add ax,half_wide
mov x_center,ax

mov bx,color
Push bx ; color

mov bx,x_center 
Push bx ;x center

mov bx, y_center
Push bx ;y center

mov bx, 0
Push bx ;zero

mov bx, radios
Push bx ; radius

mov bx,0
Push bx ; color

Call circle ; draw the circle with rhe entered values

pop bx

pop bx

pop bx

pop bx

pop bx

mov bx ,color2
Push bx ; color

mov bx,x_center 
Push bx ;x center

mov bx, y_center
Push bx ;y center

mov bx, 0
Push bx ;zero

mov bx, radios
Push bx ; radius

mov bx ,0
Push bx ; color

Call circle

pop bx

pop bx

pop bx

pop bx

pop bx
 
mov bx ,color2
Push bx ; color 
 
mov bx,x_center 
Push bx ;x center

mov ax,y_center
add ax,cotter
mov y_center,ax

mov bx,y_center
Push bx ;y center

mov bx, 0
Push bx ;zero

mov bx, radios
Push bx ; radius

mov bx ,0
Push bx ; color

Call circle  ; draw the circle with rhe entered values

pop bx

pop bx

pop bx

pop bx

pop bx



cmp si,0
ja lop1

END start
