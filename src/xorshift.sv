module xorshift #(
    parameter int WIDTH,
    // By default, a polynomial from a table of known polynomials is picked.
    // You may want to specify your own if your polynomial is beyond the supported range
    parameter bit [WIDTH-1:0] POLYNOMIAL = WIDTH'(0)
) (
    input logic clk,
    // Synchronous reset
    input logic reset,
    // An optional seed used to set the initial state upon reset
    input logic [WIDTH-1:0] seed,
    output logic [WIDTH-1:0] state = WIDTH'(0)
);

logic [WIDTH-1:0] polynomial;
logic lfsr_xnor;

integer i;
always_comb
begin
    lfsr_xnor = 0;
    for (i = 0; i < WIDTH; i++)
    begin
        if (polynomial[i])
            lfsr_xnor = lfsr_xnor ^~ state[i];
    end
    // Trick to negate the fact that it's initially set to 0. It should be synthesized away.
    // This works because the maximal length polynomials all have an even number of terms.
    // Have confirmed it works for a few values, but I may be wrong.
    lfsr_xnor = lfsr_xnor ^~ 0;
end

always_ff @(posedge clk)
begin
    if (reset)
        state <= seed;
    else
        state <= {state[WIDTH-2:0], lfsr_xnor};
end

generate
    if (POLYNOMIAL != WIDTH'(0))
        assign polynomial = POLYNOMIAL;
    else
        case (WIDTH)
// Derived with mlpolygen:
// for i in {1..256}; do echo -n $i': assign polynomial = '$i"'h"; ./mlpolygen -n1 $i 2>/dev/null; done
1: assign polynomial = 1'h1;
2: assign polynomial = 2'h3;
3: assign polynomial = 3'h5;
4: assign polynomial = 4'h9;
5: assign polynomial = 5'h12;
6: assign polynomial = 6'h21;
7: assign polynomial = 7'h41;
8: assign polynomial = 8'h8e;
9: assign polynomial = 9'h108;
10: assign polynomial = 10'h204;
11: assign polynomial = 11'h402;
12: assign polynomial = 12'h829;
13: assign polynomial = 13'h100d;
14: assign polynomial = 14'h2015;
15: assign polynomial = 15'h4001;
16: assign polynomial = 16'h8016;
17: assign polynomial = 17'h10004;
18: assign polynomial = 18'h20013;
19: assign polynomial = 19'h40013;
20: assign polynomial = 20'h80004;
21: assign polynomial = 21'h100002;
22: assign polynomial = 22'h200001;
23: assign polynomial = 23'h400010;
24: assign polynomial = 24'h80000d;
25: assign polynomial = 25'h1000004;
26: assign polynomial = 26'h2000023;
27: assign polynomial = 27'h4000013;
28: assign polynomial = 28'h8000004;
29: assign polynomial = 29'h10000002;
30: assign polynomial = 30'h20000029;
31: assign polynomial = 31'h40000004;
32: assign polynomial = 32'h80000057;
33: assign polynomial = 33'h100000029;
34: assign polynomial = 34'h200000073;
35: assign polynomial = 35'h400000002;
36: assign polynomial = 36'h80000003b;
37: assign polynomial = 37'h100000001f;
38: assign polynomial = 38'h2000000031;
39: assign polynomial = 39'h4000000008;
40: assign polynomial = 40'h800000001c;
41: assign polynomial = 41'h10000000004;
42: assign polynomial = 42'h2000000001f;
43: assign polynomial = 43'h4000000002c;
44: assign polynomial = 44'h80000000032;
45: assign polynomial = 45'h10000000000d;
46: assign polynomial = 46'h200000000097;
47: assign polynomial = 47'h400000000010;
48: assign polynomial = 48'h80000000005b;
49: assign polynomial = 49'h1000000000038;
50: assign polynomial = 50'h200000000000e;
51: assign polynomial = 51'h4000000000025;
52: assign polynomial = 52'h8000000000004;
53: assign polynomial = 53'h10000000000023;
54: assign polynomial = 54'h2000000000003e;
55: assign polynomial = 55'h40000000000023;
56: assign polynomial = 56'h8000000000004a;
57: assign polynomial = 57'h100000000000016;
58: assign polynomial = 58'h200000000000031;
59: assign polynomial = 59'h40000000000003d;
60: assign polynomial = 60'h800000000000001;
61: assign polynomial = 61'h1000000000000013;
62: assign polynomial = 62'h2000000000000034;
63: assign polynomial = 63'h4000000000000001;
64: assign polynomial = 64'h800000000000000d;
65: assign polynomial = 65'h1000000000000000d;
66: assign polynomial = 66'h200000000000000b6;
67: assign polynomial = 67'h40000000000000013;
68: assign polynomial = 68'h80000000000000051;
69: assign polynomial = 69'h100000000000000032;
70: assign polynomial = 70'h200000000000000015;
71: assign polynomial = 71'h400000000000000015;
72: assign polynomial = 72'h80000000000000002f;
73: assign polynomial = 73'h100000000000000000e;
74: assign polynomial = 74'h200000000000000004c;
75: assign polynomial = 75'h4000000000000000025;
76: assign polynomial = 76'h800000000000000001a;
77: assign polynomial = 77'h10000000000000000032;
78: assign polynomial = 78'h20000000000000000043;
79: assign polynomial = 79'h4000000000000000000e;
80: assign polynomial = 80'h80000000000000000057;
81: assign polynomial = 81'h100000000000000000008;
82: assign polynomial = 82'h2000000000000000000e9;
        endcase
endgenerate

endmodule
