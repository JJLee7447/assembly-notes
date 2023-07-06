; 要解决的问题
; 实现一个子程序setscreen ，为显示输出提供如下功能
; ( 1) 清屏。
; ( 2) 设置前景色。
; ( 3) 设置背景色。
;  (4) 向上滚动一行

; 子程序入口参数说明∶
; (1）用ah寄存器传递功能号:
; - 0 表示清屏，
; - 1 表示设置前景色，
; - 2 表示设置背景色，
; - 3 表示向上滚动一行。
; (2）对2、3号功能，用al传送颜色值，(al)={0,1,2,3,4,5,6,7}

; ```
assume cs:code, ds:data, ss:stack
data segment
    table    dw subfunc1,subfunc2,subfunc3,subfunc4
    datasave dw 0,0,0,0
data ends

stack segment
          dw 128 dup(0)
stack ends

code segment
    main:          
                   mov  ax,data
                   mov  ds,ax
                   mov  ax,stack
                   mov  ss,ax
                   mov  sp,128

    ; 功能设置

                   mov  ah,2
                   mov  al,3

                   call setScreen


                   mov  ax,4c00h
                   int  21h

setScreen proc
                   push bx
                   push cx

                   cmp  ah, 3
                   ja   exit
                   mov  bl,ah
                   mov  bh,0
                   add  bx,bx
                   call word ptr table[bx]

    exit:          
                   pop  cx
                   pop  bx
                   ret
setScreen endp

subfunc1 proc
                   push bx
                   push cx
                   push es

                   mov  bx,0b800h
                   mov  es,bx
                   mov  cx,80*25
        
    clear:         
                   mov  word ptr es:[di],' '
                   add  di,2
                   loop clear

                   pop  es
                   pop  cx
                   pop  bx

                   ret
subfunc1 endp

subfunc2 proc
                   push bx
                   push cx
                   push es

                   mov  bx,0b800h
                   mov  es,bx
                   mov  cx,80*25
                   mov  bx,1

    setFore:       
                     ; 将原来的前景色清零
                   and  byte ptr es:[bx],11111000b
                     ; 将al的值写入前景色
                   or   byte ptr es:[bx],al
                   add  bx,2
                   loop setFore

                   pop  es
                   pop  cx
                   pop  bx

                   ret
subfunc2 endp

subfunc3 proc
                   push bx
                   push cx
                   push es
                ; 将al的值左移4位,得到背景色
                   mov cl,4
                   shl al,cl

                   mov  bx,0b800h
                   mov  es,bx
                   mov  cx,80*25
                   mov  bx,1
    setbackground:       
                   ; 将原来的背景色清零
                   and  byte ptr es:[bx],10001111b
                   ; 将al的值写入背景色
                   or   byte ptr es:[bx],al
                   add  bx, 2
                   loop setbackground

                   pop  es
                   pop  cx
                   pop  bx
                   ret
subfunc3 endp

subfunc4 proc
    ; (4)向上滚动一行∶依次将第n+1行的内容复制到第n行处:最后一行为空。
                   push cx
                   push es
                   push ds
                   push si
                   push di
    ; 准备
                   mov  si,0b800h
                   mov  es,si
                   mov  ds,si
                   mov  si,160                        ; si 指向 n+1 行的第一个字符
                   mov  di,0                          ; di 指向 n 行的第一个字符
                   cld
                   mov  cx, 24                        ; 复制24行
    ; 复制
    repeat_24:        
                   push cx
                   mov  cx, 80                        ; 复制80个字
                   rep  movsw                         ;  复制一个字
                   pop  cx
                   loop repeat_24

    ; 清空最后一行
                   mov  cx, 80
                   mov  si, 0
    clear_last_row:
                   mov  byte ptr es:[si], ' '
                   add  si, 2
                   loop clear_last_row


                   pop  di
                   pop  si
                   pop  ds
                   pop  es
                   pop  cx
                   ret
subfunc4 endp
code ends
end main