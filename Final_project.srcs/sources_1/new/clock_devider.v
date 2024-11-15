module clock_devider (
    input clk,
    input [31:0] frequency,
    input reset,
    output reg clock_devided
);
    reg [31:0] system_frequency = 100_000_000; // 100 MHz clock source
    reg [31:0] clock_counter;
    reg [31:0] clock_counter_max;
    
    always @(posedge clk)
    begin
        clock_counter_max <= (system_frequency / frequency) - 1;
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            clock_counter <= 0;
        else if (clock_counter >= clock_counter_max)
            clock_counter <= 0;
        else
            clock_counter <= clock_counter + 1;
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            clock_devided <= 0;
        else if (clock_counter == clock_counter_max)
            clock_devided <= 1;
        else
            clock_devided <= 0;
    end
endmodule