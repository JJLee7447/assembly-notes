assume cs:code, ds:data, ss:stack

stack segment
    dw  128 dup(0)
stack ends

data segment
    msg db  13,10,'hello word',13,10,'$'
data ends

code segment
main:
    mov ax,data
    mov ds,ax

    lea dx,msg
    mov ah,9
    int 21h

    mov ax,4c00h
    int 21h
code ends
end main
```