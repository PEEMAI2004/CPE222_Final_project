module lift_buttons (
    // input all the buttons
    input [1:0] btn_door, btn_call_up_floor, btn_call_down_floor,
    input [3:1] btn_select_floor,

    // input led reset signal to turn off each the led
    input [1:0] led_btn_door_reset, led_btn_call_up_floor_reset, led_btn_call_down_floor_reset,
    output [3:1] led_btn_select_floor_reset,

    // output the buttons signal
    output [1:0] btn_door_out, btn_call_up_floor_out, btn_call_down_floor_out,
    output [3:1] btn_select_floor_out,

    // output led signal for the buttons
    output [1:0] led_btn_door, led_btn_call_up_floor, led_btn_call_down_floor,
    output [3:1] led_btn_select_floor
);
    // btn up 0 at 1st floor
    // btn down 0 at 2nd floor
    // btn up 1 at 2nd floor
    // btn down 1 at 3rd floor

    // if the button is pressed, the output signal will be 1 and the led will be on
    // invert the input because the button is active low
    assign btn_door_out = ~btn_door;
    assign btn_call_up_floor_out = ~btn_call_up_floor;
    assign btn_call_down_floor_out = ~btn_call_down_floor;
    assign btn_select_floor_out = ~btn_select_floor;

    wire [1:0] led_btn_door_int, led_btn_call_up_floor_int, led_btn_call_down_floor_int;
    wire [3:1] led_btn_select_floor_int;

    assign led_btn_door_int = btn_door_out;
    assign led_btn_call_up_floor_int = btn_call_up_floor_out;
    assign led_btn_call_down_floor_int = btn_call_down_floor_out;
    assign led_btn_select_floor_int = btn_select_floor_out;

    // turn off the led when the reset signal is 1
    assign led_btn_door = led_btn_door_int & ~led_btn_door_reset[0];
    assign led_btn_call_up_floor = led_btn_call_up_floor_int & ~led_btn_call_up_floor_reset[1];
    assign led_btn_call_down_floor = led_btn_call_down_floor_int & ~led_btn_call_down_floor_reset[0];
    assign led_btn_select_floor = led_btn_select_floor_int & ~led_btn_select_floor_reset;
endmodule