module AccessControl_com (
    input clk,                  // Clock signal
    input [3:0] keypad,         // 4-bit keypad input (0-9)
    input isPressed,            // Key press signal
    input reset,
    output reg access_control,   // Access control output (1: Access granted, 0: Default)
    output reg [6:0] seg,       // 7-segment display output
    output reg [3:0] an         // 4-bit anode output
);

    // Parameters for the access code
    parameter [15:0] ACCESS_CODE = 16'd1111; // Default code (0000 - 9999)
    parameter DIGIT_COUNT = 4;               // Number of digits in the access code

    // Internal registers
    reg [15:0] entered_code = 0; // Stores the current entered code
    reg [2:0] digit_count = 0;   // Counter for entered digits

    // 7-segment display decoder
    seven_seg_anode_control seven_seg_anode_control(
        .clk(clk),
        .number(entered_code),
        .debug(1),
        .seg(seg),
        .an(an)
    );

    always @(posedge isPressed or posedge reset) begin
        if (reset) begin
            // Reset the system
            entered_code <= 0;
            digit_count <= 0;
            access_control <= 0;
        end else begin
            // Check if a digit is entered
            if (keypad <= 4'd9) begin
                // Add the new digit to the entered code
                entered_code <= (entered_code * 10) + keypad;
                digit_count <= digit_count + 1;
            end

            // Check if all 4 digits are entered
            if (digit_count == DIGIT_COUNT) begin
                if (entered_code == ACCESS_CODE) begin
                    // Correct code entered
                    access_control <= 1;
                end else begin
                    // Incorrect code, reset input
                    // access_control <= 0;
                end
                // Reset after checking the code
                entered_code <= 0;
                digit_count <= 0;
            end
        end
    end
endmodule
