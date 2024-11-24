module direction_display(
    input wire clk,
    input wire reset,
    input wire [1:0] direction,
    output reg [1:0] led
    );
    // direction status led 
    // [0,0] no led
    // [0,1] right led (led14) up
    // [1,0] left led (led15) down
    // [1,1] both led
    // 5 Hz blink rate using clock divider module
    wire clk_5hz;
    clock_devider clk_div (
        .clk(clk),
        .frequency(5),
        .reset(reset),
        .clock_devided(clk_5hz)
    );

    always @(posedge clk_5hz or posedge reset)
    begin
        if (reset)
            led <= 2'b00;
        else
            case (direction)
                2'b00: led <= 2'b00;
                2'b01: led <= 2'b01;
                2'b10: led <= 2'b10;
                2'b11: led <= 2'b11;
                default: led <= 2'b00;
            endcase
    end
endmodule
