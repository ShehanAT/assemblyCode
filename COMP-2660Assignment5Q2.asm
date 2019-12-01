INCLUDE Irvine32.inc 
.data 
prompt1 BYTE "Enter a number", 0dh, 0ah, 0
prompt2 BYTE "The Fibonnaci sequence is: ", 0
space BYTE " ", 0 
.code 

main PROC 
	mov edx, OFFSET prompt1
	call WriteString 
	call ReadInt 
	mov ecx, eax ; print N numbers 
	inc ecx 
	call Crlf 
	mov eax, 0 ; make fib(1) = 0
	mov ebx, 1 ; make fib(2) = fib(1) + 0
	mov edx, OFFSET prompt2 
	call WriteString 

L1:
	add ebx, eax ; generating next number in fibonacci sequence 
	call WriteDec 
	mov edx, OFFSET space 
	call WriteString ; print “ “ 
	xchg eax, ebx 
	loop L1 ; loop until ecx becomes 0 
	call Crlf 
	exit 
main ENDP 
END main 

