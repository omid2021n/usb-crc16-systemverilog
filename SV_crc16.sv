module USBCRC16
(
    input  logic        rst,
    input  logic        clk_48MHz,

    input  logic        init_crc,       // tells us that we should initialise our LFSR
    input  logic        msg_bit,        // current bit of the message shifted into the LFSR
    input  logic        msg_bit_rdy,    // signals the arrival of a new message bit

    input  int          number_of_bits, // number of bits in our message

    output logic [15:0] crc16_out,      // CRC16 result
    output logic        crc16_rdy       // CRC16 ready signal
);

    logic [15:0] crc16_sr;
    logic        feedback;
    logic        msg_bit_reg;
    logic        msg_bit_rdy_reg;
    int          number_of_bits_left;

    assign crc16_out = ~crc16_sr;
    assign feedback  = msg_bit_reg ^ crc16_sr[15];

    // LFSR
    always_ff @(posedge clk_48MHz or posedge rst) begin
        if (rst) begin
            msg_bit_reg     <= 1'b0;
            msg_bit_rdy_reg <= 1'b0;
            crc16_sr        <= '1;
        end else begin
            msg_bit_reg     <= msg_bit;
            msg_bit_rdy_reg <= msg_bit_rdy;

            if (init_crc) begin
                crc16_sr <= '1;
            end else if (msg_bit_rdy_reg) begin
                crc16_sr[0]  <= feedback;
                crc16_sr[1]  <= crc16_sr[0];
                crc16_sr[2]  <= crc16_sr[1] ^ feedback;
                crc16_sr[3]  <= crc16_sr[2];
                crc16_sr[4]  <= crc16_sr[3];
                crc16_sr[5]  <= crc16_sr[4];
                crc16_sr[6]  <= crc16_sr[5];
                crc16_sr[7]  <= crc16_sr[6];
                crc16_sr[8]  <= crc16_sr[7];
                crc16_sr[9]  <= crc16_sr[8];
                crc16_sr[10] <= crc16_sr[9];
                crc16_sr[11] <= crc16_sr[10];
                crc16_sr[12] <= crc16_sr[11];
                crc16_sr[13] <= crc16_sr[12];
                crc16_sr[14] <= crc16_sr[13];
                crc16_sr[15] <= crc16_sr[14] ^ feedback;
            end
        end
    end

    // Bit counter
    always_ff @(posedge clk_48MHz or posedge rst) begin
        if (rst) begin
            number_of_bits_left <= 0;
        end else begin
            if (init_crc) begin
                number_of_bits_left <= number_of_bits;
            end else if (msg_bit_rdy) begin
                number_of_bits_left <= number_of_bits_left - 1;
            end
        end
    end

    // CRC output timing
    always_ff @(posedge clk_48MHz or posedge rst) begin
        if (rst) begin
            crc16_rdy <= 1'b0;
        end else begin
            if (number_of_bits_left == 0) begin
                crc16_rdy <= 1'b1;
            end else begin
                crc16_rdy <= 1'b0;
            end
        end
    end

endmodule
