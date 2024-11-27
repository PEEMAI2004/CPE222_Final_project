module seven_seg_anode_control (
    input wire clk,           // Clock for multiplexing
    input [13:0] number,      // 14-bit input for decimal number (0–9999)
    output reg [6:0] seg,     // 7-segment display cathodes
    output reg [3:0] an       // 4 anode controls
);
    reg [3:0] digit;          // Current digit to display
    reg [1:0] select = 0;     // 2-bit counter for digit selection
    reg [19:0] clk_div = 0;   // Clock divider for multiplexing

    // Extract each digit using division and modulo
    wire [3:0] digit_thousands = number / 1000;       // Thousands place
    wire [3:0] digit_hundreds  = (number / 100) % 10; // Hundreds place
    wire [3:0] digit_tens      = (number / 10) % 10;  // Tens place
    wire [3:0] digit_units     = number % 10;         // Units place

    // Clock divider for multiplexing
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
    end

    // Update digit selection based on clock divider
    always @(posedge clk_div[9]) begin
        select <= select + 1;
    end

    // Select the digit and activate the corresponding anode
    always @(*) begin
        case (select)
            2'b00: begin
                digit = digit_units;
                an = 4'b1110; // Activate anode for units
            end
            2'b01: begin
                digit = digit_tens;
                an = 4'b1101; // Activate anode for tens
            end
            2'b10: begin
                digit = digit_hundreds;
                an = 4'b1011; // Activate anode for hundreds
            end
            2'b11: begin
                digit = digit_thousands;
                an = 4'b0111; // Activate anode for thousands
            end
        endcase
    end

    // 7-segment decoder
    always @(*) begin
        case (digit)
            4'b0000: seg = 7'b1000000; // 0
            4'b0001: seg = 7'b1111001; // 1
            4'b0010: seg = 7'b0100100; // 2
            4'b0011: seg = 7'b0110000; // 3
            4'b0100: seg = 7'b0011001; // 4
            4'b0101: seg = 7'b0010010; // 5
            4'b0110: seg = 7'b0000010; // 6
            4'b0111: seg = 7'b1111000; // 7
            4'b1000: seg = 7'b0000000; // 8
            4'b1001: seg = 7'b0010000; // 9
            default: seg = 7'b1111111; // Blank
        endcase
    end
endmodule