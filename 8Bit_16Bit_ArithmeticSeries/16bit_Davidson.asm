;Author: Eli Davidson
;Date : 04/16/24
;8 Implementation of Arithmetic Series
ORG 0H

START:
	MOV R7,#17 ; Set R7, N to whatever you want
	MOV A, R7 ; set A to R7 so R4 can read it
	MOV R4, A ; Set R4 to A which is R7 R4:=R7
   	MOV R1, #41H ; Pointer to store common diff
	MOV @R1,#2
	MOV R0, #43H ; Pointer to store the arithmetic sequence
	MOV @R0, #250 ; first value FA for mem location
	CLR A
     
LOOP:
   	MOV A, @R1 ;A = A+d
   	ADD A,@R0 ; A = a(n-1) + d
	INC R0 ; R0 to point a(n) 
	INC R0 ; R0 to point to correct bit position
	MOV @R0,A ; @R0 = a(n) lower bit done here
	DEC R1 ;pointing to upper bit of d
	DEC R0 ; Decrement R0
	DEC R0 ; an-1
	DEC R0 ; upper bit of a(n-1)
	CLR A ; A = 0
	ADDC A, @R1
	ADD A,@R0 ; A is now upper bit
	INC R0	; lower bit of an
	INC R0 ; upper bits of an
	MOV @R0, A ; @R0 will have upper bit
	INC R0
	INC R1
	MOV A, #0 ; Set A to 0
  	DJNZ R4, LOOP ; Continue looping until N reaches desired value

  RET ; Return from subroutine
