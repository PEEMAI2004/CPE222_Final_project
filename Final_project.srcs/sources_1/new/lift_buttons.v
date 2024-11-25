`timescale 1ns / 1ps
module button (
    input wire reset,
    input wire button_in,
    input wire button_led_off,
    output wire button_out,
    output reg button_led
);
    // Button is low active
    assign button_out = ~button_in;
    reg button_led_hold;
    always @(*)
    begin
        // If button is pressed, turn on the LED
        if (button_in == 1'b0 || button_led_hold == 1'b1) begin
            button_led_hold = 1'b1;
        end 
        // If led off is high, turn off the LED
        if (button_led_off == 1'b1 || reset == 1'b1) begin
            button_led_hold = 1'b0;
        end
        button_led = button_led_hold;
    end
endmodule
