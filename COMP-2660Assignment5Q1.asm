INCLUDE Irvine32.inc 

.data 
GCDArray DWORD 5, 20, 24, 18, 11, 7, 432, 226, 0, 0 
prompt1 BYTE "The GCD is ", 0

.code 
	main PROC 
		mov ecx, LENGTHOF GCDArray/2 ; get the length/2 of array 
		mov esi, OFFSET GCDArray ; assign pointer to array 
	L1: 
		mov eax, [esi]
		mov ebx, [esi + 4]
		call GCD 
		mov edx, OFFSET prompt1
		call WriteString
		call WriteDec 
		call Crlf 
		add esi, TYPE GCDArray * 2 
		loop L1 
		exit 
	main ENDP

	GCD PROC 
		push ebx
		push edx 
		cmp ebx, 0
		jne L1
		jmp L2
	L1: 
		mov edx, 0
		div ebx ; divide first int by second int 
		cmp edx, 0 ; if remainder exists go to L2 which quits
		je L2
		mov eax, ebx ; else set eax and ebx for next iteration 
		mov ebx, edx 
		jmp L1
	L2:
		mov eax, ebx ; eax contains the GCD if ebx is 0
		pop edx 
		pop ebx 
		ret
	GCD ENDP
END main 