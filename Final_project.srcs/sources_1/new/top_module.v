module top_module(
    input reset,
    input clk, // 100 MHz clock for 7-segment display
    // input from button panels
    input [1:0] btn_call_up_floor, btn_call_down_floor, btn_door,
    input [3:0] btn_select_floor,
    // output from button panels
    output [1:0] led_btn_call_up_floor, led_btn_call_down_floor, led_btn_door,
    output [3:0] led_btn_select_floor,
    // input from door sensor
    input [1:0] door_sensor,
    // output to door
    output [3:0] lift_door,
    // input from access control system
    input access_control_system,
    // outputs to display current floor
    output [6:0] seg,
    output [3:0] anode
);
    lift_controller lift_controller_inst (
        .reset(reset),
        .clk(clk),
        .btn_call_up_floor(btn_call_up_floor),
        .btn_call_down_floor(btn_call_down_floor),
        .btn_door(btn_door),
        .btn_select_floor(btn_select_floor),
        .led_btn_call_up_floor(led_btn_call_up_floor),
        .led_btn_call_down_floor(led_btn_call_down_floor),
        .led_btn_door(led_btn_door),
        .led_btn_select_floor(led_btn_select_floor),
        .door_sensor(door_sensor),
        .lift_door(lift_door),
        .access_control_system(access_control_system),
        .seg(seg),
        .anode(anode)
    );


endmodule
