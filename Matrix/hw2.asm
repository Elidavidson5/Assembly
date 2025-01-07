
;; AUTHOR: ELI DAVIDSON
;;DATE : 4-30-24

SJMP MAIN
ORG 0 
ORG 30H

N1:DB "02,12,15,03" ;a=10, b=04, c=20, d=01 DB 0

ORG 50H

MAIN:
	MOV DPTR, #N1; DPTR starts at input
	MOV R2, #0 ; R2 =  a
	MOV R3, #0 ;R3 = b
	MOV R7, #0
	MOV R6, #0
	MOV R5, #0
	MOV R4,#0


START:
   MOVC A,@A+DPTR ; Load character from memory pointed by DPTR into A
	SUBB A,#'0' ;A is now the first value in 
	MOV R5,A ; first value in R5
	MOV A,#0 ; Mov 0 to A
	INC DPTR 
	MOVC A,@A+DPTR
	CJNE A, #44, FIRST_VALUE_MATRIX ;check if comma is in next place
	

FIRST_VALUE_MATRIX:
	SUBB A, #'0'
	MOV R6,A ; second element in first #
	
	MOV A, #0
	INC DPTR
	MOVC A, @A+DPTR
	CJNE A, #44, Third_number ; if true, there are 3 numbers
	MOV B,#10
	MOV A,R5 ; load the first value
	MUL AB ; multiply tenths place by 10
	ADD A,R6
	MOV R2,A ; store first value a in R2
	SJMP SECOND_VALUE




SECOND_VALUE:
	MOV A, #0
	INC DPTR
	MOVC A, @A+DPTR
	SUBB A, #'0'
	MOV R5,A
	MOV A, #0
	
	INC DPTR
	MOVC A, @A+DPTR
	SUBB A, #'0'
	MOV R6, A 

	MOV A,#0
	INC DPTR
	MOVC A,@A+DPTR
	CJNE A,#44,Third_number
	MOV A, #0
	MOV B,#10
	MOV A,R5 ; load the first value
	MUL AB ; multiply tenths place by 10
	ADD A,R6
	MOV R3,A ; store first value a in R2
	SJMP THIRD_VALUE

THIRD_VALUE:
	MOV A, #0
	INC DPTR
	MOVC A, @A+DPTR
	SUBB A, #'0'
	MOV R5,A
	MOV A, #0
	
	INC DPTR
	MOVC A, @A+DPTR
	SUBB A, #'0'
	MOV R6, A 

	MOV A,#0
	INC DPTR
	MOVC A,@A+DPTR
	CJNE A,#44,Third_number
	MOV B,#10
	MOV A,R5 ; load the first value
	MUL AB ; multiply tenths place by 10
	ADD A,R6
	MOV R4,A ; store first value a in R2
	;INC DPTR
	;MOVC A, @A+DPTR
	SJMP FOURTH_VALUE

FOURTH_VALUE:
	MOV A, #0
	INC DPTR
	MOVC A, @A+DPTR
	SUBB A, #'0'
	MOV R5,A
	MOV A, #0
	
	INC DPTR
	MOVC A, @A+DPTR
	SUBB A, #'0'

	MOV R6, A 
	MOV A,#0
	INC DPTR
	MOVC A,@A+DPTR
	;CJNE A,#44,Third_number
	MOV B,#10
	MOV A,R5 ; load the first value
	MUL AB ; multiply tenths place by 10
	ADD A,R6
	MOV R5,A ; store first value a in R2
	INC DPTR
	MOVC A, @A+DPTR
;	MOV R7,#0
	;MOV R6,#0
	SJMP SOP

Third_number:
	MOVC A,@A+DPTR


SOP:
	MOV R7, #0
	MOV R6, #0
	MOV R1,#0

	MOV A, R2 ;a 
	MOV B, R3 ;b 

	MUL AB	;a*b

	MOV R6,A	; store lowbyte
	MOV R7,B ; store high byte

	MOV A, R4 ;c
	MOV B, R5 ;d

	MUL AB	;c*d
	MOV R0,B
	MOV R1,A

	;R1+R6
	ADD A,R6 ;i.e 18+68
	MOV R6,A ; now R6 has upper bits
	;R0+R7
	MOV A, B
	ADD A,R7
	MOV B,A ; R7 has lower bit
	MOV R1, #50H ; LSB
	MOV R0,#51H
	MOV A, B
	MOV @R1,A
	MOV A,R6
	MOV @R0,A
