;将首字母转换成大写
;转换方法 and destination,11011111b
assume cs:codesg,ds:datasg
datasg segment
    db '1. file         '
    db '2. edit         '
    db '3. search       '
datasg ends

codesg segment
start:
    mov ax,datasg
    mov ds,ax

    mov bx,0
    mov cx,3

s:  mov al,[bx+3]
    and al,11011111b
    mov [bx+3],al
    add bx,10h
    loop s

    mov ax,4c00h
    int 21h

codesg ends
end start