;Author: Eli Davidson
;Date : 04/16/24
;8 Implementation of Arithmetic Series
ORG 0H

START:
	MOV A, #11 ; this is where the user sets N
	MOV R7,A
	MOV R4, A ; put N into a temp reg so we can use that in the loop condition
	MOV A, #2
   	MOV R1, #50H; Pointer to store common diff
	MOV @R1, A ; set d to 2 
	MOV R0, #51H ; Pointer to store the arithmetic sequence
   	MOV A, #1 ; first value in the series
	MOV @R0, A  
LOOP:
	CLR A ; A = 0
   	ADD A, @R1 ;A = A+d
   	ADD A,@R0 ; A = a(n-1) + d
	INC R0 ; R0 to point a(n)
	MOV @R0,A ; @R0 = a(n)
  	DJNZ R4, LOOP ; Continue looping until N reaches 127

    RET ; Return from subroutine
