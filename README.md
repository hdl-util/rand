# rand

[![Build Status](https://travis-ci.com/hdl-util/rand.svg?branch=master)](https://travis-ci.com/hdl-util/rand)

SystemVerilog code for arbitrary width random number utilities.

## Why?

Needed an arbitrary width LFSR implementation. The one I've included works for 4 through 64 bits, but is easily extensible with the addition of more constants found using [mlpolygen](https://bitbucket.org/gallen/mlpolygen/src/default/).

## Usage

### Linear Feedback Shift Register (LFSR / Xorshift)

1. Take files from `src/` and add them to your own project. If you use [hdlmake](https://hdlmake.readthedocs.io/en/master/), you can add this repository itself as a remote module.
1. Other helpful modules are also available in this GitHub organization.
1. Consult the testbench in `test/xorshift_tb.sv` for example usage.
1. Read through the parameter descriptions in `xorshift.sv` and tailor any instantiations to your situation.
1. Please create an issue if you run into a problem or have any questions.

#### Caveats

* Does not encompass all values (2 ** WIDTH-1 is missing)
* Predictable values, not suitable for any security-related application

### Ring oscillator

See `src/ring_oscillator.sv`. Because the toggle rate of a ring oscillator depends on logic delays and noise, it can act as a source for truly random n-bit word data.

#### Caveats

* This holds if and only if the sampling clock is lower than the natural oscillating frequency
* The quality of the produced random numbers is poor
  * It can be improved by passing it through an LHCA, in which case, it will pass all the [DieHard tests](https://en.wikipedia.org/wiki/Diehard_tests)

### Linear Hybrid Cellular Automata (LHCA)

See `src/lhca.sv`. LFSR generalization suitable for cryptographic applications when sourced with a ring oscillator.

## To-do List

* [x] [Xorshift](https://en.wikipedia.org/wiki/Xorshift) (LFSR)
* [x] [Ring oscillators](https://en.wikipedia.org/wiki/Ring_oscillator)
* [x] [LHCA backed by Ring Oscillators](https://electronics.stackexchange.com/questions/263656/hardware-sources-of-entropy-on-an-fpga)
* [ ] [CBRNG](https://en.wikipedia.org/wiki/Counter-based_random_number_generator_(CBRNG)#Squares_RNG)
  * Making the Squares RNG arbitrary width seems non-trivial, unfortunately
* More upon request

## Reference Documents

*These documents are not hosted here!*

* [High Speed True Random Number Generators in Xilinx FPGAs](http://forums.xilinx.com/xlnx/attachments/xlnx/EDK/27322/1/HighSpeedTrueRandomNumberGeneratorsinXilinxFPGAs.pdf)
  * This is the primary source for the LHCA concept
