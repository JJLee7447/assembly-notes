assume cs:code, ds:data, ss:stack
data segment
    table db '0123456789ABCDEF'
    msg   db 2bh
data ends

stack segment
          dw 128 dup(0)
stack ends

code segment
    main:     
              mov  ax, data
              mov  ds, ax
              mov  ax, stack
              mov  ss, ax
              mov  sp, 128
              call showBytes

              mov  ax, 4c00h
              int  21h

showBytes proc
              push bx
              push cx
              push es
              push ax

              mov  ax, 0b800h
              mov  es, ax
    ; 取值到al
              mov  byte ptr al, msg
    ; ah al 分别取高低4位
              mov  ah, al
              mov  cl, 4
              shr  ah, cl
              and  al, 0fh
    ; 从table中取值 ah
              mov  bl, ah
              mov  bh, 0
              mov  ah, table[bx]
              mov  es:[160*12 + 40*2], ah
              mov  byte ptr es:[160*12 + 40*2 + 1], 71h
    ; 从table中取值 al
              mov  bl, al
              mov  bh, 0
              mov  al, table[bx]
              mov  es:[160*12 + 40*2 + 2], al
              mov  byte ptr es:[160*12 + 40*2 +2+1], 71h

              pop  ax
              pop  es
              pop  cx
              pop  bx
              ret

showBytes endp
code ends
end main
```
