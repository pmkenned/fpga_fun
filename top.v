`timescale 1ns / 1ps
`default_nettype none

// TODO:
// * Fix VGA text timing
// * Add registers to hold line of text
// * Finish character set (lowercase, numbers, etc)
// * Add blinking cursor
// * Allow for backspace, enter, arrow keys, insert
// * Add attributes (background and foreground color)
// * Finish PS/2 support (two-way communication, etc.)
// * Add RS-232
// * Clean up file structure
//
// Terminology:
// * Interrupts (asynchronous): from hardware
// * System calls (i.e. software interrupts; synchronous): int instruction
// * Exceptions: illegal instruction, invalid memory access, etc.
//
// Questions:
// * Should peripherals write directly to memory? Or have internal buffers and
//   signal via interrupts that they have data?
// * How should hardware indicate interrupts?
// * How should memory requests be arbitrated?
// * How to map interrupts? IDT?
// * How are page faults implemented? TLB miss? L2 Miss?
// * How to implement multitasking?
//
// * CPU:
// * Physical addressing: segment registers?
// * ucode?
// * MMIO or PMIO
// * Virtual memory
// * Caches, TLB
// * User Mode, Kernel Mode
// * Interrupts (hardware, timer, etc.)
// * Exceptions (aka trap, fault)
// * Multi-cored, cache-coherency
// * Graphics accelerator

`define SYNTHESIS

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


`define ASCII_A             8'h41
`define ASCII_B             8'h42
`define ASCII_C             8'h43
`define ASCII_D             8'h44
`define ASCII_E             8'h45
`define ASCII_F             8'h46
`define ASCII_G             8'h47

// TODO: put these in a header file
`ifndef SHIFT_DIR_LEFT
`define SHIFT_DIR_LEFT    0
`define SHIFT_DIR_RIGHT   1
`endif

`ifndef SYNTHESIS

module top;

    wire clk;
    wire [17:0] addr;
    wire oe_l;
    wire we_l;
    wire [15:0] data1;
    wire ce1_l;
    wire ub1_l;
    wire lb1_l;
    wire [15:0] data2;
    wire ce2_l;
    wire ub2_l;
    wire lb2_l;
    wire [6:0] ss_abcdefg_l;
    wire ss_dp_l;
    wire [3:0] ss_sel_l;
    wire [7:0] sws;
    wire [3:0] btns;
    wire [7:0] leds;
    wire [2:0] vga_rgb;
    wire vga_hs_l;
    wire vga_vs_l;
    wire ps2_data;
    wire ps2_clk;
    wire rs232_rxd;
    wire rs232_txd;
    wire rs232_rxd_a;
    wire rs232_txd_a;

    testbench tb(
        .clk(clk),
        .addr(addr),
        .oe_l(oe_l),
        .we_l(we_l),
        .data1(data1),
        .ce1_l(ce1_l),
        .ub1_l(ub1_l),
        .lb1_l(lb1_l),
        .data2(data2),
        .ce2_l(ce2_l),
        .ub2_l(ub2_l),
        .lb2_l(lb2_l),
        .ss_abcdefg_l(ss_abcdefg_l),
        .ss_dp_l(ss_dp_l),
        .ss_sel_l(ss_sel_l),
        .sws(sws),
        .btns(btns),
        .leds(leds),
        .vga_rgb(vga_rgb),
        .vga_hs_l(vga_hs_l),
        .vga_vs_l(vga_vs_l),
        .ps2_data(ps2_data),
        .ps2_clk(ps2_clk),
        .rs232_rxd(rs232_rxd),
        .rs232_txd(rs232_txd),
        .rs232_rxd_a(rs232_rxd_a),
        .rs232_txd_a(rs232_txd_a)
    );

    design_under_test dut(
        .clk(clk),
        .addr(addr),
        .oe_l(oe_l),
        .we_l(we_l),
        .data1(data1),
        .ce1_l(ce1_l),
        .ub1_l(ub1_l),
        .lb1_l(lb1_l),
        .data2(data2),
        .ce2_l(ce2_l),
        .ub2_l(ub2_l),
        .lb2_l(lb2_l),
        .ss_abcdefg_l(ss_abcdefg_l),
        .ss_dp_l(ss_dp_l),
        .ss_sel_l(ss_sel_l),
        .sws(sws),
        .btns(btns),
        .leds(leds),
        .vga_rgb(vga_rgb),
        .vga_hs_l(vga_hs_l),
        .vga_vs_l(vga_vs_l),
        .ps2_data(ps2_data),
        .ps2_clk(ps2_clk),
        .rs232_rxd(rs232_rxd),
        .rs232_txd(rs232_txd),
        .rs232_rxd_a(rs232_rxd_a),
        .rs232_txd_a(rs232_txd_a)
    );

endmodule

module testbench (
    output reg clk,
    input wire [17:0] addr,
    input wire oe_l,
    input wire we_l,
    inout wire [15:0] data1,
    input wire ce1_l,
    input wire ub1_l,
    input wire lb1_l,
    inout wire [15:0] data2,
    input wire ce2_l,
    input wire ub2_l,
    input wire lb2_l,
    input wire [6:0] ss_abcdefg_l,
    input wire ss_dp_l,
    input wire [3:0] ss_sel_l,
    output wire [7:0] sws,
    output wire [3:0] btns,
    input wire [7:0] leds,
    input wire [2:0] vga_rgb,
    input wire vga_hs_l,
    input wire vga_vs_l,
    output reg ps2_data,
    output reg ps2_clk,
    output wire rs232_rxd,
    input wire rs232_txd,
    output wire rs232_rxd_a,
    input wire rs232_txd_a
);

    reg rst;
    assign btns[3] = rst;

    always begin
        #10 clk = ~clk;
    end

    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        #5;
        rst <= 1'b1;
        #5;
        rst <= 1'b0;
    end

    task ps2_generate_word(input [7:0] byte);

        begin

            // idle state
            @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= 1'b1;

            repeat(20) @(posedge clk);
            ps2_data <= 1'b0; // start bit

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= byte[0]; // bit[0]

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= byte[1]; // bit[1]

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= byte[2]; // bit[2]

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= byte[3]; // bit[3]

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= byte[4]; // bit[4]

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= byte[5]; // bit[5]

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= byte[6]; // bit[6]

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= byte[7]; // bit[7]

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= 1'b0; // parity (TODO)

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1;
            ps2_data <= 1'b1; // stop

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b0; // negedge ps2_clk

            repeat(20) @(posedge clk);
            ps2_clk  <= 1'b1; // idle

        end

    endtask

    initial begin
        //repeat(840000) @(posedge clk);

        ps2_generate_word(`SCAN_KEY_UP);
        ps2_generate_word(`SCAN_A);

        $finish;
    end

endmodule

`endif

`ifndef SYNTHESIS
module design_under_test(
`else
module top(
`endif
    input wire clk,
    output reg [17:0] addr,
    output reg oe_l,
    output reg we_l,
    inout wire [15:0] data1,
    output reg ce1_l,
    output reg ub1_l,
    output reg lb1_l,
    inout wire [15:0] data2,
    output reg ce2_l,
    output reg ub2_l,
    output reg lb2_l,
    output wire [6:0] ss_abcdefg_l,
    output wire ss_dp_l,
    output wire [3:0] ss_sel_l,
    input wire [7:0] sws,
    input wire [3:0] btns,
    output wire [7:0] leds,
    output wire [2:0] vga_rgb,
    output wire vga_hs_l,
    output wire vga_vs_l,
    //input wire ps2_data,
    //input wire ps2_clk,
    inout wire ps2_data,
    inout wire ps2_clk,
    input wire rs232_rxd,
    output wire rs232_txd,
    input wire rs232_rxd_a,
    output wire rs232_txd_a
);

    wire rst;
    assign rst = btns[3];

    // TODO: see if this can be made to be an array of modules
    //       use replaced with a generate statement
    wire [3:0] btns_q;
    wire [3:0] btns_pulse;
    ff_ar btn0_ff(.clk(clk), .rst(rst), .d(btns[0]), .q(btns_q[0]));
    ff_ar btn1_ff(.clk(clk), .rst(rst), .d(btns[1]), .q(btns_q[1]));
    ff_ar btn2_ff(.clk(clk), .rst(rst), .d(btns[2]), .q(btns_q[2]));
    ff_ar btn3_ff(.clk(clk), .rst(rst), .d(btns[3]), .q(btns_q[3]));
    assign btns_pulse[0] = (~btns_q[0] && btns[0]) ? 1'b1 : 1'b0;
    assign btns_pulse[1] = (~btns_q[1] && btns[1]) ? 1'b1 : 1'b0;
    assign btns_pulse[2] = (~btns_q[2] && btns[2]) ? 1'b1 : 1'b0;
    assign btns_pulse[3] = (~btns_q[3] && btns[3]) ? 1'b1 : 1'b0;

    //assign oe_l = 1'b1;
    //assign we_l = 1'b1;

    //assign ce1_l = 1'b1;
    //assign lb1_l = 1'b1;
    //assign ub1_l = 1'b1;

    //assign ce2_l = 1'b1;
    //assign lb2_l = 1'b1;
    //assign ub2_l = 1'b1;

    //assign addr = 18'h00000;
    wire [15:0] data1_out;
    wire [15:0] data2_out;
    assign data1 = (~ce1_l && ~we_l) ? data1_out : 16'bz;
    assign data2 = (~ce2_l && ~we_l) ? data2_out : 16'bz;

    assign rs232_txd = 1'b0;
    assign rs232_txd_a = 1'b0;
    
    //assign leds = 8'b00000000;

    wire [8:0] vga_row;
    wire [9:0] vga_col;
    wire vga_display;

    wire key_down;
    wire key_up;
    wire [7:0] scan_code;

    wire [7:0] scan_code_q;
    wire [7:0] scan_code_n;
    assign scan_code_n = (key_down || key_up) ? scan_code : scan_code_q;
    ff_ar #(.W(8)) scan_code_reg(.clk(clk), .rst(rst), .d(scan_code_n), .q(scan_code_q));

    wire [7:0] key_down_cnt_q;
    counter #(.W(8)) key_down_counter(.clk(clk), .rst(rst), .x(key_down), .cnt(key_down_cnt_q));
    wire [7:0] key_up_cnt_q;
    counter #(.W(8)) key_up_counter(.clk(clk), .rst(rst), .x(key_up), .cnt(key_up_cnt_q));

    assign leds = (sws[0]) ? scan_code_q : {key_down_cnt_q[3:0], key_up_cnt_q[3:0]};

    wire [17:0] vga_addr;
    wire vga_oe_l;
    wire vga_we_l;
    wire [15:0] vga_data1;
    wire vga_ce1_l;
    wire vga_ub1_l;
    wire vga_lb1_l;
    wire [15:0] vga_data2;
    wire vga_ce2_l;
    wire vga_ub2_l;
    wire vga_lb2_l;
    wire vga_done;

    wire sram_init_en;
    wire [7:0] sram_init_byte;
    wire [17:0] sram_init_addr;
    wire sram_init_we_l;
    wire [15:0] sram_init_data1;
    wire sram_init_ce1_l;
    wire sram_init_ub1_l;
    wire sram_init_lb1_l;
    wire [15:0] sram_init_data2;
    wire sram_init_ce2_l;
    wire sram_init_ub2_l;
    wire sram_init_lb2_l;
    wire sram_init_done;

    wire [7:0] ascii;
    // TODO: shift, caps lock, num lock
    scan_code_to_ascii sc2a(
        .scan_code(scan_code_q),
        .caps_lock(1'b0),
        .num_lock(1'b0),
        .shift(1'b1),
        .ascii(ascii)
    );

    assign sram_init_en = btns_pulse[0];
    assign sram_init_byte = sws[7:0]; // 8'h00; // ascii;

    wire key_down_q;
    ff_ar key_down_ff(.clk(clk), .rst(rst), .d(key_down), .q(key_down_q));

    assign data1_out = ~sram_init_done ? sram_init_data1 : {ascii, ascii};
    assign data2_out = ~sram_init_done ? sram_init_data2 : {ascii, ascii};

    // TODO: create byte-addressable interface
    //assign addr = addr_20[19:2]; 
    //assign ce2_l = ~addr_20[1];
    //assign ub1_l = ~addr_20[0];
    //assign lb1_l = addr_20[0];
    //assign ub2_l = ~addr_20[0];
    //assign lb2_l = addr_20[0];

    wire [19:0] addr_20;
    wire [6:0] char_col_cnt;
    wire [5:0] char_row_cnt;
    assign addr_20 = {7'b0, char_row_cnt, char_col_cnt};
    counter #(.W(7), .FINAL_VAL(79)) char_col_counter(.clk(clk), .rst(rst), .x(key_down_q), .cnt(char_col_cnt));
    counter #(.W(6), .FINAL_VAL(29)) char_row_counter(.clk(clk), .rst(rst), .x(key_down_q && (char_col_cnt == 79)), .cnt(char_row_cnt));

    always @(*) begin
        if (~sram_init_done) begin
            addr = sram_init_addr;
            oe_l = 1'b1;
            we_l = sram_init_we_l;
            ce1_l = sram_init_ce1_l;
            ub1_l = sram_init_ub1_l;
            lb1_l = sram_init_lb1_l;
            ce2_l = sram_init_ce2_l;
            ub2_l = sram_init_ub2_l;
            lb2_l = sram_init_lb2_l;
        end else if (key_down_q) begin
            addr = addr_20[19:2]; 
            oe_l = 1'b1;
            we_l = 1'b0;
            ce1_l = addr_20[1];
            ub1_l = addr_20[0];
            lb1_l = ~addr_20[0];
            ce2_l = ~addr_20[1];
            ub2_l = addr_20[0];
            lb2_l = ~addr_20[0];
            // addr = 'b0;
            // oe_l = 1'b1;
            // we_l = 1'b0;
            // ce1_l = 1'b0;
            // ub1_l = 1'b0;
            // lb1_l = 1'b1;
            // ce2_l = 1'b1;
            // ub2_l = 1'b1;
            // lb2_l = 1'b1;
        end else begin
            addr = vga_addr;
            oe_l = vga_oe_l;
            we_l = vga_we_l;
            ce1_l = vga_ce1_l;
            ub1_l = vga_ub1_l;
            lb1_l = vga_lb1_l;
            ce2_l = vga_ce2_l;
            ub2_l = vga_ub2_l;
            lb2_l = vga_lb2_l;
        end
    end

    assign vga_data1 = data1;
    assign vga_data2 = data2;

    sram_init si(
        .clk(clk),
        .rst(rst),
        .en(sram_init_en),
        .byte(sram_init_byte),
        .addr(sram_init_addr),
        .we_l(sram_init_we_l),
        .data1(sram_init_data1),
        .ce1_l(sram_init_ce1_l),
        .ub1_l(sram_init_ub1_l),
        .lb1_l(sram_init_lb1_l),
        .data2(sram_init_data2),
        .ce2_l(sram_init_ce2_l),
        .ub2_l(sram_init_ub2_l),
        .lb2_l(sram_init_lb2_l),
        .done(sram_init_done)
    );

    ps2_unit ps2(
        .ps2_data(ps2_data),
        .ps2_clk(ps2_clk),
        .clk(clk),
        .rst(rst),
        .key_down(key_down),
        .key_up(key_up),
        .scan_code(scan_code)
    );

    vga_text vt(
        .clk(clk),
        .rst(rst),
        .vga_col(vga_col),
        .vga_row(vga_row),
        .vga_display(vga_display),
        .vga_rgb(vga_rgb),
        .addr(vga_addr),
        .oe_l(vga_oe_l),
        .we_l(vga_we_l),
        .data1(vga_data1),
        .ce1_l(vga_ce1_l),
        .ub1_l(vga_ub1_l),
        .lb1_l(vga_lb1_l),
        .data2(vga_data2),
        .ce2_l(vga_ce2_l),
        .ub2_l(vga_ub2_l),
        .lb2_l(vga_lb2_l)
    );

    ss_driver ss_d(
        .clk(clk),
        .rst(rst),
        .hex_digit(sws[3:0]),
        .en(sws[7:4]),
        .ss_abcdefg_l(ss_abcdefg_l),
        .ss_dp_l(ss_dp_l),
        .ss_sel_l(ss_sel_l)
    );
    
    vga_driver vga_d(
        .clk(clk),
        .rst(rst),
        .vga_row(vga_row),
        .vga_col(vga_col),
        .vga_display(vga_display),
        .vga_hs_l(vga_hs_l),
        .vga_vs_l(vga_vs_l)
    );

endmodule

module hex_to_ss(
    input wire [3:0] hex,
    output reg [6:0] ss_abcdefg_l
);

    always @(hex) begin
        case (hex)
            4'h0: ss_abcdefg_l = 7'b0000001;
            4'h1: ss_abcdefg_l = 7'b1001111;
            4'h2: ss_abcdefg_l = 7'b0010010;
            4'h3: ss_abcdefg_l = 7'b0000110;
            4'h4: ss_abcdefg_l = 7'b1001100;
            4'h5: ss_abcdefg_l = 7'b0100100;
            4'h6: ss_abcdefg_l = 7'b0100000;
            4'h7: ss_abcdefg_l = 7'b0001111;
            4'h8: ss_abcdefg_l = 7'b0000000;
            4'h9: ss_abcdefg_l = 7'b0001100;
            4'ha: ss_abcdefg_l = 7'b0001000;
            4'hb: ss_abcdefg_l = 7'b1100000;
            4'hc: ss_abcdefg_l = 7'b0110001;
            4'hd: ss_abcdefg_l = 7'b1000010;
            4'he: ss_abcdefg_l = 7'b0110000;
            4'hf: ss_abcdefg_l = 7'b0111000;
            default: ss_abcdefg_l = 7'b1111111;
        endcase
    end

endmodule

module ss_driver(
    input wire clk,
    input wire rst,
    input wire [3:0] hex_digit,
    input wire [3:0] en,
    output reg [6:0] ss_abcdefg_l,
    output wire ss_dp_l,
    output wire [3:0] ss_sel_l
);

    reg [19:0] clk_cnt;
    wire clk_191Hz;
    assign clk_191Hz = clk_cnt[17];

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            clk_cnt <= 20'b0;
        end else begin
            clk_cnt <= clk_cnt + 20'b1;
        end
    end

    reg [3:0] cnt;
    wire [3:0] cnt_n;
    reg [3:0] hex_digits [3:0];
    wire [6:0] ss_array_l [3:0];

    assign cnt_n[1] = cnt[0];
    assign cnt_n[2] = cnt[1];
    assign cnt_n[3] = cnt[2];
    assign cnt_n[0] = cnt[3];
    
    assign ss_sel_l = ~cnt;

    always @(posedge clk_191Hz, posedge rst) begin
        if (rst) begin
            cnt <= 4'b1;
        end else begin
            cnt <= cnt_n;
        end
    end
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            hex_digits[0] <= 4'b0;
            hex_digits[1] <= 4'b0;
            hex_digits[2] <= 4'b0;
            hex_digits[3] <= 4'b0;
        end else begin
            if (en[0]) begin
                hex_digits[0] <= hex_digit;
            end
            if (en[1]) begin
                hex_digits[1] <= hex_digit;
            end
            if (en[2]) begin
                hex_digits[2] <= hex_digit;
            end
            if (en[3]) begin
                hex_digits[3] <= hex_digit;
            end
        end
    end
    
    always @(cnt, ss_array_l[0], ss_array_l[1], ss_array_l[2], ss_array_l[3]) begin
        case (cnt)
            4'b0001: ss_abcdefg_l = ss_array_l[0];
            4'b0010: ss_abcdefg_l = ss_array_l[1];
            4'b0100: ss_abcdefg_l = ss_array_l[2];
            4'b1000: ss_abcdefg_l = ss_array_l[3];
            default: ss_abcdefg_l = 7'b1111111;
        endcase
    end

    assign ss_dp_l = 1'b1;
    
    hex_to_ss hts0(.hex(hex_digits[0]), .ss_abcdefg_l(ss_array_l[0]));
    hex_to_ss hts1(.hex(hex_digits[1]), .ss_abcdefg_l(ss_array_l[1]));
    hex_to_ss hts2(.hex(hex_digits[2]), .ss_abcdefg_l(ss_array_l[2]));
    hex_to_ss hts3(.hex(hex_digits[3]), .ss_abcdefg_l(ss_array_l[3]));

endmodule

//`define TEST_VGA

`ifdef TEST_VGA

`define VGA_COLS 12
`define VGA_ROWS 10

`define VGA_HFP 5
`define VGA_HSP 10
`define VGA_HBP 8

`define VGA_VFP 5
`define VGA_VSP 2
`define VGA_VBP 8

`else

`define VGA_ROWS 480
`define VGA_COLS 640

`define VGA_HFP 16
`define VGA_HSP 96
`define VGA_HBP 48

`define VGA_VFP 11
`define VGA_VSP 2
`define VGA_VBP 31

`endif

`define VGA_HTOTAL (`VGA_COLS + `VGA_HFP + `VGA_HSP + `VGA_HBP)
`define VGA_VTOTAL (`VGA_ROWS + `VGA_VFP + `VGA_VSP + `VGA_VBP)

`define VGA_START_HS (`VGA_COLS + `VGA_HFP)
`define VGA_END_HS   (`VGA_COLS + `VGA_HFP + `VGA_HSP)
`define VGA_START_VS (`VGA_ROWS + `VGA_VFP)
`define VGA_END_VS   (`VGA_ROWS + `VGA_VFP + `VGA_VSP)

module vga_driver(
    input wire clk,
    input wire rst,
    output wire [8:0] vga_row,
    output wire [9:0] vga_col,
    output wire vga_display,
    output wire vga_hs_l,
    output wire vga_vs_l
);
    wire clk_25MHz;
    ff_ar clk_25MHz_ff(.clk(clk), .rst(rst), .d(~clk_25MHz), .q(clk_25MHz));
    
    wire [9:0] clk_cnt_q;
    wire [9:0] clk_cnt_n;
    wire [9:0] row_cnt_q;
    wire [9:0] row_cnt_n;
    
    assign clk_cnt_n = (clk_cnt_q == `VGA_HTOTAL-1) ? 10'b0 : clk_cnt_q + 10'b1;
    assign row_cnt_n = (row_cnt_q == `VGA_VTOTAL-1) ? 10'b0 : (clk_cnt_q == `VGA_HTOTAL-1) ? row_cnt_q + 10'b1 : row_cnt_q;

    ff_ar #(.W(11)) clk_cnt_ff(.clk(clk_25MHz), .rst(rst), .d(clk_cnt_n), .q(clk_cnt_q));
    ff_ar #(.W(11)) row_cnt_ff(.clk(clk_25MHz), .rst(rst), .d(row_cnt_n), .q(row_cnt_q));

    // outputs

    assign vga_display = ((clk_cnt_q < `VGA_COLS) && (row_cnt_q < `VGA_ROWS)) ? 1'b1 : 1'b0;
    assign vga_col = clk_cnt_q;
    assign vga_row = row_cnt_q[8:0];

    assign vga_hs_l = ((clk_cnt_q >= `VGA_START_HS) && (clk_cnt_q < `VGA_END_HS)) ? 1'b0 : 1'b1;
    assign vga_vs_l = ((row_cnt_q >= `VGA_START_VS) && (row_cnt_q < `VGA_END_VS)) ? 1'b0 : 1'b1;

endmodule


// TODO: context menu key
// TODO: print screen, scroll lock, pause
// TODO: media keys?

module ps2_unit(
    inout wire ps2_data,
    inout wire ps2_clk,
    input wire clk,
    input wire rst,
    output wire key_down,
    output wire key_up,
    output wire [7:0] scan_code
);

    wire [7:0] ps2_data_byte;
    wire ps2_odd_parity;
    wire ps2_packet_done;

    assign ps2_data = 1'bz;
    assign ps2_clk  = 1'bz;

    // TODO: ps2_transmitter

    ps2_receiver ps2_rx(
        .clk(clk),
        .rst(rst),
        .ps2_data(ps2_data),
        .ps2_clk(ps2_clk),
        .ps2_data_byte(ps2_data_byte),
        .ps2_odd_parity(ps2_odd_parity),
        .ps2_packet_done(ps2_packet_done)
    );

    ps2_parser ps2_p(
        .clk(clk),
        .rst(rst),
        .ps2_data_byte(ps2_data_byte),
        .ps2_odd_parity(ps2_odd_parity),
        .ps2_packet_done(ps2_packet_done),
        .key_down(key_down),
        .key_up(key_up),
        .scan_code(scan_code)
    );

endmodule

module ps2_receiver(
    input wire clk,
    input wire rst,
    input wire ps2_data,
    input wire ps2_clk,
    output wire [7:0] ps2_data_byte,
    output wire ps2_odd_parity,
    output wire ps2_packet_done
);

    // TODO: if necessary, may use shift register to get stable ps2_clk transition

    wire ps2_clk_stable;
    ff_ar #(.W(8)) ps2_clk_stable_ff(.clk(clk), .rst(rst), .d(~ps2_clk), .q(ps2_clk_stable));

    wire [9:0] ps2_data_reg_q; // don't store stop bit
    shift_register #(.W(10), .SHIFT_DIR(`SHIFT_DIR_RIGHT)) ps2_data_shift_reg(.clk(ps2_clk_stable), .rst(rst), .d(ps2_data), .q(ps2_data_reg_q));

    // NOTE: final value is 10 so that the stop bit cycle resets the counter to 0 to start over
    wire [3:0] ps2_clk_cnt_q;
    counter #(.W(4), .START_VAL(0), .FINAL_VAL(10)) ps2_clk_counter(.clk(ps2_clk_stable), .rst(rst), .x(1'b1), .cnt(ps2_clk_cnt_q));

    wire ps2_done_flag_q, ps2_done_flag_n;
    assign ps2_done_flag_n = (ps2_clk_cnt_q == 'd10) ? 1'b1 : 1'b0;
    ff_ar ps2_done_flag_ff(.clk(clk), .rst(rst), .d(ps2_done_flag_n), .q(ps2_done_flag_q));

    // outputs

    assign ps2_packet_done = (ps2_clk_cnt_q == 'd10 && ~ps2_done_flag_q);
    assign ps2_data_byte = ps2_data_reg_q[8:1];
    assign ps2_odd_parity = ps2_data_reg_q[9];

endmodule

module ps2_parser(
    input wire clk,
    input wire rst,
    input wire [7:0] ps2_data_byte,
    input wire ps2_odd_parity,
    input wire ps2_packet_done,
    output wire key_down,
    output wire key_up,
    output wire [7:0] scan_code
);

    // TODO: check parity bit

    wire prev_was_key_up_q;
    wire prev_was_key_up_n;
    assign prev_was_key_up_n = (ps2_packet_done) ? ((ps2_data_byte == `SCAN_KEY_UP) ? 1'b1 : 1'b0) : prev_was_key_up_q;
    ff_ar prev_was_key_up_ff(.clk(clk), .rst(rst), .d(prev_was_key_up_n), .q(prev_was_key_up_q));

    wire [7:0] byte1_q;
    wire [7:0] byte1_n;
    wire [7:0] byte2_q;
    wire [7:0] byte2_n;

    assign byte1_n = (ps2_packet_done && ~prev_was_key_up_q) ? ps2_data_byte : byte1_q;
    assign byte2_n = (ps2_packet_done && prev_was_key_up_q) ? ps2_data_byte : 8'b0;

    ff_ar #(.W(8)) byte_1_reg(.clk(clk), .rst(rst), .d(byte1_n), .q(byte1_q));
    ff_ar #(.W(8)) byte_2_reg(.clk(clk), .rst(rst), .d(byte2_n), .q(byte2_q));

    // outputs

    assign key_down = (ps2_packet_done && ~prev_was_key_up_q && ~prev_was_key_up_n) ? 1'b1 : 1'b0;
    assign key_up   = (ps2_packet_done && prev_was_key_up_q) ? 1'b1 : 1'b0;
    assign scan_code = ps2_data_byte;

endmodule

module scan_code_to_ascii(
    input wire [7:0] scan_code,
    input wire caps_lock,
    input wire num_lock,
    input wire shift,
    output reg [7:0] ascii
);

    wire upper;
    assign upper = (caps_lock ^ shift);

    always @(*) begin
        case (scan_code)
            `SCAN_0:        ascii = shift ? ")" : "0";
            `SCAN_1:        ascii = shift ? "!" : "1";
            `SCAN_2:        ascii = shift ? "@" : "2";
            `SCAN_3:        ascii = shift ? "#" : "3";
            `SCAN_4:        ascii = shift ? "$" : "4";
            `SCAN_5:        ascii = shift ? "%" : "5";
            `SCAN_6:        ascii = shift ? "^" : "6";
            `SCAN_7:        ascii = shift ? "&" : "7";
            `SCAN_8:        ascii = shift ? "*" : "8";
            `SCAN_9:        ascii = shift ? "(" : "9";
            `SCAN_MINUS:    ascii = shift ? "_" : "-";
            `SCAN_EQUAL:    ascii = shift ? "+" : "=";
            `SCAN_LBRACKET: ascii = shift ? "{" : "[";
            `SCAN_RBRACKET: ascii = shift ? "}" : "]";
            `SCAN_FSLASH:   ascii = shift ? "|" : "\\";
            `SCAN_SEMI:     ascii = shift ? ":" : ";";
            `SCAN_QUOTE:    ascii = shift ? "\"" : "'";
            `SCAN_COMMA:    ascii = shift ? "<" : ",";
            `SCAN_PERIOD:   ascii = shift ? ">" : ".";
            `SCAN_A:        ascii = upper ? "A" : "a";
            `SCAN_B:        ascii = upper ? "B" : "b";
            `SCAN_C:        ascii = upper ? "C" : "c";
            `SCAN_D:        ascii = upper ? "D" : "d";
            `SCAN_E:        ascii = upper ? "E" : "e";
            `SCAN_F:        ascii = upper ? "F" : "f";
            `SCAN_G:        ascii = upper ? "G" : "g";
            `SCAN_H:        ascii = upper ? "H" : "h";
            `SCAN_I:        ascii = upper ? "I" : "i";
            `SCAN_J:        ascii = upper ? "J" : "j";
            `SCAN_K:        ascii = upper ? "K" : "k";
            `SCAN_L:        ascii = upper ? "L" : "l";
            `SCAN_M:        ascii = upper ? "M" : "m";
            `SCAN_N:        ascii = upper ? "N" : "n";
            `SCAN_O:        ascii = upper ? "O" : "o";
            `SCAN_P:        ascii = upper ? "P" : "p";
            `SCAN_Q:        ascii = upper ? "Q" : "q";
            `SCAN_R:        ascii = upper ? "R" : "r";
            `SCAN_S:        ascii = upper ? "S" : "s";
            `SCAN_T:        ascii = upper ? "T" : "t";
            `SCAN_U:        ascii = upper ? "U" : "u";
            `SCAN_V:        ascii = upper ? "V" : "v";
            `SCAN_W:        ascii = upper ? "W" : "w";
            `SCAN_X:        ascii = upper ? "X" : "x";
            `SCAN_Y:        ascii = upper ? "Y" : "y";
            `SCAN_Z:        ascii = upper ? "Z" : "z";
            default:        ascii = 8'h00;
        endcase
    end

endmodule

module sram_init(
    input wire clk,
    input wire rst,
    input wire en,
    input wire [7:0] byte,
    output wire [17:0] addr,
    output wire we_l,
    output wire [15:0] data1,
    output wire ce1_l,
    output wire ub1_l,
    output wire lb1_l,
    output wire [15:0] data2,
    output wire ce2_l,
    output wire ub2_l,
    output wire lb2_l,
    output wire done
);

    wire [17:0] addr_n;
    wire done_n;
    wire done_q;

    assign done = (done_q && ~en);

    assign ce1_l = 1'b0;
    assign ub1_l = 1'b0;
    assign lb1_l = 1'b0;
    assign ce2_l = 1'b0;
    assign ub2_l = 1'b0;
    assign lb2_l = 1'b0;
    assign data1 = {byte, byte};
    assign data2 = {byte, byte};

    assign we_l = done;

    wire en_cnt;
    assign en_cnt = (en || ~done);

    counter #(.W(18), .FINAL_VAL(18'h3ffff)) addr_counter(.clk(clk), .rst(rst), .x(en_cnt), .cnt(addr));

    assign done_n = en ? 1'b0 : (done_q ? 1'b1 : (addr ==  18'h3ffff));
    ff_ar #(.RESET_VAL(1)) done_ff(.clk(clk), .rst(rst), .d(done_n), .q(done_q));

endmodule
