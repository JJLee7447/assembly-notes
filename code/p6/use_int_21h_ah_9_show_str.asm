assume cs:code, ds:data

data segment
    str  db "Hello World!$"
data ends

code segment
    start:
        ;   mov ah,2
        ;   mov bh,0
        ;   mov dh,5
        ;   mov dl,12
        ;   int 10h

          mov ax, data
          mov ds, ax
          mov dx, offset str
          mov ah, 9
          int 21h

          mov ax, 4c00h
          int 21h
code ends
end start
```
