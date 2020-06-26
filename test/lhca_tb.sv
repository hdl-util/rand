module lhca_tb ();
    timeunit 1ns;
    timeprecision 1ns;
    logic clk = 1'b0;
    always
    begin
        #1;
        clk <= ~clk;
    end
    localparam WIDTH = 12;
    logic [WIDTH-1:0] source, state;
    ring_oscillator #(.WIDTH(WIDTH)) ring_oscillator(.state(source));
    lhca #(.WIDTH(WIDTH)) lhca(.clk(clk), .source(source), .state(state));

    initial begin
        #100;
        $finish;
    end

    always_ff @(posedge clk)
    begin
        $display("%h", state);
    end
endmodule
