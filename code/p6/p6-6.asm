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
             mov  si,offset do0

    ; 获取安装程序的目的地址
             mov  ax,0
             mov  es,ax
             mov  di,200h

    ; 获取安装程序的长度
             mov  cx,offset do0end - offset do0
             cld
    ; 根据si和di的值，将中断处理程序复制到目的地址
             rep  movsb                            ; 将中断处理程序复制到目的地址

    ; 设置中断向量表
             mov  ax,0
             mov  es,ax
             mov  word ptr es:[0*4],200h           ; 设置中断向量表的偏移地址  IP
             mov  word ptr es:[0*4+2],0            ; 设置中断向量表的段地址  CS
    ; 主程序结束
             mov  ax,4c00h
             int  21h

    ; 设置中断处理程序
    do0:     
             jmp  short do0start
    str      db   'overflow!'                      ; 将数据写到代码区保证与代码起加载。
    tstr     db   '000'                            ; 将数据写到代码区保证与代码起加载。
    table    db   '0123456789ABCDEF'
    do0start:
    ; 找到显示区域以及字符串的地址
             mov  ax,cs
             mov  ds,ax
             mov  si, 202h                         ; 字符串的地址

             mov  ax,0b800h
             mov  es,ax
             mov  di,12*160+36*2
             mov  cx,9                             ; 字符串长度
    s:                                             ; 将数据写到显示区域
             mov  al, [si]                         ; 获取显示字符保存到al
             mov  es:[di],ax                       ; 设置显示字符到显示区域
             mov  es:[di+1],71h                    ; 设置显示属性
             inc  si
             add  di,2
             loop s

            
             mov  ax,cs
             mov  ds,ax
             mov  si, 20bh                         ; 字符串的地址

             mov  di, 24*160+40*2
             mov  cx ,3


    s1:                                            ; 将数据写到显示区域

             mov  al, [si]                         ; 获取显示字符保存到al
             mov  es:[di],ax                       ; 设置显示字符到显示区域
             mov  es:[di+1],71h                    ; 设置显示属性
             inc  si
             add  di,2
             loop s1
            
    

             mov  ax,4c00h
             int  21h


    do0end:  
             nop

code ends
end main
```

;---------------------------------------------------------------
    ;          mov  ax,0b800h
    ;          mov  es,ax
    ;          mov  si,0
    ;          mov  di,24*160+40*2

    ;         mov ax,cs
    ;         mov ds,ax
    ;         mov  si, 20eh

    ;         mov bx, offset tstr
    
    ;         mov al,bl ; 保存bl
    ;         mov dh,bh  ; 保存bh
    ; ; 
    ;         mov ah,al
    ;         mov cl,4
    ;         shr ah,cl
    ;         and al,0fh

    ;         mov dl,dh
    ;         mov cl,4
    ;         shr dh,cl
    ;         and dl,0fh

    ; ;
    ;         mov bl,dh
    ;         mov bh,0
    ;         mov al,table[bx]
    ;         mov es:[di],al
    ;         mov es:[di+1],71h

    ;         mov bl,dl
    ;         mov bh,0
    ;         mov al,table[bx]
    ;         mov es:[di+2],al
    ;         mov es:[di+3],71h

    ;         mov bl,ah
    ;         mov bh,0
    ;         mov al,table[bx]
    ;         mov es:[di+4],al
    ;         mov es:[di+5],71h

    ;         mov bl,al
    ;         mov bh,0
    ;         mov al,table[bx]
    ;         mov es:[di+6],al
    ;         mov es:[di+7],71h


        
            ;  mov  al, [si]
            ;  mov  es:[di],al
            ;  mov  es:[di+1],71h
            ;  inc  si
            ;  add  di,2