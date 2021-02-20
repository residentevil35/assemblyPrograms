TITLE Add and Subtract, Version 2         (AddSub2.asm)

; ***************************************************
; Rachel Coughanour                                 *
; Spring 2021                                       *
; CS 340 - Average                                  *
; This program calculates the average of a set      *
; of numbers and finds the largest number.          *
;****************************************************

INCLUDE Irvine32.inc

.data
ary      dword  150, -50, 125, 90, 35, -192, 52, 634, 193, 999, -524, 1, -5 
         dword  300, 25, 71, 414, 143, 142, 52, -32, 58, 56, 42, -81, 25, 93, 151, 215, 0     ; array filled with data 
count    dword 0                                                                              ; symbol to hold how many values are in the array 
sum      dword ?                                                                              ; symbol to hold the sum of the values of the array 
avg      dword 0                                                                              ; symbol to hold the average 
rem      dword ?                                                                              ; symbol to hold the remainder 


.code
main PROC

mov  eax, 0                   ; accumulator set to 0 
mov  ebx, 0                   ; sentinel value 
mov  edx, 0                   ; clear edx 
mov  esi, offset ary          ; move address of array into esi 

; loop to sum the values of the array 
next: 
   add  eax, [esi]               ; add the value in the array to eax 
   add  count, 1                 ; increment count by 1 each iteration to see how many values 
   add  esi, 4                   ; bump esi to the next location 
   cmp  ebx, [esi]               ; see if [esi] is equal to the sentinel value of 0 
   jne  next                     ; if not, continue through the loop 

   mov sum, eax                  ; move the value of eax into sum 

 ; loop to find the average of the array
 divide:
   sub  eax, count               ; subtract eax by the value of count 
   add  avg, 1                   ; incrment average by 1 every loop 
   cmp  eax, count               ; compare what is in eax to count 
   jg  divide                    ; if eax is greater than count, loop again 

   mov ebx, avg                  ; move average into ebx 
   mov rem, eax                  ; move the value of eax into rem 
   mov ecx, rem                  ; move the remainder into ecx 
   mov eax, sum                  ; move the sum into eax 

   call	DumpRegs			   ; display the registers

	exit
main ENDP
END main
