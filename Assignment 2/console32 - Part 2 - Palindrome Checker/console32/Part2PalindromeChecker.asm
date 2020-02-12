include \masm32\include\masm32rt.inc																; Agilan Ampigaipathar and Christien Soosaipillai									

.data																								; Set data variables 

welcomePrompt BYTE "Welcome to our Palindrome Checker!", 0											; Make a welcome prompt 
strPrompt BYTE "Enter a string (or a sequence of characters to see if its reverse matches): ", 0	; Ask user for input
palindromePrompt BYTE "It is a palindrome!", 0														; Prompt if the input is a palindrome 
NotAPalindromePrompt BYTE "It is NOT a palindrome!", 0												; Prompt if the input is not a palindrome 

crlf BYTE 0ah, 0dh, 0																				; Prompt for a new line using the ASCII values

forward BYTE 50 DUP(0), 0																			; Stores an input upto 50 characters to hold the original input
reverse BYTE 50 DUP(0), 0																			; Stores the reverse of the input of upto 50 characters 
numChars DWORD 0																					; A DWORD named numChars is initialized at 0

.code																								; Starts the code section 
main proc																							; Open the main function 												
	invoke StdOut, ADDR welcomePrompt																; Output the welcome prompt 
	invoke StdOut, ADDR crlf																		; Outputs a new line 
	invoke StdOut, ADDR strPrompt																	; Output the instruction prompt asking for user input 
	invoke StdIn, ADDR forward, 50																	; Store the user input into the forward variable 

	mov numChars, eax																				; Copy the eax register value to the numChars DWORD variable
	mov ecx, eax																					; Copy the value at eax at the ecx register 
	mov esi, OFFSET forward 																		; Copies the address of forward to the esi register 

	mov edx, esi																					; Copies the esi value into the edx register

pushLoop:																							; Open a Push Loop
	xor eax, eax 																					; Sets eax to zero since it always equals itself with the xor
	mov al, [esi]																					; Copies the elements of the esi stack register into the al register
	push eax																						; Push the recently calculated register values each loop
	inc esi																							; Increment esi by 1
	loop pushLoop																					; Close the push loop

	mov ecx, numChars																				; Copies the number of characters into the ecx counter register
	mov edi, OFFSET reverse																			; Copies the address of reverse to the edi register
	mov esi, OFFSET forward																			; Copies the address of the forward to the esi register. 

popLoop:																							; Open the Pop Loop
	pop eax																							; Pop the eax register values each loop from most recent to most outdated
	cmp al,[esi]																					; Compare each element of the esi register to each element of the al register 
	jne NotAPalindrome																				; Jump if the elements do not equal each other meaning the input is not a palindrome
	inc esi																							; Increment the esi register by 1											
	loop popLoop																					; Close the Pop Loop.

IsAPalindrome:																						; For the possibility if it is a palindrome
	invoke StdOut, ADDR crlf																		; Output a new line														
	invoke StdOut, ADDR palindromePrompt															; Output the prompt for the confirmed palindrome possibility
	jmp Return																						; Jump to the Return function 

NotAPalindrome:																						; For the not a palindrome possibility	
	dec ecx;																						; Decrement the ecx counter register by 1
	L1:																								; Make a loop to pop each element in the stack and clear it so no errors occur
	pop eax																							; Pop each element for each time the loop runs until the stack is cleared 
	loop L1																							; Close the loop
	invoke StdOut, ADDR crlf																		; Output a new line	
	invoke StdOut, ADDR NotAPalindromePrompt														; Output the prompt to confirm that the input is not a palindrome. 

Return:																								; Open the Return function 
mov eax, 0																							; Initiate the eax register value back to 0 in order to finish the program
ret																									; Return 0

main endp																							; Close the main function 
end main																							; End the program 