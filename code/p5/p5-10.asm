assume cs:code,ds:data,ss:stack
data segment
         db 22,1,3,8,9,8,34,99
         db 0,0,0,0,0,0,0,0
data ends

stack segment stack
            db 10h dup(0)
stack ends

code segment
main:
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
    mov sp,10h

    call func

    mov ax,4c00h
    int 21h

func:
    push cx
    push bx
    push ax
    push si
    push di

    mov cx,8    
    mov si,0
    mov di,0
    mov bx,0
    mov ax,0
s0:
    mov al,byte ptr ds:[si]
    cmp al,8
    je ok1
    ja ok2
    jb ok3
    jmp next1
ok1:
    inc ah
    add byte ptr ds:[di],ah
    mov ah,0
ok2:
    inc ah
    add ds:[di+1],ah
    mov ah,0
ok3:
    inc ah
    add ds:[di+2],ah
    mov ah,0

next1:
    inc si
    loop s0

    pop di
    pop si
    pop ax
    pop bx
    pop cx
    ret

code ends
end main
