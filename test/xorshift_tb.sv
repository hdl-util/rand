module xorshift_tb;
    timeunit 1ns;
    timeprecision 1ns;
    logic clk = 1'b0;
    always
    begin
        #1;
        clk <= ~clk;
    end
    localparam int WIDTH = 4;
    logic reset = 1'b0;
    logic [WIDTH-1:0] state;
    xorshift #(.WIDTH(WIDTH)) xorshift(.clk(clk), .reset(reset), .state(state));

    logic [WIDTH-1:0] seen [0:2**WIDTH-1];
    integer i, current = 0;
    always_ff @(posedge clk)
    begin
        if (current == 3 * 2**WIDTH)
            $finish;
        else
        begin
            seen[current % (2**WIDTH - 1)] <= state;
            for (i = 0; i < current % (2**WIDTH - 1); i++)
            begin
                assert(seen[i] != state) else $fatal(1, "Encountered a repeat of %d at %d %d %d %p", state, i, current % (2**WIDTH - 1), seen);
            end
        end
        current <= current + 1'd1;
    end
endmodule
