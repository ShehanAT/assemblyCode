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

title "Sample Final Exam 2017 Question 1"

Include Irvine32.inc 

.data 
n DWORD ?
k DWORD ?
result DWORD 00000000h
.code 

main PROC 
    push n ; [ebp + 12], ecx, this is the first parameter  
    push k : [ebp + 8], ebx, this is the second parameter 
    call recu ; calling recu(n - 1, k - 1)
main ENDP 

recu PROC 

recu ENDP 
    push ebp 
    mov ebp, esp 
    mov ebx, [ebp + 8] ; ebx contains n 
    mov ecx, [ebp + 12] ; ecx contains k 
    cmp ecx, 0 
    je L0 ; if k = 0 then quit with return value of 1
    cmp ecx, ebx 
    je L0 ; if k = n then quit with return value of 1  
    dec ebx ; n = n - 1
    cmp ecx, ebx 
    jne L1 ; if k != n then jump to recursive case, else jump to base case  
L0: ; this is the base case 
    mov eax, 1 ; return value 1 in eax when quitting
    jmp Quit 
L1: ; this is the recursive case 
    dec ebx ; n = n - 1
    dec ecx ; k = k - 1
    push ebx ; second parameter
    push ecx ; first parameter 
    call recu ; calling recu(n - 1, k - 1)
    push eax ; push return value of recu(n - 1, k - 1) onto stack 
    dec ebx  ; n = n - 1
    push ebx ; first parameter for recu(n - 1, k)
    push ecx ; second parameter for recu(n - 1, k)
    call recu ; calling recu(n - 1, k)
    push eax ; push return value of recu(n - 1, k) onto stack 
    pop ebx ; restore return value of recu(n - 1, k - 1) onto edx 
    add eax, ebx ; add return value of recu(n - 1, k - 1) with return value of recu(n - 1, k)
Quit:
    pop ebp 
    ret 8
END main 