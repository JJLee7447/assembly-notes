assume cs:codesg
codesg segment

s0: mov ax,bx
    mov si,offset s0
    mov di,offset s1

    mov ax,cs:[si]
    mov cs:[di],ax
s1: nop
    nop

    mov ax,4c00h
    int 21h

codesg ends
end s0