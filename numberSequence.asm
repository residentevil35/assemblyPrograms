

; ***************************************************
; CS 340 - Number Sequence Procedures               *
; This program generates random numbers based on a  *
; set pattern and then finds the total count, sum   *
; and average of those numbers.                     *
;****************************************************

INCLUDE Irvine32.inc

.data
slot          dword 4 
ary2          dword 100 dup (0)                 ; array to hold the generated values 
count         dword 0                           ; symbol to hold how many values are in the array 
count2        dword 1                           ; symbol to hold how many values are in the array 
valueCount    dword 7                           ; how many values to print per line 
values        dword 0                           ; holds number of values in the array 
sum           dword ?                           ; symbol to hold the sum of the values of the array 
avg           dword 0                           ; symbol to hold the average 
NULL          equ 0                             ; setting the word 'NULL' = 0 
CR            equ 13                            ; creating a carriage return 
LF            equ 10                            ; creating a line feed 
SPACE         equ 32                            ; creating a space 
labelSum      byte "Sum = ", NULL, CR, LF       ; label for the string for sum 
labelAvg      byte "Avg = ", NULL, CR, LF       ; label for the string for average 
labelVal      byte "Values = ", NULL, CR, LF    ; label for the number of values 
newline       byte  CR, LF, NULL                ; to print a newline 
labelSpace    byte SPACE, NULL                  ; character to print a space 
answer        byte 8  dup  (?),                 ; array to hold the answer in decimal 


.code
;*************
; Procedures *
;*************

;****************************************************
; Procedure to convert integers to ASCII characters *
;****************************************************

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

;****************************
; Procedure to write a line *
;****************************

WriteLine PROC 
next:
     mov       al,[esi]          ; move address into al register 
     call      WriteChar         ; call procedure to write char
     add       esi,1             ; increment the loop 
     cmp       al,NULL           ; check if end of string 
     jne       next              ; if not empty, repeat loop 
     ret
WriteLine ENDP

;******************************
; Procedure to write a number *
;******************************

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

;*****************************************************
; Procedure to print a carriage return and line feed *
;*****************************************************
printCRLF PROC
    lea esi, newline         ; load address of newline into esi
    call WriteLine           ; call the WriteLine proc 
    ret 
printCRLF ENDP

;*****************************************************
; Procedure to compute the sum of the set of numbers *
;*****************************************************

findSum PROC 
mov eax, 0 
mov ebx, 0 
mov esi, offset ary2             ; point to the address of the array

next: 
   add  eax, [esi]               ; add the value in the array to eax 
   add  count, 1                 ; increment count by 1 each iteration to see how many values 
   mov ebx, count
   add  esi, 4                   ; bump esi to the next location 
   cmp  ebx, count2               ; see if [esi] is equal to the sentinel value of 0 
   jne  next                     ; if not, continue through the loop 

   mov sum, eax                  ; move the value of sum into eax 
   ret
findSum ENDP

;*********************************************************
; Procedure to compute the average of the set of numbers *
;*********************************************************

findAvg PROC
  mov ebx, count2                  ; move the value of count to ebx 
  mov edx, 0                       ; move a 0 to edx 
  mov eax, sum                     ; move the value of sum to eax
  idiv ebx                         ; divide by ebx 
  mov avg, eax                     ; move average into eax 
  ret
findAvg ENDP

;*********************************************
; Procedure to generate the set of numbers   *
;*********************************************

fillArray PROC
add edx, 0                          ; make sure edx is empty 
add eax, 0                          ; add the first digit to eax
mov esi, offset ary2                ; move address of ary2 to esi 
add [esi], eax                      ; add what eax is to the value slot in ary2
add esi, 4                          ; bump to next location 
 
fill:
  add eax, 3                        ; add +3 to eax
  add count2, 1                     ; increment counter by 1
  mov edx, eax                      ; move the value of eax to edx 
  add [esi], eax                    ; add what eax is to the value slot in ary2 
  add esi, 4                        ; bump to the next location

  add eax, 8                        ; add +8 to eax 
  add count2, 1                     ; increment counter by 1 
  mov edx, eax                      ; move the value of eax to edx 
  add [esi], eax                    ; add what eax is to the value slot in ary2 
  add esi, 4                        ; bump to the next location 

  add eax, 5                        ; add +5 to eax
  add count2, 1                     ; increment counter by 1
  mov edx, eax                      ; move value of eax to edx
  add [esi], eax                    ; add what eax is to the value slot in ary2
  add esi, 4                        ; bump to the next location 
  cmp edx, 400                      ; compare if edx equals 400
  jne fill                          ; if not, go through the loop again  

  mov ebx, count2                   ; move count2 to ebx 
  ret
fillArray ENDP

;*******************************
; Procedure to print the array *
;*******************************

printArray PROC
   mov eax, 0                    ; clear the eax register 
   mov ecx, 1                    ; clear the ecx register 
   mov esi, offset ary2          ; point to address of ary2
   mov eax, [esi]                ; move value of esi into eax 
   call  IntAsc                  ; call the convert integer proc 
   call  WriteNum                ; print the answer in decimal
   lea esi, labelSpace           ; load esi with labelSpace
   call WriteLine                ; call WriteLine proc 
 
  print:
      mov esi, offset ary2       ; point to the address of ary2
      add esi, slot              ; bump to the next memory location 
      add slot, 4                ; bump the memory location by 4
      mov eax, [esi]             ; move to eax the value of esi 
      call  IntAsc               ; call the convert integer proc 
      call  WriteNum             ; print the answer in decimal 
      add ebx, 1                 ; increment ebx by 1
      lea esi, labelSpace        ; load esi with labelSpace
      call WriteLine             ; call WriteLine proc 
      add ecx, 1                 ; bump ecx by 1 
      mov edx, 0                 ; clear edx register 
      mov eax, ecx               ; move the value of ecx to eax 
      idiv valueCount            ; divide by valueCount 
      cmp edx, 0                 ; check if edx = 0 ([count % 7 == 0])
      je  new                    ; if equal, jump to new loop 
      cmp ecx, count2            ; compare ecx by what is in count2 
      jne print                  ; if not equal, print again
      

new:
     call printCRLF              ; call printCRLF proc
     jmp print                   ; go back to print loop
ret 
printArray ENDP
;--------------------------------------------------------------------------
main PROC

mov  eax, 0                   ; accumulator set to 0 
mov  ebx, 0                   ; sentinel value 
mov  edx, 0                   ; clear edx 

; filling the array 
;-----------------------------------------------------------------------------
call fillArray                ; call fillArray proc

;printing number of values 
;------------------------------------------------------------------------------
   call findSum               ; call procedure to sum the values in the array 
   lea esi, labelVal          ; put address of labelVal into esi 
   call WriteLine             ; call WriteLine proc 
   mov eax, count2            ; move the value of count to eax 
   lea esi, answer            ; get address of answer array 
   call  IntAsc               ; call the convert integer proc 
   call  WriteNum             ; print the answer in decimal 
   call printCRLF             ; call procedure to print a newline

;printing the sum
;------------------------------------------------------------------------------
    lea esi, labelSum         ; put address of labelSum into esi 
    call WriteLine            ; call WriteLine proc
    mov eax, sum              ; move sum to eax 
    lea esi,answer            ; get address of answer array
    call IntAsc               ; call the convert integer proc 
    call WriteNum             ; print the answer in decimal 
    call printCRLF            ; call procedure to print a newline 


 ;printing the average 
 ;--------------------------------------------------------------------------------
     call findAvg             ; procedure to find the average of the values 
     lea esi, labelAvg        ; put address of labelAvg into esi 
     call WriteLine           ; call WriteLine proc 
     mov  eax,avg             ; move avg into eax 
     lea  esi,answer          ; get address of answer array  
     call IntAsc              ; call the convert integer proc 
     call WriteNum            ; printing the answer in decimal
     call printCRLF           ; call procedure to print a newline

  ;printing the array
  ;-------------------------------------------------------------------------------
   call printCRLF           ; call procedure to print a newline
   call printArray               ; call printArray proc 

   ;call	DumpRegs			; display the registers

	exit
main ENDP
END main
