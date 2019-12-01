; to read interger user input and store in variable N 
N DWORD ?
prompt BYTE "Please enter a value for N:", 0

mov edx, OFFSET prompt1 
call WriteString 
call ReadDec ; read user input as decimal number and store in eax 
mov N, eax

; to read string user input and store in variable number
N BYTE 100 DUP(?) ; 100 stands for max array size 
; Note about DUP: 4 DUP(2) is equivalent to 2, 2, 2, 2

; This program fills an array of WORDS with random integers 

.data 
count = 100 
array WORD count DUP(?)

.code 
main proc 
    push OFFSET array ; push array on to stack 
    push COUNT ; push array size on to stack 
    call ArrayFill 

    mov esi, OFFSET array 
    mov ecx, COUNT 
    call DumpMem ; display register contents 
main endp 

ArrayFill proc 
    push ebp 
    mov ebp, esp 
    mov esi, [ebp + 12] ; point esi to array 
    mov ecx, [ebp + 8] ; set ecx to array size 
    cmp ecx, 0 
    jle L2 ; if array size <= 0 then exit program 
L1:  ; else loop through array and assign random integers 
    mov eax, 10000h ; setting the end range, so the random number range would be from 0 to ffffh(because ffffh comes before 10000h)
    call RandomRange ; calling library function that returns random number to eax 
    mov [esi], eax ; assign random number to array index 
    add esi, TYPE WORD ; increment the array pointer 
    loop L1 ; decreament ecx and repeat L1 until ecx == 0  

L2: 
    pop ebp 
    ret 8 ; clean up the stack 

ArrayFill endp 
END main 

