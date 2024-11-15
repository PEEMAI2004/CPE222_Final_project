module seven_seg_anode_control (
    input clk,             // 100 MHz clock source
    input [6:0] number,    // 2-digit number (0 to 99)
    output reg [6:0] seg,  // 7-segment display output
    output reg [3:0] anode // 4 anode control output
);

    // Split the number into tens and ones digits
    reg [3:0] tens_digit, ones_digit;
    always @(*) begin
        tens_digit = number / 10;
        ones_digit = number % 10;
    end

    // Refresh rate configuration for anodes (100 Hz)
    localparam system_frequency = 100_000_000; // 100 MHz
    localparam clock_counter_max = (system_frequency / 1_000_000) - 1; // 100 Hz refresh rate
    reg [25:0] clock_counter = 0;
    reg [1:0] anode_control = 0;

    // Refresh logic for 7-segment multiplexing
    always @(posedge clk) begin
        if (clock_counter == clock_counter_max) begin
            clock_counter <= 0;
            anode_control <= (anode_control == 2'b11) ? 2'b00 : anode_control + 1;
        end else begin
            clock_counter <= clock_counter + 1;
        end
    end

    // 7-segment display decoder instances
    wire [6:0] tens_seg, ones_seg;
    seven_seg_decoder seg_decoder_tens (
        .value(tens_digit),
        .seg(tens_seg)
    );
    seven_seg_decoder seg_decoder_ones (
        .value(ones_digit),
        .seg(ones_seg)
    );

    // Control the anode signals and segment display based on `anode_control`
    always @(*) begin
        case (anode_control)
            
            2'b01: begin
                anode = 4'b1101; // Enable tens place anode
                seg = tens_seg;
            end
            2'b00: begin
                anode = 4'b1110; // Enable ones place anode
                seg = ones_seg;
            end
            default: begin
                anode = 4'b1111; // Turn off all anodes
                seg = 7'b1111111; // Blank segment output
            end
        endcase
    end
endmodule
