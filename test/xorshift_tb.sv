module xorshift_tb;
    timeunit 1ns;
    timeprecision 1ns;
    logic clk = 1'b0;
    always
    begin
        #1;
        clk <= ~clk;
    end
    localparam int WIDTH = 12;
    logic reset = 1'b1;
    logic [WIDTH-1:0] seed = WIDTH'(1), state;
    xorshift #(.WIDTH(WIDTH)) xorshift(.clk(clk), .reset(reset), .seed(seed), .state(state));

    logic [WIDTH-1:0] seen [0:2**WIDTH-1];
    integer i, current = -1;
    always_ff @(posedge clk)
    begin
        if (current == -1)
            reset <= 1'b0;
        else if (current == 2**WIDTH - 1)
            $finish;
        else
        begin
            seen[current] <= state;
            for (i = 0; i < current; i++)
            begin
                assert(seen[i] != state) else $fatal(1, "Encountered a repeat of %d at %d %d", state, i, current);
            end
        end
        current <= current + 1'd1;
    end
endmodule
