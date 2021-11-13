`include "defines.vh"

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
    wire prom_clk;
    wire prom_oe;
    wire prom_data;
    wire fd_index_l;
    wire fd_trk00_l;
    wire fd_wpt_l;
    wire fd_rdata_l;
    wire fd_dskchg_l;
    wire fd_redwc_l;
    wire fd_motea_l;
    wire fd_drvsb_l;
    wire fd_drvsa_l;
    wire fd_moteb_l;
    wire fd_dir_l;
    wire fd_step_l;
    wire fd_wdata_l;
    wire fd_wgate_l;
    wire fd_side1_l;

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
        .rs232_txd_a(rs232_txd_a),
        .prom_clk(prom_clk),
        .prom_oe(prom_oe),
        .prom_data(prom_data),
        .fd_index_l(fd_index_l),
        .fd_trk00_l(fd_trk00_l),
        .fd_wpt_l(fd_wpt_l),
        .fd_rdata_l(fd_rdata_l),
        .fd_dskchg_l(fd_dskchg_l),
        .fd_redwc_l(fd_redwc_l),
        .fd_motea_l(fd_motea_l),
        .fd_drvsb_l(fd_drvsb_l),
        .fd_drvsa_l(fd_drvsa_l),
        .fd_moteb_l(fd_moteb_l),
        .fd_dir_l(fd_dir_l),
        .fd_step_l(fd_step_l),
        .fd_wdata_l(fd_wdata_l),
        .fd_wgate_l(fd_wgate_l),
        .fd_side1_l(fd_side1_l)
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
        .rs232_txd_a(rs232_txd_a),
        .prom_clk(prom_clk),
        .prom_oe(prom_oe),
        .prom_data(prom_data),
        .fd_index_l(fd_index_l),
        .fd_trk00_l(fd_trk00_l),
        .fd_wpt_l(fd_wpt_l),
        .fd_rdata_l(fd_rdata_l),
        .fd_dskchg_l(fd_dskchg_l),
        .fd_redwc_l(fd_redwc_l),
        .fd_motea_l(fd_motea_l),
        .fd_drvsb_l(fd_drvsb_l),
        .fd_drvsa_l(fd_drvsa_l),
        .fd_moteb_l(fd_moteb_l),
        .fd_dir_l(fd_dir_l),
        .fd_step_l(fd_step_l),
        .fd_wdata_l(fd_wdata_l),
        .fd_wgate_l(fd_wgate_l),
        .fd_side1_l(fd_side1_l)
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
    input wire prom_clk,
    input wire prom_oe,
    output wire prom_data,
    input wire rs232_txd_a,
    output reg fd_index_l,
    output reg fd_trk00_l,
    output reg fd_wpt_l,
    output reg fd_rdata_l,
    output reg fd_dskchg_l,
    input wire fd_redwc_l,
    input wire fd_motea_l,
    input wire fd_drvsb_l,
    input wire fd_drvsa_l,
    input wire fd_moteb_l,
    input wire fd_dir_l,
    input wire fd_step_l,
    input wire fd_wdata_l,
    input wire fd_wgate_l,
    input wire fd_side1_l
);

    reg rst;
    assign btns[3] = rst;

    assign sws[7:0] = 'b00100000;

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

// TODO: use a function for the encoding part
    function [15:0] mfm_encode(input [7:0] byte, input is_marker);

        integer i;
        reg last_bit = 1'b0;

        begin
            mfm_encode[15] = ~last_bit && ~byte[7]; // clock bit
            for (i = 7; i > 0; i = i - 1) begin
                mfm_encode[i*2]   = byte[i];                  // data bit
                mfm_encode[i*2-1] = ~byte[i] && ~byte[i-1];   // clock bit
            end
            mfm_encode[0] = byte[0]; // last data bit
            last_bit = mfm_encode[0];

            // remove clock bits for address markers
            if (is_marker) begin
                if (byte == 8'hc2) mfm_encode[7] = 1'b0;
                if (byte == 8'ha1) mfm_encode[5] = 1'b0;
            end
        end

    endfunction

    task mfm_transmit(input [7:0] byte, input is_marker);

        integer i;
        reg [15:0] mfm_bits;
        reg last_bit = 1'b0;

        begin

            mfm_bits = mfm_encode(byte, is_marker);

            for (i = 15; i >= 0; i = i - 1) begin
                if (mfm_bits[i] == 'b1) begin
                    fd_rdata_l <= 'b0;
                end
                repeat(2) @(posedge clk);
                fd_rdata_l <= 1'b1;
                repeat(7) @(posedge clk);
            end

        end

    endtask

    task mfm_transmit_data(input [7:0] byte);
        mfm_transmit(byte, 0);
    endtask

    task mfm_transmit_marker(input [7:0] byte);
        mfm_transmit(byte, 1);
    endtask

    initial begin
        //repeat(840000) @(posedge clk);

        //ps2_generate_word(`SCAN_KEY_UP);
        //ps2_generate_word(`SCAN_A);

        fd_index_l <= 1'b1;
        fd_trk00_l <= 1'b1;
        fd_wpt_l <= 1'b1;
        fd_rdata_l <= 1'b1;
        fd_dskchg_l <= 1'b1;

        repeat(10) @(posedge clk);

        fd_index_l <= 1'b0;
        repeat(10) @(posedge clk);
        fd_index_l <= 1'b1;
        repeat(10) @(posedge clk);

        fd_index_l <= 1'b0;
        repeat(10) @(posedge clk);
        fd_index_l <= 1'b1;
        repeat(10) @(posedge clk);

        fd_index_l <= 1'b0;
        repeat(10) @(posedge clk);
        fd_index_l <= 1'b1;
        repeat(10) @(posedge clk);

//        fd_rdata_l <= 1'b1;
//        repeat(43) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(22) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(338) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(22) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(111) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(22) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(124) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(22) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(30) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(30) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(278) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(22) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(9969) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(22) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(22) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(23) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(136) @(posedge clk);
//        fd_rdata_l <= 1'b0;
//        repeat(22) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//        repeat(155) @(posedge clk);

        fd_rdata_l <= 1'b1;
        repeat(31) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(22) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(111) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(22) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(125) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(22) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(125) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(22) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(339) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(86) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(113) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(22) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(125) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(22) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(125) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(22) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(340) @(posedge clk);
        fd_rdata_l <= 1'b0;
        repeat(22) @(posedge clk);
        fd_rdata_l <= 1'b1;
        repeat(110) @(posedge clk);

//        mfm_transmit_data(8'h4e); // gap
//        repeat(4) mfm_transmit_data(8'h00); // sync
//        repeat(3) mfm_transmit_marker(8'hc2);
        @(posedge clk);

//        fd_rdata_l <= 1'b0;
//        repeat(2) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//
//        repeat(19) @(posedge clk);
//
//        fd_rdata_l <= 1'b0;
//        repeat(2) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//
//        repeat(28) @(posedge clk);
//
//        fd_rdata_l <= 1'b0;
//        repeat(2) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//
//        repeat(38) @(posedge clk);
//
//        fd_rdata_l <= 1'b0;
//        repeat(2) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//
//        repeat(19) @(posedge clk);
//
//        fd_rdata_l <= 1'b0;
//        repeat(2) @(posedge clk);
//        fd_rdata_l <= 1'b1;
//
//        repeat(38) @(posedge clk);

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
    output wire rs232_txd_a,
    output wire prom_clk,
    output wire prom_oe,
    input wire prom_data,

//    inout wire [1:40] gpio

    // fd inputs
    input wire fd_index_l,
    input wire fd_trk00_l,
    input wire fd_wpt_l,
    input wire fd_rdata_l,
    input wire fd_dskchg_l,

    // fd outputs
    output wire fd_redwc_l,
    output wire fd_motea_l,
    output wire fd_drvsb_l,
    output wire fd_drvsa_l,
    output wire fd_moteb_l,
    output wire fd_dir_l,
    output wire fd_step_l,
    output wire fd_wdata_l,
    output wire fd_wgate_l,
    output wire fd_side1_l
);

    wire rst;
    assign rst = btns[3];

//    wire fd_redwc_l;
//    wire fd_index_l;
//    wire fd_motea_l;
//    wire fd_drvsb_l;
//    wire fd_drvsa_l;
//    wire fd_moteb_l;
//    wire fd_dir_l;
//    wire fd_step_l;
//    wire fd_wdata_l;
//    wire fd_wgate_l;
//    wire fd_trk00_l;
//    wire fd_wpt_l;
//    wire fd_rdata_l;
//    wire fd_side1_l;
//    wire fd_dskchg_l;
//
//    // fd inputs
//    assign fd_index_l   = gpio[34];
//    assign fd_trk00_l   = gpio[25];
//    assign fd_wpt_l     = gpio[24];
//    assign fd_rdata_l   = gpio[23];
//    assign fd_dskchg_l  = gpio[21];
//
//    // fd outputs
//    assign gpio[35]     = fd_redwc_l;
//    assign gpio[33]     = fd_motea_l;
//    assign gpio[32]     = fd_drvsb_l;
//    assign gpio[31]     = fd_drvsa_l;
//    assign gpio[30]     = fd_moteb_l;
//    assign gpio[29]     = fd_dir_l;
//    assign gpio[28]     = fd_step_l;
//    assign gpio[27]     = fd_wdata_l;
//    assign gpio[26]     = fd_wgate_l;
//    assign gpio[22]     = fd_side1_l;

    assign fd_redwc_l   = 1'b0; // high-density
    assign fd_motea_l   = sws[0];
    assign fd_drvsb_l   = 1'b1;
    assign fd_drvsa_l   = sws[1];
    assign fd_moteb_l   = 1'b1;
    assign fd_dir_l     = sws[3];
    assign fd_step_l    = sws[2];
    assign fd_wdata_l   = 1'b1;
    assign fd_wgate_l   = 1'b1;
    assign fd_side1_l   = 1'b1;

    assign leds[6:5] = 1'b0;
    assign leds[4] = ~fd_rdata_l;
    assign leds[3] = ~fd_wpt_l;
    assign leds[2] = ~fd_trk00_l;
    assign leds[1] = ~fd_dskchg_l;
    assign leds[0] = ~fd_index_l;

//    reg [7:0] leds_reg;
//    assign leds = leds_reg;
//    wire [63:0] fd_data_q;
//    always @(*) begin
//        case (sws[7:5])
//            'b000: leds_reg[7:0] = fd_data_q[7:0];
//            'b001: leds_reg[7:0] = fd_data_q[15:8];
//            'b010: leds_reg[7:0] = fd_data_q[23:16];
//            'b011: leds_reg[7:0] = fd_data_q[31:24];
//            'b100: leds_reg[7:0] = fd_data_q[39:32];
//            'b101: leds_reg[7:0] = fd_data_q[47:40];
//            'b110: leds_reg[7:0] = fd_data_q[55:48];
//            'b111: leds_reg[7:0] = fd_data_q[63:56];
//        endcase
//    end

    //wire [4:0] clk_cnt;
    //wire clk_1MHz;
    //assign clk_1MHz = clk_cnt[4];
    //counter #(.W(5)) clk_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(1'b1), .cnt(clk_cnt));

    // index latch and pulse
    wire fd_index_q;
    ff_ar fd_index_ff(.clk(clk), .rst(rst), .d(fd_index_l), .q(fd_index_q));

    wire fd_index_down_pulse, fd_index_up_pulse;
    assign fd_index_down_pulse = (~fd_index_l && fd_index_q) ? 1'b1 : 1'b0;
    assign fd_index_up_pulse   = (fd_index_l && ~fd_index_q) ? 1'b1 : 1'b0;

    wire [3:0] index_cnt;
    counter #(.W(4)) index_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(fd_index_up_pulse), .cnt(index_cnt));

    wire seen_index_q, seen_index_n;
    assign seen_index_n = seen_index_q ? 1'b1 : index_cnt >= 'd3;
    ff_ar seen_index_ff(.clk(clk), .rst(rst), .d(seen_index_n), .q(seen_index_q));

    // read data latch and pulse
    wire fd_rdata_q, fd_rdata2_q, fd_rdata3_q;
    ff_ar fd_rdata_ff(.clk(clk), .rst(rst), .d(fd_rdata_l), .q(fd_rdata_q));
    ff_ar fd_rdata2_ff(.clk(clk), .rst(rst), .d(fd_rdata_q), .q(fd_rdata2_q));
    ff_ar fd_rdata3_ff(.clk(clk), .rst(rst), .d(fd_rdata2_q), .q(fd_rdata3_q));

    wire fd_rdata_down_pulse, fd_rdata_up_pulse;
    assign fd_rdata_down_pulse = (~fd_rdata2_q && fd_rdata3_q) ? 1'b1 : 1'b0;
    assign fd_rdata_up_pulse   = (fd_rdata2_q && ~fd_rdata3_q) ? 1'b1 : 1'b0;

    wire seen_data_q, seen_data_n;
    assign seen_data_n = seen_data_q ? 1'b1 : (~fd_rdata2_q && seen_index_q);
    ff_ar seen_data_ff(.clk(clk), .rst(rst), .d(seen_data_n), .q(seen_data_q));

    // typical number of cycles between rdata negedges: 190
`ifdef SYNTHESIS
    `define MAX_RDATA_CLKS 100
`else
    `define MAX_RDATA_CLKS 10
`endif
    // count clock cycles since last rdata down pulse, reset after MAX_RDATA_CLKS
    //wire [9:0] rdata_cnt;
    //counter #(.W(16), .FINAL_VAL(`MAX_RDATA_CLKS)) rdata_counter(.clk(clk), .rst(rst), .clr(fd_rdata_down_pulse), .x(1'b1), .cnt(rdata_cnt));

    wire rdata_clk_cnt_clear;
    assign rdata_clk_cnt_clear = fd_rdata_down_pulse && seen_index_q;

    wire [2:0] clear_cnt;
    counter #(.W(3)) clear_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(rdata_clk_cnt_clear || clear_cnt != 0), .cnt(clear_cnt));

    wire [15:0] rdata_clk_cnt;
    counter #(.W(16), .SATURATE(1)) rdata_clk_counter(.clk(clk), .rst(rst), .clr(rdata_clk_cnt_clear), .x(seen_index_q), .cnt(rdata_clk_cnt));

    wire [15:0] rdata_clk_cnt_reg;
    ff_ar #(.W(16)) rdata_clk_cnt_ff(.clk(clk), .rst(rst), .d(rdata_clk_cnt_clear ? rdata_clk_cnt : rdata_clk_cnt_reg), .q(rdata_clk_cnt_reg));

    wire [15:0] rdata_cnt_cnt;
    counter #(.W(16), .SATURATE(1)) rdata_cnt_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(rdata_clk_cnt_clear), .cnt(rdata_cnt_cnt));

//    // count number of bits shifted into data register
//    wire [4:0] rdata_bit_cnt;
//    counter #(.W(5)) rdata_bit_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(seen_data_n && rdata_cnt == 'b0 && rdata_bit_cnt < 16), .cnt(rdata_bit_cnt));
//
//    // hold bits from rdata line
//    wire [15:0] fd_data_q;
//    shift_register #(.W(16)) fd_data_shift_reg(.clk(clk), .rst(rst), .en(rdata_cnt == 'b0 && rdata_bit_cnt < 16), .d(~fd_rdata_l), .q(fd_data_q));
//
//    wire index_addr_mark_c2, id_addr_mark_a1;
//    assign index_addr_mark_c2 = fd_data_q == 'b0101001000100100 ? 'b1 : 'b0;
//    assign id_addr_mark_a1    = fd_data_q == 'b0100010010001001 ? 'b1 : 'b0;
//
//    wire [7:0] c2_cnt;
//    counter #(.W(8)) c2_counter(.clk(clk), .rst(rst), .clr(fd_index_up_pulse), .x(rdata_cnt == 'b0 && index_addr_mark_c2), .cnt(c2_cnt));



//    wire [19:0] fd_index_down_q;
//    ff_ar #(.W(20)) fd_index_down_reg(.clk(clk), .rst(rst), .d(fd_index_up_pulse ? fd_index_down_cnt : fd_index_down_q), .q(fd_index_down_q));

//    wire seen_index_q;
//    wire seen_index_n;
//    assign seen_index_n = seen_index_q ? 1'b1 : (~fd_index_l);
//    ff_ar seen_index_ff(.clk(clk_1MHz), .rst(rst), .d(seen_index_n), .q(seen_index_q));
//
//    wire seen_data_q;
//    wire seen_data_n;
//    assign seen_data_n = seen_data_q ? 1'b1 : (~fd_rdata_l && seen_index_q);
//    ff_ar seen_data_ff(.clk(clk_1MHz), .rst(rst), .d(seen_data_n), .q(seen_data_q));
//
//    wire [5:0] clks_after_data;
//    counter #(.W(5)) clk_data_counter(.clk(clk_1MHz), .rst(rst), .clr(1'b0), .x(seen_data_q), .cnt(clks_after_data));
//    wire clks_lt_32_n;
//    wire clks_lt_32_q;
//    assign clks_lt_32_n = ~clks_after_data[5] && ~clks_lt_32_q;
//    ff_ar clks_lt_32_ff(.clk(clk_1MHz), .rst(rst), .d(clks_lt_32_n), .q(clks_lt_32_q));

//    shift_register #(.W(64)) fd_data_shift_reg(.clk(clk_1MHz), .rst(rst), .en(seen_data_n && clks_lt_32_n), .d(fd_rdata_l), .q(fd_data_q));

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

    assign prom_clk = 1'bz;
    assign prom_oe = 1'bz;

// START PROM
//    wire seen_sig;
//    wire seen_sig_n;
//    wire [7:0] prom_bit_cnt;
//    wire [15:0] prom_num_bytes;
//    wire [15:0] prom_num_bytes_n;
//    wire [15:0] prom_reg;
//
//    assign prom_num_bytes_n = (prom_bit_cnt == 15) ? prom_reg : prom_num_bytes;
//
//    assign prom_oe = 1'b1;
//    assign leds = prom_reg[7:0];
//    shift_register #(.W(16)) prom_shift_reg(.clk(prom_clk), .rst(rst), .en(1'b1), .d(prom_data), .q(prom_reg));
//    wire [28:0] prom_clk_cnt;
//    assign prom_clk = prom_clk_cnt[24];
//
//    counter #(.W(29)) prom_clk_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(1'b1), .cnt(prom_clk_cnt));
//
//    counter #(.W(8)) prom_bit_counter(.clk(prom_clk), .rst(rst), .clr(1'b0), .x(seen_sig), .cnt(prom_bit_cnt));
//
//    assign seen_sig_n = seen_sig ? 1'b1 : (prom_reg == `PROM_SIG);
//
//    ff_ar seen_sig_ff(.clk(prom_clk), .rst(rst), .d(seen_sig_n), .q(seen_sig));
//
//    ff_ar #(.W(16)) prom_num_bytes_reg(.clk(prom_clk), .rst(rst), .d(prom_num_bytes_n), .q(prom_num_bytes));
// END PROM

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

    //assign rs232_txd = 1'b0;
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
    counter #(.W(8)) key_down_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(key_down), .cnt(key_down_cnt_q));
    wire [7:0] key_up_cnt_q;
    counter #(.W(8)) key_up_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(key_up), .cnt(key_up_cnt_q));

    //assign leds = (sws[0]) ? scan_code_q : {key_down_cnt_q[3:0], key_up_cnt_q[3:0]};

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

    // TODO: convert 4 hex digits to ascii characters and store in SRAM
    wire [7:0] hex_ascii [0:3];
    hex_to_ascii h2a0(.hex(rdata_clk_cnt_reg[15:12]), .ascii(hex_ascii[0]));
    hex_to_ascii h2a1(.hex(rdata_clk_cnt_reg[11:8]),  .ascii(hex_ascii[1]));
    hex_to_ascii h2a2(.hex(rdata_clk_cnt_reg[7:4]),   .ascii(hex_ascii[2]));
    hex_to_ascii h2a3(.hex(rdata_clk_cnt_reg[3:0]),   .ascii(hex_ascii[3]));
    //hex_to_ascii h2a0(.hex('d0), .ascii(hex_ascii[0]));
    //hex_to_ascii h2a1(.hex('d1), .ascii(hex_ascii[1]));
    //hex_to_ascii h2a2(.hex('d2), .ascii(hex_ascii[2]));
    //hex_to_ascii h2a3(.hex('d3), .ascii(hex_ascii[3]));

    assign sram_init_en = btns_pulse[0];
    assign sram_init_byte = sws[7:0]; // 8'h00; // ascii;

    wire key_down_q;
    ff_ar key_down_ff(.clk(clk), .rst(rst), .d(key_down), .q(key_down_q));

    //assign data1_out = ~sram_init_done ? sram_init_data1 : {ascii, ascii};
    //assign data2_out = ~sram_init_done ? sram_init_data2 : {ascii, ascii};
    assign data1_out = ~sram_init_done ? sram_init_data1 : {hex_ascii[0], hex_ascii[1]};
    assign data2_out = ~sram_init_done ? sram_init_data2 : {hex_ascii[2], hex_ascii[3]};
    //assign data1_out = ~sram_init_done ? sram_init_data1 : {prom_reg[15:8], prom_reg[7:0]};
    //assign data2_out = ~sram_init_done ? sram_init_data2 : {prom_reg[15:8], prom_reg[7:0]};

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
    counter #(.W(7), .FINAL_VAL(79)) char_col_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(key_down_q), .cnt(char_col_cnt));
    counter #(.W(6), .FINAL_VAL(29)) char_row_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(key_down_q && (char_col_cnt == 79)), .cnt(char_row_cnt));

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
//        end else if (prom_bit_cnt == 31) begin
//            addr = 'b0;
//            oe_l = 1'b1;
//            we_l = 1'b0;
//            ce1_l = 1'b0;
//            ub1_l = 1'b0;
//            lb1_l = 1'b0;
//            ce2_l = 1'b1;
//            ub2_l = 1'b1;
//            lb2_l = 1'b1;
//        end else if (prom_bit_cnt == 47) begin
//            addr = 'b0;
//            oe_l = 1'b1;
//            we_l = 1'b0;
//            ce1_l = 1'b1;
//            ub1_l = 1'b1;
//            lb1_l = 1'b1;
//            ce2_l = 1'b0;
//            ub2_l = 1'b0;
//            lb2_l = 1'b0;
        end else if (rdata_clk_cnt_clear || clear_cnt != 0) begin
            addr = {2'b0, rdata_cnt_cnt[15:0]};
            oe_l = 1'b1;
            we_l = 1'b0;
            ce1_l = clear_cnt[2];
            ub1_l = clear_cnt[1];
            lb1_l = ~clear_cnt[1];
            ce2_l = ~clear_cnt[2];
            ub2_l = clear_cnt[1];
            lb2_l = ~clear_cnt[1];
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

    wire xmodem_done;
    wire xmodem_saw_valid_block;
    wire xmodem_saw_invalid_block;
    wire xmodem_receiving_repeat_block;
    wire xmodem_saw_valid_msg_byte;
    wire [7:0] xmodem_data_byte;
    wire tx;
    wire xmodem_start;
    wire rx_pin;

    assign xmodem_start = btns_pulse[1];

    assign rx_pin = rs232_rxd;
    assign rs232_txd = tx;

    wire xmodem_done_q;
    ff_ar xmodem_done_ff(.clk(clk), .rst(rst), .d(xmodem_done ? 1'b1 : xmodem_done_q), .q(xmodem_done_q));
    assign leds[7] = xmodem_done_q;

    xmodem xm(
        .xmodem_done(xmodem_done),
        .xmodem_saw_valid_block(xmodem_saw_valid_block),
        .xmodem_saw_invalid_block(xmodem_saw_invalid_block),
        .xmodem_receiving_repeat_block(xmodem_receiving_repeat_block),
        .xmodem_saw_valid_msg_byte(xmodem_saw_valid_msg_byte),
        .xmodem_data_byte(xmodem_data_byte),
        .tx(tx),
        .start(xmodem_start),
        .rx_pin(rx_pin),
        .clk(clk),
        .rst(rst)
    );

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

    ss_driver_4digits ss_d(
        .clk(clk),
        .rst(rst),
        //.hex_digits({fd_index_down_cnt[19:12], fd_rdata_down_cnt[7:0]}),
        //.hex_digits(fd_rdata2_down_cnt[15:0]),
        //.hex_digits(sws[7] ? index_to_data_cnt[19:4] : index_to_data_cnt[15:0]),
        //.hex_digits(clks_first_n_data_cnt[15:0]),
        //.hex_digits(fd_data_q),
        .hex_digits('b0),
        .ss_abcdefg_l(ss_abcdefg_l),
        .ss_dp_l(ss_dp_l),
        .ss_sel_l(ss_sel_l)
    );

//    ss_driver ss_d(
//        .clk(clk),
//        .rst(rst),
//        //.hex_digit(sws[3:0]),
//        //.hex_digit(prom_clk_cnt[27:24]),
//        //.hex_digit(prom_num_bytes[7:0]),
//        .hex_digit(fd_index_cnt),
//        //.en(sws[7:4]),
//        .en(4'h8),
//        .ss_abcdefg_l(ss_abcdefg_l),
//        .ss_dp_l(ss_dp_l),
//        .ss_sel_l(ss_sel_l)
//    );

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

module ss_driver_4digits(
    input wire clk,
    input wire rst,
    input wire [15:0] hex_digits,
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

    hex_to_ss hts0(.hex(hex_digits[3:0]),   .ss_abcdefg_l(ss_array_l[0]));
    hex_to_ss hts1(.hex(hex_digits[7:4]),   .ss_abcdefg_l(ss_array_l[1]));
    hex_to_ss hts2(.hex(hex_digits[11:8]),  .ss_abcdefg_l(ss_array_l[2]));
    hex_to_ss hts3(.hex(hex_digits[15:12]), .ss_abcdefg_l(ss_array_l[3]));

endmodule

//module ss_driver(
//    input wire clk,
//    input wire rst,
//    input wire [3:0] hex_digit,
//    input wire [3:0] en,
//    output reg [6:0] ss_abcdefg_l,
//    output wire ss_dp_l,
//    output wire [3:0] ss_sel_l
//);
//
//    reg [19:0] clk_cnt;
//    wire clk_191Hz;
//    assign clk_191Hz = clk_cnt[17];
//
//    always @(posedge clk, posedge rst) begin
//        if (rst) begin
//            clk_cnt <= 20'b0;
//        end else begin
//            clk_cnt <= clk_cnt + 20'b1;
//        end
//    end
//
//    reg [3:0] cnt;
//    wire [3:0] cnt_n;
//    reg [3:0] hex_digits [3:0];
//    wire [6:0] ss_array_l [3:0];
//
//    assign cnt_n[1] = cnt[0];
//    assign cnt_n[2] = cnt[1];
//    assign cnt_n[3] = cnt[2];
//    assign cnt_n[0] = cnt[3];
//
//    assign ss_sel_l = ~cnt;
//
//    always @(posedge clk_191Hz, posedge rst) begin
//        if (rst) begin
//            cnt <= 4'b1;
//        end else begin
//            cnt <= cnt_n;
//        end
//    end
//
//    always @(posedge clk, posedge rst) begin
//        if (rst) begin
//            hex_digits[0] <= 4'b0;
//            hex_digits[1] <= 4'b0;
//            hex_digits[2] <= 4'b0;
//            hex_digits[3] <= 4'b0;
//        end else begin
//            if (en[0]) begin
//                hex_digits[0] <= hex_digit;
//            end
//            if (en[1]) begin
//                hex_digits[1] <= hex_digit;
//            end
//            if (en[2]) begin
//                hex_digits[2] <= hex_digit;
//            end
//            if (en[3]) begin
//                hex_digits[3] <= hex_digit;
//            end
//        end
//    end
//
//    always @(cnt, ss_array_l[0], ss_array_l[1], ss_array_l[2], ss_array_l[3]) begin
//        case (cnt)
//            4'b0001: ss_abcdefg_l = ss_array_l[0];
//            4'b0010: ss_abcdefg_l = ss_array_l[1];
//            4'b0100: ss_abcdefg_l = ss_array_l[2];
//            4'b1000: ss_abcdefg_l = ss_array_l[3];
//            default: ss_abcdefg_l = 7'b1111111;
//        endcase
//    end
//
//    assign ss_dp_l = 1'b1;
//
//    hex_to_ss hts0(.hex(hex_digits[0]), .ss_abcdefg_l(ss_array_l[0]));
//    hex_to_ss hts1(.hex(hex_digits[1]), .ss_abcdefg_l(ss_array_l[1]));
//    hex_to_ss hts2(.hex(hex_digits[2]), .ss_abcdefg_l(ss_array_l[2]));
//    hex_to_ss hts3(.hex(hex_digits[3]), .ss_abcdefg_l(ss_array_l[3]));
//
//endmodule

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

    // TODO: should these widths be only 10?
    ff_ar #(.W(10)) clk_cnt_ff(.clk(clk_25MHz), .rst(rst), .d(clk_cnt_n), .q(clk_cnt_q));
    ff_ar #(.W(10)) row_cnt_ff(.clk(clk_25MHz), .rst(rst), .d(row_cnt_n), .q(row_cnt_q));

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
    ff_ar ps2_clk_stable_ff(.clk(clk), .rst(rst), .d(~ps2_clk), .q(ps2_clk_stable));

    wire [9:0] ps2_data_reg_q; // don't store stop bit
    shift_register #(.W(10), .SHIFT_DIR(`SHIFT_DIR_RIGHT)) ps2_data_shift_reg(.clk(ps2_clk_stable), .rst(rst), .en(1'b1), .d(ps2_data), .q(ps2_data_reg_q));

    // NOTE: final value is 10 so that the stop bit cycle resets the counter to 0 to start over
    wire [3:0] ps2_clk_cnt_q;
    counter #(.W(4), .START_VAL(0), .FINAL_VAL(10)) ps2_clk_counter(.clk(ps2_clk_stable), .rst(rst), .clr(1'b0), .x(1'b1), .cnt(ps2_clk_cnt_q));

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

module hex_to_ascii(
    input wire [3:0] hex,
    output reg [7:0] ascii
);

    always @(*) begin
        case (hex)
            4'h0: ascii = "0";
            4'h1: ascii = "1";
            4'h2: ascii = "2";
            4'h3: ascii = "3";
            4'h4: ascii = "4";
            4'h5: ascii = "5";
            4'h6: ascii = "6";
            4'h7: ascii = "7";
            4'h8: ascii = "8";
            4'h9: ascii = "9";
            4'ha: ascii = "a";
            4'hb: ascii = "b";
            4'hc: ascii = "c";
            4'hd: ascii = "d";
            4'he: ascii = "e";
            4'hf: ascii = "f";
            default: ascii = " ";
        endcase
    end

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
            `SCAN_BSLASH:   ascii = shift ? "|" : "\\";
            `SCAN_FSLASH:   ascii = shift ? "/" : "?";
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

    counter #(.W(18), .FINAL_VAL(18'h3ffff)) addr_counter(.clk(clk), .rst(rst), .clr(1'b0), .x(en_cnt), .cnt(addr));

    assign done_n = en ? 1'b0 : (done_q ? 1'b1 : (addr ==  18'h3ffff));
    ff_ar #(.RESET_VAL(1)) done_ff(.clk(clk), .rst(rst), .d(done_n), .q(done_q));

endmodule
