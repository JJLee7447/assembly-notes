data segment
         db 22,1,3,8,9,8,34,99
         db 0,0,0,0,0,0,0,0
data ends

stacksg segment stack
            db 10h dup(0)
stacksg ends
code segment
            assume cs:code, ds:data, ss:stacksg
    main:   
            mov    ax, data
            mov    ds, ax
            mov    ax, stacksg
            mov    ss, ax
            mov    sp, 10h
            call   equql8
            call   abouve8
            call   below8
            
            mov    ax, 4c00h
            int    21h


    equql8: 
            push   cx
            push   ax
            push   di
            push   si

            mov    si, 0
            mov    di, 8
            mov    cx, 8
            mov    ax, 0
    s0:     
            mov    byte ptr al, [si]
            cmp    byte ptr al, 8
            je     ok
            jmp    short next1
    ok:     inc    ah
    next1:  
            inc    si
            mov    byte ptr [di], ah
            loop   s0

            pop    si
            pop    di
            pop    ax
            pop    cx
            ret


    abouve8:
            push   cx
            push   ax
            push   di
            push   si
    
            mov    si, 0
            mov    di, 9
            mov    cx, 8
            mov    ax, 0
    s1:     
            mov    byte ptr al, [si]
            cmp    byte ptr al, 8
            ja    ok1
            jmp    short next2
    ok1:    inc    ah
    next2:  
            inc    si
            mov    byte ptr [di], ah
            loop   s1
    
            pop    si
            pop    di
            pop    ax
            pop    cx
            ret
    
    below8: 
            push   cx
            push   ax
            push   di
            push   si

            mov    si, 0
            mov    di, 10
            mov    cx, 8
            mov    ax, 0
    s2:     
            mov    byte ptr al, [si]
            cmp    byte ptr al, 8
            jb     ok2
            jmp    short next3
    ok2:    inc    ah
    next3:  
            inc    si
            mov    byte ptr [di], ah
            loop   s2

            pop    si
            pop    di
            pop    ax
            pop    cx
            ret

code ends
end main
