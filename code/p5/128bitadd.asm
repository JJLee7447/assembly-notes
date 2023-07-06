assume cs:code,ds:data,ss:stacksg
data segment
         dw 8 dup(0)
         dw 0A452H,0A8F5H,78E6H,0A8EH,8B7AH,54F6H,0F04H,671EH
         dw 0E71EH,0EF04H,54F6H,8B7AH,0A8EH,78E6H,58F5H,0452H
data ends
stacksg segment
          db 16 dup(0)
stacksg ends
code segment
    main:  
           mov    ax,data
           mov    ds,ax
           mov    si,16
           mov    di,32
           mov    ax,stacksg
           mov    ss,ax
           mov    sp,16

           mov    cx,8
           call   add128

           mov    ax,4c00h
           int    21h


    add128:
    ;压栈
           push   ax
           push   cx
           push   si
           push   di
    ;将cf清零
    s:
           sub    ax,ax
    ;从data段取数
           mov    ax,ds:[si]
    ;加法
           adc    ax,ds:[di]
    ;存入data段
           mov    ds:[si-16],ax
    ;下一个数
    ; 使用inc 不会影响进位标志位  而 add 会影响进位标志位
           inc    si
           inc    si
           inc    di
           inc    di
    ;循环
           loop   s
    ;出栈
           pop    di
           pop    si
           pop    cx
           pop    ax
           ret

code ends
end main
```