;adc 大数相加
;001e f000H + 0020 1000H
datasg segment
           dw 10h dup(0)
code segment
         assume cs:code

    main:
         mov    ax,datasg
         mov    ds,ax
         mov    ax,0f000h
         mov    bx,001eh

         add    ax,1000h
         adc    bx,0020h

         mov    word ptr ds:[0],ax
         mov    word ptr ds:[2],bx
         mov    ax ,4c00h
         int    21h
code ends
end main
```