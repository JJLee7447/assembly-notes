assume cs:codesg, ds:datasg
datasg segment
    db 'conversation'
datasg ends

codesg segment

main:
    mov ax, datasg
    mov ds, ax
    mov si, 0
    mov cx, 12

capital:
    and byte ptr ds:[si], 11011111b
    inc si
    loop capital

    mov ax, 4c00h
    int 21h

codesg ends
end main
