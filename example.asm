.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
;32 x 18
window_title DB "Exemplu proiect desenare",0
area_width EQU 1280
area_height EQU 720
numar_de_sarit equ 19; pentru parcurgere matrice
linie_maxima equ 16;pentru matrice
dimensiune_patrat equ 40;pentru matrice
coloana_maxima equ 18;analog
x_initial equ 40
y_initial equ 80
linie dd 4
coloana dd 1
gameover dd 0;pt a verifica daca sa se afiseze gameover
counter_miscari dd 0;pt a numara a catea miscare a botului e
counterok3 dd 0
timer_bot dd 0;pentru a face ca botul sa inteprinda actiuni din sec in sec
linie_bot dd 15;linie initiala bot
pozitie_bot dd 0
coloana_bot dd 17;coloana initiala bot
viata dd 3;viata
instructiuni dd 0;pt a afisa fereasta de instructiuni
x0 equ 0;de unde se genereaza matricea
y0 equ 40
overx1 equ 0;de unde se genereaza gameover
overy1 equ 0
area DD 0
x1 equ 1068
y1 equ 540;coordonate pt linii pt generare sageti
x2 equ 1055
y2 equ 555
x3 equ 1122
y3 equ 555
x4 equ 1068
y4 equ 610
x5 equ 950
y5 equ 485
x6 equ 950
y6 equ 600
harta DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;matricea de joc
      DD 0,2,1,1,2,2,2,2,2,2,2,2,1,1,1,2,2,2,0
	  DD 0,2,1,1,1,2,2,2,2,3,2,2,2,1,1,2,2,2,0
	  DD 0,2,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	  DD 0,4,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0
	  DD 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	  DD 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,0
	  DD 0,2,0,1,0,1,0,1,0,1,0,1,0,1,2,2,2,2,0
	  DD 0,2,2,1,1,2,2,2,2,2,2,2,2,1,1,2,2,2,0                                                                        ;BLAJAN GEORGE-PAUL
	  DD 0,2,2,1,1,1,1,2,2,3,2,2,2,2,1,2,2,2,0
	  DD 0,2,2,1,1,2,2,2,2,2,1,2,2,2,1,2,2,2,0
	  DD 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
	  DD 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0
	  DD 0,2,2,1,0,1,0,1,0,1,0,1,0,1,0,1,0,2,0
	  DD 0,2,2,1,1,2,2,2,2,3,2,2,1,1,2,2,2,2,0
	  DD 0,2,2,2,1,2,2,2,2,2,2,2,2,1,1,2,2,7,0
	  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	  
	  
game_over_map DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;matricea de gameover
              DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,1,1,1,1,0,1,1,1,1,0,1,0,0,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,1,0,0,0,0,1,0,0,1,0,1,1,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,1,0,1,1,0,1,1,1,1,0,1,0,1,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,1,0,0,1,0,1,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,0,0,0,0,1,1,0,0,0,1,0,0,0,1,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,0
			  DD 0,0,0,0,1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0
			  DD 0,0,0,1,0,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0
			  DD 0,0,0,1,0,0,0,0,1,0,1,0,0,0,1,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,0
			  DD 0,0,0,1,0,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0
			  DD 0,0,0,0,1,0,0,1,0,0,0,1,0,1,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0
			  DD 0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,1,0,0,1,0,0,1,0,0,0,0,0,0
			  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			  DD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			  
			  
instr_map 	DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;matricea de instructiuni
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DD 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	  





counter DD 0 ; numara evenimentele de tip timer
counterok DD 0;pt a numara secundele pana la explozia bombei
spatiu_bomba DD 0;pt a salva unde e plasata bomba
ok1 dd 0;pt a da enable la apasare butoane in scop de selectare directie pus bomba
counterok2 dd 0
ok2 dd 0;pt a da enable la explozie

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20
ok3 dd 0
buff dd 0
symbol_width EQU 10
symbol_height EQU 20
my_symbol_width EQU 40	
my_symbol_height EQU 40
my_symbol_width2 EQU 7
my_symbol_height2 EQU 4
my_symbol_height3 equ 17
bmp_spec dd 0
my_symbol_width3 equ 18
include digits.inc
include letters.inc
include simboluri.inc
include simboluri2.inc
include simboluri3.inc
include simboluri4.inc



.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
simbol4 proc;procedura de generare simbol
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi,simboluri4
	sub eax,0
	


draw_text:
	mov ebx, my_symbol_width
	mul ebx
	mov ebx, my_symbol_height
	mul ebx
	add esi, eax
	mov ecx, my_symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, my_symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, my_symbol_width
	jmp bucla_simbol_coloane
	bucla_simbol_linii_punte:
	jmp bucla_simbol_linii
bucla_simbol_coloane:


	cmp byte ptr [esi], 1
	je simbol_pixel_negru
	cmp byte ptr[esi],0
	je simbol_pixel_alb

	jmp simbol_pixel_next
simbol_pixel_negru:
	mov dword ptr [edi], 0000000h
	jmp simbol_pixel_next
	simbol_pixel_alb:
	mov dword ptr[edi],0FFFFFFh
	jmp simbol_pixel_next
	
	
	
	
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii_punte
	popa
	mov esp, ebp
	pop ebp
	ret
	

simbol4 endp



simbol3 proc;procedura de generare simbol
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi,simboluri3
	sub eax,0
	


draw_text:
	mov ebx, my_symbol_width3
	mul ebx
	mov ebx, my_symbol_height3
	mul ebx
	add esi, eax
	mov ecx, my_symbol_height3
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, my_symbol_height3
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, my_symbol_width3
	jmp bucla_simbol_coloane
	bucla_simbol_linii_punte:
	jmp bucla_simbol_linii
bucla_simbol_coloane:


	cmp byte ptr [esi], 1
	je simbol_pixel_negru
	cmp byte ptr[esi],0
	je simbol_pixel_alb
	cmp byte ptr[esi],2
	je simbol_pixel_rosu
	cmp byte ptr[esi],3
	je simbol_pixel_verde
	jmp simbol_pixel_next
simbol_pixel_negru:
	mov dword ptr [edi], 0000000h
	jmp simbol_pixel_next
	simbol_pixel_alb:
	mov dword ptr[edi],0FFFFFFh
	jmp simbol_pixel_next
	simbol_pixel_rosu:
	mov dword ptr[edi],0FF0000h
	jmp simbol_pixel_next 
	simbol_pixel_verde:
	mov dword ptr[edi],000FF00h
	jmp simbol_pixel_next 
	
	
	
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii_punte
	popa
	mov esp, ebp
	pop ebp
	ret
	

simbol3 endp
simbol2 proc;procedura generare simbol
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi,simboluri2
	sub eax,0
	


draw_text:
	mov ebx, my_symbol_width2
	mul ebx
	mov ebx, my_symbol_height2
	mul ebx
	add esi, eax
	mov ecx, my_symbol_height2
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, my_symbol_height2
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, my_symbol_width2
	jmp bucla_simbol_coloane
	bucla_simbol_linii_punte:
	jmp bucla_simbol_linii
bucla_simbol_coloane:


	cmp byte ptr [esi], 1
	je simbol_pixel_negru
	cmp byte ptr[esi],0
	je simbol_pixel_alb
	jmp simbol_pixel_next
simbol_pixel_negru:
	mov dword ptr [edi], 0000000h
	jmp simbol_pixel_next
	simbol_pixel_alb:
	mov dword ptr[edi],0FFFFFFh
	jmp simbol_pixel_next
	
	
	
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii_punte
	popa
	mov esp, ebp
	pop ebp
	ret
	

simbol2 endp
simbol proc;procedura pt generale simbol/aici sunt puse simbolurile pt zid lemn om iarba bomba buff etc
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi,simboluri
	sub eax,0
	


draw_text:
	mov ebx, my_symbol_width
	mul ebx
	mov ebx, my_symbol_height
	mul ebx
	add esi, eax
	mov ecx, my_symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, my_symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, my_symbol_width
	jmp bucla_simbol_coloane
	bucla_simbol_linii_punte:
	jmp bucla_simbol_linii
bucla_simbol_coloane:
cmp byte ptr[esi],5
je simbol_pixel_mov
cmp byte ptr[esi],8
je simbol_pixel_alb
cmp byte ptr[esi],6
je simbol_pixel_crem
cmp byte ptr[esi],7
je simbol_pixel_portocaliu
	cmp byte ptr [esi], 0
	je simbol_pixel_negru
	cmp byte ptr[esi], 2
	je simbol_pixel_maro
	cmp byte ptr[esi],3
	je simbol_pixel_verde
	cmp byte ptr[esi],4
	je simbol_pixel_albastru
	mov dword ptr [edi],06E6E6Eh
	jmp simbol_pixel_next
simbol_pixel_negru:
	mov dword ptr [edi], 0000000h
	jmp simbol_pixel_next
	simbol_pixel_alb:
	mov dword ptr[edi],0FFFFFFh
	je simbol_pixel_next
	simbol_pixel_maro:
	mov dword ptr[edi],0B18904h
	jmp simbol_pixel_next
	simbol_pixel_verde:
	mov dword ptr[edi],074DF00h
	jmp simbol_pixel_next
	simbol_pixel_albastru:
	mov dword ptr[edi],01384E5h
	jmp simbol_pixel_next
	simbol_pixel_mov:
	mov dword ptr[edi],07931ADh
	jmp simbol_pixel_next
	simbol_pixel_crem:
	mov dword ptr[edi],0DC9A59h
	jmp simbol_pixel_next
	simbol_pixel_portocaliu:
	mov dword ptr[edi],0FF8004h
	
	
	
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii_punte
	popa
	mov esp, ebp
	pop ebp
	ret
	

simbol endp


make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text

	
	
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp
; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm
make_simbol_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call simbol
	add esp, 16
endm
make_simbol_macro2 macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call simbol2
	add esp, 16
endm
make_simbol_macro3 macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call simbol3
	add esp, 16
endm
make_simbol_macro4 macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call simbol4
	add esp, 16
endm
linie_orizontala_dreapta macro x,y,lungime;macrouri pt generarea liniilor pt butoane
local bucla_linie
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,lungime
bucla_linie:
mov dword ptr[eax],0000000h
add eax,4
loop bucla_linie


endm
linie_orizontala_stanga macro x,y,lungime
local bucla_linie
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,lungime
bucla_linie:
mov dword ptr[eax],0000000h
sub eax,4
loop bucla_linie
endm
linie_verticala_sus macro x,y,lungime
local bucla_linie
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,lungime
bucla_linie:
mov dword ptr[eax],0000000h
sub eax,area_width*4
loop bucla_linie
endm
linie_verticala_jos macro x,y,lungime
local bucla_linie
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,lungime
bucla_linie:
mov dword ptr[eax],0000000h
add eax,area_width*4
loop bucla_linie
endm
linie_oblica_sus macro x,y,lungime
local bucla_linie
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,lungime
bucla_linie:
mov dword ptr[eax],0000000h
sub eax,(area_width-1)*4
loop bucla_linie
endm
linie_oblica_sus_stanga macro x,y,lungime
local bucla_linie
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,lungime
bucla_linie:
mov dword ptr[eax],0000000h
sub eax,(area_width+1)*4
loop bucla_linie
endm
linie_oblica_jos_stanga macro x,y,lungime
local bucla_linie
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,lungime
bucla_linie:
mov dword ptr[eax],0000000h
add eax,(area_width-1)*4
loop bucla_linie
endm
linie_oblica_jos_dreapta macro x,y,lungime
local bucla_linie
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,lungime
bucla_linie:
mov dword ptr[eax],0000000h
add eax,(area_width+1)*4
loop bucla_linie
endm
construire_mapa macro;aici se genereaza mapa
	xor ECX,ECX
xor ebp,ebp;se seteaza la 0 registrii
xor edi,edi
xor esi,esi
comparare:
cmp ecx,linie_maxima;se compara contorul de linii cu linia maxima -1 deoarece merge de la 0 la n-1 / daca este mai mare inseamna ca matricea e gata de parcurs
jg final
cmp ebp,coloana_maxima;comparam cu coloana maxima -1 deoarece merge de la 0 /daca e mai mare inseamna ca o linie s a terminat de parcurs
jg initializare
mov eax,ecx;se muta in eax numarul curent de linie
mov ebx,numar_de_sarit;numar de sarit reprezinta cate coloane se sare imrepuna cu o linie 
mul ebx
add eax,ebp;se adauga coloana curenta la valaore
mov ebx,4;se inm cu 4 pt ca avem elemente DD
mul ebx
mov ebx,eax;se muta in ebx pozitia din matrice curenta
mov eax,ebp
mov esi,dimensiune_patrat;dimensiune patrat este 40 adica numarul de pixeli din simboluri
mul esi;aici se calculeaza asa: coordonata initiala x0 plus cate coloane sunt parcurse*numar pixel patrat
add eax,x0
mov esi,eax
mov eax,ecx
mov edi,dimensiune_patrat
mul edi
add eax,y0
mov edi,eax
make_simbol_macro harta[ebx],area,esi,edi;apelul funcitie de generare simbol pe baza valorilor dp pozitii din matrice
add ebp,1
jmp comparare

initializare:
mov ebp,0;aici se merge din nou la col 0 cand s a terminat de parcurs o linie
add ecx,1
jmp comparare
final:
xor ecx,ecx
xor ebp,ebp
xor eax,eax
xor edi,edi; se reseteaza la 0 registrii
endm

generare_instructiuni macro;un macro analog celui de mai sus care apeleaza matricea de instructiuni 
	xor ECX,ECX
xor ebp,ebp
xor edi,edi
xor esi,esi
comparare3:
cmp ecx,17
jg final_instructiuni
cmp ebp,31
jg initializare3
mov eax,ecx
mov ebx,32
mul ebx
add eax,ebp
mov ebx,4
mul ebx
mov ebx,eax
mov eax,ebp
mov esi,dimensiune_patrat
mul esi
add eax,overx1
mov esi,eax
mov eax,ecx
mov edi,dimensiune_patrat
mul edi
add eax,overy1
mov edi,eax
make_simbol_macro4 instr_map[ebx],area,esi,edi
add ebp,1
jmp comparare3

initializare3:
mov ebp,0
add ecx,1
jmp comparare3
final_instructiuni:
xor ecx,ecx
xor ebp,ebp
xor eax,eax
xor edi,edi

endm

generare_game_over macro; un macro analog celor de mai sus care apeleaza matricea ce afiseaza game over
	xor ECX,ECX
xor ebp,ebp
xor edi,edi
xor esi,esi
comparare2:
cmp ecx,17
jg final_game_over
cmp ebp,31
jg initializare2
mov eax,ecx
mov ebx,32
mul ebx
add eax,ebp
mov ebx,4
mul ebx
mov ebx,eax
mov eax,ebp
mov esi,dimensiune_patrat
mul esi
add eax,overx1
mov esi,eax
mov eax,ecx
mov edi,dimensiune_patrat
mul edi
add eax,overy1
mov edi,eax
make_simbol_macro4 game_over_map[ebx],area,esi,edi
add ebp,1
jmp comparare2

initializare2:
mov ebp,0
add ecx,1
jmp comparare2
final_game_over:
xor ecx,ecx
xor ebp,ebp
xor eax,eax
xor edi,edi
endm

generare_sageti macro x1,y1,x2,y2,x3,y3,x4,y4;macro de generare sageti pt a ingloba toate celelalte macro singulare pt fiecare linie in parte
linie_verticala_sus x1,y1,40
	linie_orizontala_dreapta x1,y1,40
	linie_verticala_sus x1 + 40,y1,40
	linie_orizontala_stanga x1,y1 - 40,20
	linie_oblica_sus x1 - 20,y1 - 40,40
	linie_orizontala_dreapta x1 + 40,y1 - 40,20
	linie_oblica_sus_stanga x1+60,y1-40,40
	linie_orizontala_stanga x2,y2,40
	linie_verticala_sus x2-40,y2,20
	linie_verticala_jos x2,y2,40
	linie_orizontala_stanga x2,y2+40,40
	linie_verticala_jos x2-40,y2+40,20
	linie_oblica_sus_stanga x2-40,y2+60,40
	linie_oblica_jos_stanga x2-40,y2-20,40
	linie_orizontala_dreapta x3,y3,40
	linie_verticala_sus x3+40,y3,20
	linie_verticala_jos x3,y3,40
	linie_orizontala_dreapta x3,y3+40,40
	linie_verticala_jos x3+40,y3+40,20
	linie_oblica_jos_dreapta x3+40,y3-20,40
	linie_oblica_sus x3+40,y3+60,40
	linie_orizontala_dreapta x4,y4,40
	linie_verticala_jos x4,y4,40
	linie_verticala_jos x4+40,y4,40
	linie_orizontala_stanga x4,y4+40,20
	linie_orizontala_dreapta x4+40,y4+40,20
	linie_oblica_jos_dreapta x4-20,y4+40,40
    linie_oblica_jos_stanga x4+60,y4+40,40

endm

generare_butoane macro x5,y5
linie_orizontala_stanga x5,y5,120
linie_verticala_jos x5,y5,80
linie_orizontala_stanga x5,y5+80,120
linie_verticala_jos x5-120,y5,80
linie_orizontala_stanga x6,y6,120
linie_verticala_jos x6,y6,80
linie_orizontala_stanga x6,y6+80,120
linie_verticala_jos x6-120,y6,80
endm
verificare_buton macro x,y;aici se verifica daca s a dat click in interiorul butoanelor
local comparare1,comparare2,comparare3,comparare4,comparare5,comparare6
cmp instructiuni,1
je verificare_instructiuni
mov edi,x
comparare1:
cmp edi,x1
jl comparare2
cmp edi,x1+40
jg comparare2
mov edi,y
cmp edi,y1
jg comparare2
cmp edi,y1-65
jl comparare2
sub linie,1
mov eax,linie
mov ebx,numar_de_sarit;daca s a dat click in butonul up si nu avem deasupra piatra lemn alt om sau bomba atunci se poate face deplasarea
mul ebx
add eax,coloana
mov ebx,4
mul ebx
cmp harta[eax],0
je refacere1
cmp harta[eax],1
je refacere1  
cmp harta[eax],5
je refacere1
cmp harta[eax],7
je refacere1  ;apasare buton up
cmp ok1,1;aici ok1 verifica daca s a apasat inaintea butonul "BOMB" / daca s a apasat inainte butonul bomb ok1 se seteaza la 1..si urmeaza a fi verificat care din butoanele de directie este apsat pt a plasa bomba in acea pozitie
; de ex daca se apasa bomb si apoi up si pozitia de sus e libera se plaseaza bomba in acea pozitie
je plasarebomba1
cmp harta[eax],3;aici verificam daca simbolul de deasupra este un talisman de buff,daca este asa se sare la eticheta absorbire 
je absorbire1
cmp harta[eax],6;daca pe locul unde se face deplasarea este o flama de explozie/ atunci fluxul sare la scadeviata deoarece cand flama atinge player ul viata acestuia se decrementeaza cu 1
je scadeviata1
mov harta[eax],4; dupa verificarea tuturor cazurilor exceptionale ultimul caz este cel in care e doar iarba deasupra si se poate face deplasarea
add linie,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4;dupa deplasare trebuie sa ne intoarcem pe pozitia initiala pt a seta locul de unde am venit cu iarba/spatiu gol pt a nu avea 2 3 etc oameni pe harta :)
mul ebx
mov harta[eax],2
sub linie,1
jmp sfarsit
scadeviata1:;eticheta de reducere a vietii
mov harta[eax],4
add linie,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
sub linie,1
sub viata,1
jmp peste

absorbire1:;eticheta de preluare buff
mov harta[eax],4
add linie,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
sub linie,1
mov buff,1; se seteaza buff cu 1 pt a spune progamului ca bomba urmatoare va avea o explozie dubla / dar doar dupa apasarea butonului "BUFF"
jmp inlocuire_buff;
plasarebomba1:
mov spatiu_bomba,eax
mov ok1,0
mov ok2,1
mov harta[eax],5
mov counterok,0
refacere1:
add linie,1;analog si pentru celelalte butoane de deplasare
jmp sfarsit

comparare2:
mov edi,x
cmp edi,x3
jl comparare3
cmp edi,x3+65
jg comparare3
mov edi,y
cmp edi,y3
jl comparare3
cmp edi,y3+40
jg comparare3
add coloana,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
cmp harta[eax],1
je refacere2
cmp harta[eax],0
je refacere2
cmp harta[eax],5
je refacere2
cmp harta[eax],7
je refacere2
cmp ok1,1
je plasarebomba2
cmp harta[eax],3
je absorbire2
cmp harta[eax],6
je scadeviata2
mov harta[eax],4
sub coloana,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
add coloana,1
jmp sfarsit
scadeviata2:
mov harta[eax],4
sub coloana,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
add coloana,1
sub viata,1
jmp peste2
absorbire2:
mov harta[eax],4
sub coloana,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
add coloana,1
mov buff,1
jmp inlocuire_buff

plasarebomba2:
mov ok1,0
mov ok2,1
mov spatiu_bomba,eax
mov counterok,0
mov harta[eax],5
refacere2:
sub coloana,1
jmp sfarsit ;apasare buton rt

comparare3:
mov edi,x
cmp edi,x2
jg comparare4
cmp edi,x2-65
jl comparare4
mov edi,y
cmp edi,y2
jl comparare4
cmp edi,y2+40
jg comparare4 
sub coloana,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
cmp harta[eax],1
je refacere3
cmp harta[eax],0
je refacere3
cmp harta[eax],5
je refacere3
cmp harta[eax],7
je refacere3
cmp ok1,1
je plasarebomba3
cmp harta[eax],3
je absorbire3
cmp harta[eax],6
je pierdeviata3
mov harta[eax],4
add coloana,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
sub coloana,1
jmp sfarsit
pierdeviata3:
mov harta[eax],4
add coloana,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
sub coloana,1
sub viata,1
jmp peste2
absorbire3:
mov harta[eax],4
add coloana,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
sub coloana,1
mov buff,1
jmp inlocuire_buff
plasarebomba3:
mov ok1,0
mov ok2,1
mov spatiu_bomba,eax
mov harta[eax],5
mov counterok,0
refacere3:
add coloana,1
jmp sfarsit ;apasare buton lt

comparare4:
mov edi,x
cmp edi,x4
jl comparare5
cmp edi,x4+40
jg comparare5
mov edi,y
cmp edi,y4
jl comparare5
cmp edi,y4+65
jg comparare5
add linie,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
cmp harta[eax],0
je refacere4
cmp harta[eax],1
je refacere4
cmp harta[eax],5
je refacere4
cmp harta[eax],7
je refacere4
cmp ok1,1
je plasarebomba4
cmp harta[eax],3
je absorbire4
cmp harta[eax],6
je pierdeviata4
mov harta[eax],4
sub linie,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
add linie,1
jmp sfarsit
pierdeviata4:
mov harta[eax],4
sub linie,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
add linie,1
sub viata,1
jmp peste2
absorbire4:
mov harta[eax],4
sub linie,1
mov eax,linie
mov ebx,numar_de_sarit
mul ebx
add eax,coloana
mov ebx,4
mul ebx
mov harta[eax],2
add linie,1
mov buff,1
jmp inlocuire_buff
plasarebomba4:
mov ok1,0
mov ok2,1
mov counterok,0
mov spatiu_bomba,eax
mov harta[eax],5
refacere4:
sub linie,1 ;apasare buton dw
jmp sfarsit

comparare5:
mov edi,x
cmp edi,x5
jg comparare6
cmp edi,x5-120;apasare buton buff
jl comparare6
mov edi,y
cmp edi,y5
jl comparare6
cmp edi,y5+80
jg comparare6
cmp buff,1
jne comparare6
mov buff,0
mov bmp_spec,1
jmp inlocuire_buff

comparare6:
mov edi,x
cmp edi,x6
jg comparare7
cmp edi,x6-120;apasare buton bomb
jl comparare7
mov edi,y
cmp edi,y6
jl comparare7
cmp edi,y6+80
jg comparare7
mov ok1,1; se pune o variabila de verificare,prin care procedura de la verificare sageti deplasare verifica daca butonul bomb a fost apasat si daca a fost
;se poate face plasarea bombei in directia dorita
comparare7:
mov edi,x
cmp edi,800
jl sfarsit
cmp edi,950
jg sfarsit
mov edi,y
cmp edi,200
jl sfarsit
cmp edi,300
jg sfarsit
mov instructiuni,1;aici avem butonul de instructiuni
;seteaza variabila instructiuni cu 1 si sare la spatiul de generare harti pt a afisa harta responsabila cu afisarea instructiunilor
jmp sfarsit
verificare_instructiuni:
mov edi,x
cmp edi,1150
jl sfarsit
cmp edi,1250
jg sfarsit
mov edi,y
cmp edi,650
jl sfarsit
cmp edi,700
jg sfarsit
mov instructiuni,0


sfarsit:

endm



; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	jmp afisare_litere
	
evt_click:
verificare_buton [ebp+arg2],[ebp+arg3];apeleaza verificare buton in urma unui click
	
evt_timer:
	inc counter
	inc counterok;numara secundele la care explodeaza bomba
	inc timer_bot;numara la cat timp botul face o actiune (o secunda)
inc counterok3	;numara secundele dupa care se curata flama bombei 

	cmp counterok,15;dupa 3 secunde bomba explodeaza
	jne dupa
	cmp ok2,1; se foloseste ok2 setat de la butoanele de sageti pt a alege directia de plasare a bombei
	jne dupa
	mov ok2,0; se initializeaza enable ul ok2
	cmp bmp_spec,1;daca avem bomba speciala adica cea primita de la buff care explodeaza dublu atunci coordonatele acoperite de flama si apoi stergerea lor se recalculeaza
	je bomba_speciala;se sare la eticheta unde se va face calculul pozitiilor pt bomba speciala
	mov ebx,spatiu_bomba
	mov harta[ebx],6;aici se pune flama in pozitia bombei ..se considera ca daca spatiul a fost liber cat sa se plaseze bomba si sa se activeze enable ul atunci sigur se poate pune flama exploziei macar in locul ala
	sub ebx,4
	cmp harta[ebx],0; se verifica daca in calea exploziei e zid pe care nu l poate distruge
	je alt1
	cmp harta[ebx],4; se verifica daca in calea exploziei este om pe care nu l poate ucide dar scade viata cu 1
	je alt1_om
	mov harta[ebx],6;daca nu se muta pe pozitia libera simbolul de flama
	jmp alt1
	alt1_om:;scade viata cu 1
	sub viata,1
	alt1:
	add ebx,8
	cmp harta[ebx],0
	je alt2; analog pt celelate pozitii / bomba explodeaza in forma de + deci vor fi flame pe pozitia initiala a bombei deasupra sub stanga dreapta
	cmp harta[ebx],4
	je alt2_om
	mov harta[ebx],6
	jmp alt2
	alt2_om:
	sub viata,1
	alt2:
	sub ebx,80
	cmp harta[ebx],0
	je alt3
	cmp harta[ebx],4
	je alt3_om
	mov harta[ebx],6
	jmp alt3
	alt3_om:
	sub viata,1
	alt3:
	add ebx,152
	cmp harta[ebx],0
	je dupa
	cmp harta[ebx],4
	je alt4_om
	mov harta[ebx],6
	jmp dupa
	alt4_om:
	sub viata,1
	jmp dupa
	bomba_speciala:
		mov ebx,spatiu_bomba
	mov harta[ebx],6;aici se pune flama in pozitia bombei ..se considera ca daca spatiul a fost liber cat sa se plaseze bomba si sa se activeze enable ul atunci sigur se poate pune flama exploziei macar in locul ala
	sub ebx,4
	cmp harta[ebx],0; daca e piatra nu se propaga si sare la special2 / nu la special1 ci la special2 pentru ca dupa logica daca bomba se dubleaza si explodeaza intr un plus de 2 ori mai mare
	;daca pe prima pozite din stanga este zid bomba in realitate nu s ar propaga mai departe de zid de aceea se sare la special2 pt a nu pune flama pe a 2 a pozitie din stanga 
	; pe scurt explozia nu se propaga mai departe de zid oricat de lunga ar fi flama ei
	je special2
	cmp harta[ebx],4
	je special1_om; daca gaseste om tot asa..sare la special_om care o sa sara la special2 pt ca am consideraat ca flama nu s ar propaga mai departe de om in spatele lui dar i ar scadea viata cu 1
	mov harta[ebx],6
	jmp special1
	
	special1_om:
	sub viata,1
	jmp special2    ;analog pentru toate celelalte pozitii
	special1:
	mov ebx,spatiu_bomba
	sub ebx,8
	cmp harta[ebx],0
	je special2
	cmp harta[ebx],4
	je special2_om
	mov harta[ebx],6
	jmp special2
	special2_om:
	sub viata,1
	jmp special2
	special2:
	mov ebx,spatiu_bomba
	add ebx,4
	cmp harta[ebx],0
	je special4
	cmp harta[ebx],4
	je special3_om
	mov harta[ebx],6
	jmp special3
	special3_om:
	sub viata,1
	jmp special4
	special3:
	mov ebx,spatiu_bomba
	add ebx,8
	cmp harta[ebx],0
	je special4
	cmp harta[ebx],4
	je special4_om
	mov harta[ebx],6
	jmp special4
	special4_om:
	sub viata,1
	jmp special4
	special4:
	mov ebx,spatiu_bomba
	sub ebx,76
	cmp harta[ebx],0
	je special6
	cmp harta[ebx],4
	je special5_om
	mov harta[ebx],6
	jmp special5
	special5_om:
	sub viata,1
	jmp special6
	special5:
	mov ebx,spatiu_bomba
	sub ebx,152
	cmp harta[ebx],0
	je special6
	cmp harta[ebx],4
	je special6_om
	mov harta[ebx],6
	jmp special6
	special6_om:
	sub viata,1
	jmp special6
	special6:
	mov ebx,spatiu_bomba
	add ebx,76
	cmp harta[ebx],0
	je dupa
	cmp harta[ebx],4
	je special7_om
	mov harta[ebx],6
	jmp special7
	special7_om:
	sub viata,1
	jmp dupa
	special7:
	mov ebx,spatiu_bomba
	add ebx,152
	cmp harta[ebx],0
	je dupa
	cmp harta[ebx],4
	je special8_om
	mov harta[ebx],6
	jmp dupa
	special8_om:
	sub viata,1
	jmp dupa
	
	dupa:
	cmp counterok,20; aici contorizam 4 secunde trecute de la plasarea bombei pentru ca bomba explodeaza dupa 3 si flama ei dispare dupa a 4 a sec adica dupa o sec de existenta
	jne  final2
	mov ebx,spatiu_bomba
	cmp bmp_spec,1; verificam daca bomba care a explodat era una speciala/ daca da trebuie verificate mai multe pozitii pt a sterge flama 
	je stergere_speciala
	cmp harta[ebx],6 ; se verifica daca exista flame in jurul locului exploziei pt a fi sterse
	jne dupa1
	mov harta[ebx],2
	dupa1:
	add ebx,4
	cmp harta[ebx],6
	jne dupa2
	mov harta[ebx],2
	dupa2:
	sub ebx,8
	cmp harta[ebx],6
	jne dupa3
	mov harta[ebx],2
	dupa3:
	sub ebx,72
	cmp harta[ebx],6
	jne dupa4
	mov harta[ebx],2
	dupa4:
	add ebx,152
	cmp harta[ebx],6
	jne final2
	mov harta[ebx],2
jmp final2
stergere_speciala:
mov bmp_spec,0 ; analog verificarii de mai sus
;si aici se putea implementa tot un fel de stergere inteligenta / daca in stanga originii de ex nu exista flama e clar ca nu are cum sa existe o pozitie mai departe in stanga
; nu mai tin minte de ce n am implementat asa la momentul respectiv
	cmp harta[ebx],6
	jne stergere1
	mov harta[ebx],2
	stergere1:
	mov ebx,spatiu_bomba
	add ebx,4
	cmp harta[ebx],6
	jne stergere3
	mov harta[ebx],2
	stergere2:
	mov ebx,spatiu_bomba
	add ebx,8
	cmp harta[ebx],6
	jne stergere3
	mov harta[ebx],2
	stergere3:
	mov ebx,spatiu_bomba
	sub ebx,4
	cmp harta[ebx],6
	jne stergere5
	mov harta[ebx],2
	stergere4:
	mov ebx,spatiu_bomba
	sub ebx,8
	cmp harta[ebx],6
	jne stergere5
	mov harta[ebx],2
	stergere5:
	mov ebx,spatiu_bomba
	sub ebx,76
	cmp harta[ebx],6
	jne stergere7
	mov harta[ebx],2
	stergere6:
	mov ebx,spatiu_bomba
	sub ebx,152
	cmp harta[ebx],6
	jne stergere7
	mov harta[ebx],2
	stergere7:
	mov ebx,spatiu_bomba
	add ebx,76
	cmp harta[ebx],6
	jne final2
	mov harta[ebx],2
	stergere8:
	mov ebx,spatiu_bomba
	add ebx,152
	cmp harta[ebx],6
	jne final2
	mov harta[ebx],2
	

	
	final2:


	
	
	
	
	
	
	
afisare_litere:
;afisam litere pe butoane ...titlul
	
	;scriem un mesaj
	make_text_macro 'U', area, 1080, 505
make_text_macro 'P', area, 1090, 505
make_text_macro 'R', area, 1140, 565
make_text_macro 'T', area, 1150, 565
make_text_macro 'D', area, 1080, 625
make_text_macro 'W', area, 1090, 625
make_text_macro 'L', area, 1020, 565
make_text_macro 'T', area, 1030, 565
make_text_macro 'B', area, 870, 515
make_text_macro 'U', area, 880, 515
make_text_macro 'F', area, 890, 515
make_text_macro 'F', area, 900, 515
make_text_macro 'B', area, 870, 630
make_text_macro 'O', area, 880, 630
make_text_macro 'M', area, 890, 630
make_text_macro 'B', area, 900, 630
make_text_macro 'B', area, 300, 10
make_text_macro 'O', area, 310, 10
make_text_macro 'M', area,320, 10
make_text_macro 'B', area, 330, 10
make_text_macro 'E', area, 340, 10
make_text_macro 'R', area, 350, 10
make_text_macro 'M', area, 360, 10
make_text_macro 'A', area, 370, 10
make_text_macro 'N', area, 380, 10
linie_orizontala_dreapta 800,440,150
linie_verticala_sus 800,440,100
linie_orizontala_dreapta 800,340,150
linie_verticala_jos 950,340,100
make_text_macro 'H', area, 820,360
make_text_macro 'P', area,830 ,360
make_text_macro 'B', area,820 ,400
make_text_macro 'U', area,830 ,400
make_text_macro 'F', area,840 ,400
make_text_macro 'F', area,850 ,400
make_simbol_macro2 0,area,840,365
make_simbol_macro2 0,area,840,373
make_simbol_macro2 0,area,860,412
make_simbol_macro2 0,area,860,405
linie_orizontala_dreapta 800,300,150
linie_verticala_sus 800,300,100
linie_orizontala_dreapta 800,200,150
linie_verticala_jos 950,200,100
make_text_macro 'I',area,815,240
make_text_macro 'N',area,825,240
make_text_macro 'S',area,835,240
make_text_macro 'T',area,845,240
make_text_macro 'R',area,855,240
make_text_macro 'U',area,865,240
make_text_macro 'C',area,875,240
make_text_macro 'T',area,885,240
make_text_macro 'I',area,895,240
make_text_macro 'O',area,905,240
make_text_macro 'N',area,915,240
make_text_macro 'S',area,925,240

inlocuire_buff:;aici se face o fel de alegere pt generari
;daca buff ul e 1 at se genereaza o bila verde in dreptul  buff ului pt a anunta jucatorul ca are la dispozitie buff
cmp buff,1
je faceverde
make_simbol_macro3 1,area,878,402;daca nu e 1 buff se pune automat bila rosie adica buff ul nu este valid 
jmp peste
faceverde:
make_simbol_macro3 2,area,878,402
peste:
cmp viata,3
je face3inimi; daca viata e 3 se deseneaza 3 inimi
cmp viata,2
je face2inimi ;daca viata e 2 se deseneaza 2 inimi etc
cmp viata,1
je face1inimi
make_text_macro ' ',area,855,362
make_text_macro ' ',area,865,362; daca nu mai exista viata se sterg inimile toate prin suprapunere peste cu spatiu si se muta in variabila gameover 1 pt a se genera mai jos matricea de gameover
make_text_macro ' ',area,875,362
make_text_macro ' ',area,885,362
make_text_macro ' ',area,895,362
make_text_macro ' ',area,905,362
mov gameover,1

jmp peste2
face3inimi:
make_simbol_macro3 0,area,855,362
make_simbol_macro3 0,area,875,362
make_simbol_macro3 0,area,895,362
jmp peste2
face2inimi:
make_simbol_macro3 0,area,855,362
make_simbol_macro3 0,area,875,362
make_text_macro ' ',area,895,362
make_text_macro ' ',area,905,362

jmp peste2
face1inimi:
make_simbol_macro3 0,area,855,362
make_text_macro ' ',area,875,362
make_text_macro ' ',area,885,362
make_text_macro ' ',area,895,362
make_text_macro ' ',area,905,362
peste2:
cmp instructiuni,1; daca variabila instructiuni este 1 se sare la generare matrice instructiuni
je afisare_instructiuni
cmp gameover,1;daca variabila gameover este 1 se sare la generare matrice gameover
je afisare_game_over
construire_mapa;daca nu este vreun caz special se genereaza matricea de jos si butoanele 
generare_sageti x1,y1,x2,y2,x3,y3,x4,y4
generare_butoane x5,y5
make_text_macro ' ',area,760,250
make_text_macro ' ',area,770,250
make_text_macro ' ',area,780,250
make_text_macro ' ',area,790,250; aici se suprascriu cu spatiu literele ramase de la generarea de instructiuni ( nu mi a venit alta idee)
make_text_macro ' ',area,760,100
make_text_macro ' ',area,770,100
make_text_macro ' ',area,780,100
make_text_macro ' ',area,790,100
make_text_macro ' ',area,800,100
make_text_macro ' ',area,760,60
make_text_macro ' ',area,770,60
make_text_macro ' ',area,780,60
make_text_macro ' ',area,790,60
make_text_macro ' ',area,800,60
make_text_macro ' ',area,810,60
make_text_macro ' ',area,820,60
make_text_macro ' ',area,830,60
make_text_macro ' ',area,840,60
make_text_macro ' ',area,850,60
make_text_macro ' ',area,860,60
make_text_macro ' ',area,870,60
make_text_macro ' ',area,880,60
make_text_macro ' ',area,760,50
make_text_macro ' ',area,770,50
make_text_macro ' ',area,780,50
make_text_macro ' ',area,790,50
make_text_macro ' ',area,800,50
make_text_macro ' ',area,810,50
make_text_macro ' ',area,820,50
make_text_macro ' ',area,830,50
make_text_macro ' ',area,840,50
make_text_macro ' ',area,850,50
make_text_macro ' ',area,860,50
make_text_macro ' ',area,870,50
make_text_macro ' ',area,880,50
make_text_macro ' ',area,800,110
make_text_macro ' ',area,810,110
make_text_macro ' ',area,820,110
make_text_macro ' ',area,800,100
make_text_macro ' ',area,810,100
make_text_macro ' ',area,820,100
make_simbol_macro4 1,area,1150,650
make_simbol_macro4 1,area,1170,650
make_simbol_macro4 1,area,1190,650
make_simbol_macro4 1,area,1210,650
make_simbol_macro4 1,area,1230,650
make_simbol_macro4 1,area,1150,670
make_simbol_macro4 1,area,1170,670
make_simbol_macro4 1,area,1190,670
make_simbol_macro4 1,area,1210,670
make_simbol_macro4 1,area,1230,670
jmp sari
afisare_game_over:; aici se genereaza matricea de game over
generare_game_over
jmp sari
afisare_instructiuni:
generare_instructiuni
make_text_macro 'D',area,300,50; aici se genereaza matricea de instructiuni si o lunga lista de simboluri litere pt a explica functionalitatile jocului
make_text_macro 'E',area,310,50
make_text_macro 'P',area,320,50
make_text_macro 'L',area,330,50
make_text_macro 'A',area,340,50
make_text_macro 'S',area,350,50
make_text_macro 'A',area,360,50
make_text_macro 'R',area,370,50
make_text_macro 'E',area,380,50
make_text_macro 'A',area,390,50
make_text_macro ' ',area,400,50
make_text_macro 'S',area,410,50
make_text_macro 'E',area,420,50
make_text_macro ' ',area,430,50
make_text_macro 'R',area,440,50
make_text_macro 'E',area,450,50
make_text_macro 'A',area,460,50
make_text_macro 'L',area,470,50
make_text_macro 'I',area,480,50
make_text_macro 'Z',area,490,50
make_text_macro 'E',area,500,50
make_text_macro 'A',area,510,50
make_text_macro 'Z',area,520,50
make_text_macro 'A',area,530,50
make_text_macro ' ',area,540,50
make_text_macro 'C',area,550,50
make_text_macro 'U',area,560,50
make_text_macro ' ',area,570,50
make_text_macro 'A',area,580,50
make_text_macro 'J',area,590,50
make_text_macro 'U',area,600,50
make_text_macro 'T',area,610,50
make_text_macro 'O',area,620,50
make_text_macro 'R',area,630,50
make_text_macro 'U',area,640,50
make_text_macro 'L',area,650,50
make_text_macro ' ',area,660,50
make_text_macro 'B',area,670,50
make_text_macro 'U',area,680,50
make_text_macro 'T',area,690,50
make_text_macro 'O',area,700,50
make_text_macro 'A',area,710,50
make_text_macro 'N',area,720,50
make_text_macro 'E',area,730,50
make_text_macro 'L',area,740,50
make_text_macro 'O',area,750,50
make_text_macro 'R',area,760,50
make_text_macro ' ',area,770,50
make_text_macro 'U',area,780,50
make_text_macro 'P',area,790,50
make_text_macro ' ',area,800,50
make_text_macro 'D',area,810,50
make_text_macro 'W',area,820,50
make_text_macro ' ',area,830,50
make_text_macro 'L',area,840,50
make_text_macro 'T',area,850,50
make_text_macro ' ',area,860,50
make_text_macro 'R',area,870,50
make_text_macro 'T',area,880,50
make_text_macro 'B',area,300,100
make_text_macro 'O',area,310,100
make_text_macro 'M',area,320,100
make_text_macro 'B',area,330,100
make_text_macro 'A',area,340,100
make_text_macro ' ',area,350,100
make_text_macro 'S',area,360,100
make_text_macro 'E',area,370,100
make_text_macro ' ',area,380,100
make_text_macro 'P',area,390,100
make_text_macro 'L',area,400,100
make_text_macro 'A',area,410,100
make_text_macro 'S',area,420,100
make_text_macro 'E',area,430,100
make_text_macro 'A',area,440,100
make_text_macro 'Z',area,450,100
make_text_macro 'A',area,460,100
make_text_macro ' ',area,470,100
make_text_macro 'C',area,480,100
make_text_macro 'U',area,490,100
make_text_macro ' ',area,500,100
make_text_macro 'C',area,510,100
make_text_macro 'O',area,520,100
make_text_macro 'M',area,530,100
make_text_macro 'B',area,540,100
make_text_macro 'I',area,550,100
make_text_macro 'N',area,560,100
make_text_macro 'A',area,570,100
make_text_macro 'T',area,580,100
make_text_macro 'I',area,590,100
make_text_macro 'A',area,600,100
make_text_macro ' ',area,610,100
make_text_macro 'B',area,620,100
make_text_macro 'O',area,630,100
make_text_macro 'M',area,640,100
make_text_macro 'B',area,650,100
make_text_macro ' ',area,660,100
make_simbol_macro3 3,area,670,102
make_text_macro 'U',area,690,100
make_text_macro 'P',area,700,100
make_simbol_macro3 4,area,710,102
make_text_macro 'D',area,730,100
make_text_macro 'W',area,740,100
make_simbol_macro3 4,area,750,102
make_text_macro 'L',area,770,100
make_text_macro 'T',area,780,100
make_simbol_macro3 4,area,790,102
make_text_macro 'R',area,810,100
make_text_macro 'T',area,820,100
make_text_macro 'B',area,300,150
make_text_macro 'O',area,310,150
make_text_macro 'M',area,320,150
make_text_macro 'B',area,330,150
make_text_macro 'A',area,340,150
make_text_macro ' ',area,350,150
make_text_macro 'E',area,360,150
make_text_macro 'X',area,370,150
make_text_macro 'P',area,380,150
make_text_macro 'L',area,390,150
make_text_macro 'O',area,400,150
make_text_macro 'D',area,410,150
make_text_macro 'E',area,420,150
make_text_macro 'A',area,430,150
make_text_macro 'Z',area,440,150
make_text_macro 'A',area,450,150
make_text_macro ' ',area,460,150
make_text_macro 'D',area,470,150
make_text_macro 'U',area,480,150
make_text_macro 'P',area,490,150
make_text_macro 'A',area,500,150
make_text_macro ' ',area,510,150
make_text_macro '3',area,520,150
make_text_macro ' ',area,530,150
make_text_macro 'S',area,540,150
make_text_macro 'E',area,550,150
make_text_macro 'C',area,560,150
make_text_macro 'A',area,300,200
make_text_macro 'V',area,310,200
make_text_macro 'E',area,320,200
make_text_macro 'T',area,330,200
make_text_macro 'I',area,340,200
make_text_macro ' ',area,350,200
make_text_macro 'L',area,360,200
make_text_macro 'A',area,370,200
make_text_macro ' ',area,380,200
make_text_macro 'D',area,390,200
make_text_macro 'I',area,400,200
make_text_macro 'S',area,410,200
make_text_macro 'P',area,420,200
make_text_macro 'O',area,430,200
make_text_macro 'Z',area,440,200
make_text_macro 'I',area,450,200
make_text_macro 'T',area,460,200
make_text_macro 'I',area,470,200
make_text_macro 'E',area,480,200
make_text_macro ' ',area,490,200
make_text_macro '3',area,500,200
make_text_macro ' ',area,510,200
make_text_macro 'V',area,520,200
make_text_macro 'I',area,530,200
make_text_macro 'E',area,540,200
make_text_macro 'T',area,550,200
make_text_macro 'I',area,560,200
make_text_macro 'B',area,300,250
make_text_macro 'U',area,310,250
make_text_macro 'F',area,320,250
make_text_macro 'F',area,330,250
make_text_macro ' ',area,340,250
make_text_macro 'U',area,350,250
make_text_macro 'L',area,360,250
make_text_macro ' ',area,370,250
make_text_macro 'E',area,380,250
make_text_macro 'S',area,390,250
make_text_macro 'T',area,400,250
make_text_macro 'E',area,410,250
make_text_macro ' ',area,420,250
make_text_macro 'D',area,430,250
make_text_macro 'I',area,440,250
make_text_macro 'S',area,450,250
make_text_macro 'P',area,460,250
make_text_macro 'O',area,470,250
make_text_macro 'N',area,480,250
make_text_macro 'I',area,490,250
make_text_macro 'B',area,500,250
make_text_macro 'I',area,510,250
make_text_macro 'L',area,520,250
make_text_macro ' ',area,530,250
make_text_macro 'L',area,540,250
make_text_macro 'A',area,550,250
make_text_macro ' ',area,560,250
make_text_macro 'A',area,570,250
make_text_macro 'P',area,580,250
make_text_macro 'A',area,590,250
make_text_macro 'S',area,600,250
make_text_macro 'A',area,610,250
make_text_macro 'R',area,620,250
make_text_macro 'E',area,630,250
make_text_macro 'A',area,640,250
make_text_macro ' ',area,650,250
make_text_macro 'B',area,660,250
make_text_macro 'U',area,670,250
make_text_macro 'T',area,680,250
make_text_macro 'O',area,690,250
make_text_macro 'N',area,700,250
make_text_macro 'U',area,710,250
make_text_macro 'L',area,720,250
make_text_macro 'U',area,730,250
make_text_macro 'I',area,740,250
make_text_macro ' ',area,750,250
make_text_macro 'B',area,760,250
make_text_macro 'U',area,770,250
make_text_macro 'F',area,780,250
make_text_macro 'F',area,790,250
make_text_macro 'B',area,300,300
make_text_macro 'U',area,310,300
make_text_macro 'F',area,320,300
make_text_macro 'F',area,330,300
make_text_macro ' ',area,340,300
make_text_macro 'U',area,350,300
make_text_macro 'L',area,360,300
make_text_macro ' ',area,370,300
make_text_macro 'D',area,380,300
make_text_macro 'U',area,390,300
make_text_macro 'B',area,400,300
make_text_macro 'L',area,410,300
make_text_macro 'E',area,420,300
make_text_macro 'A',area,430,300
make_text_macro 'Z',area,440,300
make_text_macro 'A',area,450,300
make_text_macro ' ',area,460,300
make_text_macro 'E',area,470,300
make_text_macro 'X',area,480,300
make_text_macro 'P',area,490,300
make_text_macro 'L',area,500,300
make_text_macro 'O',area,510,300
make_text_macro 'Z',area,520,300
make_text_macro 'I',area,530,300
make_text_macro 'A',area,540,300
make_text_macro ' ',area,550,300
make_text_macro 'B',area,560,300
make_text_macro 'O',area,570,300
make_text_macro 'M',area,580,300
make_text_macro 'B',area,590,300
make_text_macro 'E',area,600,300
make_text_macro 'I',area,610,300
make_text_macro 'L',area,300,350
make_text_macro 'A',area,310,350
make_text_macro ' ',area,320,350
make_text_macro 'P',area,330,350
make_text_macro 'I',area,340,350
make_text_macro 'E',area,350,350
make_text_macro 'R',area,360,350
make_text_macro 'D',area,370,350
make_text_macro 'E',area,380,350
make_text_macro 'R',area,390,350
make_text_macro 'E',area,400,350
make_text_macro 'A',area,410,350
make_text_macro ' ',area,420,350
make_text_macro 'V',area,430,350
make_text_macro 'I',area,440,350
make_text_macro 'E',area,450,350
make_text_macro 'T',area,460,350
make_text_macro 'I',area,470,350
make_text_macro 'L',area,480,350
make_text_macro 'O',area,490,350
make_text_macro 'R',area,500,350
make_text_macro ' ',area,510,350
make_text_macro 'J',area,520,350
make_text_macro 'O',area,530,350
make_text_macro 'C',area,540,350
make_text_macro 'U',area,550,350
make_text_macro 'L',area,560,350
make_text_macro ' ',area,570,350
make_text_macro 'S',area,580,350
make_text_macro 'E',area,590,350
make_text_macro ' ',area,600,350
make_text_macro 'I',area,610,350
make_text_macro 'N',area,620,350
make_text_macro 'C',area,630,350
make_text_macro 'H',area,640,350
make_text_macro 'E',area,650,350
make_text_macro 'I',area,660,350
make_text_macro 'E',area,670,350
linie_orizontala_dreapta 1150,650,100
linie_verticala_jos 1150,650,50
linie_orizontala_dreapta 1150,700,100
linie_verticala_sus 1250,700,50
make_text_macro 'B',area,1180,665
make_text_macro 'A',area,1190,665
make_text_macro 'C',area,1200,665
make_text_macro 'K',area,1210,665








; posibile bug uri: intercalarea plasarii bombei de catre player si bot /bomba bot ului are uneori prioritate din ce am observat
;plasarea de 3 bombe simultan
;botul dupa cele 30 miscari stationeaza
;nu exista bug uri la miscare/colectare buff/incasare flama de la bomba/trecere prin bomba/plasa bomba in spatii intersize/exploztie ziduri etc
;dupa afisarea de gameover nu exista optiune de restart
;dupa afisare instructiuni exista buton de back
; nu am mai implementat pana la urma miscarea bot ului deoarece cand plasa bomba se suprapunea peste bomba player ului si nu mi s a parut un bug acceptabil
;problema se putea rezolva cu un alt enable pt bomba bot dar nu am mai avut timp sa ma gandesc
;las mai jos sectiunea de cod pentru miscare oricum
; cmp timer_bot,5;daca nu a trecut o secunda adica 5 unitati de timp at robbotul nu face miscare
; jne da
; inc counter_miscari
; mov eax,linie_bot
	; mov ebx,numar_de_sarit
	; mul ebx
	; add eax,coloana_bot
	; mov ebx,4;aici am trasat un parcurs predefinit al robotului inclusiv plasarea de bombe si ferirea de elemente
	;intiial am construit o functie de randomizare dar am observat unele bug uri greu rezolvabile in timpul ramas/ am incercat si varianta cu "urmareste player ul" dar aceea parca e mai potrivita pt jocuri in care mobii doar ucid
	;jucatorul cand il ating nu aici unde trebuie plasate bombe 
	; mul ebx
	; cmp counter_miscari,1
	; jne miscare2
	; sub linie_bot,1
	; mov ebx,eax
	; sub ebx,76
	; mov harta[ebx],7
	; mov harta[eax],2
	; mov timer_bot,0
	; miscare2:
	; cmp counter_miscari,2
	; jne miscare3
	; sub coloana_bot,1
	; mov ebx,eax
	; sub ebx,4
	; mov harta[ebx],7
	; mov harta[eax],2
	; mov timer_bot,0
	; miscare3:
	; cmp counter_miscari,3   ;aici este o serie de 30 de miscari
	
	;se poate face repetitiva daca dupa fiecare instructiuni de miscare se pune jmp  "da"(eticheta de final in acest caz) si la miscare 30 se da mov counter miscari,0 ca sa se reia miscarile de la 0
	;de altfel ar trebui in acel caz si verificate blocuri lemn si piatra si player in calea botului pt a nu le acoperi deoarece nu e permis
	; jne miscare4
	; sub coloana_bot,1
	; mov ebx,eax
	; sub ebx,4
	; mov harta[ebx],7
	; mov harta[eax],2
	; mov timer_bot,0
	; miscare4:
	; cmp counter_miscari,4
	; jne miscare5
	; mov ebx,eax
	; sub ebx,4
	; mov harta[ebx],5
	; mov spatiu_bomba,ebx
	; mov ebx,eax
	; add ebx,4
	; mov harta[ebx],7
	; mov harta[eax],2
	; add coloana_bot,1
	; mov timer_bot,0
	; mov ok2,1
; mov counterok,0
; miscare5:
; cmp counter_miscari,5
; jne miscare6
; mov ebx,eax
; mov harta[ebx],7

; mov timer_bot,0
; miscare6:
; cmp counter_miscari,6
; jne miscare7
; mov ebx,eax
; mov harta[ebx],7
; mov timer_bot,0
; miscare7:
; cmp counter_miscari,7
; jne miscare8
; mov ebx,eax
; mov harta[ebx],7
; mov timer_bot,0
; miscare8:
; cmp counter_miscari,8
; jne miscare9
; mov ebx,eax
; sub ebx,4
; sub coloana_bot,1
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
; miscare9:
; cmp counter_miscari,9
; jne miscare10
; mov ebx,eax
; sub ebx,4
; sub coloana_bot,1
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
; miscare10:
; cmp counter_miscari,10
; jne miscare11
	; mov ebx,eax
	; sub ebx,4
; mov harta[ebx],5
	; mov spatiu_bomba,ebx
	; mov ebx,eax
	; add ebx,4
	; mov harta[ebx],7
	; mov harta[eax],2
	; add coloana_bot,1
	; mov timer_bot,0
	; mov ok2,1
; mov counterok,0
	; miscare11:
	; cmp counter_miscari,11
	; jne miscare12
	; mov ebx,eax
	; mov harta[ebx],7
	; mov timer_bot,0
	; miscare12:
		; cmp counter_miscari,12
	; jne miscare13
	; mov ebx,eax
	; mov harta[ebx],7
	; mov timer_bot,0
	; miscare13:
		; cmp counter_miscari,13
	; jne miscare14
	; mov ebx,eax
	; mov harta[ebx],7
	; mov timer_bot,0
; miscare14:
; cmp counter_miscari,14
; jne miscare15
; mov ebx,eax
; sub ebx,4
; sub coloana_bot,1
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
; miscare15:
; cmp counter_miscari,15
; jne miscare16
; mov ebx,eax
; sub ebx,4
; sub coloana_bot,1
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
; miscare16:
; cmp counter_miscari,16
; jne miscare17
; mov ebx,eax
; sub ebx,76
; mov harta[ebx],5
	; mov spatiu_bomba,ebx
	; mov ebx,eax
	; add ebx,4
	; mov harta[ebx],7
	; mov harta[eax],2 ;botul plaseaza bombe din cand in cand dupa care se fereste
	; add coloana_bot,1
	; mov timer_bot,0
	; mov ok2,1
; mov counterok,0
; miscare17:
; cmp counter_miscari,17
; jne miscare18
; mov timer_bot,0
; miscare18:
; cmp counter_miscari,18
; jne miscare19
; mov timer_bot,0
; miscare19:
; cmp counter_miscari,19
; jne miscare20
; mov timer_bot,0
; miscare20:
; cmp counter_miscari,20
; jne miscare21
; mov ebx,eax
; sub ebx,4
; sub coloana_bot,1
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
; miscare21:
; cmp counter_miscari,21
; jne miscare22
; mov ebx,eax
; sub linie_bot,1
; sub ebx,76
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
; miscare22:
; cmp counter_miscari,22
; jne miscare23
; mov ebx,eax
; sub ebx,76
; mov harta[ebx],5
; mov spatiu_bomba,ebx
; mov ebx,eax
; add ebx,76
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
	; mov ok2,1
; mov counterok,0
; add linie_bot,1
; miscare23:
; cmp counter_miscari,23
; jne miscare24
; mov timer_bot,0
; miscare24:
; cmp counter_miscari,24
; jne miscare25
; mov timer_bot,0
; miscare25:
; cmp counter_miscari,25
; jne miscare26
; mov timer_bot,0
; miscare26:
; cmp counter_miscari,26
; jne miscare27
; mov ebx,eax
; sub ebx,76
; sub linie_bot,1
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
; miscare27:
; cmp counter_miscari,27
; jne miscare28
; sub linie_bot,1
; mov ebx,eax
; sub ebx,76
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
; miscare28:
; cmp counter_miscari,28
; jne miscare29
; mov ebx,eax
; sub linie_bot,1
; sub ebx,76
; mov harta[ebx],7
; mov harta[eax],2
; mov timer_bot,0
;miscare29:
;cmp counter_miscari,29
;jne miscare30
;mov ebx,eax
;sub linie_bot,1
;sub ebx,76
;mov harta[ebx],7
;mov harta[eax],2
;mov timer_bot,0
;miscare30:



;da:

sari:

final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start
