module lift_buttons(
    // call button
    input [1:0] btn_call_up_floor,
    input [1:0] btn_call_down_floor,
    input [1:0] call_button_up_led_reset,
    input [1:0] call_button_down_led_reset,
    // floor button
    input [3:0] btn_select_floor,
    input [3:0] floor_button_led_reset,
    // door button
    input [1:0] btn_door,
    input [1:0] door_button_led_reset,
    // reset
    input reset,
    // output
    // call button led
    output [1:0] led_btn_call_up_floor,
    output [1:0] led_btn_call_down_floor,
    // floor button led
    output [3:0] led_btn_select_floor,
    // door button led
    output [1:0] led_btn_door,
    // button output 
    output [1:0] call_button_up_out,
    output [1:0] call_button_down_out,
    output [3:0] floor_select_button_out,
    output [1:0] door_button_out
    );
    // invert all the input
    assign call_button_up_out = ~btn_call_up_floor;
    assign call_button_down_out = ~btn_call_down_floor;
    assign floor_select_button_out = ~btn_select_floor;
    assign door_button_out = ~btn_door;

    // led high when button is pressed
    reg [1:0] call_button_up_led, call_button_down_led;
    reg [3:0] floor_button_led;
    reg [1:0] door_button_led;

    always @(posedge reset or posedge btn_call_up_floor[0] or posedge btn_call_up_floor[1] or posedge btn_call_down_floor[0] or posedge btn_call_down_floor[1] or posedge btn_select_floor[0] or posedge btn_select_floor[1] or posedge btn_select_floor[2] or posedge btn_select_floor[3] or posedge btn_door[0] or posedge btn_door[1] or posedge call_button_up_led_reset[0] or posedge call_button_up_led_reset[1] or posedge call_button_down_led_reset[0] or posedge call_button_down_led_reset[1] or posedge floor_button_led_reset[0] or posedge floor_button_led_reset[1] or posedge floor_button_led_reset[2] or posedge floor_button_led_reset[3] or posedge door_button_led_reset[0] or posedge door_button_led_reset[1]) begin
        if (reset) begin
            call_button_up_led <= 2'b00;
            call_button_down_led <= 2'b00;
            floor_button_led <= 4'b0000;
            door_button_led <= 2'b00;
        end else begin
            if (call_button_up_led_reset[0]) call_button_up_led[0] <= 1'b0;
            else if (btn_call_up_floor[0]) call_button_up_led[0] <= 1'b1;
            
            if (call_button_up_led_reset[1]) call_button_up_led[1] <= 1'b0;
            else if (btn_call_up_floor[1]) call_button_up_led[1] <= 1'b1;
            
            if (call_button_down_led_reset[0]) call_button_down_led[0] <= 1'b0;
            else if (btn_call_down_floor[0]) call_button_down_led[0] <= 1'b1;
            
            if (call_button_down_led_reset[1]) call_button_down_led[1] <= 1'b0;
            else if (btn_call_down_floor[1]) call_button_down_led[1] <= 1'b1;
            
            if (floor_button_led_reset[0]) floor_button_led[0] <= 1'b0;
            else if (btn_select_floor[0]) floor_button_led[0] <= 1'b1;
            
            if (floor_button_led_reset[1]) floor_button_led[1] <= 1'b0;
            else if (btn_select_floor[1]) floor_button_led[1] <= 1'b1;
            
            if (floor_button_led_reset[2]) floor_button_led[2] <= 1'b0;
            else if (btn_select_floor[2]) floor_button_led[2] <= 1'b1;
            
            if (floor_button_led_reset[3]) floor_button_led[3] <= 1'b0;
            else if (btn_select_floor[3]) floor_button_led[3] <= 1'b1;
            
            if (door_button_led_reset[0]) door_button_led[0] <= 1'b0;
            else if (btn_door[0]) door_button_led[0] <= 1'b1;
            
            if (door_button_led_reset[1]) door_button_led[1] <= 1'b0;
            else if (btn_door[1]) door_button_led[1] <= 1'b1;
        end
    end

    assign call_button_up_out = call_button_up_led;
    assign call_button_down_out = call_button_down_led;
    assign floor_select_button_out = floor_button_led;
    assign door_button_out = door_button_led;

    
endmodule
