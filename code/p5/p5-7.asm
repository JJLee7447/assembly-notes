assume cs:codesg , ds:datasg, ss:stacksg

datasg segment
           db 'worl',0
           db 'hell',0
           db 'wind',0
           db 'good',0
datasg ends

stacksg segment
            dw 10h dup(0)
stacksg ends

codesg segment
    main:   
    ;初始化栈和数据段
            mov  ax,stacksg
            mov  ss,ax
            mov  sp,10h

            mov  ax,datasg
            mov  ds,ax
            mov  bx,0
            mov  cx,4

    ;调用capital过程将字符串中的小写字母转换为大写字母
    s:      
            mov  si,bx
            call capital
            add  bx,5
            loop s

            mov  ax,4c00h
            int  21h

    ;将字符串中的小写字母转换为大写字母
    ;si:字符串首地址
    ;cx:字符串长度
    capital:
            push cx
            push si
    change: 
            mov  cl,ds:[si]
            mov  ch,0
            jcxz ok

            and  byte ptr ds:[si], 11011111b
            inc  si
            jmp  short change
    ok:     
            pop  si
            pop  cx
            ret

codesg ends
end main
