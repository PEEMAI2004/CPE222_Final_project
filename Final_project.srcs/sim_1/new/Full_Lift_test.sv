`timescale 1ns / 1ps


`timescale 1ns / 1ps

module lift_controller_tb;

// Inputs
reg clk;
reg reset;
reg [1:0] door_sensor;
reg [1:0] btn_door;
reg [1:0] btn_call_up_floor, btn_call_down_floor;
reg [3:1] btn_select_floor;
reg emergency_stop;

// Outputs
wire [1:0] led_btn_door;
wire [1:0] led_btn_call_up_floor, led_btn_call_down_floor;
wire [3:1] led_btn_select_floor;
wire [3:1] led_floor_request;
wire [1:0] direction_led;
wire [6:0] seg;
wire [3:0] anode;
wire [3:0] lift_door;

// Instantiate the Unit Under Test (UUT)
lift_controller uut (
    .clk(clk),
    .reset(reset),
    .door_sensor(door_sensor),
    .btn_door(btn_door),
    .btn_call_up_floor(btn_call_up_floor),
    .btn_call_down_floor(btn_call_down_floor),
    .btn_select_floor(btn_select_floor),
    .emergency_stop(emergency_stop),
    .led_btn_door(led_btn_door),
    .led_btn_call_up_floor(led_btn_call_up_floor),
    .led_btn_call_down_floor(led_btn_call_down_floor),
    .led_btn_select_floor(led_btn_select_floor),
    .led_floor_request(led_floor_request),
    .direction_led(direction_led),
    .seg(seg),
    .anode(anode),
    .lift_door(lift_door)
);

// Clock generation
always #5 clk = ~clk; // 10ns clock period (100MHz)

initial begin
    // Initialize Inputs
    clk = 0;
    reset = 1;
    door_sensor = 2'b00;
    btn_door = 2'b00;
    btn_call_up_floor = 2'b00;
    btn_call_down_floor = 2'b00;
    btn_select_floor = 3'b000;
    emergency_stop = 0;

    // Wait for global reset
    #20;
    reset = 0;

    // Test 1: Move to the 2nd floor
    btn_select_floor[2] = 1;
    #50; // Wait for lift to respond

    btn_select_floor[2] = 0;
    #200; // Simulate time for lift to reach the 2nd floor

    // Test 2: Door opens and closes
    btn_door[0] = 1;
    #30;
    btn_door[0] = 0;
    #500; // Simulate door open/close process

    // Test 3: Move to the 3rd floor
    btn_select_floor[3] = 1;
    #50;

    btn_select_floor[3] = 0;
    #200;

    // Test 4: Emergency stop during movement
    emergency_stop = 1;
    #30;
    emergency_stop = 0;

    #500; // Simulate recovery from emergency stop

    // Test 5: Move back to the 1st floor
    btn_select_floor[1] = 1;
    #50;

    btn_select_floor[1] = 0;
    #200;

    // Test Complete
    $stop;
end

endmodule

