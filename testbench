`timescale 1ns/1ps

module tb;

    logic        rst;
    logic        clk_48MHz;
    logic        init_crc;
    logic        msg_bit;
    logic        msg_bit_rdy;
    int          number_of_bits;
    logic [15:0] crc16_out;
    logic        crc16_rdy;

    // message under test
    logic [7:0]  data_byte = 8'h12;   // 0001_0010
    int          i;

    USBCRC16 dut
    (
        .rst             (rst),
        .clk_48MHz       (clk_48MHz),
        .init_crc        (init_crc),
        .msg_bit         (msg_bit),
        .msg_bit_rdy     (msg_bit_rdy),
        .number_of_bits  (number_of_bits),
        .crc16_out       (crc16_out),
        .crc16_rdy       (crc16_rdy)
    );

    // 48 MHz clock -> ~20.83 ns period
    initial clk_48MHz = 1'b0;
    always #10.417 clk_48MHz = ~clk_48MHz;

    initial begin
        rst            = 1'b1;
        init_crc       = 1'b0;
        msg_bit        = 1'b0;
        msg_bit_rdy    = 1'b0;
        number_of_bits = 8;

        repeat (3) @(posedge clk_48MHz);
        rst = 1'b0;
        @(posedge clk_48MHz);

        // load / initialise CRC engine
        init_crc = 1'b1;
        @(posedge clk_48MHz);
        init_crc = 1'b0;

        // shift in data_byte, LSB first (bit 0 ... bit 7)
        for (i = 0; i < 8; i++) begin
            msg_bit     = data_byte[i];
            msg_bit_rdy = 1'b1;
            @(posedge clk_48MHz);
        end

        msg_bit_rdy = 1'b0;

        // wait for crc16_rdy
        wait (crc16_rdy == 1'b1);
        @(posedge clk_48MHz);

        $display("Input byte      = 0x%0h", data_byte);
        $display("crc16_out       = 0x%0h", crc16_out);
        $display("crc16_rdy       = %0b",   crc16_rdy);

        repeat (5) @(posedge clk_48MHz);
        $finish;
    end
  initial  begin 
    
     $dumpfile("tb.vcd");
      $dumpvars(0, tb);
    end  
  

endmodule
