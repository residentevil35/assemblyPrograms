TITLE Equation, Version 2         (AddSub2.asm)

; Rachel Coughanour
; Equations - Assignment 1 
; This program adds, subtracts, and multiplies numbers. 

INCLUDE Irvine32.inc

.data
A     dword    20         ; value for A 
B     dword    12         ; value for B 
ABTot dword     ?         ; value to hold the total of A + B
C1    dword    36         ; value for C
D     dword    52         ; value for D 
CDTot dword     ?         ; to hold the total of C + D 
E     dword     ?         ; holds C + D * 2 
F     dword     ?         ; holds A + B * 3 
G     dword     ?         ; to hold the total of D - C 
H     dword     ?         ; to hold the total of A - B 
nine  dword     9         ; holds a 9 
clear dword     0         ; symbol to clear the registers 

.code

; #1:  Z = (A + B) * 3 + (D - C) * 2 + 9 
; #2:  Z = (A - B) * 3 + (D + C) * 2 - 9 

main PROC

; I first cleared the registers to make sure nothing was left over 
mov   eax, clear
mov   ebx, clear 

mov   eax, A
add   eax, B              ; A + B 
mov   ABTot, eax          ; mov the total of A + B to ABTot 
add   eax, ABTot 
add   eax, ABTot          ; way of multiplying by 3 
mov   F, eax              ; move the content of A + B * 3 into F 
mov   eax, clear          ; clear out the eax register 

mov   eax, D
sub   eax, C1             ; D - C 
mov   G, eax              ; moves the total of D - C to G 
add   eax, G              ; way of multiplying by 2 

; adding up the final answers for #1 
add   eax, F              ; 96 + 32 
add   eax, nine           ; 96 + 32 + 9 

mov   ebx, C1 
add   ebx, D              ; C + D 
mov   CDTot, ebx          ; add the total of C + D to CDTot 
add   ebx, CDTot          ; way of multiplying by 2 
mov   E, ebx              ; move the contents of C + D * 2 into E 
mov   ebx, clear          ; clear out ebx register 

mov   ebx, A
sub   ebx, B              ; A - B 
mov   H, ebx              ; moves the total of A - B into H 
add   ebx, H 
add   ebx, H              ; way of multiplying by 3 

; adding up the final answers for #2 
add   ebx, E              ; 24 + 176
sub   ebx, nine           ; 24 + 176 - 9

call	DumpRegs			 ; display the registers

	exit
main ENDP
END main
