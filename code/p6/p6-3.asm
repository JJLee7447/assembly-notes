assume cs:code, ds:data, ss:stack
data segment
    table dw ag0,ag30,ag60,ag90,ag120,ag150,ag180
    ag0   db '0',0                                   ;0 sin(0)=0
    ag30  db '0.5',0                                 ;1 sin(30)=0.5
    ag60  db '0.866',0                               ;2 sin(60)=0.866
    ag90  db '1',0                                   ;3 sin(90)=1
    ag120 db '0.866',0                               ;4 sin(120)=0.866
    ag150 db '0.5',0                                 ;5 sin(150)=0.5
    ag180 db '0',0                                   ;6 sin(180)=0
    msg   db 60,90,30

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
            call showsin

            mov  ax, 4c00h
            int  21h

showsin proc
            push bx
            push es
            push cx
            push ax
            mov  bx , 0b800h
            mov  es, bx

    ; al 取数
            mov byte ptr al, msg

            mov  ah, 0
            mov  bl,30
            div  bl
            mov  bl,al
            mov  bh,0
            add  bx,bx
    ; 从table中取值
            mov  bx,table[bx]

    ; si 为显示位置
            mov  si,160 * 12 +40*2
    shows:  
            mov  ah, ds:[bx]

            cmp  ah, 0
            je   exit
            mov  es:[si], ah
            mov  es:[si+1], 71h
            inc bx
            add  si, 2
            jmp  shows


    exit:   

            pop  ax
            pop  cx
            pop  es
            pop  bx
            ret
showsin endp
code ends
end main
```
