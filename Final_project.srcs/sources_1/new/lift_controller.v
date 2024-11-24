module lift_controller (
    input clk, reset,
    // I/O
    input [1:0] door_sensor,
    input [1:0] btn_door, btn_call_up_floor, btn_call_down_floor,
    input [3:1] btn_select_floor,
    output [1:0] led_btn_door, led_btn_call_up_floor, led_btn_call_down_floor,
    output [3:1] led_btn_select_floor,
    output [1:0] direction_led,
    output [6:0] seg,
    output [3:0] anode,
    output [3:0] lift_door
);
// store values for state machine
reg [3:0] current_floor;
reg [1:0] lift_stage;
reg [1:0] direction;
// signal form door
wire door_status;
wire [1:0] door_signal;
// signal from panel button
wire [1:0] btn_door_signal, btn_call_up_floor_signal, btn_call_down_floor_signal;
wire [3:1] btn_select_floor_signal;
// signal to panel led to turn off
reg [1:0] led_btn_door_off, led_btn_call_up_floor_off, led_btn_call_down_floor_off;
reg [3:1] led_btn_select_floor_off;

// init modules
lift_button_panel panels1(
    // Button inputs
    .btn_door(btn_door),
    .btn_call_up_floor(btn_call_up_floor),
    .btn_call_down_floor(btn_call_down_floor),
    .btn_select_floor(btn_select_floor),
    // Button led off
    .btn_door_led_off(led_btn_door_off),
    .btn_call_up_floor_led_off(led_btn_call_up_floor_off),
    .btn_call_down_floor_led_off(led_btn_call_down_floor_off),
    .btn_select_floor_led_off(led_btn_select_floor_off),
    // Button led
    .btn_door_led(led_btn_door),
    .btn_call_up_floor_led(led_btn_call_up_floor),
    .btn_call_down_floor_led(led_btn_call_down_floor),
    .btn_select_floor_led(led_btn_select_floor),
    // Signal outputs
    .btn_door_out(btn_door_signal),
    .btn_call_up_floor_out(btn_call_up_floor_signal),
    .btn_call_down_floor_out(btn_call_down_floor_signal),
    .btn_select_floor_out(btn_select_floor_signal)
);

lift_door door1(
    .clk(clk),
    .reset(reset),
    .door_open_in(door_signal[0]),        // door open signal
    .door_close_in(door_signal[1]),       // door close signal
    .current_floor(current_floor),       // current floor
    .lift_stage(lift_stage),          // lift stage output
    .sensor(door_sensor),   // sensor signal
    .door(lift_door),       // door signal output
    .door_status()          // door status output
);

seven_seg_decoder decoder1(
    .value(current_floor),   
    .seg(led_floor)
);

assign anode = 4'b1110;

direction_display direction1(
    .clk(clk),
    .reset(reset),
    .direction(),
    .led(led_direction)
);

endmodule