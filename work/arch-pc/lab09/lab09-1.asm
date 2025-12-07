%include 'in_out.asm'
SECTION .data
msg: DB 'Введите x: ',0
result: DB 'f(g(x)) = 2*(3x-1)+7 = 6x+5 = ',0
SECTION .bss
x: RESB 80
res: RESB 80
SECTION .text
GLOBAL _start
_start:
;------------------------------------------
; Основная программа
;------------------------------------------
mov eax, msg
call sprint        ; Вывод "Введите x: "
mov ecx, x
mov edx, 80
call sread         ; Чтение x с клавиатуры
mov eax, x
call atoi          ; Преобразование строки в число (eax = x)
call _calcul       ; Вызов главной подпрограммы
mov eax, result
call sprint        ; Вывод сообщения о результате
mov eax, [res]
call iprintLF      ; Вывод результата
call quit          ; Завершение программы

;------------------------------------------
; Подпрограмма вычисления g(x) = 3x - 1
; Вход:  eax = x
; Выход: eax = 3x - 1
;------------------------------------------
_subcalcul:
    mov ebx, 3      ; ebx = 3
    mul ebx         ; eax = 3*x
    sub eax, 1      ; eax = 3x - 1
    ret             ; Возврат значения g(x)

;------------------------------------------
; Главная подпрограмма вычисления f(g(x))
; f(x) = 2x + 7
; g(x) = 3x - 1
; Итого: f(g(x)) = 2*(3x-1) + 7 = 6x + 5
; Вход:  eax = x
; Выход: результат сохраняется в [res]
;------------------------------------------
_calcul:
    ; Вычисляем g(x) = 3x - 1
    call _subcalcul ; eax = g(x) = 3x - 1
    
    ; Вычисляем f(g(x)) = 2*(3x-1) + 7
    mov ebx, 2      ; ebx = 2
    mul ebx         ; eax = 2 * (3x - 1) = 6x - 2
    add eax, 7      ; eax = (6x - 2) + 7 = 6x + 5
    
    ; Сохраняем результат
    mov [res], eax  ; res = 6x + 5
    ret             ; Возврат в основную программу
