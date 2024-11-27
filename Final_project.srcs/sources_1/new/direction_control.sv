`timescale 1ns / 1ps
module direction_control(
    input wire [3:0] current_floor,
    input wire [1:0] current_direction,
    input wire activation,
    input wire [3:1] requests,
    output reg [1:0] next_direction,
    output reg [3:1] request_remove,
    output reg [3:0] target_floor,
    output reg [3:1] led_btn_select_floor_off,
    output reg [1:0] led_btn_call_down_floor_off,
    output reg [1:0] led_btn_call_up_floor_off
);
    // Declare variable outside of the always block
    reg [3:0] i;  // Variable for loop index

    always @(*) begin
        // Reset request_remove for all floors initially
        request_remove = 3'b000;
        // Reset signal to turn off all leds
        led_btn_call_up_floor_off = 2'b00;
        led_btn_call_down_floor_off = 2'b00;
        led_btn_select_floor_off = 4'b0000;

        // led_btn_select_floor_off[current_floor] = 1'b1;

        // If current_floor is in requests, mark it for removal
        if (requests[current_floor] == 1) begin
            request_remove[current_floor] = 1'b1;
        end
        
        // Turn off the corresponding led on the button panel
        case (current_floor)
            1: begin
            led_btn_call_up_floor_off[0] = 1'b1;    // send signal to turn off led
            led_btn_select_floor_off[1] = 1'b1;
            end
            2: begin
            led_btn_call_up_floor_off[1] = 1'b1;    // send signal to turn off led
            led_btn_call_down_floor_off[0] = 1'b1;
            led_btn_select_floor_off[2] = 1'b1;
            end
            3: begin
            led_btn_call_down_floor_off[1] = 1'b1;  // send signal to turn off led
            led_btn_select_floor_off[3] = 1'b1;
            end
            default: begin
            // Default case to handle unexpected values
            led_btn_call_up_floor_off = 2'b00;
            led_btn_call_down_floor_off = 2'b00;
            end
        endcase

        // Find target floor by ignoring the current floor
        target_floor = 4'b0000;  // Default target_floor to 0 initially
        for (i = 3; i >= 1; i = i - 1) begin
            if (requests[i] == 1 && i != current_floor) begin
                target_floor = i;  // Set target floor to the first requested floor that's not the current floor
            end
        end

        // Handle the special case where target floor is 0
        if (target_floor == 4'b0000) begin
            next_direction = 2'b00;  // Stationary if the target floor is 0
        end else begin
            // Set next direction based on current_floor and target_floor
            if (current_direction != 2'b10) begin
                if (target_floor > current_floor) begin
                    next_direction = 2'b01;  // Going up
                end else if (target_floor < current_floor) begin
                    next_direction = 2'b10;  // Going down
                end else begin
                    next_direction = 2'b00;  // Stay stationary
                end
            end else begin
                if (target_floor < current_floor) begin
                    next_direction = 2'b10;  // Going down
                end else if (target_floor > current_floor) begin
                    next_direction = 2'b01;  // Going up
                end else begin
                    next_direction = 2'b00;  // Stay stationary
                end
            end
        end
        // if (target_floor == 4'b0000) begin
        //     target_floor = current_floor;
        // end
    end
endmodule
