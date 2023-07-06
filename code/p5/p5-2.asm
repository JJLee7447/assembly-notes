assume cs: codesg
codesg segment
start:  mov ax,04
        jmp short s
        add ax,1
        nop
        nop
   s:   inc ax
codesg ends
end start