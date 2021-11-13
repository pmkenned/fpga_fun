`timescale 1ns / 1ps
`default_nettype none

`define SYNTHESIS

`define CLOG2(x) \
    (x <= 2) ? 1 : \
    (x <= 4) ? 2 : \
    (x <= 8) ? 3 : \
    (x <= 16) ? 4 : \
    (x <= 32) ? 5 : \
    (x <= 64) ? 6 : \
    (x <= 128) ? 7 : \
    (x <= 256) ? 8 : \
    (x <= 512) ? 9 : \
    (x <= 1024) ? 10 : \
    (x <= 2048) ? 11 : \
    (x <= 4096) ? 12 : \
    (x <= 8192) ? 13 : \
    (x <= 16384) ? 14 : \
    (x <= 32768) ? 15 : \
    (x <= 65536) ? 16 : \
    (x <= 131072) ? 17 : \
    (x <= 262144) ? 18 : \
    (x <= 524288) ? 19 : \
    (x <= 1048576) ? 20 : \
    (x <= 2097152) ? 21 : \
    (x <= 4194304) ? 22 : \
    (x <= 8388608) ? 23 : \
    (x <= 16777216) ? 24 : \
    (x <= 33554432) ? 25 : \
    (x <= 67108864) ? 26 : \
    (x <= 134217728) ? 27 : \
    (x <= 268435456) ? 28 : \
    (x <= 536870912) ? 29 : \
    (x <= 1073741824) ? 30 : 31
//    (x <= 2147483648) ? 31 : \
//    (x <= 4294967296) ? 32 : \

`define PROM_SIG    16'hf0a1

`define DIR_DOWN    0
`define DIR_UP      1

`define SHIFT_DIR_LEFT    0
`define SHIFT_DIR_RIGHT   1

// TODO: move to header file
`define SCAN_SET_LED        8'hed
`define SCAN_ACK            8'hfa
`define SCAN_ECHO           8'hee
`define SCAN_SET_RATE       8'hf3
`define SCAN_RESEND         8'hfe
`define SCAN_RESET          8'hff
`define SCAN_EXTENDED       8'he0
`define SCAN_EXTENDED_E1    8'he1
`define SCAN_KEY_UP         8'hf0

// Non-Extended
`define SCAN_ESC            8'h76
`define SCAN_F1             8'h05
`define SCAN_F2             8'h06
`define SCAN_F3             8'h04
`define SCAN_F4             8'h0c
`define SCAN_F5             8'h03
`define SCAN_F6             8'h0b
`define SCAN_F7             8'h83
`define SCAN_F8             8'h0a
`define SCAN_F9             8'h01
`define SCAN_F10            8'h09
`define SCAN_F11            8'h78
`define SCAN_F12            8'h07
`define SCAN_BACKTICK       8'h0e
`define SCAN_1              8'h16
`define SCAN_2              8'h1e
`define SCAN_3              8'h26
`define SCAN_4              8'h25
`define SCAN_5              8'h2e
`define SCAN_6              8'h36
`define SCAN_7              8'h3d
`define SCAN_8              8'h3e
`define SCAN_9              8'h46
`define SCAN_0              8'h45
`define SCAN_MINUS          8'h4e
`define SCAN_EQUAL          8'h55
`define SCAN_BACKSPACE      8'h66
`define SCAN_TAB            8'h0d
`define SCAN_Q              8'h15
`define SCAN_W              8'h1d
`define SCAN_E              8'h24
`define SCAN_R              8'h2d
`define SCAN_T              8'h2c
`define SCAN_Y              8'h35
`define SCAN_U              8'h3c
`define SCAN_I              8'h43
`define SCAN_O              8'h44
`define SCAN_P              8'h4d
`define SCAN_LBRACKET       8'h54
`define SCAN_RBRACKET       8'h5b
`define SCAN_BSLASH         8'h5d
`define SCAN_CAPS           8'h58
`define SCAN_A              8'h1c
`define SCAN_S              8'h1b
`define SCAN_D              8'h23
`define SCAN_F              8'h2b
`define SCAN_G              8'h34
`define SCAN_H              8'h33
`define SCAN_J              8'h3b
`define SCAN_K              8'h42
`define SCAN_L              8'h4b
`define SCAN_SEMI           8'h4c
`define SCAN_QUOTE          8'h52
`define SCAN_ENTER          8'h5a
`define SCAN_LSHIFT         8'h12
`define SCAN_Z              8'h1a
`define SCAN_X              8'h22
`define SCAN_C              8'h21
`define SCAN_V              8'h2a
`define SCAN_B              8'h32
`define SCAN_N              8'h31
`define SCAN_M              8'h3a
`define SCAN_COMMA          8'h41
`define SCAN_PERIOD         8'h49
`define SCAN_FSLASH         8'h4a
`define SCAN_RSHIFT         8'h59
`define SCAN_LCTRL          8'h14
`define SCAN_LALT           8'h11
`define SCAN_SPACE          8'h29
`define SCAN_PAD_NUM        8'h77
`define SCAN_PAD_TIMES      8'h7c
`define SCAN_PAD_MINUS      8'h7b
`define SCAN_PAD_7          8'h6c
`define SCAN_PAD_8          8'h75
`define SCAN_PAD_9          8'h7d
`define SCAN_PAD_4          8'h6b
`define SCAN_PAD_5          8'h73
`define SCAN_PAD_6          8'h74
`define SCAN_PAD_1          8'h69
`define SCAN_PAD_2          8'h72
`define SCAN_PAD_3          8'h7a
`define SCAN_PAD_0          8'h70
`define SCAN_PAD_PERIOD     8'h71
`define SCAN_PAD_PLUS       8'h79
`define SCAN_LWINDOWS       8'h8b
`define SCAN_RWINDOWS       8'h8c

// Extended
`define EX_SCAN_PAD_ENTER   8'h5a
`define EX_SCAN_PAD_FSLASH  8'h4a
`define EX_SCAN_RALT        8'h11
`define EX_SCAN_RCTRL       8'h14
`define EX_SCAN_INS         8'h70
`define EX_SCAN_DEL         8'h71
`define EX_SCAN_HOME        8'h6c
`define EX_SCAN_END         8'h69
`define EX_SCAN_PGUP        8'h7d
`define EX_SCAN_PGDN        8'h7a
`define EX_SCAN_UP          8'h75
`define EX_SCAN_RIGHT       8'h74
`define EX_SCAN_LEFT        8'h6b
`define EX_SCAN_DOWN        8'h72
