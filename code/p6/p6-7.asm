assume cs:code, ss:stack

stack segment
          db 100 dup(0)
stack ends

code segment
    main:    
    ; 安装中断处理程序

    ; 获取要安装的程序的段地址和偏移地址
             mov  ax,cs
             mov  ds,ax
             mov  si,offset capital

    ; 获取安装程序的目的地址
             mov  ax,0
             mov  es,ax
             mov  di,200h

    ; 获取安装程序的长度
             mov  cx,offset capitalend - offset capital
             cld
    ; 根据si和di的值，将中断处理程序复制到目的地址
             rep  movsb                            ; 将中断处理程序复制到目的地址

    ; 设置中断向量表
             mov  ax,0
             mov  es,ax
             mov  word ptr es:[7ch*4],200h           ; 设置中断向量表的偏移地址  IP
             mov  word ptr es:[7ch*4+2],0            ; 设置中断向量表的段地址  CS
    ; 主程序结束
             mov  ax,4c00h
             int  21h
    ; 中断处理程序
capital:
    ; 保存寄存器
             push cx
             push si

    change:
        ; 获取键盘输入的字符

            mov byte ptr cl,[si]
            mov ch,0
            jcxz ok
            and byte ptr [si],11011111b
            inc si
            jmp change

    ok:
    ; 恢复寄存器
            pop si
            pop cx
            iret
capitalend:
    nop
code ends
end main
```