# TODO:

- Create program for outputting mem file for PROM
- Create program for creating vga_text.v from bmp, png
- Fix VGA text timing
- Add registers to hold line of text
- Finish character set (lowercase, numbers, etc)
- Add blinking cursor
- Allow for backspace, enter, arrow keys, insert
- Add attributes (background and foreground color)
- Finish PS/2 support (two-way communication, etc.)
- Add RS-232
- Clean up file structure

## Terminology:

- Interrupts (asynchronous): from hardware
- System calls (i.e. software interrupts; synchronous): int instruction
- Exceptions: illegal instruction, invalid memory access, etc.

## Questions:

- Should peripherals write directly to memory? Or have internal buffers and signal via interrupts that they have data?
- How should hardware indicate interrupts?
- How should memory requests be arbitrated?
- How to map interrupts? IDT?
- How are page faults implemented? TLB miss? L2 Miss?
- How to implement multitasking?

## CPU:

- Physical addressing: segment registers?
- ucode?
- MMIO or PMIO
- Virtual memory
- Caches, TLB
- User Mode, Kernel Mode
- Interrupts (hardware, timer, etc.)
- Exceptions (aka trap, fault)
- Multi-cored, cache-coherency
- Graphics accelerator
