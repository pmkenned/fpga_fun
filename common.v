`timescale 1ns / 1ps
`default_nettype none

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
    (x <= 1073741824) ? 30 : \
    (x <= 2147483648) ? 31 : -1
//    (x <= 4294967296) ? 32 : \

module ff_ar
#(
    parameter W=1,
    parameter RESET_VAL=0
)
(
    input wire clk,
    input wire rst,
    input wire [W-1:0] d,
    output reg [W-1:0] q
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            q <= RESET_VAL;
        end else begin
            q <= d;
        end
    end

endmodule

`define DIR_DOWN    0
`define DIR_UP      1

`define SHIFT_DIR_LEFT    0
`define SHIFT_DIR_RIGHT   1

module counter
#(
    parameter W=8,
    parameter START_VAL=0,
    parameter FINAL_VAL=127,
    parameter INC_VAL=1,
    parameter DIR=`DIR_UP
)
(
    input wire clk,
    input wire rst,
    input wire x,
    output wire [W-1:0] cnt
);

    wire [W-1:0] next_num;
    generate
        if (DIR == `DIR_UP) begin
            assign next_num = cnt + 'b1;
        end else begin
            assign next_num = cnt - 'b1;
        end
    endgenerate

    wire [W-1:0] cnt_n;
    assign cnt_n = (x) ? ((cnt == FINAL_VAL) ? START_VAL : next_num) : cnt;

    ff_ar #(.W(W), .RESET_VAL(START_VAL)) counter_ff(.clk(clk), .rst(rst), .d(cnt_n), .q(cnt));

endmodule

module shift_register
#(
    parameter W=8,
    parameter SHIFT_W=1,
    parameter RESET_VAL=0,
    parameter SHIFT_DIR=`SHIFT_DIR_LEFT
)
(
    input wire clk,
    input wire rst,
    input wire [SHIFT_W-1:0] d,
    output wire [W-1:0] q
);

    wire [W-1:0] q_n;
    generate
        if (SHIFT_DIR == `SHIFT_DIR_RIGHT) begin
            assign q_n = {d, q[W-1:SHIFT_W]};
        end else begin
            assign q_n = {q[W-1-SHIFT_W:0], d};
        end
    endgenerate

    ff_ar #(.W(W), .RESET_VAL(RESET_VAL)) shift_ff(.clk(clk), .rst(rst), .d(q_n), .q(q));

endmodule

