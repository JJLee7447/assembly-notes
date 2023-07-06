assume cs:codesg, ss:stacksg

stacksg segment
    db 16 dup(0)
stacksg ends

codesg segment

main:
    mov ax,stacksg
    mov ss,ax
    mov sp,16

    mov ax,1000
    call s

    mov ax,4c00h
    int 21h

s:  
    add ax,ax
    ret

codesg ends
end main
