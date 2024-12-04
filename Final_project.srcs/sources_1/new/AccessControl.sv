module Accesscontrol (
    input clk,               // Top-level clock
    input reset,             // Top-level reset
    inout wire [7:0] JC,     // Pmod keypad row and column pins
    output wire [6:0] seg,
    output wire [3:0] anode,
    output accesscontrol,
    output reg [3:0] keypad_key,
    output reg keypad_status
);
    wire isPressed;
    wire [3:0] key;
    
    Keypad_Decoder keypad_decoder(
        .clk(clk),
        .row(JC[3:0]),
        .reset(reset),
        .col(JC[7:4]),
        .key(key),
        .isPressed(isPressed)
    );
    
    AccessControl_com access_control(
        .clk(clk),
        .reset(reset),
        .keypad(key),
        .isPressed(isPressed),
        .access_control(accesscontrol),
        .seg(seg),
        .an(anode)
    );
    always @(*) begin
        keypad_key = key;
        keypad_status = isPressed;
    end

endmodule
