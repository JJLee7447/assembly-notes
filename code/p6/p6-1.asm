assume cs:code, ds:data, ss:stack
data segment
         db 'hello world', 0
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
         mov  ax, 0b800h
         mov  es, ax
         mov  si, 0
         mov  di, 160*12 + 80 - 5*2

         call func
         mov  ax, 4c00h
         int  21h
    func proc
         push cx
         push si
         push di


    w:   mov  cl, ds:[si]
         mov  ch, 0
         jcxz ok

         mov  es:[di], cx
         inc  di
         mov  byte ptr es:[di], 71h
         inc  si
         inc  di
         jmp  w

    ok:  
         pop  di
         pop  si
         pop  cx
         ret


func endp
code ends
end main
```