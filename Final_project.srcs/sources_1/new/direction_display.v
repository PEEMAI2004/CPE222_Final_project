module direction_display(
    input wire clk,
    input wire reset,
    input wire [1:0] direction,
    output reg [1:0] led
    );

    reg [23:0] counter;
    reg slow_clk;

    // Clock divider to generate 5 Hz clock from 100 MHz input clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 24'd0;
            slow_clk <= 1'b0;
        end else if (counter == 24'd9999999) begin
            counter <= 24'd0;
            slow_clk <= ~slow_clk;
        end else begin
            counter <= counter + 1;
        end
    end

    // Direction status LED
    always @(posedge slow_clk or posedge reset) begin
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
