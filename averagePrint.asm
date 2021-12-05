; ***************************************************
; CS 340 - Average                                  *
; This program calculates the average of a set      *
; of numbers and finds the largest number.          *
;****************************************************

INCLUDE Irvine32.inc

.data
ary           dword  150, -50, 125, 90, 35, -192, 52, 634, 193, 999, -524, 1, -5 
              dword  300, 25, 71, 414, 143, 142, 52, -32, 58, 56, 42, -81, 25, 93, 151, 215, 0     ; array filled with data 
count         dword 0                                                                              ; symbol to hold how many values are in the array 
sum           dword ?                                                                              ; symbol to hold the sum of the values of the array 
avg           dword 0                                                                              ; symbol to hold the average 
rem           dword ?                                                                              ; symbol to hold the remainder 
NULL          equ 0                                                                                ; setting the word 'NULL' = 0 
CR            equ 13                                                                               ; creating a carriage return 
LF            equ 10                                                                               ; creating a line feed 
labelSum      byte "Sum = ", NULL, CR, LF                                                          ; label for the string for sum 
labelAvg      byte "Avg = ", NULL, CR, LF                                                          ; label for the string for average 
labelRem      byte "Rem = ", NULL, CR, LF                                                          ; label for the remainder 
answer        byte 8  dup  (?),                                                                    ; array to hold the answer in decimal 


.code

; Procedure to convert integers to ascii characters 
IntAsc PROC
 mov     ebx,10              ; Move 10 into EBX
    Next:
        mov     edx,0           ; Move 0 into EDX
        cwd                     ; Convert to double word
        idiv    ebx             ; Divide EAX by EBX
        add     dl,30h          ; Add 30h to DL
        mov     [esi],dl        ; Move DL into dereferenced ESI
        add     esi,1           ; Add one to ESI
        cmp     eax,0           ; Compare EAX and zero
        jne     Next            ; Jump to Next if not equal to
    ret
  IntAsc ENDP

  ; Process to write to a line 
WriteLine PROC 
next:
     mov       al,[esi]          ; move address into al register 
     call      WriteChar         ; call procedure to write char
     add       esi,1             ; increment the loop 
     cmp       al,NULL           ; check if end of string 
     jne       next              ; if not empty, repeat loop 
     ret
WriteLine ENDP

; Procedure to write a number 
  WriteNum PROC
    add     esi,-1              ; Add -1 to ESI
    Next:
        mov     al,[esi]        ; Move dereferenced ESI into AL
        call    WriteChar       ; Call WriteChar function
        add     esi,-1          ; Add -1 to ESI
        cmp     al,0            ; Compare AL and zero
        jne     Next            ; Jump to Next if not equal to
        ret
WriteNum ENDP

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

   mov rem, eax                  ; move the value of eax into rem 

   ;printing the sum
    lea esi, labelSum            ; put address of labelSum into esi 
    call WriteLine               ; call WriteLine proc
    mov eax, sum                  ; move the sum into eax 
    lea      esi,answer          ; get address of answer array
    call     IntAsc              ; call the convert integer proc 
    call     WriteNum            ; print the answer in decimal 

    ; printing the average  
    lea      esi,labelAvg           ; put address of labelAvg into esi 
    call     WriteLine              ; call WriteLine proc
    mov      eax,avg                ; move avg into eax 
    lea      esi,answer             ; get address of answer array  
    call     IntAsc                 ; call the convert integer proc 
    call     WriteNum               ; printing the answer in decimal

  ; printing the rem string 
    lea      esi,labelRem           ; move labelRem into esi 
    call     WriteLine              ; procedure to print the string 
    mov      eax, rem               ; move rem into eax 
    lea      esi, answer            ; get address of answer array 
    call     IntAsc                 ; call the convert integer proc 
    call     WriteNum               ; printing the answer in decimal 


   ;call	DumpRegs			   ; display the registers

	exit
main ENDP
END main
