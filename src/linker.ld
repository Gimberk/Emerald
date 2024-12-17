/*
Stupid linker that nobody likes, like bruv. Also, Samuel, if you ever read this, you're pretty cool. I finally got 
around to (that translates to: had enough courage and knowledge) making your OS. I called it emerald because I can. That's about it. Thanks, have a great life!
        - James Fleming, 12/12/2024
*/

OUTPUT_FORMAT(elf32-i386)
ENTRY(_start)

SECTIONS
{
    . = 0x00100000;
    .multiboot : { *(.multiboot) }

    .disk_image : { *(.disk_image) }

    .text : { *(.text) }
    .rodata : { *(.rodata) }
    .data : { *(.data) }
    .bss : {
        *(.bss)
        *(COMMON)
    }
}
