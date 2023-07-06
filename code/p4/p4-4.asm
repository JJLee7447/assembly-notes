assume cs:codesg,ds:datasg,ss:stacksg
datasg segment
    db 'ibm             '
    db 'amd             '
    db 'int             '
    db 'not             '

datasg ends

stacksg segment
    dw 0,0,0,0,0,0,0,0

stacksg ends

codesg segment
    start:
        mov ax,datasg
        mov ds,ax

        mov ax,stacksg
        mov ss,ax
        mov sp,16

        mov cx,4
        mov bx,0
    s0: 
        push cx
        mov si,0
        mov cx,3
    s1: 
        mov al,[bx+si]
        and al,11011111b
        mov [bx+si],al
        inc si
        loop s1

        add bx,10h
        pop cx
        loop s0

        mov ax,4c00h
        int 21h
    codesg ends
end start