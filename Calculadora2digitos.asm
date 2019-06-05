section .data

    operando1: db "Entre com o operando 1: ", 10
    operando1Len equ $-operando1
    operando2: db "Entre com o operando 2: ", 10
    operando2Len equ $-operando2
    operador: db "Entre com a operacao( + , - , / , * ): ", 10
    operadorLen equ $-operador
   
    
section     .bss
    valorLido: resb 4
    valorLido2: resb 4
    msg:        resb 20
    op1:        resb 10
    op2:        resb 10
    op:         resb 10
    conta:      resb 4
    aux:        resb 4
    valorBinario:   resb 10

section .text
global main
main:
    mov     ebp, esp; for correct debugging
    
    ;Impressao mesg1
        mov eax, 4; system call para sys_write
	mov ebx, 1
	mov ecx, operando1
	mov edx, operando1Len

	int 80h ; chamada do kernel
    
    
    
    ;SCAN OPERANDO 1
    mov     ebp, esp; for correct debugging
    
    mov     eax,3   ; serviço do SO sys_read  
    mov     ebx,0   ; file deor (stdin)  
    mov     ecx,valorLido ; carrega o endereco da area de memoria  
    mov     edx,2   ; tamanho da area de memoria                            
    int     0x80    ; chamada da interrupcao 80h  (chamada ao SO)
    
    
    ;armazenar operando 1
    mov [op1], word 0
    
    ;somar primeiro dígito
    mov al, [valorLido] ;copia o primeiro dígito
    movzx ax, al
    sub ax, '0' ;converte de ascii para decimal
    mov bx, 10
    mul bx ;obter n*10 em ax
 
    mov bx, [op1] ;copiar o valor atual do operando 1 em bx
    add ax, bx ;somar o valor atual do operando 1 com o valor do novo dígito processado
    mov [op1], ax ;atualizar valor do operando 1 com o dígito processado
    
    xor eax,eax
    ;somar segundo dígito
    mov al, [valorLido + 1] ;copia o secontagundo dígito
    movzx ax, al
    sub ax, '0' ;converte de ascii para decimal
    mov bx, 10
  
    mov bx, [op1] ;copiar o valor atual do operando 1 em bx
    add ax, bx ;somar o valor atual do operando 1 com o valor do novo dígito processado
    mov [op1], ax ;atualizar valor do operando 1 com o dígito processado
    
    
    
    
    ;transf
    
    
    
    ;/////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    ;Impressao mesgOP
        mov eax, 4; system call para sys_write
        mov ebx, 1
	mov ecx, operador
	mov edx, operadorLen

	int 80h ; chamada do kernel

    ;SCAN OPERADOR
    xor eax, eax
    mov     eax,3   ; serviço do SO sys_read  
    mov     ebx,0   ; file deor (stdin)  
    mov     ecx,op ; carreaga o endereco da area de memoria  
    mov     edx,1 ; tamanho da area de memoria                             
    int     0x80    ; chamada da interrupcao 80h  (chamada ao SO)
     
     ;//////////////////////////////////////////////////////////////////////////  
     
    ;Impressao mesg2 
        mov eax, 4; system call para sys_write
	mov ebx, 1
	mov ecx, operando2
	mov edx, operando2Len

	int 80h ; chamada do kernel
           
                          
    ;SCAN OPERANDO 2
    mov     ebp, esp; for correct debugging
    mov     eax,3   ; serviço do SO sys_read  
    mov     ebx,0   ; file deor (stdin)  
    mov     ecx,valorLido2 ; carreaga o endereco da area de memoria  
    mov     edx,2 ; tamanho da area de memoria                             
    int     0x80    ; chamada da interrupcao 80h  (chamada ao SO)
    
    ;armazenar operando 2
    mov [op2], word 0
    
    
    ;somar primeiro dígito
  
    mov al, [valorLido2] ;copia o primeiro dígito
    movzx ax, al
    sub ax, '0' ;converte de ascii para decimal
    mov bx, 10
    mul bx ;obter n*10 em ax
    mov bx, [op2] ;copiar o valor atual do operando 1 em bx
    add ax, bx ;somar o valor atual do operando 1 com o valor do novo dígito processado
    mov [op2], ax ;atualizar valor do operando 1 com o dígito processado
    
    
    xor eax,eax
    ;somar segundo dígito
    mov al, [valorLido2 + 1] ;copia o segundo dígito
    movzx ax, al
    sub ax, '0' ;converte de ascii para decimal
    mov bx, 10

    mov bx, [op2] ;copiar o valor atual do operando 1 em bx
    add ax, bx ;somar o valor atual do operando 1 com o valor do novo dígito processado
    mov [op2], ax ;atualizar valor do operando 1 com o dígito processado
    
   

    
    ;////////////////////////////////////////////////////////////////////////////////////
    
    
    ;IF ELSE
    cmp     [op], byte '+'
    je      soma
    
    cmp     [op], byte '-'
    je      subtracao
    
    cmp     [op], byte '*'
    je      multiplicacao
    
    cmp     [op], byte '/'
    je      divisao
    
soma:
    mov     eax,[op1]
    mov     ebx,[op2]
    add     eax, ebx ; Soma dos valores inteiros
    mov     [conta], eax;

    jmp     resultado
    
subtracao:
    mov     eax,[op1]
    mov     ebx,[op2]
    sub     eax, ebx
    mov     [conta], eax
    
    jmp     resultado

multiplicacao:
    mov     [op1], ax
    mov     ebx,[op2]
    mul     ebx
    mov     [conta], ax
    
    jmp     resultado

;TESTE
divisao:
    mov ax, [op1]
    mov ebx, [op2]
    div ebx
    mov [conta], ax
    
    jmp resultado

resultado:
    
    mov al, [conta] ;copia o primeiro dígito
    movzx ax, al
    add ax, '0' ;converte de ascii para decimal
    mov bx, 10
    div bx ;obter n*10 em ax
    mov bx, [aux] ;copiar o valor atual do operando 1 em bx
    add ax, bx ;somar o valor atual do operando 1 com o valor do novo dígito processado
    mov [aux], ax ;atualizar valor do operando 1 com o dígito processado
    
    
    xor eax,eax
    ;somar segundo dígito
    mov al, [conta + 1] ;copia o segundo dígito
    movzx ax, al
    add ax, '0' ;converte de ascii para decimal
    mov bx, 10

    mov bx, [aux] ;copiar o valor atual do operando 1 em bx
    add ax, bx ;somar o valor atual do operando 1 com o valor do novo dígito processado
    mov [aux], ax ;atualizar valor do operando 1 com o dígito processado
    
    mov     ebp, esp; for correct debugging
    mov     eax,4    ;serviço do SO sys_write
    mov     ebx,1    ;file deor (stdout)
    mov     ecx,aux   ;carrega em ecx o endereco do text
    mov     edx,2 ;tamanho da mensagem  
    int     0x80     ;chamada da interrupcao 80h  (chamada ao SO)
    jmp     sair
        
sair:     
    
    
                                    
    mov     eax,1    ;system call number (sys_exit)
    int     0x80     ;call kernel
    ret
