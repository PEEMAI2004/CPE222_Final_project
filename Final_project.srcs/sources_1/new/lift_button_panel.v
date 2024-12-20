`timescale 1ns / 1ps
module lift_button_panel (
    input wire reset,
    // Button inputs
    input wire [1:0] btn_door, btn_call_up_floor, btn_call_down_floor,
    input wire [3:1] btn_select_floor,
    // Button led off
    input wire [1:0] btn_door_led_off, btn_call_up_floor_led_off, btn_call_down_floor_led_off,
    input wire [3:1] btn_select_floor_led_off,
    // Access control
    input wire access_control, access_control_by_pass,
    // Current current_state
    input wire [3:0] current_state,
    // Button led
    output wire [1:0] btn_door_led, btn_call_up_floor_led, btn_call_down_floor_led,
    output wire [3:1] btn_select_floor_led,
    // Signal outputs
    output wire [1:0] btn_door_out, btn_call_up_floor_out, btn_call_down_floor_out,
    output wire [3:1] btn_select_floor_out,
    output reg  reset_access_control, led_access_control_status
);
reg access_control_1;
// Door button
// Door open button
button btn_door_open (
    .reset(reset),
    .button_in(btn_door[0]),
    .button_led_off(btn_door_led_off[0]),
    .button_out(btn_door_out[0]),
    .button_led(btn_door_led[0])
);
// Door close button
button btn_door_close (
    .reset(reset),
    .button_in(btn_door[1]),
    .button_led_off(btn_door_led_off[1]),
    .button_out(btn_door_out[1]),
    .button_led(btn_door_led[1])
);
// Call up floor button
button btn_call_up_floor_1 (
    .reset(reset),
    .button_in(access_control_1),
    .button_led_off(btn_call_up_floor_led_off[0]),
    .button_out(btn_call_up_floor_out[0]),
    .button_led(btn_call_up_floor_led[0])
);
button btn_call_up_floor_2 (
    .reset(reset),
    .button_in(btn_call_up_floor[1]),
    .button_led_off(btn_call_up_floor_led_off[1]),
    .button_out(btn_call_up_floor_out[1]),
    .button_led(btn_call_up_floor_led[1])
);
// Call down floor button
button btn_call_down_floor_1 (
    .reset(reset),
    .button_in(btn_call_down_floor[0]),
    .button_led_off(btn_call_down_floor_led_off[0]),
    .button_out(btn_call_down_floor_out[0]),
    .button_led(btn_call_down_floor_led[0])
);
button btn_call_down_floor_2 (
    .reset(reset),
    .button_in(btn_call_down_floor[1]),
    .button_led_off(btn_call_down_floor_led_off[1]),
    .button_out(btn_call_down_floor_out[1]),
    .button_led(btn_call_down_floor_led[1])
);
// Select floor button
button btn_select_floor_1 (
    .reset(reset),
    .button_in(btn_select_floor[1]),
    .button_led_off(btn_select_floor_led_off[1]),
    .button_out(btn_select_floor_out[1]),
    .button_led(btn_select_floor_led[1])
);
button btn_select_floor_2 (
    .reset(reset),
    .button_in(btn_select_floor[2]),
    .button_led_off(btn_select_floor_led_off[2]),
    .button_out(btn_select_floor_out[2]),
    .button_led(btn_select_floor_led[2])
);
button btn_select_floor_3 (
    .reset(reset),
    .button_in(btn_select_floor[3]),
    .button_led_off(btn_select_floor_led_off[3]),
    .button_out(btn_select_floor_out[3]),
    .button_led(btn_select_floor_led[3])
);

always @(*) begin
    // if (reset) begin
    //     reset_access_control = 1;
    // end
    // else begin
    //     reset_access_control = 0;
    // end

    if (access_control || access_control_by_pass) begin
        led_access_control_status = 1;
        access_control_1 = btn_call_up_floor[0];
        end else begin
            led_access_control_status = 0;
            access_control_1 = 1;
        end
    // if current state is 4 door close
    if (current_state == 4'b0100) begin
        reset_access_control = 1;
    end else begin
        reset_access_control = 0;
    end
end

endmodule
