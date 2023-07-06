assume cs:codesg, ds:datasg, ss:stacksg
datasg segment
    dw  8 dup(1)
datasg ends

stacksg segment
    dw  8 dup(0)
stacksg ends

codesg segment
main:
    ;初始化栈和数据段
    mov ax,stacksg
    mov ss,ax
    mov sp,16
    mov ax,datasg
    mov ds,ax
    mov bx,0

    mov ax,1
    push ax
    mov ax,3
    push ax


    call difcube

    mov ax,4c00h
    int 21h
difcube:
    push bp         ; 保存bp，因为bp可能在其他地方被修改
    mov bp,sp
    mov ax,[bp+4]   ; 将参数取出来
    sub ax,[bp+6]   ; ax = ax - ss:[bp+6]
    mov bp,ax       
    mul bp
    mul bp          ; 结果存入ax和dx

    mov ds:[bx],ax  ; 将结果存入ds:[bx]
    mov ds:[bx+2],dx

    pop bp          ; 因为该bp可能在其他地方被修改，所以需要恢复 
    ret 4           ; 将参数弹出栈，因为参数已经不需要了

codesg ends
end main
```