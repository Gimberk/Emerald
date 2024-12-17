section .multiboot
multiboot_header_start:
    dd 0xe85250d6                ; magic number
    dd 0                         ; protected mode code
    dd multiboot_header_end - multiboot_header_start ; header length

    ; checksum
    dd 0x100000000 - (0xe85250d6 + 0 + (multiboot_header_end - multiboot_header_start))

    ; required end tag
    db 0    ; type
    db 0    ; flags
    db 8    ; size
multiboot_header_end:

section .text
global _start

_start:
    mov esp, stack_top

    mov ebx, [eax + 4]      ; mods address
    mov ecx, [ebx + 4]      ; mods count

    mov edx, [ebx]
    mov esi, [ebx + 4]

    push edx        ; start address of the disk
    push esi        ; size of the disk

    extern kernel_main
    call kernel_main

_start.halt:
    cli
    hlt
    jmp _start.halt


section .bss
    ALIGN 16

stack_bottom:
    resb 16384 ; reserve 16 kib for the stack
stack_top: