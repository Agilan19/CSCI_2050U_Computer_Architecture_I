include \masm32\include\masm32rt.inc							;Christien Soosaipillai and Agilan Ampigaipathar 
	
.data

prompt1 BYTE  "Enter the size of the message: ", 0				;promts user to enter first number
sizeOfMess DWORD 0												;allocates storage for 51 bytes, 51st bit signals end of the string, null byte

prompt2 BYTE  "Enter the message: ", 0							;promts user to enter second number
message BYTE  51 DUP (0)										;allocates storage for 51 bytes, 51st bit signals end of the string, null byte

prompt3 BYTE "Enter the key: ", 0								;Enter the key to be used
key BYTE 51 DUP (0)												;allocates storage for 51 bytes, 51st bit signals end of the string, null byte

prompt4 BYTE "Encrypted Message: ", 0

sizeOfKey DWORD 0



encrypt BYTE 51 DUP (0)

.code
main proc

	;get message size
	;invoke StdOut, ADDR prompt1
	;invoke StdIn, ADDR sizeOfMess, 4							;take the input for size of message(only 4 characters)
	



	 
	;Get actualy message	 
	invoke StdOut, ADDR prompt2									;invoke the print method for prompt 1
	invoke StdIn, ADDR message, 50								;invoke the input method, ask user for message and cant be longer than the sizeOfMess value stored in ebx
	mov sizeOfMess, eax

	;Get the key
	invoke StdOut, ADDR prompt3									;invoke the print method for prompt 1
	invoke StdIn, ADDR key, 50									;invoke the input method, input integer value into num1str for the first 10 digits only
	mov sizeOfKey, eax											;gets size of key

	;References
	mov esi, OFFSET key											;points to the first value of the addressof the key array(after loop points to the first empty space)
	mov eax,sizeOfMess											;move the sizeOfMess to eax
	sub eax,sizeOfKey											;subtract the sizeOfKey from eax
	mov ecx,eax													;move eax to ecx 
	mov edi, OFFSET	key											;move the address of the first index in key to edi
	add edi,sizeOfKey											;add the sizeOfKey to edi

	key_Loop:
	mov ah, [esi]												;move to an 8-bit register to get the one character at that register ([esi] means get the value of the address pointed to by esi)
	mov [edi],ah												;move the character value into the first empty spot into the array pointed to by edi
	inc esi														;increment esi(in the key)
	inc edi														;increment edi(next empty spot)
   	loop key_Loop												;jump back to the top of the loop if ecx is not equal to zero(decrease ecx by 1, if it isn't zero go back to the top of the loop)
	

	mov esi, OFFSET key											;move the address of the first index in the key to esi
	mov edi, OFFSET message										;move the address of the first index in message to edi
	mov ebx, OFFSET encrypt										;move the address of the first index in encrypt to ebx

	mov ecx, sizeOfMess											;move sizeOfMess to ecx
			
	full_key:
		mov al,[esi]											;moves the value of the address pointed to by esi to an 8-bit al register to get the one character at that register 
		mov dl,[edi]											;moves the value of the address pointed to by edi to an 8-bit dl register to get the one character at that register 
		sub al,65												;subtract 65 from the 8 bit value containing the letter character to get the shift that you need
		sub dl,al												;subtract the shift value to the value of dl to perform the shift
		mov [ebx],dl											;move that shift to the encrypted array of ebx	
		cmp dl,65												;compare dl and 65 which represents letter "a"
		jl startOver											;if dl < 90 then jump to startOver
		inc esi													;increment esi
		inc edi													;increment edi
		inc ebx													;increment ebx
	loop full_key												;since loop references ecx it will decrement it by 1 and ecx contains the size of the message

	jmp encrypted												;if the above loop is completed jump to the encrypted loop to print

	startOver:
		add dl,26												;add 26 from dl if it is over 90 this way you loop back around to the 60's positions
		mov [ebx],dl											;move the new value to the address pointed to by ebx
		inc esi												    ;increment esi
		inc edi													;increment edi
		inc ebx													;increment ebx
	loop full_key


	encrypted:

		invoke StdOut,ADDR prompt4								
		invoke StdOut,ADDR encrypt								;prints encrypted message

	; return 0
	mov eax, 0													;move value 0 to memory eax
	ret
main endp
end main