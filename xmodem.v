`include "defines.vh"

`define CLK_FREQ 50_000_000
`ifdef SYNTHESIS
    `define XM_CYC_PER_BIT     9'd434 // TODO: define in terms of CLK_FREQ and BAUD
`else
    `define XM_CYC_PER_BIT     9'd20 // TODO: define in terms of CLK_FREQ and BAUD
`endif

`define XM_NUM_SAMPLES     4'd10
`define XM_MAX_RETRY       4'd10
`define XM_NUM_CYC_TIMEOUT (10*`CLK_FREQ)

`define SOH 8'h01
`define EOT 8'h04

`define ACK 8'h06
`define NAK 8'h15

`define SA 'd0
`define SB 'd1
`define SC 'd2
`define SD 'd3
`define SE 'd4
`define SF 'd5
`define SX 'dx

module xmodem(
    output wire xmodem_done,
    output wire xmodem_saw_valid_block,
    output wire xmodem_saw_invalid_block,
    output wire xmodem_receiving_repeat_block,
    output wire xmodem_saw_valid_msg_byte,
    output wire [7:0] xmodem_data_byte,
    output wire tx,
    input wire start,
    input wire rx_pin,
    input wire clk, rst
);

    wire saw_valid_msg_byte;
    wire saw_valid_block, saw_invalid_block;
    wire repeat_block;
    wire [7:0] data_byte;

    assign xmodem_saw_valid_msg_byte = saw_valid_msg_byte;
    assign xmodem_saw_valid_block = saw_valid_block;
    assign xmodem_saw_invalid_block = saw_invalid_block;
    assign xmodem_data_byte = data_byte;
    assign xmodem_receiving_repeat_block = repeat_block;

    wire rx_q, rx;
    // handle metastability
    ff_ar #(1,1'b1) rx_ff1(.q(rx_q), .d(rx_pin), .clk(clk), .rst(rst));
    ff_ar #(1,1'b1) rx_ff2(.q(rx), .d(rx_q), .clk(clk), .rst(rst));

    wire send_ACK;
    wire send_NAK;
    wire saw_EOT_block;
    wire saw_valid_byte;
    wire saw_msg_byte;
    wire saw_block;
    wire valid_block;

    assign saw_valid_msg_byte = saw_valid_byte & saw_msg_byte;
    assign saw_valid_block = saw_block && valid_block;
    assign saw_invalid_block = saw_block && ~valid_block;

    xmodem_bitlevel_fsmd xbitfsmd(
        .saw_valid_byte(saw_valid_byte),
        .data_byte(data_byte),
        .rx(rx),
        .clk(clk),
        .rst(rst)
    );

    xmodem_blocklevel_fsmd xblkfsmd(
        .saw_block(saw_block),
        .valid_block(valid_block),
        .saw_EOT_block(saw_EOT_block),
        .saw_msg_byte(saw_msg_byte),
        .repeat_block(repeat_block),
        .data_byte(data_byte),
        .saw_valid_byte(saw_valid_byte),
        .clk(clk),
        .rst(rst)
    );

    xmodem_protocol_fsmd xprofsmd(
        .send_ACK(send_ACK),
        .send_NAK(send_NAK),
        .xmodem_done(xmodem_done),
        .start(start),
        .saw_block(saw_block),
        .valid_block(valid_block),
        .saw_EOT_block(saw_EOT_block),
        .clk(clk),
        .rst(rst)
    );

    xmodem_transmitter_fsmd xtranfsmd(
        .tx(tx),
        .send_ACK(send_ACK),
        .send_NAK(send_NAK),
        .clk(clk),
        .rst(rst)
    );

endmodule

module xmodem_bitlevel_fsmd(
    output wire saw_valid_byte,
    output wire [7:0] data_byte,
    input wire rx,
    input wire clk, rst
);

    wire saw_byte, valid_byte;
    wire max_samples, max_cycles;
    wire init_cycle_cnt, clr_cycle_cnt;
    wire clr_sample_cnt;
    wire take_sample;
    wire negedge_rx;

    assign saw_valid_byte = saw_byte & valid_byte;

    xmodem_bitlevel_fsm bitf(
        .saw_byte(saw_byte),
        .init_cycle_cnt(init_cycle_cnt),
        .clr_cycle_cnt(clr_cycle_cnt),
        .clr_sample_cnt(clr_sample_cnt),
        .take_sample(take_sample),
        .max_samples(max_samples),
        .max_cycles(max_cycles),
        .negedge_rx(negedge_rx),
        .clk(clk),
        .rst(rst)
    );

    xmodem_bitlevel_datapath bitd(
        .max_cycles(max_cycles),
        .max_samples(max_samples),
        .valid_byte(valid_byte),
        .negedge_rx(negedge_rx),
        .data_byte(data_byte),
        .rx(rx),
        .take_sample(take_sample),
        .init_cycle_cnt(init_cycle_cnt),
        .clr_cycle_cnt(clr_cycle_cnt),
        .clr_sample_cnt(clr_sample_cnt),
        .clk(clk),
        .rst(rst)
    );

endmodule

module xmodem_bitlevel_fsm(
    output reg saw_byte,
    output reg init_cycle_cnt, clr_cycle_cnt,
    output reg clr_sample_cnt,
    output reg take_sample,
    input wire max_samples, max_cycles,
    input wire negedge_rx,
    input wire clk, rst
);

    wire curr_state;
    reg  next_state;

    // next state logic
    always @(*) begin
        case(curr_state)
            `SA: next_state = negedge_rx ? `SB : `SA;
            `SB: next_state = max_samples ? `SA : `SB;
        endcase
    end

    ff_ar state(.clk(clk), .rst(rst), .d(next_state), .q(curr_state));

    // output logic
    always @(*) begin

        clr_sample_cnt = 1'b0;
        clr_cycle_cnt = 1'b0;
        init_cycle_cnt = 1'b0;
        saw_byte = 1'b0;
        take_sample = 1'b0;

        case(curr_state)
            `SA: begin
                clr_sample_cnt = negedge_rx;
                init_cycle_cnt = negedge_rx;
            end
            `SB: begin
                clr_cycle_cnt = max_cycles;
                take_sample = max_cycles;
                saw_byte = max_samples;
            end
        endcase
    end

endmodule

module xmodem_bitlevel_datapath(
    output wire max_cycles,
    output wire max_samples,
    output wire valid_byte,
    output wire negedge_rx,
    output wire [7:0] data_byte,
    input wire rx,
    input wire take_sample,
    input wire init_cycle_cnt, clr_cycle_cnt,
    input wire clr_sample_cnt,
    input wire clk, rst
);

    wire [3:0] sample_cnt;
    wire [`CLOG2(`XM_CYC_PER_BIT)-1:0] cycle_cnt;
    wire [8:0] data;

    assign max_samples = (sample_cnt == `XM_NUM_SAMPLES) ? 1'b1 : 1'b0;
    assign max_cycles = (cycle_cnt == `XM_CYC_PER_BIT) ? 1'b1 : 1'b0;

    assign data_byte = data[7:0];
    assign valid_byte = data[8];

    wire rx_q;
    ff_ar rx_ff(.q(rx_q), .d(rx), .clk(clk), .rst(rst));
    assign negedge_rx = ~rx && rx_q;

    shift_register #(.W(9), .SHIFT_DIR(`SHIFT_DIR_RIGHT)) data_sr(.q(data), .d(rx), .en(take_sample), .clk(clk), .rst(rst));
    counter #(.W(4)) sample_counter(.cnt(sample_cnt), .x(take_sample), .clr(clr_sample_cnt), .clk(clk), .rst(rst));

    reg [`CLOG2(`XM_CYC_PER_BIT)-1:0] next_cycle_cnt;

    always @(*) begin
        if(clr_cycle_cnt)       next_cycle_cnt = 'b0;
        else if(init_cycle_cnt) next_cycle_cnt = `XM_CYC_PER_BIT >> 1'b1;
        else                    next_cycle_cnt = cycle_cnt + 1'b1;
    end

    ff_ar #(`CLOG2(`XM_CYC_PER_BIT), 'b0) cycle_counter(.q(cycle_cnt), .d(next_cycle_cnt), .clk(clk), .rst(rst));

endmodule

module xmodem_blocklevel_fsmd(
    output wire saw_block,
    output wire valid_block,
    output wire saw_EOT_block,
    output wire saw_msg_byte,
    output wire repeat_block,
    input wire [7:0] data_byte,
    input wire saw_valid_byte,
    input wire clk, rst
);

    wire clr_byte_cnt_and_chksum,
          ld_block_num,
          en_block_num_err_ff,
          inc_byte_cnt_and_chksum,
          saw_SOH_byte, saw_EOT_byte,
          saw_128_bytes;

    xmodem_blocklevel_fsm blkf(
        .saw_block(saw_block),
        .saw_EOT_block(saw_EOT_block),
        .clr_byte_cnt_and_chksum(clr_byte_cnt_and_chksum),
        .ld_block_num(ld_block_num),
        .en_block_num_err_ff(en_block_num_err_ff),
        .inc_byte_cnt_and_chksum(inc_byte_cnt_and_chksum),
        .saw_msg_byte(saw_msg_byte),
        .saw_valid_byte(saw_valid_byte),
        .saw_128_bytes(saw_128_bytes),
        .saw_SOH_byte(saw_SOH_byte),
        .saw_EOT_byte(saw_EOT_byte),
        .clk(clk),
        .rst(rst)
    );

    xmodem_blocklevel_datapath blkd(
        .saw_SOH_byte(saw_SOH_byte),
        .saw_EOT_byte(saw_EOT_byte),
        .saw_128_bytes(saw_128_bytes),
        .valid_block(valid_block),
        .repeat_block(repeat_block),
        .saw_block(saw_block),
        .clr_byte_cnt_and_chksum(clr_byte_cnt_and_chksum),
        .ld_block_num(ld_block_num),
        .en_block_num_err_ff(en_block_num_err_ff),
        .inc_byte_cnt_and_chksum(inc_byte_cnt_and_chksum),
        .data_byte(data_byte),
        .clk(clk),
        .rst(rst)
    );

endmodule

module xmodem_blocklevel_fsm(
    output reg saw_block,
    output reg saw_EOT_block,
    output reg clr_byte_cnt_and_chksum,
    output reg ld_block_num,
    output reg en_block_num_err_ff,
    output reg inc_byte_cnt_and_chksum,
    output reg saw_msg_byte,
    input wire saw_valid_byte,
    input wire saw_128_bytes,
    input wire saw_SOH_byte,
    input wire saw_EOT_byte,
    input wire clk, rst
);

    // may want to just make this the input

    wire [2:0] curr_state;
    reg  [2:0] next_state;

    // next state logic
    always @(*) begin
        case(curr_state)
            `SA: next_state = saw_valid_byte && saw_SOH_byte ? `SB : `SA;
            `SB: next_state = saw_valid_byte ? `SC : `SB;
            `SC: next_state = saw_valid_byte ? `SD: `SC;
            `SD: next_state = saw_128_bytes && saw_valid_byte ? `SE : `SD;
            `SE: next_state = saw_valid_byte ? `SA : `SE;
            default: next_state = `SA;
        endcase
    end

    ff_ar #(.W(3)) state(.q(curr_state), .d(next_state), .clk(clk), .rst(rst));

    // output logic
    always @(*) begin

        clr_byte_cnt_and_chksum = 1'b0;
        ld_block_num = 1'b0;
        en_block_num_err_ff = 1'b0;
        inc_byte_cnt_and_chksum = 1'b0;
        saw_block = 1'b0;
        saw_EOT_block = 1'b0;
        saw_msg_byte = 1'b0;

        case(curr_state)
            `SA: begin
                clr_byte_cnt_and_chksum = 1'b1;
                saw_EOT_block = saw_valid_byte & saw_EOT_byte;
            end
            `SB: ld_block_num = saw_valid_byte;
            `SC: en_block_num_err_ff = saw_valid_byte;
            `SD: begin
                saw_msg_byte = saw_valid_byte;
                inc_byte_cnt_and_chksum = saw_valid_byte;
            end
            `SE: saw_block = saw_valid_byte;
        endcase
    end

endmodule

module xmodem_blocklevel_datapath(
    output wire saw_SOH_byte, saw_EOT_byte,
                 saw_128_bytes,
                 valid_block,
    output wire repeat_block,
    input wire saw_block,
    input wire clr_byte_cnt_and_chksum,
                ld_block_num,
                en_block_num_err_ff,
                inc_byte_cnt_and_chksum,
    input wire [7:0] data_byte,
    input wire clk, rst
);

    wire block_num_err;
    wire chksum_err;

    wire [6:0] byte_cnt;
    wire [7:0] block_num;
    wire [7:0] prev_block_num;
    wire [7:0] chksum;
    reg  [7:0] next_chksum;

    wire valid_block_num_bits, valid_block_num, block_num_err_comb;

    assign saw_SOH_byte = (data_byte == `SOH) ? 1'b1 : 1'b0;
    assign saw_EOT_byte = (data_byte == `EOT) ? 1'b1 : 1'b0;
    assign saw_128_bytes = (byte_cnt == 7'd127) ? 1'b1 : 1'b0;

    assign repeat_block = (block_num == prev_block_num) & en_block_num_err_ff;

    assign valid_block_num_bits = (block_num == ~data_byte) ? 1'b1 : 1'b0;
    assign valid_block_num = ((block_num == prev_block_num) || (block_num == prev_block_num+1'b1)) ? 1'b1 : 1'b0;
    assign block_num_err_comb = ~valid_block_num_bits | ~valid_block_num;

    assign chksum_err = (chksum != data_byte) ? 1'b1 : 1'b0;

    assign valid_block = ~block_num_err & ~chksum_err;

    always @(*) begin
        if(clr_byte_cnt_and_chksum)         next_chksum = 8'h00;
        else if(inc_byte_cnt_and_chksum)    next_chksum = chksum + data_byte;
        else                                next_chksum = chksum;
    end

    ff_ar #(.W(8)) chksum_reg(.q(chksum), .d(next_chksum), .clk(clk), .rst(rst));

    ff_ar #(.W(8), .RESET_VAL(8'h01)) block_num_reg(.q(block_num), .d(ld_block_num ? data_byte : block_num), .clk(clk), .rst(rst));
    ff_ar #(.W(8), .RESET_VAL(8'h00)) prev_block_num_reg(.q(prev_block_num), .d((saw_block & valid_block) ? block_num : prev_block_num), .clk(clk), .rst(rst));

    ff_ar #(.W(1)) block_num_err_ff(.q(block_num_err), .d(en_block_num_err_ff ? block_num_err_comb : block_num_err), .clk(clk), .rst(rst));
    counter #(.W(7)) byte_counter(.cnt(byte_cnt), .clr(clr_byte_cnt_and_chksum), .x(inc_byte_cnt_and_chksum), .clk(clk), .rst(rst));

endmodule

module xmodem_protocol_fsmd(
    output wire send_ACK, send_NAK,
    output wire xmodem_done,
    input wire start,
    input wire saw_block, valid_block, saw_EOT_block,
    input wire clk, rst
);

    wire timeout,
          time_for_NAK,
          inc_timeout_NAK_cnt,
          inc_NAK_timer,
          inc_invalid_NAK_cnt,
          clr_timeout_NAK_cnt,
          clr_invalid_NAK_cnt,
          clr_NAK_timer;

    xmodem_protocol_fsm xprofsm(
        .send_ACK(send_ACK),
        .send_NAK(send_NAK),
        .xmodem_done(xmodem_done),
        .inc_timeout_NAK_cnt(inc_timeout_NAK_cnt),
        .inc_NAK_timer(inc_NAK_timer),
        .inc_invalid_NAK_cnt(inc_invalid_NAK_cnt),
        .clr_timeout_NAK_cnt(clr_timeout_NAK_cnt),
        .clr_invalid_NAK_cnt(clr_invalid_NAK_cnt),
        .clr_NAK_timer(clr_NAK_timer),
        .start(start),
        .saw_block(saw_block),
        .valid_block(valid_block),
        .saw_EOT_block(saw_EOT_block),
        .timeout(timeout),
        .time_for_NAK(time_for_NAK),
        .clk(clk),
        .rst(rst)
    );

    xmodem_protocol_datapath xprodp(
        .timeout(timeout),
        .time_for_NAK(time_for_NAK),
        .inc_timeout_NAK_cnt(inc_timeout_NAK_cnt),
        .inc_NAK_timer(inc_NAK_timer),
        .inc_invalid_NAK_cnt(inc_invalid_NAK_cnt),
        .clr_timeout_NAK_cnt(clr_timeout_NAK_cnt),
        .clr_invalid_NAK_cnt(clr_invalid_NAK_cnt),
        .clr_NAK_timer(clr_NAK_timer),
        .clk(clk),
        .rst(rst)
    );

endmodule

module xmodem_protocol_fsm(
    output reg send_ACK,
    output reg send_NAK,
    output reg xmodem_done,
    output reg inc_timeout_NAK_cnt,
    output reg inc_NAK_timer,
    output reg inc_invalid_NAK_cnt,
    output reg clr_timeout_NAK_cnt,
    output reg clr_invalid_NAK_cnt,
    output reg clr_NAK_timer,
    input wire start,
    input wire saw_block, valid_block, saw_EOT_block, timeout,
    input wire time_for_NAK,
    input wire clk, rst
);

    wire curr_state;
    reg  next_state;

    // next state logic
    always @(*) begin
        case(curr_state)
            `SA: next_state = start ? `SB : `SA;
            `SB: next_state = (timeout | saw_EOT_block) ? `SA : `SB;
        endcase
    end

    ff_ar state(.q(curr_state), .d(next_state), .clk(clk), .rst(rst));

    // output logic
    always @(*) begin

        send_ACK = 1'b0;
        send_NAK = 1'b0;
        inc_timeout_NAK_cnt = 1'b0;
        inc_NAK_timer = 1'b0;
        inc_invalid_NAK_cnt = 1'b0;
        clr_timeout_NAK_cnt = 1'b0;
        clr_invalid_NAK_cnt = 1'b0;
        clr_NAK_timer = 1'b0;

        xmodem_done = saw_EOT_block;

        case(curr_state)
            `SA: begin
                send_ACK = saw_EOT_block;
                send_NAK = start;
            end

            `SB: begin
                if(time_for_NAK) begin
                    send_NAK = 1'b1;
                    inc_timeout_NAK_cnt = 1'b1;
                    clr_NAK_timer = 1'b1;
                end
                else if(~(saw_block & valid_block)) begin
                    inc_NAK_timer = 1'b1;
                end

                if(saw_block & valid_block) begin
                    send_ACK = 1'b1;
                    clr_timeout_NAK_cnt = 1'b1;
                    clr_invalid_NAK_cnt = 1'b1;
                end
                if(saw_block & ~valid_block) begin
                    send_NAK = 1'b1;
                    inc_invalid_NAK_cnt = 1'b1;
                end
            end
        endcase
    end

endmodule

module xmodem_protocol_datapath(
    output wire timeout,
                 time_for_NAK,
    input wire inc_timeout_NAK_cnt,
                inc_NAK_timer,
                inc_invalid_NAK_cnt,
                clr_timeout_NAK_cnt,
                clr_invalid_NAK_cnt,
                clr_NAK_timer,
    input wire clk, rst
);

    wire [`CLOG2(`XM_NUM_CYC_TIMEOUT)-1:0] NAK_timer;
    wire [`CLOG2(`XM_MAX_RETRY)-1:0] timeout_NAK_cnt;
    wire [`CLOG2(`XM_MAX_RETRY)-1:0] invalid_NAK_cnt;

    assign time_for_NAK = (NAK_timer == `XM_NUM_CYC_TIMEOUT) ? 1'b1 : 1'b0;
    assign timeout = (timeout_NAK_cnt == `XM_MAX_RETRY) || (invalid_NAK_cnt == `XM_MAX_RETRY) ? 1'b1 : 1'b0;

    counter #(`CLOG2(`XM_MAX_RETRY)) timeout_counter(.cnt(timeout_NAK_cnt), .clr(clr_timeout_NAK_cnt), .x(inc_timeout_NAK_cnt), .clk(clk), .rst(rst));
    counter #(`CLOG2(`XM_MAX_RETRY)) invalid_counter(.cnt(invalid_NAK_cnt), .clr(clr_invalid_NAK_cnt), .x(inc_invalid_NAK_cnt), .clk(clk), .rst(rst));
    counter #(`CLOG2(`XM_NUM_CYC_TIMEOUT)) NAK_timer_counter(.cnt(NAK_timer), .clr(clr_NAK_timer), .x(inc_NAK_timer), .clk(clk), .rst(rst));

endmodule

module xmodem_transmitter_fsmd(
    output wire tx,
    input wire send_ACK, send_NAK,
    input wire clk, rst
);

    wire inc_cyc_cnt,
          clr_cyc_cnt,
          clr_bit_cnt,
          rot_and_inc_bit_cnt,
          byte_sent, bit_sent,
          ld_ACK_or_NAK_ff;

    xmodem_transmitter_fsm xtranfsm(
        .inc_cyc_cnt(inc_cyc_cnt),
        .clr_cyc_cnt(clr_cyc_cnt),
        .clr_bit_cnt(clr_bit_cnt),
        .rot_and_inc_bit_cnt(rot_and_inc_bit_cnt),
        .ld_ACK_or_NAK_ff(ld_ACK_or_NAK_ff),
        .send_ACK(send_ACK),
        .send_NAK(send_NAK),
        .byte_sent(byte_sent),
        .bit_sent(bit_sent),
        .clk(clk),
        .rst(rst)
    );

    xmodem_transmitter_datapath xtrandp(
        .tx(tx),
        .bit_sent(bit_sent),
        .byte_sent(byte_sent),
        .send_ACK(send_ACK),
        .ld_ACK_or_NAK_ff(ld_ACK_or_NAK_ff),
        .inc_cyc_cnt(inc_cyc_cnt),
        .clr_cyc_cnt(clr_cyc_cnt),
        .clr_bit_cnt(clr_bit_cnt),
        .rot_and_inc_bit_cnt(rot_and_inc_bit_cnt),
        .clk(clk),
        .rst(rst)
    );

endmodule

module xmodem_transmitter_fsm(
    output reg inc_cyc_cnt,
    output reg clr_cyc_cnt,
    output reg clr_bit_cnt,
    output reg rot_and_inc_bit_cnt,
    output reg ld_ACK_or_NAK_ff,
    input wire send_ACK, send_NAK,
    input wire byte_sent, bit_sent,
    input wire clk, rst
);

    wire curr_state;
    reg  next_state;

    // next state logic
    always @(*) begin
        case(curr_state)
            `SA: next_state = (send_ACK || send_NAK) ? `SB : `SA;
            `SB: next_state = (byte_sent) ? `SA : `SB;
        endcase
    end

    ff_ar state(.q(curr_state), .d(next_state), .clk(clk), .rst(rst));

    // output logic
    always @(*) begin

        inc_cyc_cnt = 1'b0;
        clr_cyc_cnt = 1'b0;
        clr_bit_cnt = 1'b0;
        rot_and_inc_bit_cnt = 1'b0;
        ld_ACK_or_NAK_ff = 1'b0;

        case(curr_state)
            `SA: begin
                clr_cyc_cnt = 1'b1;
                clr_bit_cnt = 1'b1;
                ld_ACK_or_NAK_ff = 1'b1;
            end
            `SB: begin
                inc_cyc_cnt = ~bit_sent;
                clr_cyc_cnt = bit_sent;
                rot_and_inc_bit_cnt = bit_sent;
            end
        endcase
    end

endmodule

module xmodem_transmitter_datapath(
    output wire tx,
    output wire bit_sent, byte_sent,
    input wire send_ACK,
    input wire ld_ACK_or_NAK_ff,
    input wire inc_cyc_cnt,
    input wire clr_cyc_cnt,
    input wire clr_bit_cnt,
    input wire rot_and_inc_bit_cnt,
    input wire clk, rst
);

    wire [`CLOG2(`XM_CYC_PER_BIT)-1:0] cyc_cnt;
    wire [3:0] bit_cnt;
    wire [9:0] ACK_bits;
    wire [9:0] NAK_bits;
    wire ACK_or_NAK;

    assign tx = (ACK_or_NAK == 1'b1) ? ACK_bits[0] : NAK_bits[0];

    assign bit_sent = (cyc_cnt == `XM_CYC_PER_BIT) ? 1'b1 : 1'b0;
    assign byte_sent = (bit_cnt == 4'd10) ? 1'b1 : 1'b0;

    ff_ar ACK_or_NAK_ff(.q(ACK_or_NAK), .d(ld_ACK_or_NAK_ff ? send_ACK : ACK_or_NAK), .clk(clk), .rst(rst));
    // TODO: why do these shift registers use q[0] as d?
    shift_register #(.W(10), .RESET_VAL({`ACK, 1'b0, 1'b1}), .SHIFT_DIR(`SHIFT_DIR_RIGHT)) ACK_sr(.q(ACK_bits), .d(ACK_bits[0]), .en(rot_and_inc_bit_cnt), .clk(clk), .rst(rst));
    shift_register #(.W(10), .RESET_VAL({`NAK, 1'b0, 1'b1}), .SHIFT_DIR(`SHIFT_DIR_RIGHT)) NAK_sr(.q(NAK_bits), .d(NAK_bits[0]), .en(rot_and_inc_bit_cnt), .clk(clk), .rst(rst));
    counter #(.W(`CLOG2(`XM_CYC_PER_BIT))) cyc_counter(.cnt(cyc_cnt), .clr(clr_cyc_cnt), .x(inc_cyc_cnt), .clk(clk), .rst(rst));
    counter #(.W(4)) bit_counter(.cnt(bit_cnt), .clr(clr_bit_cnt), .x(rot_and_inc_bit_cnt), .clk(clk), .rst(rst));

endmodule
